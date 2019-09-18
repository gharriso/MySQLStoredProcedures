import MySQLdb
from optparse import OptionParser

parser = OptionParser()
parser.add_option("-u", "--username", dest="username",default="root") 
parser.add_option("-H", "--hostname",default="localhost")
parser.add_option("-p","--password",dest="password",default="")
parser.add_option("-d","--database",dest="database",default="mysql")
parser.add_option("-P","--port",dest="port",type="int",default=3306)
(options, args) = parser.parse_args()

conn = MySQLdb.connect (host = options.hostname,
                        user = options.username,
                        passwd = options.password,
                        db = options.database,
                        port=options.port)
