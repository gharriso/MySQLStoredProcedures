       call_multi_rs("sp_employee_report(1,@out_customer_count)")
       cursor2=conn.cursor()
       cursor2.execute("SELECT @out_customer_count")
       row=cursor2.fetchone()
       print "Customer count=%s" % row[0]
       cursor2.close()
