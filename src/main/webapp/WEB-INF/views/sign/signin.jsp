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
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Jekyll v4.0.1">
        <title>Signin Template Â· Bootstrap</title>

        <link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/sign-in/">

        <!-- Bootstrap core CSS -->
        <link href="<c:url value="/assets/dist/css/bootstrap.css" />" rel="stylesheet">

        <style>
            .bd-placeholder-img {
                font-size: 1.125rem;
                text-anchor: middle;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
            }

            @media (min-width: 768px) {
                .bd-placeholder-img-lg {
                    font-size: 3.5rem;
                }
            }
        </style>
        <!-- Custom styles for this template -->
        <link href="<c:url value="/assets/custom/signin.css" />" rel="stylesheet">
    </head>
    <body class="text-center">
        <form class="form-signin" action="<c:url value="/user/signin" />" name="signinForm" method="POST">
            <img class="mb-4" src="../assets/brand/bootstrap-solid.svg" alt="" width="72" height="72">
            <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
            <label for="inputEmail" class="sr-only">Email address</label>
            <input type="text" id="inputEmail" name="email" class="form-control" placeholder="Email address" required autofocus>
            <label for="inputPassword" class="sr-only">Password</label>
            <input type="password" id="inputPassword" name="password" class="form-control" placeholder="Password" required>
            <div class="checkbox mb-3">
                <label>
                    <input type="checkbox" value="remember-me"> Remember me
                </label>
            </div>
            <button id="signin-btn" class="btn btn-lg btn-primary btn-block" type="button">Sign in</button>
            <p class="mt-5 mb-3 text-muted">&copy; 2017-2020</p>
        </form>
    <script src="<c:url value="/webjars/jquery/3.4.1/jquery.min.js" />"></script>
    <script>
        $(function() {
            $(document).on("click", "#signin-btn", function() {
                const email = $("#inputEmail").val();
                const password = $("#inputPassword").val();
                const referer = '<c:out value="${referer}" />';
                $.ajax({
                    url: "<c:url value="/user/signin" />",
                    method: "POST",
                    data: {
                        email: email,
                        password: password,
                    },
                    success: function(data) {
                        location.href = referer;
                    },
                    error: function(data) {
                        alert("아이디와 비밀번호를 다시 확인해 주세요");
                        $("#inputPassword").val("");
                    }
                });
            });
        });
    </script>
    </body>
</html>
