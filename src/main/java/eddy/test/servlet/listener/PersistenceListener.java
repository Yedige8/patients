package eddy.test.servlet.listener;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class PersistenceListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        ServletContext context = event.getServletContext();
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("main");
        context.setAttribute("emf", factory);
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        ServletContext context = event.getServletContext();
        EntityManagerFactory factory = (EntityManagerFactory) context.getAttribute("emf");
        factory.close();
    }
}
