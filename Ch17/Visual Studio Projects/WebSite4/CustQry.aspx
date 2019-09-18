
<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Collections.Specialized" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<script runat="server">
    public MySqlConnection  myConnection;
    public DataSet          CustomerData;
    public MySqlDataAdapter SpAdapter;
    public MySqlCommand     SpCommand;
    public MySqlParameter SpSearchParm;
    
    void Page_Load(object sender, EventArgs e)
    {
            
        myConnection = new MySqlConnection();
        myConnection.ConnectionString = ConfigurationSettings.AppSettings["MySQLDS"];
       // myConnection.ConnectionString = ConfigurationSettings.ConnectionStrings["MySQLDS"].ConnectionString; 
        

        try
        {
            myConnection.Open();
            SpCommand = new MySqlCommand("sp_find_customers", myConnection);
            SpCommand.CommandType = CommandType.StoredProcedure;
            SpSearchParm = SpCommand.Parameters.Add("customer_name_pattern", MySqlDbType.String);
            SpAdapter= new MySqlDataAdapter();
            SpAdapter.SelectCommand = SpCommand;
            CustomerData = new DataSet();
            

        }
        catch (MySqlException MyException)
        {
            Response.Write("MySql error: MySQL code: " + MyException.Number
                              + " " + MyException.Message);
        }

    }

    void Page_Unload(object sender, EventArgs e)
    {
        myConnection.Close();
    }


    void FindButton_Click(object sender, EventArgs e)
    {
        SpSearchParm.Value=CustStringTextBox.Text;
        CustomerData.Clear();
        try 
        {
            SpAdapter.Fill(CustomerData);
            CustomerData.Tables[0].TableName = "CustList";
            CustGrid.DataSource = CustomerData;
            CustGrid.DataMember = "CustList";
            CustGrid.DataBind();
            CustGrid.Visible = true;

        }
        catch (MySqlException MyException)
        {
            Response.Write("MySql error: MySQL code: " + MyException.Number
                              + " " + MyException.Message);
        }
    }

    protected void CustGrid_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Find customers</title>
</head>
<body>
    <h2 id="CustomerGrid">
        Search Customers</h2>
    <form id="form1" runat="server">
    <div visible="false">
        Customer Search string (%=wildcard):&nbsp;&nbsp;<asp:TextBox ID="CustStringTextBox" Runat="server">
        </asp:TextBox>&nbsp;<asp:Button
            ID="FindButton" Runat="server" Text="Find" OnClick="FindButton_Click" />&nbsp;<br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DataGrid ID="CustGrid" Runat="server" Visible="False" OnSelectedIndexChanged="CustGrid_SelectedIndexChanged">
        </asp:DataGrid>
    </div>
    </form>
</body>
</html>
