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
