<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020-05-08
  Time: 오전 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>

    <link rel="stylesheet" href="<c:url value="/assets/dist/css/bootstrap.css" />">
    <!-- Custom styles for this template -->
    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link rel="stylesheet" href="<c:url value="/assets/custom/blog.css" />" />
</head>
<body>
    <c:import url="/WEB-INF/views/common/header.jsp" />
    <div class="container">
        <h1>body</h1>
        <form action="<c:url value="/user/signup" />" name="signupForm" method="POST">
            <label>이메일</label>
            <!--<input type="email" id="email" name="email" />-->
            <input type="text" id="id" name="email" />
            <br>
            <label>비밀번호</label>
            <input type="password" id="password" name="password" />
            <br>
            <label>닉네임</label>
            <input type="text" name="nickname" />
            <br>
            <input id="register-btn" type="submit" name="submit" value="회원가입">
        </form>
    </div>
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
