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
    <c:choose>
        <c:when test="${empty user}">
            <h2>user: empty</h2>
        </c:when>
        <c:when test="${user.userNo eq bloger.userNo }">
            <h2>user: author</h2>
        </c:when>
        <c:otherwise>
            <h2>user: guest(${user.nickname})</h2>
        </c:otherwise>
    </c:choose>
    <h2>title: ${blog.title}</h2>
    <h3>userNo: ${bloger.userNo}</h3>
    <h3>nickname: ${bloger.nickname}</h3>
    <h3>email: ${bloger.email}</h3>
    <h3>registered: ${bloger.registerDate}</h3>

    <h3>category list</h3>
    <ul id="category-list">
        <c:forEach items="${categories}" var="category">
            <li><a href="<c:url value="/${user.nickname}/categories/${category.categoryNo}" />">${category.category}</a></li>
        </c:forEach>
    </ul>

    <h3>post list</h3>
    <ul id="post-list">
        <c:forEach items="${posts}" var="post">
            <li><a href="<c:url value="/${user.nickname}/${post.postNo}" />">${post.title}</a></li>
        </c:forEach>
    </ul>

    <h2>write</h2>
    <!-- start -->
    <c:choose>
        <c:when test="${user.userNo eq bloger.userNo }">
            <form action="<c:url value="/${user.nickname}/write" />" method="POST">
                <label for="category">Select Category</label>
                <select name="categoryNo" id="category">
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.categoryNo}">${category.category}</option>
                    </c:forEach>
                </select><br>
                <label for="post-title">title: </label>
                <input id="post-title" type="text" name="postTitle" value=""><br>
                <label for="post-body">body: </label>
                <input id="post-body" type="text" name="postBody" value=""><br>
                <button id="post-submit" type="submit">submit</button>
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
