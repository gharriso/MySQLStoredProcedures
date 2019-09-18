	List result =
		session.createQuery("from Event as e where e.date > ?")
			  .setDate(0, yesterday).list();
