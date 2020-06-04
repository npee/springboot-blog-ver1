<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020-05-07
  Time: 오후 6:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

    <c:import url="/WEB-INF/views/common/footer.jsp" />

    <h1>body</h1>
    <h2>title: ${blog.title}</h2>
    <h3>userNo: ${bloger.userNo}</h3>
    <h3>nickname: ${bloger.nickname}</h3>
    <h3>email: ${bloger.email}</h3>
    <h3>registered: ${bloger.registerDate}</h3>

    <c:choose>
        <c:when test="${empty user}">
            <h2>user: empty</h2>
        </c:when>
        <c:when test="${user.userNo eq bloger.userNo }">
            <h2>user: author</h2>
            <h3>새 카테고리(blog-settings로 이전)</h3>
            <h3>글쓰기</h3>
            <c:choose>
                <c:when test="${empty categories}">
                    <p>카테고리 목록이 비어있습니다. 새 카테고리를 먼저 생성해주세요.</p>
                </c:when>
                <c:otherwise>
                    <a href="/${user.nickname}/write">글쓰기</a>
                </c:otherwise>
            </c:choose>

        </c:when>
        <c:otherwise>
            <h2>user: guest(${user.nickname})</h2>
        </c:otherwise>
    </c:choose>

    <h3>category list</h3>
    <ul id="category-list">
        <c:forEach items="${categories}" var="category">
            <li><a href="<c:url value="/${user.nickname}/categories/${category.categoryNo}" />">${category.category}</a></li>
        </c:forEach>
    </ul>

    <h3>post list</h3>
    <ul id="post-list">
        <c:forEach items="${posts}" var="post">
            <li><a href="<c:url value="/${bloger.nickname}/${post.postNo}" />">${post.title}</a></li>
        </c:forEach>
    </ul>

</body>
</html>
