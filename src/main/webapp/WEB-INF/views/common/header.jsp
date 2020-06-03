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
        <div class="row flex-nowrap justify-content-between align-items-center">

            <div class="col-4 pt-1">
                <!--<a class="text-muted" href="#">Subscribe</a>-->
            </div>

            <div class="col-4 text-center">
                <a class="blog-header-logo text-dark" href="#">Large</a>
            </div>
            <div class="col-4 d-flex justify-content-end align-items-center">
                <a class="text-muted" href="#" aria-label="Search">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="mx-3" role="img" viewBox="0 0 24 24" focusable="false"><title>Search</title><circle cx="10.5" cy="10.5" r="7.5"/><path d="M21 21l-5.2-5.2"/></svg>
                </a>
                <c:choose>
                    <c:when test="${empty user}">
                        <a class="auth-btn btn btn-sm btn-outline-secondary" href="<c:url value="/user/signup" />">회원가입</a>
                        <a class="auth-btn btn btn-sm btn-outline-secondary" href="<c:url value="/user/signin" />">로그인</a>
                    </c:when>
                    <c:otherwise>
                        <a class="auth-btn btn btn-sm btn-outline-secondary" href="<c:url value="/user/signout" />">로그아웃</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>
</div>