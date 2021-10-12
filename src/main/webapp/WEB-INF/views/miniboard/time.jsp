<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2021-09-21
  Time: 오후 11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h1>${time}</h1>

    <form id="actionForm" action="/miniboard/view" method="get">
        <input type="hidden" name="divisionId" value="${divisionDTO.divisionId}">
    </form>
</body>
</html>
