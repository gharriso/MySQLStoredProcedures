       cursor=conn.cursor(MySQLdb.cursors.DictCursor)
       cursor.execute("CALL sp_rep_report(%s)",(rep_id))
       print "Employee details:"
       for row in cursor:
           print "%d %s %s" % (row["employee_id"],
                               row["surname"],
                               row["firstname"])
       cursor.nextset()
       print "Employees customers:"
       for row in cursor:
           print "%d %s" % (row["customer_id"],
                            row["customer_name"])
       cursor.close()
