<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>${requestScope.patient.patientFullName}</title>
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css"/>"/>
</head>
<body>
<div class="container my-4 p-4 border shadow-sm">
    <div class="row">
        <div class="col-12">
            <form action="<c:url value="/patients/update"/>" method="post" autocomplete="off" class="m-0">
                <h3 class="h3 mb-3">Информация о пациенте</h3>
                <input type="hidden" name="patient_id" value="${requestScope.patient.patientId}"/>
                <c:if test="${not empty sessionScope.patient_iin_error}">
                    <div class="alert alert-danger" role="alert">${sessionScope.patient_iin_error}</div>
                    <c:remove var="patient_iin_error" scope="session"/>
                </c:if>
                <div class="input-group mb-3">
                    <input type="text" name="patient_iin" value="${requestScope.patient.patientIin}" placeholder="Введите ИИН" aria-label="ИИН" class="form-control"/>
                </div>
                <c:if test="${not empty sessionScope.patient_full_name_error}">
                    <div class="alert alert-danger" role="alert">${sessionScope.patient_full_name_error}</div>
                    <c:remove var="patient_full_name_error" scope="session"/>
                </c:if>
                <div class="input-group mb-3">
                    <input type="text" name="patient_full_name" value="${requestScope.patient.patientFullName}" placeholder="Фамилия Имя Отчество" aria-label="ФИО" class="form-control"/>
                </div>
                <c:if test="${not empty sessionScope.patient_address_error}">
                    <div class="alert alert-danger" role="alert">${sessionScope.patient_address_error}</div>
                    <c:remove var="patient_address_error" scope="session"/>
                </c:if>
                <div class="input-group mb-3">
                    <input type="text" name="patient_address" value="${requestScope.patient.patientAddress}" placeholder="Адрес" aria-label="Адрес" class="form-control"/>
                </div>
                <c:if test="${not empty sessionScope.patient_phone_error}">
                    <div class="alert alert-danger" role="alert">${sessionScope.patient_phone_error}</div>
                    <c:remove var="patient_phone_error" scope="session"/>
                </c:if>
                <div class="input-group mb-3">
                    <input type="text" name="patient_phone" value="${requestScope.patient.patientPhone}" placeholder="Номер телефона в формате +7 (777) 777-77-77" aria-label="Номер телефона" class="form-control"/>
                </div>
                <div class="border-bottom mb-3"></div>
                <h3 class="h3 mb-3">История посещений</h3>
                <c:if test="${not empty requestScope.patient.histories}">
                    <table class="table mb-3">
                        <thead>
                        <tr>
                            <th scope="col">Специалист</th>
                            <th scope="col">ФИО врача</th>
                            <th scope="col">Диагноз</th>
                            <th scope="col">Жалобы</th>
                            <th scope="col">Дата посещения</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="history" items="${requestScope.patient.histories}">
                            <tr>
                                <td>${history.specialist}</td>
                                <td>${history.doctorFullName}</td>
                                <td>${history.diagnosis}</td>
                                <td>${history.complaints}</td>
                                <td>${history.visitDate}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty requestScope.patient.histories}">
                    <div class="alert alert-info">Историй посещений пуста</div>
                </c:if>
                <a href="<c:url value="/history/new?patient_id=${requestScope.patient.patientId}"/>" class="btn btn-primary mb-3">
                    Добавить запись в историю
                </a>
                <div class="border-bottom mb-3"></div>
                <input type="submit" value="Изменить пациента" class="btn btn-primary"/>
            </form>
        </div>
    </div>
</div>
<script src="<c:url value="/js/bootstrap.min.js"/>"></script>
</body>
</html>
