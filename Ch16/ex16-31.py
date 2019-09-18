import MySQLdb

def call_sp(mhost,musername,mpassword,mdatabase,mport):
    html_tables=[]
    html_out=[]

    try:
        conn = MySQLdb.connect (host = mhost,
                            user = musername,
                            passwd =mpassword,
                            db = mdatabase,
                            port=int(mport))
        
        csr1=conn.cursor();
        csr1.execute("call sp_mysql_info(%s,@server_version)",(mdatabase))
        while True:
            rows=csr1.fetchall()
            col_desc=csr1.description
            if col_desc<>None:  #Make sure there is a result
               if (col_desc[0][0] == "table_header"):
                   #This is a special result set that contains a header only
                   html="<h2>%s</h2>" % rows[0][0]
               else:
                   html=html_table(col_desc,rows)
               html_tables.append(html)
            if csr1.nextset()==None:
                break
        #Get stored procedure output parameter    
        csr1.execute("SELECT @server_version")
        row=csr1.fetchone()
        mysql_version=row[0]
        csr1.close()

        #Build up the html output
        html_out.append("<html><head><title>"+
                        "MySQL Server status and statistics"+
                        "</title></head>"+
                        "<h1>MySQL Server status and statistics</h1>")
        html_out.append("<b>Host:</b> %s<br>" % mhost)
        html_out.append("<b>Port:</b> %s<br>" % mport)
        html_out.append("<b>Version:</b> %s<br>" % mysql_version)
        html_out.append("".join(html_tables))
        
        html_out.append("</html>")
        return "".join(html_out)
    
    except MySQLdb.Error, e:
        return "MySQL Error %d: %s" % (e.args[0], e.args[1])

def html_table(col_desc,rows):
    # Create HTML table out of cursor.description and cursor.fetchall
    html_out=[]
    html_out.append('<table border=1><tr>')
    for col in col_desc:
        html_out.append('<td><b>%s</b></td>' % col[0])
    html_out.append('</tr>')
    for row in rows:
        html_out.append('<tr>')
        for col in row:
            html_out.append('<td>%s</td>' % col)
        html_out.append('</tr>')
    html_out.append('</table>')
    s='\n'.join(html_out)
    return s
