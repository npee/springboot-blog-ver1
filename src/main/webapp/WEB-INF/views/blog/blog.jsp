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
<%--@elvariable id="user" type="Optional<User>"--%>
<%--@elvariable id="bloger" type="Optional<User>"--%>
<%--@elvariable id="blog" type="Optional<Blog>"--%>
<%--@elvariable id="categories" type="List<Optional<Category>>"--%>
<body>
    <c:import url="/WEB-INF/views/common/header.jsp" />
    <h1>body</h1>
    <c:choose>
        <c:when test="${empty user}">
            <h2>user: empty</h2>
        </c:when>
        <c:when test="${user.get().userNo eq bloger.get().userNo }">
            <h2>user: author</h2>
        </c:when>
        <c:otherwise>
            <h2>user: guest(${user.get().nickname})</h2>
        </c:otherwise>
    </c:choose>
    <h2>title: ${blog.get().title}</h2>
    <h3>userNo: ${bloger.get().userNo}</h3>
    <h3>nickname: ${bloger.get().nickname}</h3>
    <h3>email: ${bloger.get().email}</h3>
    <h3>registered: ${bloger.get().registerDate}</h3>
    <h3>category list</h3>
    <ul>
        <c:forEach items="${categories}" var="category">
            <li>CategoryNo: ${category.get().categoryNo} | Category: ${category.get().category}</li>
        </c:forEach>
    </ul>
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
