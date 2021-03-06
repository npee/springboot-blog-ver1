<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020-05-07
  Time: 오후 6:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--@elvariable id="user" type="User"--%>
<%--@elvariable id="bloger" type="User"--%>
<%--@elvariable id="blog" type="Blog"--%>
<%--
<header>
    <h1>header</h1>
    <h2><a href="/">home</a></h2>
    <c:if test="${not empty bloger and not empty blog}">
        <h2><a href="<c:url value="/${bloger.nickname}" />">${blog.title}</a></h2>
    </c:if>
    <c:choose>
        <c:when test="${empty user}">
            <li><a href="<c:url value="/user/signup" />">회원가입</a></li>
            <li><a href="<c:url value="/user/signin" />">로그인</a></li>
        </c:when>
        <c:otherwise>
            <li>Session(user): ${user.nickname}</li>
            <li><a href="<c:url value="/user/settings" />">사용자 설정</a></li>
            <li><a href="<c:url value="/${user.nickname}" />">내 블로그</a></li>
            <li><a href="<c:url value="/${user.nickname}/settings" />">블로그 설정</a></li>
            <li><a href="<c:url value="/user/signout" />">로그아웃</a></li>
        </c:otherwise>
    </c:choose>
</header>
--%>
<div class="container">
    <header class="blog-header py-3">
        <div class="row">
            <div id="logo" class="col-2 text-center">
                <a class="blog-header-logo text-dark" href="<c:url value="/" /> ">
                    명찬의 JBlog
                </a>
            </div>
            <div id="header-btn-box" class="col-10 d-flex justify-content-end align-items-center">
                <c:choose>
                    <c:when test="${empty user}">
                        <a class="auth-btn btn btn-sm btn-outline-secondary" href="<c:url value="/user/signup" />">회원가입</a>
                        <a class="auth-btn btn btn-sm btn-outline-secondary" href="<c:url value="/user/signin" />">로그인</a>
                    </c:when>
                    <c:otherwise>
                        <a class="auth-btn btn btn-sm btn-outline-secondary" href="<c:url value="/${user.nickname}/settings" />">설정</a>
                        <a class="auth-btn btn btn-sm btn-outline-secondary" href="<c:url value="/${user.nickname}" />">내 블로그</a>
                        <a class="auth-btn btn btn-sm btn-outline-secondary" href="<c:url value="/user/signout" />">로그아웃</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>
</div>