package eddy.test.servlet;


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

@WebServlet("/patients/update")
public class UpdatePatientServlet extends HttpServlet {

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
        request.getRequestDispatcher("/update_patient.jsp").forward(request, response);
        manager.close();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        EntityManager manager = factory.createEntityManager();
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        boolean hasErrors = false;
        String patientIin = request.getParameter("patient_iin").trim();
        if (!patientIin.matches("\\d{12}")) {
            hasErrors = true;
            session.setAttribute("patient_iin_error", "ИИН не соответствует формату");
        }
        String patientFullName = request.getParameter("patient_full_name").trim();
        if (!patientFullName.toLowerCase().matches("[а-яё-]+\\s[a-яё-]+(\\s[а-яё-]+)?")) {
            hasErrors = true;
            session.setAttribute("patient_full_name_error", "ФИО не соответствует формату");
        }
        String patientAddress = request.getParameter("patient_address").trim();
        if (patientAddress.isEmpty()) {
            hasErrors = true;
            session.setAttribute("patient_address_error", "Адрес обязателен для заполнения");
        }
        String patientPhone = request.getParameter("patient_phone").trim();
        if (!patientPhone.matches("\\+\\d\\s\\(\\d{3}\\)\\s\\d{3}-\\d{2}-\\d{2}")) {
            hasErrors = true;
            session.setAttribute("patient_phone_error", "Номер телефона не соответствует формату");
        }
        long patientId = Long.parseLong(request.getParameter("patient_id"));
        if (hasErrors) {
            session.setAttribute("prev_patient_iin", patientIin);
            session.setAttribute("prev_patient_full_name", patientFullName);
            session.setAttribute("prev_patient_address", patientAddress);
            session.setAttribute("prev_patient_phone", patientPhone);
            response.sendRedirect(request.getContextPath() + "/patients/update?patient_id=" + patientId);
        } else {
            Patient patient = manager.find(Patient.class, patientId);
            try {
                manager.getTransaction().begin();
                patient.setPatientIin(patientIin);
                patient.setPatientFullName(patientFullName);
                patient.setPatientAddress(patientAddress);
                patient.setPatientPhone(patientPhone);
                manager.getTransaction().commit();
            } catch (Exception e) {
                manager.getTransaction().rollback();
            } finally {
                manager.close();
            }
            response.sendRedirect(request.getContextPath() + "/patients");
        }
        manager.close();
    }
}
