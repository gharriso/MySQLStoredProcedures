       new_manager=24
       cursor1=conn.cursor()
       for old_manager in [28,87,60]:
              cursor1.execute("UPDATE employees "+
                              "   SET manager_id=%s"+
                              " WHERE manager_id=%s",
                              [new_manager,old_manager])
              print "%d employees updated from manager %d to %d" % \
                     (cursor1.rowcount,old_manager,new_manager)
       cursor1.execute("COMMIT")
       cursor1.close()  
