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
</head>
<%--@elvariable id="user" type="User"--%>
<%--@elvariable id="bloger" type="User"--%>
<%--@elvariable id="blog" type="Blog"--%>
<%--@elvariable id="categories" type="List<Category>>"--%>
<%--@elvariable id="posts" type="List<Post>>"--%>
<body>
    <c:import url="/WEB-INF/views/common/header.jsp" />
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
            <a href="/${user.nickname}/write">글쓰기</a>
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
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
