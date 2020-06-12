<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020-05-07
  Time: 오후 6:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
    <head>
        <title>title</title>
        <link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/blog/">

        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="<c:url value="/assets/dist/css/bootstrap.css" />">

        <style>
            .bd-placeholder-img {
                font-size: 1.125rem;
                text-anchor: middle;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
            }

            .write-btn {
                margin-top: 1.0em;
            }

            @media (min-width: 768px) {
                .bd-placeholder-img-lg {
                    font-size: 3.5rem;
                }
            }
        </style>
        <!-- Custom styles for this template -->
        <link href="https://fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link rel="stylesheet" href="<c:url value="/assets/custom/blog.css" />" />
    </head>
    <%--@elvariable id="user" type="User"--%>
    <%--@elvariable id="bloger" type="User"--%>
    <%--@elvariable id="blog" type="Blog"--%>
    <%--@elvariable id="categories" type="List<Category>>"--%>
    <%--@elvariable id="posts" type="List<Post>>"--%>
    <body>
        <c:import url="/WEB-INF/views/common/header.jsp" />
        <main role="main" class="container">
            <div class="row">
                <div class="col-md-8 blog-main">
                    <div class="row">
                        <c:choose>
                            <c:when test="${empty user}">
                                <div class="col-md-12">
                                    <h3 class="pt-2 pb-3 mb-4 border-bottom selected-category">
                                        <c:choose>
                                            <c:when test="${empty param.selectedCategory}">
                                                카테고리: 전체
                                            </c:when>
                                            <c:otherwise>
                                                ${param.selectedCategory}
                                            </c:otherwise>
                                        </c:choose>
                                    </h3>
                                </div>
                            </c:when>
                            <c:when test="${user.userNo eq bloger.userNo }">
                                <div class="col-md-9">
                                    <h3 class="pt-2 pb-3 mb-4 border-bottom selected-category">
                                        <c:choose>
                                            <c:when test="${empty param.selectedCategory}">
                                                카테고리: 전체
                                            </c:when>
                                            <c:otherwise>
                                                ${param.selectedCategory}
                                            </c:otherwise>
                                        </c:choose>
                                    </h3>
                                </div>
                                <div class="col-md-3 text-center write-btn">
                                    <c:choose>
                                        <c:when test="${empty categories}">
                                            <a class="auth-btn btn btn-sm btn-outline-secondary" href="/${user.nickname}/settings">카테고리 생성</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="auth-btn btn btn-sm btn-outline-secondary" href="/${user.nickname}/write">글쓰기</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:when>
                        </c:choose>
                    </div>

                    <div class="row mb-2">
                        <c:choose>
                            <c:when test="${empty param.selectedCategory}">
                                <c:forEach items="${posts}" var="post">
                                    <fmt:parseDate value="${post.registerDate}" pattern="yyyy-MM-dd'T'HH:mm" var="registerLDT" type="both" />
                                    <fmt:formatDate value="${registerLDT}" pattern="yyyy년 MM월 dd일" var="postRegisterDate" />
                                    <div class="col-md-12">
                                        <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                                            <div class="col p-4 d-flex flex-column position-static">
                                                <strong class="d-inline-block mb-2 text-primary">${post.postFromCategory.category}</strong>
                                                <h3 class="mb-0">${post.title}</h3>
                                                <div class="mb-1 text-muted">${postRegisterDate}</div>
                                                <p class="card-text mb-auto">${post.body}</p>
                                                <a href="<c:url value="/${bloger.nickname}/${post.postNo}" />" class="stretched-link">해당 포스트로 이동</a>
                                            </div>
                                            <div class="col-auto d-none d-lg-block">
                                                <svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: Thumbnail"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">썸네일</text></svg>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${posts}" var="post">
                                    <c:if test="${post.postFromCategory.category eq param.selectedCategory}">
                                        <fmt:parseDate value="${post.registerDate}" pattern="yyyy-MM-dd'T'HH:mm" var="registerLDT" type="both" />
                                        <fmt:formatDate value="${registerLDT}" pattern="yyyy년 MM월 dd일" var="postRegisterDate" />
                                        <div class="col-md-12">
                                            <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                                                <div class="col p-4 d-flex flex-column position-static">
                                                    <strong class="d-inline-block mb-2 text-primary">${post.postFromCategory.category}</strong>
                                                    <h3 class="mb-0">${post.title}</h3>
                                                    <div class="mb-1 text-muted">${postRegisterDate}</div>
                                                    <p class="card-text mb-auto">${post.body}</p>
                                                    <a href="<c:url value="/${bloger.nickname}/${post.postNo}" />" class="stretched-link">해당 포스트로 이동</a>
                                                </div>
                                                <div class="col-auto d-none d-lg-block">
                                                    <svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: Thumbnail"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">썸네일</text></svg>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
                <aside class="col-md-4 blog-sidebar">
                    <div class="p-4 mb-3 bg-light rounded">
                        <h4 class=""><a class="text-dark" href="<c:url value="/${bloger.nickname}" />">${bloger.nickname}님의 블로그</a></h4>
                        <p class="mb-0">email: ${bloger.email}</p>
                        <p class="mb-0">기타 프로필</p>
                    </div>

                    <div class="p-4">
                        <h4 class="font-italic">카테고리</h4>
                        <ol class="list-unstyled mb-0">
                            <c:forEach items="${categories}" var="category">
                                <li><a href="<c:url value="/${bloger.nickname}?selectedCategory=${category.category}" />">${category.category}</a></li>
                            </c:forEach>
                        </ol>
                    </div>
                </aside>
            </div>
        </main>
        <c:import url="/WEB-INF/views/common/footer.jsp" />
    </body>
</html>
