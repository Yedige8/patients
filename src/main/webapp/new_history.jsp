<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${requestScope.patient.patientFullName} - Новая запись</title>
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css"/>">
</head>
<body>
<div class="container my-4 p-4 border shadow-sm">
    <div class="row">
        <div class="col-12">
            <form action="<c:url value="/history/new"/>" method="post" autocomplete="off" class="m-0">
                <h3 class="h3 mb-3">${requestScope.patient.patientFullName} - Новая запись</h3>
                <input type="hidden" name="patient_id" value="${requestScope.patient.patientId}"/>
                <c:if test="${not empty sessionScope.specialist_error}">
                    <div class="alert alert-danger" role="alert">${sessionScope.specialist_error}</div>
                    <c:remove var="specialist_error" scope="session"/>
                </c:if>
                <div class="input-group mb-3">
                    <input type="text" name="specialist" placeholder="Специалист" aria-label="Специалист" class="form-control"/>
                </div>
                <c:if test="${not empty sessionScope.doctor_full_name_error}">
                    <div class="alert alert-danger" role="alert">${sessionScope.doctor_full_name_error}</div>
                    <c:remove var="doctor_full_name_error" scope="session"/>
                </c:if>
                <div class="input-group mb-3">
                    <input type="text" name="doctor_full_name" placeholder="Фамилия Имя Отчество врача" aria-label="ФИО врача" class="form-control"/>
                </div>
                <c:if test="${not empty sessionScope.diagnosis_error}">
                    <div class="alert alert-danger" role="alert">${sessionScope.diagnosis_error}</div>
                    <c:remove var="diagnosis_error" scope="session"/>
                </c:if>
                <div class="input-group mb-3">
                    <input type="text" name="diagnosis" placeholder="Диагноз" aria-label="Диагноз" class="form-control"/>
                </div>
                <c:if test="${not empty sessionScope.complaints_error}">
                    <div class="alert alert-danger" role="alert">${sessionScope.complaints_error}</div>
                    <c:remove var="complaints_error" scope="session"/>
                </c:if>
                <div class="input-group mb-3">
                    <input type="text" name="complaints" placeholder="Жалобы" aria-label="Жалобы" class="form-control"/>
                </div>
                <c:if test="${not empty sessionScope.visit_date_error}">
                    <div class="alert alert-danger" role="alert">${sessionScope.visit_date_error}</div>
                    <c:remove var="visit_date_error" scope="session"/>
                </c:if>
                <div class="input-group mb-3">
                    <input type="text" name="visit_date" placeholder="Дата посещения в формате гггг-мм-дд" aria-label="Дата посещения" class="form-control"/>
                </div>
                <div class="border-bottom mb-3"></div>
                <input type="submit" value="Добавить запись" class="btn btn-primary mb-3">
            </form>
        </div>
    </div>
</div>
<script src="<c:url value="/js/bootstrap.min.js"/>"></script>
</body>
</html>
