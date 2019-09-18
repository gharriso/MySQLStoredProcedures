PreparedStatement prepared1 = myConnection.prepareStatement(
					"select product_id,product_description,normal_value" +
					"  from products " +
					" where product_id=?");
