def randomizer(python_number):
   cursor1=conn.cursor()
   cursor1.execute("SET @inoutvar=%s",(python_number))
   cursor1.execute("CALL randomizer(@inoutvar)")
   cursor1.execute("SELECT @inoutvar")
   row=cursor1.fetchone()
   cursor1.close()
   return(row[0])
