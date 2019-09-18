
<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Collections.Specialized" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<script runat="server">
    //public MySqlConnection  myConnection;
    //public DataSet          CustomerData;
    //public MySqlDataAdapter SpAdapter;
    //public MySqlCommand     SpCommand;
    //public MySqlParameter SpSearchParm;
    

    void FindButton_Click(object sender, EventArgs e)
    {
        //Arrays of grids and literals for our output.
        System.Web.UI.WebControls.DataGrid[] DataGrids;
        DataGrids = new System.Web.UI.WebControls.DataGrid[20];
        System.Web.UI.WebControls.Literal[] Literals;
        Literals = new System.Web.UI.WebControls.Literal[20];
            
        
        String myConnectionString = "Database=" + tDatabase.Text +
           " ;Host=" + tHost.Text +
           ";UserName=" + tUsername.Text+ ";Password=" + tPassword.Text;


        MySqlConnection myConnection = new MySqlConnection();
        myConnection.ConnectionString = myConnectionString;

        try
        {
            myConnection.Open();
            MySqlCommand SpCmd = new MySqlCommand("sp_mysql_info", myConnection);
            SpCmd.CommandType = CommandType.StoredProcedure;
            MySqlParameter InDbParm = SpCmd.Parameters.Add(
	                       "in_database",MySqlDbType.String);
            InDbParm.Value = tDatabase.Text;
            MySqlParameter OutMyVersion = SpCmd.Parameters.Add(
                           "server_version", MySqlDbType.String);
            OutMyVersion.Direction = ParameterDirection.Output;

            MySqlDataAdapter MyAdapter = new MySqlDataAdapter(SpCmd);
            MyAdapter.SelectCommand = SpCmd;
            DataSet SpDataSet = new DataSet();
            MyAdapter.Fill(SpDataSet);

            ReportHeaderl.Text = "<h1>MySQL Server status and statistics</h1>" +
                     "<b>Host:</b>"+tHost.Text+"<br>"+
                     " <b>Port:</b> "+tPort.Text+"<br>"+
                     "<b>Version:</b>"+OutMyVersion.Value+"<br>";

            int grid_no = 0;
            int heading_no=0;
            foreach (DataTable SpTable in SpDataSet.Tables) {
                if (SpTable.Columns[0].ColumnName == "table_header")
                {
                    Literals[heading_no]=new Literal();
                    Literals[heading_no].Text="<h2>"+ SpTable.Rows[0][0]+"</h2>";
                    PlaceHolder.Controls.Add(Literals[heading_no]);
                    heading_no++;
                }
                else
                {
                    DataGrids[grid_no] = new DataGrid();
                    DataGrids[grid_no].DataSource = SpTable;
                    DataGrids[grid_no].DataBind();
                    DataGrids[grid_no].BorderWidth = 1;
                    DataGrids[grid_no].HeaderStyle.BackColor = System.Drawing.Color.Silver;
                    PlaceHolder.Controls.Add(DataGrids[grid_no]);
                    grid_no++;
                }
            }



        }
        catch (MySqlException MyException)
        {
            Response.Write("Connection error: MySQL code: " + MyException.Number
                              + " " + MyException.Message);
        }


    }

    protected void CustGrid_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>MySQL Server Statistics</title>
</head>
<body>
    <h1>Enter MySQL Server Details</h1>
    <form id="form1" runat="server">
        <table>  
            <tr><td>Host:</td>
            <td> <asp:TextBox ID="tHost" Runat="server">localhost</asp:TextBox></td></tr>
            <tr><td>Port: </td>
            <td><asp:TextBox ID="tPort" Runat="server">3306</asp:TextBox></td></tr>
            <tr><td>Username: </td>
            <td> <asp:TextBox ID="tUsername" Runat="server">root</asp:TextBox></td></tr>
            <tr><td>Password: </td>
            <td> <asp:TextBox ID="tPassword" Runat="server" TextMode="Password"></asp:TextBox></td></tr>
            <tr><td>Database: </td>
            <td> <asp:TextBox ID="tDatabase" Runat="server">prod</asp:TextBox></td></tr>
        </table> 
    <div visible="false">
        <br /><asp:Button ID="FindButton" Runat="server" Text="Submit" OnClick="FindButton_Click" /><br />

    </div>
    </form>
    <asp:Literal ID="ReportHeaderl" runat="server"></asp:Literal>
    <br />
    <asp:PlaceHolder id="PlaceHolder" runat="server" />
</body>
</html>
