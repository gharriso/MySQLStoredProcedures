try:
    option_file = ".mysqldb"
    conn = MySQLdb.connect(read_default_file = "./.mysqldb")
    print "Connected"
except MySQLdb.Error, e:
    print "Top level Error %d: %s" % (e.args[0], e.args[1])
    sys.exit (1)
