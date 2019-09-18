public class Employee
{
	private long id;
	private String surname;
	private String firstName;
	private String address1;
	private String address2;
	private double salary;

	public Employee(long id, String surname, String firstName,
			      String address1, String address2, double salary)
	{
		this.id = id;
		this.surname = surname;
		this.firstName = firstName;
		this.address1 = address1;
		this.address2 = address2;
		this.salary = salary;
	}

	public String toString() {
		return "Employee : " + employeeId + " " + surname;
	}

	public String getSurname() {
		return surname;
	}

	public String getFirstName() {
		return firstName;
	}
	
	/* Other getters and setters would go here */
}
