       cursor1=conn.cursor()
       cursor1.execute("call simple_stored_proc()")
       cursor1.close()
