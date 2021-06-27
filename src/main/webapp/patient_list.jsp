<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Список пациентов</title>
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css"/>"/>
</head>
<body>
<div class="container my-4 p-4 border shadow-sm">
    <div class="row">
        <div class="col-12">
            <form action="<c:url value="/patients"/>" method="get" autocomplete="off" class="mb-3">
                <div class="input-group">
                    <input type="text" name="search_string" placeholder="Поиск по ИИН либо ФИО" aria-label="Поиск" class="form-control"/>
                </div>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <a href="<c:url value="/patients/new"/>" class="btn btn-primary mb-3">Добавить нового пациента</a>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <table class="table m-0">
                <thead>
                <tr>
                    <th scope="col">ИИН</th>
                    <th scope="col">ФИО</th>
                    <th scope="col">Номер телефона</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="patient" items="${requestScope.patients}">
                    <tr>
                        <td><a href="<c:url value="/patients/update?patient_id=${patient.patientId}"/>">${patient.patientIin}</a></td>
                        <td>${patient.patientFullName}</td>
                        <td>${patient.patientPhone}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="<c:url value="/js/bootstrap.min.js"/>"></script>
</body>
</html>
