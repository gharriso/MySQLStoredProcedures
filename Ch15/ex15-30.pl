#!/usr/bin/perl
use CGI qw(:standard);
use HTML::Table;
use DBI;
use strict;
if ( !param() ) {
	my $form_tbl = new HTML::Table();
	$form_tbl->addRow( "Hostname:", textfield( 'hostname', 'localhost' ) );
	$form_tbl->addRow( "Username:", textfield( 'username', 'root' ) );
	$form_tbl->addRow( "Password:", password_field('password') );
	$form_tbl->addRow( "Database:", textfield('database') );
	$form_tbl->addRow( "Port:",     textfield( 'port', 3306 ) );
	print header, start_html('MySQL Server Status'),
	  h1('Enter MySQL Server details'), start_form, $form_tbl->getTable, 
	  submit,end_form, hr;
}
else {
	my $hostname = param('hostname');
	my $username = param('username');
	my $password = param('password');
	my $db       = param('database');
	my $port     = param('port');
	my @html_body;

	my $dbh = DBI->connect( "DBI:mysql:$db:$hostname:$port",
		"$username", "$password", { PrintError => 0 } );
	if (DBI::err) {
		print header, start_html("Error"), $DBI::errstr;
	}
	else {
		my $sth = $dbh->prepare('call sp_mysql_info(?,@server_version)')
		  || die $DBI::err . ": " . $DBI::errstr;
		$sth->bind_param( 1, $db );
		$sth->execute || die DBI::err . ": " . $DBI::errstr;
		do {
			if ( $sth->{NAME}->[0] eq "table_header" ) {
				my @row = $sth->fetchrow_array();
				push( @html_body, h2( $row[0] ), p );
			}
			else {
				my $table = new HTML::Table();
				$table->setBorder(1);
				foreach my $colno ( 0 .. $sth->{NUM_OF_FIELDS} ) {
					$table->setCell( 1, $colno + 1, $sth->{NAME}->[$colno] );
					$table->setCellBGColor( 1, $colno + 1, "silver" );
				}
				my $rowno = 1;
				while ( my @row = $sth->fetchrow_array() ) {
					$rowno++;
					foreach my $colno ( 0 .. $#row ) {
						$table->setCell( $rowno, $colno + 1, $row[$colno] );
					}
				}
				push( @html_body, $table->getTable );
			}
		} until ( !$sth->more_results );

		$sth = $dbh->prepare('SELECT @server_version') || die $DBI::errstr;
		$sth->execute() || die $DBI::errstr;
		my @row = $sth->fetchrow_array();
		my $mysql_version = $row[0];

		print header, start_html('MySQL Server Status'),
		  h1('MySQL Server Status');
		print "<b>Server: </b>", $hostname, br, "<b>Port: </b>", $port, br,
		  "<b>Database:</b>", $db, br "<b>Version:</b>", $mysql_version, br;
		for my $html (@html_body) {
			print $html;
		}
		print end_html;
	}
}
