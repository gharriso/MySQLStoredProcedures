      try:
              conn = MySQLdb.connect (host = 'localhost',
                            user = 'root',
                            passwd = '2br02b',
                            db = 'prod',
                            port=3306)
              cursor1=conn.cursor()
              cursor1.execute("CALL error_test_proc()")
              cursor1.close()
              
       except MySQLdb.Error, e:
              print "Mysql Error %d: %s" % (e.args[0], e.args[1])
