<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020-05-15
  Time: 오후 6:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%--@elvariable id="user" type="User"--%>
<%--@elvariable id="bloger" type="User"--%>
<%--@elvariable id="blog" type="Blog"--%>
<%--@elvariable id="categories" type="List<Category>>"--%>
<%--@elvariable id="posts" type="List<Post>>"--%>
<%--@elvariable id="post" type="Post"--%>
<html>
    <head>
        <title>글쓰기</title>
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
    <body>
        <c:import url="/WEB-INF/views/common/header.jsp" />
        <h1>body</h1>
        <h2>write</h2>
        <!-- start -->
        <c:choose>
            <c:when test="${empty categories}">
                <p>카테고리를 먼저 생성해주세요.</p>
            </c:when>
            <c:when test="${user.userNo eq bloger.userNo }">
                <form action="<c:url value="/${user.nickname}/write" />" method="POST">
                    <label for="category">Select Category</label>
                    <select name="categoryNo" id="category">
                        <c:forEach items="${categories}" var="category">
                            <c:choose>
                                <c:when test="${category.categoryNo eq post.postFromCategory.categoryNo }">
                                    <option value="${category.categoryNo}" selected="selected">${category.category}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${category.categoryNo}">${category.category}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select><br>
                    <label for="post-title">title: </label>
                    <input id="post-title" type="text" name="postTitle" value="${post.title}"><br>
                    <label for="post-body">body: </label>
                    <input id="post-body" type="text" name="postBody" value="${post.body}"><br>
                    <c:choose>
                        <c:when test="${empty post.postFromCategory}">
                            <input type="hidden" name="postNo" value="0">
                            <button id="post-write" type="submit">작성 완료</button>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="postNo" value="${post.postNo}">
                            <button id="post-update" type="submit">수정 완료</button>
                        </c:otherwise>
                    </c:choose>

                </form>
            </c:when>
            <c:otherwise>
                <h3>Need Sign</h3>
            </c:otherwise>
        </c:choose>
        <!-- end -->
        <c:import url="/WEB-INF/views/common/footer.jsp" />
    </body>
</html>
