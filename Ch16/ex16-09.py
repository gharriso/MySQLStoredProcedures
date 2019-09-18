       cursor1=conn.cursor();
       cursor1.execute("SELECT department_id,department_name "+
                       "  FROM departments")
       while True:
              row = cursor1.fetchone ()
              if not row:
                     break
              print "%6d %-20s" % (row[0], row[1])
       cursor1.close()
