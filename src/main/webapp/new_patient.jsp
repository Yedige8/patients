<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Новый пациент</title>
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css"/>">
</head>
<body>
<div class="container my-4 p-4 border shadow-sm">
    <div class="row">
        <div class="col-12">
            <form action="<c:url value="/patients/new"/>" method="post" autocomplete="off" class="m-0">
                <h3 class="h3 mb-3">Информация о пациенте</h3>
                <c:if test="${not empty sessionScope.patient_iin_error}">
                    <div class="alert alert-danger" role="alert">${sessionScope.patient_iin_error}</div>
                    <c:remove var="patient_iin_error" scope="session"/>
                </c:if>
                <div class="input-group mb-3">
                    <input type="text" name="patient_iin" placeholder="Введите ИИН" aria-label="ИИН" class="form-control"/>
                </div>
                <c:if test="${not empty sessionScope.patient_full_name_error}">
                    <div class="alert alert-danger" role="alert">${sessionScope.patient_full_name_error}</div>
                    <c:remove var="patient_full_name_error" scope="session"/>
                </c:if>
                <div class="input-group mb-3">
                    <input type="text" name="patient_full_name" placeholder="Фамилия Имя Отчество" aria-label="ФИО" class="form-control"/>
                </div>
                <c:if test="${not empty sessionScope.patient_address_error}">
                    <div class="alert alert-danger" role="alert">${sessionScope.patient_address_error}</div>
                    <c:remove var="patient_address_error" scope="session"/>
                </c:if>
                <div class="input-group mb-3">
                    <input type="text" name="patient_address" placeholder="Адрес" aria-label="Адрес" class="form-control"/>
                </div>
                <c:if test="${not empty sessionScope.patient_phone_error}">
                    <div class="alert alert-danger" role="alert">${sessionScope.patient_phone_error}</div>
                    <c:remove var="patient_phone_error" scope="session"/>
                </c:if>
                <div class="input-group mb-3">
                    <input type="text" name="patient_phone" placeholder="Номер телефона в формате +7 (777) 777-77-77" aria-label="Номер телефона" class="form-control"/>
                </div>
                <div class="border-bottom mb-3"></div>
                <input type="submit" value="Добавить пациента" class="btn btn-primary"/>
            </form>
        </div>
    </div>
</div>
<script src="<c:url value="/js/bootstrap.min.js"/>"></script>
</body>
</html>
