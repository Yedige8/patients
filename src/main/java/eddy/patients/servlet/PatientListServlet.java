package eddy.patients.servlet;

import eddy.patients.entity.Patient;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/patients")
public class PatientListServlet extends HttpServlet {

    private EntityManagerFactory factory;

    @Override
    public void init() {
        ServletContext context = getServletContext();
        factory = (EntityManagerFactory) context.getAttribute("emf");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManager manager = factory.createEntityManager();
        String searchString = request.getParameter("search_string");
        if (searchString != null) {
            searchString = searchString.trim();
        }
        List<Patient> patients;
        if (searchString != null && searchString.matches("\\d{12}")) {
            patients = manager
                    .createQuery("select p from Patient p where p.patientIin = ?1", Patient.class)
                    .setParameter(1, searchString)
                    .getResultList();
        } else if (searchString != null && searchString.toLowerCase().matches("[а-яё-]+(\\s[a-яё-]+)?(\\s[а-яё-]+)?")) {
            patients = manager
                    .createQuery("select p from Patient p where p.patientFullName like ?1", Patient.class)
                    .setParameter(1, searchString + "%")
                    .getResultList();
        } else {
            patients = manager
                    .createQuery("select p from Patient p", Patient.class)
                    .getResultList();
        }
        request.setAttribute("patients", patients);
        request.getRequestDispatcher("/patient_list.jsp").forward(request, response);
        manager.close();
    }
}
