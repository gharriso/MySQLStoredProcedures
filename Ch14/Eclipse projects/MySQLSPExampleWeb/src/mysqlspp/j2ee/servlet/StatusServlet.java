/*
 * Created on 9/09/2005
 * 
 * TODO To change the template for this generated file go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
package mysqlspp.j2ee.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
/*
 * import java.sql.Connection; import java.sql.DriverManager; import
 * java.sql.SQLException;
 */

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StatusServlet extends HttpServlet
{
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
 	{
		String hostname = request.getParameter("mhost");
		String port = request.getParameter("mport");
		String username = request.getParameter("muser");
		String password = request.getParameter("mpass");
		String database = request.getParameter("mdb");
		StringBuffer html = new StringBuffer();
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String connString = "jdbc:mysql://" + hostname + ":" + port + "/" +
				database + "?user=" + username + "&password=" + password;
			Connection connection = DriverManager.getConnection(connString);

			CallableStatement myproc =
 				connection.prepareCall("{CALL sp_mysql_info(?,?)}");
			myproc.registerOutParameter(2, Types.VARCHAR);
			myproc.setString(1, database);

			boolean moreResultSets = myproc.execute();
			while (moreResultSets) {
				ResultSet rs = myproc.getResultSet();
				ResultSetMetaData rsmd = rs.getMetaData();
				if (rsmd.getColumnName(1).equals("table_header")) {
					rs.next();
					html.append("<h2>").append(rs.getString(1))
 					    .append("</h2>");
				} else {
					makeTable(rs, rsmd, html);
				}
				moreResultSets = myproc.getMoreResults();
			}
			String version = myproc.getString(2);
			
			out.println("<HTML><HEAD><TITLE>MySQL Server status</TITLE></HEAD>");
			out.println("<H1>MySQL Server status and statistics</H1>");
			out.println("<b>Server:</b>\t" + hostname + "<br>");
			out.println("<b>Port:</b>\t" + port + "<br>");
			out.println("<b>Version:</b>:\t" + version + "<br>");
			out.println(html.toString());
			out.println("</HTML>");
		} catch (SQLException e) {
			out.println(e.getErrorCode() + " " + e.getMessage());
 			e.printStackTrace(out);
		} catch (InstantiationException e) {
			e.printStackTrace(out);
		} catch (IllegalAccessException e) {
			e.printStackTrace(out);
		} catch (ClassNotFoundException e) {
			e.printStackTrace(out);
		} finally {
			out.flush();
			out.close();
 		}
	}
	
	private void makeTable(ResultSet rs, ResultSetMetaData rsmd, StringBuffer html)
 		throws SQLException
 	{
		html.append("<table border=\"1\"><tr>");

		for (int i = 1; i <= rsmd.getColumnCount(); i++)
			html.append("<td bgcolor=\"silver\">").append(rsmd.getColumnName(i))
                  .append("</td>");
		html.append("</tr>");

		while (rs.next()) {
			html.append("<tr>");
			for (int i = 1; i <= rsmd.getColumnCount(); i++)
				html.append("<td>").append(rs.getString(i)).append("</td>");
			html.append("</tr>\n");
		}

		html.append("</table>\n");
	}
}

