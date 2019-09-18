    cursor1=conn.cursor() 
    cursor1.execute("SELECT department_id,department_name "+ \
                            "  FROM departments ORDER BY department_id")
    while True:
        somerows=cursor1.fetchmany(10)
        if not somerows :
            break
        for row in somerows:
            print "%6d %-20s" % (row[0],row[1])
    cursor1.close()
