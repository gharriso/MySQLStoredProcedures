import MySQLdb

conn = MySQLdb.connect (host = "localhost",
                        user = "root",
                        passwd = "secret",
                        db = "mysql",
                        port=3306)
