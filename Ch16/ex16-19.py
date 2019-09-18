def apply_discount(p1,p2):
       
       cursor1=conn.cursor()
       cursor1.execute("call sp_apply_discount(%s,%s)",(p1,p2))
       cursor1.close() 
