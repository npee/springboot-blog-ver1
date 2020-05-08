<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020-05-08
  Time: 오전 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <c:import url="/WEB-INF/views/common/header.jsp" />
    <h1>body</h1>
    <form action="<c:url value="/user/signin" />" name="signinForm" method="POST">
        <label>이메일</label>
        <input type="email" id="email" name="email" />
        <br>
        <label>비밀번호</label>
        <input type="password" id="password" name="password" />
        <br>
        <input id="signin-btn" type="submit" name="submit" value="로그인">
    </form>
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
