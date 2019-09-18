def dynamic_sql(sql):
       names=[]
       lengths=[]
       dividers=[]
       cursor1=conn.cursor() 
       cursor1.execute(sql)
       for col_desc in  cursor1.description:
              col_name=col_desc[0]
              col_length=col_desc[2]
              col_length=max(col_length,len(col_name))
              names.append(col_name)
              lengths.append(col_length)
              dividers.append('-' * col_length)
       format = " ".join(["%%-%ss" % col_len for col_len in lengths])
       print format % tuple(names)
       print format % tuple(dividers)
       rows=cursor1.fetchall()
       for row in rows:
              print format % tuple(row)
       cursor1.close()
