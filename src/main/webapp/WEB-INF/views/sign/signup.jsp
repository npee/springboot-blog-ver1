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
    <link rel="stylesheet" href="<c:url value="/assets/custom/signup.css" />" />
</head>
<body>
    <div class="text-center">
        <form class="form-signup" action="<c:url value="/user/signup" />" name="signupForm" method="POST">
            <img class="mb-4" src="../assets/brand/bootstrap-solid.svg" alt="" width="72" height="72">
            <h1 class="h3 mb-3 font-weight-normal">회원가입</h1>
            <label for="email" class="sr-only">Email address</label>
            <input type="text" id="email" name="email" class="form-control" placeholder="Email address" required autofocus>
            <label for="password" class="sr-only">Password</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
            <label for="nickname" class="sr-only">Password</label>
            <input type="text" id="nickname" name="nickname" class="form-control" placeholder="Nickname" required>
            <div class="checkbox mb-3">
                <label>
                    <input type="checkbox" value="remember-me"> Remember me
                </label>
            </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit">Sign up</button>
            <p class="mt-5 mb-3 text-muted">&copy; 2017-2020</p>
        </form>
        <%--
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
        --%>
    </div>
</body>
</html>
