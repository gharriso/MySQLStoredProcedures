import java.sql.Types;
//import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;

import org.springframework.jdbc.core.*;

import org.springframework.jdbc.datasource.*;
import org.springframework.jdbc.object.StoredProcedure;
import org.springframework.jdbc.core.SqlReturnResultSet;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.RowMapper;

public class mysql_spring_sp {

	public static void main(String[] args) {

		System.out.println("Stored procedure multi-results!");
		mysql_spring_sp t = new mysql_spring_sp();
		t.test();
		System.out.println("Done!");

	}

	void test() {
		DriverManagerDataSource datasource = new DriverManagerDataSource();
		datasource.setDriverClassName("com.mysql.jdbc.Driver");
		datasource.setUrl("jdbc:mysql://localhost:3306/prod");
		datasource.setUsername("root");
		datasource.setPassword("secret");
		int department_id = 12;

		MyStoredProcedure msp = new MyStoredProcedure(datasource);
		Map inParameters = new HashMap();
		inParameters.put("department_id", new Integer(department_id));
		Map results = msp.execute(inParameters);

		List employees = (List) results.get("Employees");
		System.out.println("Employees of department " + department_id);
		for (int i = 0; i < employees.size(); i++) {
			Employee e = (Employee) employees.get(i);
			System.out.println(e.getEmployeeId() + "\t" +
						    e.getFirstname() + "\t" + e.getSurname());
		}

		List customers = (List) results.get("Customers");
		System.out.println("Customers of department " + department_id);
		for (int i = 0; i < customers.size(); i++) {
			Customer c = (Customer) customers.get(i);
			System.out.println(c.getCustomerId() + "\t" + c.getCustomerName());
		}

		Double salesTotal = (Double) results.get("sales_total");
		System.out.println("Total sales for the department " +
					    department_id + "=" + salesTotal);

		
	


		

		/*
		 * List customers=(List)res.get("Customers"); for (int i = 0; i <
		 * customers.size(); i++) { Customer c=(Customer)customers.get(i);
		 * System.out.println(c.getCustomerName()); }
		 * 
		 * List employees=(List)res.get("Employees"); for (int i = 0; i <
		 * employees.size(); i++) { Employee e=(Employee)employees.get(i);
		 * System.out.println(e.getSurname()); }
		 */

	}
	
	public class Customer {
		private int customerId;

		private String customerName;

		private String address1;

		private String address2;

		private String zipcode;

		public Customer(int customerId, String customerName, String address1,
				String address2, String zipcode) {
			this.customerName = customerName;
			this.customerId = customerId;
			this.address1 = address1;
			this.address2 = address2;
			this.zipcode = zipcode;
		}

		public int getCustomerId() {
			return customerId;
		}

		public String getCustomerName() {
			return customerName;
		}

		public void setCustomerName(String CustomerName) {
			this.customerName = customerName;
		}

		/* Other getters and setters go here */

		public String toString() {
			return "Customer : " + customerId + " " + customerName + ".\n";
		}

	}

	public class Employee {
		private int employeeId;
		private String surname;
		private String firstname;
		private String address1;
		private String address2;
		private double salary;

		public Employee(int employeeId, String surname, String firstname,
				String address1, String address2, double salary) {

			this.employeeId = employeeId;
			this.surname = surname;
			this.firstname = firstname;
			this.address1 = address1;
			this.address2 = address2;
			this.salary = salary;
		}

		public String toString() {
			return "Employee : " + employeeId + " " + surname + ".\n";
		}

		public String getSurname() {
			return surname;
		}

		public String getFirstname() {
			return firstname;
		}
		
		/* Other getters and setters would go here */

		public int getEmployeeId() {
			return employeeId;
		}

		public void setSurname(String surname) {
			this.surname = surname;
		}

		public void setCustomerId(int EmployeeId) {
			this.employeeId = employeeId;
		}

	}

	private class MyStoredProcedure extends StoredProcedure {

		public MyStoredProcedure(DataSource ds) {
			setDataSource(ds);
			setSql("sp_department_report");

			declareParameter(new SqlReturnResultSet("Employees",
					new RowMapper() {
						public Object mapRow(ResultSet rs, int rowNum)
								throws SQLException {
							Employee e = new Employee(
									rs.getInt("employee_id"),
									rs.getString("surname"), 
									rs.getString("firstname"), 
									rs.getString("address1"), 
									rs.getString("address2"), 
									rs.getDouble("salary"));
							return e;
						}
					}));
			
			declareParameter(new SqlReturnResultSet("Customers",
					new RowMapper() {
						public Object mapRow(ResultSet rs, int rowNum)
								throws SQLException {
							Customer c = new Customer(
									rs.getInt("customer_id"),
									rs.getString("customer_name"), 
									rs.getString("address1"), 
									rs.getString("address2"), 
									rs.getString("zipcode"));
							return c;
						}
					}));

			declareParameter(new SqlParameter("department_id", Types.INTEGER));

			declareParameter(new SqlOutParameter("sales_total", Types.DOUBLE));

			compile();
		}

	}


}
