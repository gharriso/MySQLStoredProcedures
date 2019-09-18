try:
    conn = MySQLdb.connect (host = options.hostname,
                            user = options.username,
                            passwd = options.password,
                            db = options.database,
                            port=options.port)
                            
except MySQLdb.Error, e:
    print "Error connecting %d: %s" % (e.args[0], e.args[1])
