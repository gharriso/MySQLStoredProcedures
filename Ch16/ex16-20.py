       cursor1=conn.cursor(MySQLdb.cursors.DictCursor)
       cursor1.execute("CALL sp_emps_in_dept(%s)",(1))
       for row in cursor1:
           print "%d %s %s" % \
               (row['employee_id'],row['surname'],row['firstname'])
       cursor1.close()
