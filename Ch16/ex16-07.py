       cursor1=conn.cursor()
       cursor1.execute("UPDATE employees "+
                       "   SET manager_id=28"+
                       " WHERE manager_id=24")
       print "%d rows updated" % cursor1.rowcount
       cursor1.execute("COMMIT")
       cursor1.close()
