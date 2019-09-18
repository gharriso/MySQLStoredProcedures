	List result = session.getNamedQuery("getRecentEventsSP")
					 .setDate(0,yesterday).list();
