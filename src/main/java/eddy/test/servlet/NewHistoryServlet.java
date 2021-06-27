package eddy.test.servlet;

import eddy.test.entity.History;
import eddy.test.entity.Patient;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/history/new")
public class NewHistoryServlet extends HttpServlet {

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
        long patientId = Long.parseLong(request.getParameter("patient_id"));
        Patient patient = manager.find(Patient.class, patientId);
        request.setAttribute("patient", patient);
        request.getRequestDispatcher("/new_history.jsp").forward(request, response);
        manager.close();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        EntityManager manager = factory.createEntityManager();
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        boolean hasErrors = false;
        String specialist = request.getParameter("specialist").trim();
        if (specialist.isEmpty()) {
            hasErrors = true;
            session.setAttribute("specialist_error", "Специалист обязателен для заполнения");
        }
        String doctorFullName = request.getParameter("doctor_full_name").trim();
        if (!doctorFullName.toLowerCase().matches("[а-яё-]+\\s[a-яё-]+(\\s[а-яё-]+)?")) {
            hasErrors = true;
            session.setAttribute("doctor_full_name_error", "ФИО не соответствует формату");
        }
        String diagnosis = request.getParameter("diagnosis").trim();
        if (diagnosis.isEmpty()) {
            hasErrors = true;
            session.setAttribute("diagnosis_error", "Диагноз обязателен для заполнения");
        }
        String complaints = request.getParameter("complaints").trim();
        if (complaints.isEmpty()) {
            hasErrors = true;
            session.setAttribute("complaints_error", "Жалобы обязательны для заполнения");
        }
        String visitDate = request.getParameter("visit_date").trim();
        if (!visitDate.matches("\\d{4}-\\d{2}-\\d{2}")) {
            hasErrors = true;
            session.setAttribute("visit_date_error", "Дата посещения не соответствует формату");
        }
        long patientId = Long.parseLong(request.getParameter("patient_id"));
        if (hasErrors) {
            session.setAttribute("prev_specialist", specialist);
            session.setAttribute("prev_doctor_full_name", doctorFullName);
            session.setAttribute("prev_diagnosis", diagnosis);
            session.setAttribute("prev_complaints", complaints);
            session.setAttribute("prev_visit_date", visitDate);
            response.sendRedirect(request.getContextPath() + "/history/new?patient_id=" + patientId);
        } else {
            History history = new History();
            Patient patient = manager.find(Patient.class, patientId);
            history.setPatient(patient);
            history.setSpecialist(specialist);
            history.setDoctorFullName(doctorFullName);
            history.setDiagnosis(diagnosis);
            history.setComplaints(complaints);
            history.setVisitDate(LocalDate.parse(visitDate));
            try {
                manager.getTransaction().begin();
                manager.persist(history);
                manager.getTransaction().commit();
            } catch (Exception e) {
                manager.getTransaction().rollback();
            } finally {
                manager.close();
            }
            response.sendRedirect(request.getContextPath() + "/patients/update?patient_id=" + patientId);
        }
        manager.close();
    }
}
