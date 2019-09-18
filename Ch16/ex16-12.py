       cursor1 = conn.cursor (MySQLdb.cursors.DictCursor)
       cursor1.execute ("SELECT department_id,department_name "+
                       "  FROM departments")
       result_set = cursor1.fetchall ()
       for row in result_set:
              print "%s, %s" % (row["department_id"], row["department_name"])
