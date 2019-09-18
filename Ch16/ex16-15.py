   try:
        conn.autocommit(False)
        csr1.execute("UPDATE account_balance "+
                     "  SET balance=balance-%s "+
                     "WHERE account_id=%s",
                     [tfer_amount,from_account])
        csr1.execute("UPDATE account_balance "+
                     "  SET balance=balance+%s "+
                     "WHERE account_id=%s",
                     [tfer_amount,to_account])
                         
    except MySQLdb.Error, e:
        conn.rollback()
        print "Transaction aborted:  %d: %s" % (e.args[0], e.args[1]) 
    else:
       conn.commit()
       print "Transaction succeeded"
