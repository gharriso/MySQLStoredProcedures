import org.hibernate.Transaction;
import org.hibernate.Session;
import java.util.Date;
import java.util.*;
import java.text.*;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

//import org.apache.log4j.SimpleLayout;
//import org.apache.log4j.FileAppender;

public class EventManager {
	static Logger logger = Logger.getLogger(EventManager.class);

	public static void main(String[] args) {
		EventManager mgr = new EventManager();

		if (args[0].equals("store")) {
			mgr.createAndStoreEvent("My Event", new Date());
		} else if (args[0].equals("list")) {
			List events = mgr.listEvents();
			for (int i = 0; i < events.size(); i++) {
				Event theEvent = (Event) events.get(i);
				System.out.println("Event: " + theEvent.getTitle() + " Time: "
						+ theEvent.getDate());
			}

		} else if (args[0].equals("load2")) {
			System.out.println("Load2:");

			mgr.loadEvent();

		} else if (args[0].equals("update")) {
			mgr.updateEvent();
		} else if (args[0].equals("delete")) {
			mgr.createAndDeleteEvent("Temp event", new Date());
		}
		HibernateUtil.sessionFactory.close();
	}

	private List listEvents() {
		Session session = HibernateUtil.currentSession();
		Transaction tx = session.beginTransaction();
		// List result = session.createQuery("from Event").list();

		Date yesterday;
		DateFormat myformat = new SimpleDateFormat("yyyy.MM.dd");
		try {
			yesterday = myformat.parse("2005.12.07");

			/*
			 * List result = session.createQuery( "from Event as e where e.date >
			 * ?").setDate(0, yesterday) .list();
			 */
			List result = session.getNamedQuery("getRecentEventsSP").setDate(0,
					yesterday).list();
			tx.commit();
			session.close();
			return result;
		} catch (ParseException e) {
			return null;
		}

	}

	private void updateEvent() {
		Session session = HibernateUtil.currentSession();
		Transaction tx = session.beginTransaction();
		Long myId = java.lang.Long.valueOf("1");

		System.out.println(myId);

		Event anEvent = (Event) session.load(Event.class, myId);
		anEvent.setTitle("Title from updateEvent()");
		anEvent.setDate(new Date());
		session.save(anEvent);
		tx.commit();
		HibernateUtil.closeSession();

	}

	private void createAndDeleteEvent(String title, Date theDate) {
		Session session = HibernateUtil.currentSession();
		
		Transaction tx = session.beginTransaction();
		Event theEvent = new Event();
		theEvent.setTitle(title);
		theEvent.setDate(theDate);
		session.save(theEvent);
		tx.commit();
		
		System.out.println(theEvent.getId());
		tx=session.beginTransaction();
		session.delete(theEvent);
		tx.commit();
		
		HibernateUtil.closeSession();
	}

	private void createAndStoreEvent(String title, Date theDate) {
		Session session = HibernateUtil.currentSession();
		Transaction tx = session.beginTransaction();
		Event theEvent = new Event();
		theEvent.setTitle(title);
		theEvent.setDate(theDate);
		session.save(theEvent);
		tx.commit();
		HibernateUtil.closeSession();
	}

	private void addPersonToEvent(Long personId, Long eventId) {
		Session session = HibernateUtil.currentSession();
		Transaction tx = session.beginTransaction();
		Person aPerson = (Person) session.load(Person.class, personId);
		Event anEvent = (Event) session.load(Event.class, eventId);
		aPerson.getEvents().add(anEvent);
		tx.commit();
		HibernateUtil.closeSession();
	}

	private void loadEvent() {
		Session session = HibernateUtil.currentSession();
		Transaction tx = session.beginTransaction();
		Long id = new Long(1);

		System.out.println(id);

		Event anEvent = (Event) session.load(Event.class, id);
		System.out.println(anEvent.getId());
		System.out.println(anEvent.getTitle());
		tx.commit();
		HibernateUtil.closeSession();

	}
}