import MySQLdb
from MySQLdb.constants import CLIENT

conn = MySQLdb.connect(  other connection_options ,
				 client_flag=CLIENT.MULTI_RESULTS)
