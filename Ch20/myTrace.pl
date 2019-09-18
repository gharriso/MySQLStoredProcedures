# TODO: Print out last_query_cost

#
# MySQLTrace: run an SQL and display statistics
#
#
#

=pod

=head1 NAME

myTrace:  benchmark/report on SQL statement performance

=cut

use DBI;
use Time::HiRes qw(usleep ualarm gettimeofday tv_interval);

#use strict;

require "ctime.pl";

#use Regexp::Common;
use Scalar::Util qw(looks_like_number);

#DBI->trace(9);
#
# Get command line
#
#TODO:  getopts is not strict compatible; change to use use Getopt::Long;
#TODO:  Pod2Usage
require "getopts.pl";

my $usage =
"MySQLTrace [-u username] [-p password] [-h host] [-P port] [-D database] [-T] [-o] \n"
  . "[-t trace_level] [-R] [-e count] [-f file]\n\t"
  . "-T causes the SQL to be run twice - only second execution stats are counted\n\t"
  . "-o causes the output file (.trc) to be overwritten, otherwise it is appended\n\t"
  . "-R causes a reconnect between each SQL execution\n"
  . "-e causes SQL statistics to be averaged over 'count' executions (excluding the first if -T is specified)";

&Getopts('u:P:h:p:D:f:oTt:R:e:') || die $usage;

# Globals
# TODO: During convert to strict mode, all variables were made global.  Should clean up those that
# should be local in scope

my ( $USER, $PASSWORD, $HOST );
my ( $PORT, $DATABASE, $INFILE );
my ( $OVERWRITE, $EXEC_COUNT );
my ( $statement_no, $sql_text, @sqls, $opt_T, $rows );
my ( @start_times, @exec_times, @final_times, @rows );
my ( $exec,    $opt_R, $db_my, @parse_times, @data_array, $first_row_time );
my ( $message, $code,  $level, %keylist );
my ( $stat_name, %stat_final, %stat_delta, %stat_init, %sum_elapsed );
my (%sum_rows);
my ( %sum_lreads, %sum_preads, %sum_text );
my ( $outfile, $errfile, $datfile, $outcsv );
my ( %stat_array, $stat_value );
my ( $e_csr, @cols, $id, $select_type, $table, $type, $possible_keys );
my ( $key,        $key_len,    $ref,        $extra );
my ( $total_ela,  $parse_ela,  $fetch_ela,  $exec_ela );
my ( $total_time, $parse_time, $fetch_time, $exec_time );

if ($opt_u) { $USER = $opt_u; }
else { $USER = "root"; }
if ($opt_p) { $PASSWORD = $opt_p; }
else { $PASSWORD = "secret"; }
if ($opt_h) { $HOST = $opt_h; }
else { $HOST = "localhost"; }
if ($opt_P) { $PORT = $opt_P; }
else { $PORT = "3306"; }
if ($opt_D) { $DATABASE = $opt_D; }
else { $DATABASE = "prod"; }
if ($opt_f) { $INFILE = $opt_f; }
else { die $usage }
if ($opt_o) { $OVERWRITE = 1; $opt_o = 1; }
else { $OVERWRITE = 0 }
if ($opt_t) { DBI->trace($opt_t); }
if ($opt_e) { $EXEC_COUNT = $opt_e; }
else { $EXEC_COUNT = 1; }

sub main() {
	&init();
	$statement_no = 0;
	for $sql_text (@sqls) {
		$statement_no++;
		if ($opt_T) {
			$rows = &run_sql($sql_text);
			$rows = 0;
		}

		&get_init_stats();
		$rows = &run_sql($sql_text);
		&get_final_stats();
		&print_results();

	}
	&print_summary();
}

sub run_sql() {
	my ( $sql, $password_string );
	($sql) = @_;
	$sql_text = $sql;    # TODO: Not sure why this is neccessary....

	$rows = 0;
	$exec=1; 
	if ($opt_p) { $password_string = "-p $PASSWORD"; }

	@start_times = ();
	@exec_times  = ();
	@final_times = ();
	@rows        = ();    #These are global

	if ( $sql =~ /^!(.*)$/ ) {
		$sql = substr( $sql, 1 );
		open( MYSQLPIPE,
			"|mysql -D$DATABASE -h$HOST -P$PORT -u$USER $password_string" )
		  || die $!;
		select(MYSQLPIPE);
		$| = 1;
		select(STDOUT);
		print MYSQLPIPE $sql . ";\n";
		print MYSQLPIPE "exit\n";
		close(MYSQLPIPE);
	}
	else {

		print DATOUT "---------------------\n$sql_text\n-----------------\n";

		for $exec ( 1 .. $EXEC_COUNT ) {

			if ($opt_R) { &connect(); }
			$start_times[ $exec - 1 ] = gettimeofday;

			my $tmp_csr = $db_my->prepare($sql_text) || warn $DBI::errstr;
			$parse_times[ $exec - 1 ] = gettimeofday;

			$tmp_csr->execute || warn $DBI::errstr;
			$exec_times[ $exec - 1 ] = gettimeofday;

			if ( $exec == 1 ) {
				print DATOUT join( "\t", @{ $tmp_csr->{NAME_lc} } ) . "\n";
			}
			if ($opt_D) {
				$rows[ $exec - 1 ] =
				  $tmp_csr->dump_results( 35, "\n", " ", *DATOUT );
			}
			else {
				while ( (@data_array) = $tmp_csr->fetchrow_array ) {
					$rows++;
					if ( $rows == 1 ) { $first_row_time = gettimeofday; }

				}
			}

			$final_times[ $exec - 1 ] = gettimeofday;
		}

	}
	$rows[$exec-1]=0 if (!defined($rows[$exec-1])) ; 
	return ( $rows[ $exec - 1 ] );

}

sub get_explain() {

	#DBI->trace(9);
	$e_csr = $db_my->prepare( 'EXPLAIN extended ' . $sql_text )
	  || die $DBI::errstr;

	@cols = $e_csr->{NAME};
	$e_csr->execute() || die $DBI::errstr;

	printf("Explain plan\n");
	printf("------------\n\n");
	my @explain_array = ();
	my $i             = 0;
	my $keylist       = "";
	while (
		(
			$id, $select_type, $table, $type, $possible_keys, $key, $key_len,
			$ref, $rows, $extra
		)
		= $e_csr->fetchrow_array
	  )
	{
		printf( "ID=%-2d\tTable=%-20s Select type=%-20s "
			  . "Access type=%-12s Rows=%-5d \n",
			$id, $table, $select_type, $type, $rows );
		$key           = "" if ( !defined($key) );
		$possible_keys = "" if ( !defined($possible_keys) );
		$ref           = "" if ( !defined($ref) );
		$extra         = "" if ( !defined($extra) );
		printf( "\t\tKey=%-30s (Possible=%-30s)\n", $key, $possible_keys );
		printf( "\t\tRef=%-20s \tExtra=%-30s\n",    $ref, $extra );

		if ( length($key) < 1 ) { $key = "no key" }
		$keylist = $keylist . $key . ";";

		$explain_array[$i] =
		  "$id\t$select_type select($type) on $table using $key\n\t\t$extra\n";
		$i++;

	}

	$keylist{$statement_no} = $keylist;
	print "Short Explain\n";
	print "-------------\n";
	for $i ( 0 .. $#explain_array ) {
		print $explain_array[$i];
	}
	printf("\n\n");
	my $warn_csr = $db_my->prepare("show warnings") || warn $DBI::errstr;
	$warn_csr->execute || warn $DBI::errstr;
	print "Warnings\n";
	print "--------\n";
	while ( ( $level, $code, $message ) = $warn_csr->fetchrow_array ) {
		print $message. "\n";
	}
	$e_csr->finish;

}

sub sum() {
	my $sum = 0;
	for ( 0 .. $#_ ) {
		$sum += $_[$_];
	}
	return ($sum);
}

sub print_results() {

	#calc sums of times.
	for ( 0 .. $#final_times ) {
		$total_ela += ( $final_times[$_] - $start_times[$_] );
		$parse_ela += ( $parse_times[$_] - $start_times[$_] );
		$fetch_ela += ( $final_times[$_] - $exec_times[$_] );
		$exec_ela  += ( $exec_times[$_] - $parse_times[$_] );
	}

	# calc averages of those times.

	$total_time = $total_ela / $EXEC_COUNT;
	$parse_time = $parse_ela / $EXEC_COUNT;
	$fetch_time = $fetch_ela / $EXEC_COUNT;
	$exec_time  = $exec_ela / $EXEC_COUNT;

	printf(
"\n----------------------------------------------------\nSTATEMENT #%d\n\n",
		$statement_no );
	print $sql_text. "\n\n\n";

	&get_explain();

	if ( $EXEC_COUNT > 1 ) {
		printf("\n\nStatistics averaged over $EXEC_COUNT executions\n\n");
	}

	printf( "\n\n%-8s %12s\n\n", 'Phase', 'Elapsed (s)' );
	printf( "%-8s %8.4f\n",      'Parse', $parse_time );
	printf( "%-8s %8.4f\n",      'Exec',  $exec_time );
	printf( "%-8s %8.4f\n",      'Fetch', $fetch_time );
	print "-----------------\n";
	printf( "%-8s %8.4f\n", 'Total', $total_time );

	printf(
"\n%-50s %10s\n-------------------------------------------------------------\n",
		'Statistic', 'Value' );
	for $stat_name ( sort( keys(%stat_final) ) ) {
		$stat_delta{$stat_name} =
		  $stat_final{$stat_name} - $stat_init{$stat_name};
		if ( $stat_delta{$stat_name} > 0 ) {
			printf( "%-50s %10d\n",
				$stat_name, $stat_delta{$stat_name} / $EXEC_COUNT );
		}
	}
	print
"--------------------------------------------------------------------------\n";
	$sum_elapsed{$statement_no} = $total_time;
	$sum_rows{$statement_no}    = $stat_delta{"Innodb_rows_read"} / $EXEC_COUNT;
	$sum_lreads{$statement_no}  =
	  $stat_delta{"Innodb_buffer_pool_read_requests"} / $EXEC_COUNT;
	$sum_preads{$statement_no} = $stat_delta{"Innodb_data_reads"} / $EXEC_COUNT;
	$sum_text{$statement_no}   = $sql_text;
}

sub connect() {
	$db_my = DBI->connect( "DBI:mysql:$DATABASE:$HOST:$PORT",
		"$USER", "$PASSWORD", { PrintError => 0 } )
	  || die $DBI::errstr;
}

sub init() {

	&connect();
	my @filebits = split( /\./, $INFILE );
	$outfile = $filebits[0] . '.trc';
	$errfile = $filebits[0] . '.err';
	$datfile = $filebits[0] . '.dat';
	$outcsv  = $filebits[0] . '.csv';
	open( CSVFILE, "> $outcsv" ) || die $! . " Opening $outcsv";

	if ($OVERWRITE) {
		open( STDOUT, "|tee  $outfile" ) || die $!;
		open( STDERR, "|tee  $errfile" ) || die $!;
		open( DATOUT, ">  $datfile" )    || die $!;
	}
	else {
		open( STDOUT, "|tee -a $outfile" ) || die $!;
		open( STDERR, "|tee -a $errfile" ) || die $!;
		open( DATOUT, ">> $datfile" )      || die $!;
	}
	$sql_text = "";
	select(STDERR);
	$| = 1;
	select(STDOUT);
	$| = 1;
	open( INFILE, "<$INFILE" ) || die $!;
	while (<INFILE>) {

		if (/(.*);/) {

			$sql_text = $sql_text . $1;
			push( @sqls, $sql_text );
			$sql_text = "";
		}
		elsif (/^(\s+)$/) { }
		elsif (/#(.*)/)   { }
		else {
			chop($_);
			$sql_text = $sql_text . $_ . " ";
		}
	}

	#print $sql_text;
	close(INFILE);
	printf( "\n\n==========================="
		  . "================================================\n\n" );
	my $mytime = &ctime(time);
	chop($mytime);
	printf("MySQL execution statistics\n\n");
	printf( "File Name : %-20s  Time: %-30s\n", $INFILE, $mytime );
	printf("Connection host=$HOST port=$PORT db=$DATABASE\n\n");

}

sub get_init_stats() {
	%stat_init = &get_stats();
}

sub get_stats() {

	my ($st_csr) = $db_my->prepare("show status") || die $DBI::errstr;
	$st_csr->execute || die $DBI::errstr;
	while ( ( $stat_name, $stat_value ) = $st_csr->fetchrow_array ) {
		if ( looks_like_number($stat_value) ) {
			$stat_array{$stat_name} = $stat_value;
		}
	}
	$st_csr->finish;

	return (%stat_array);
}

sub get_final_stats() {
	%stat_final = &get_stats();
}

sub summary_format() {

}

sub print_summary() {
	format SIO_TOP=

Summary of SQL executions  
  
Stmt No   Elapsed         Rows     Log Reads Phys Reads SQL                                   Keys
------- --------- ------------ ------------- ---------- ------------------------------------- ------------------------

.

	format SIO_ROW=
@>>>>>> @>>>>>>>> @>>>>>>>>>>> @>>>>>>>>>>>> @>>>>>>>>> @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<
$statement_no , $sum_elapsed{$statement_no} , $sum_rows{$statement_no} ,$sum_lreads{$statement_no} , $sum_preads{$statement_no} ,        $sum_text{$statement_no} ,$keylist{$statement_no} 
.

	$^ = "SIO_TOP";
	$~ = "SIO_ROW";
	for $statement_no ( 1 .. $#sqls + 1 ) {
		write;
	}

	select(CSVFILE);

	print "Statement No,Elapsed,Rows,Log Reads,Phys Reads,Keys,SQL\n";
	for $statement_no ( 1 .. $#sqls + 1 ) {
		print
"$statement_no , $sum_elapsed{$statement_no} , $sum_rows{$statement_no} , $sum_lreads{$statement_no} , "
		  . "$sum_preads{$statement_no} ,\"$keylist{$statement_no}\","
		  . "\"$sum_text{$statement_no} \"\n";
	}

}

sub my_do() {
	my ($sql) = @_;
	my $my_csr = $db_my->prepare($sql) || die $DBI::errstr;
	$my_csr->execute || die $DBI::errstr;
	$my_csr->finish;
}

&main();

=pod

=head1 SYNOPSIS

BmyTrace [options]

Prints out execution statistics for the SQL statements contained in a text file

=head1 OPTIONS

[-u username] [-P password] [-h host] [-p port] [-D database] [-T] [-o] .
   "[-t trace_level] [-R] [-e count] [-f file]\n\t".
"-T causes the SQL to be run twice - only second execution stats are counted\n\t".
"-o causes the output file (.trc) to be overwritten, otherwise it is appended\n\t".
"-R causes a reconnect between each SQL execution\n".
"-e causes SQL statistics to be averaged over 'count' executions (excluding the first if -T is specified)";



=head1 LICENSE

BmyTrace is licensed under the GNU General Public License version
2. For the full license information, please visit
http://www.gnu.org/copyleft/gpl.html

=cut

__END__
