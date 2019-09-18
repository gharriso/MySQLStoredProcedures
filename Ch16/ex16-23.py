def call_multi_rs(sp):
   rs_id=0;
   cursor = conn.cursor()
   cursor.execute ("CALL "+sp)
   while True:
      data = cursor.fetchall()
      if cursor.description:  #Make sure there is a result
         rs_id+=1
         print "\nResult set %3d" % (rs_id)
         print "--------------\n"
         names = []
         lengths = []
         rules = []
         for field_description in cursor.description:
            field_name = field_description[0]
            names.append(field_name)
            field_length = field_description[2] or 12
            field_length = max(field_length, len(field_name))
            lengths.append(field_length)
            rules.append('-' * field_length)
            format = " ".join(["%%-%ss" % l for l in lengths])
            result = [ format % tuple(names), format % tuple(rules) ]
         for row in data:
            result.append(format % tuple(row))
         print "\n".join(result)
      if cursor.nextset()==None:
         break
   print "All rowsets returned"
   cursor.close()
