<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020-05-07
  Time: 오후 6:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header>
    <h1>header</h1>
    <c:choose>
        <c:when test="${empty user}">
            <h2>Sessions not Exist!</h2>
        </c:when>
        <c:otherwise>
            <h2>Session(user): ${user.get().nickname}</h2>
        </c:otherwise>
    </c:choose>
</header>