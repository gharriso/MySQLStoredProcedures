IF customers_for_rep(in_employee_id) > 0 THEN
	 CALL calc_sales_rep_bonus(in_employee_id);
ELSE
	 CALL calc_nonrep_bonus(in_employee_id);
END IF;
