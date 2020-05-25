<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020-05-14
  Time: 오후 3:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
    <head>
        <title>post</title>
    </head>
    <%--@elvariable id="user" type="User"--%>
    <%--@elvariable id="bloger" type="User"--%>
    <%--@elvariable id="blog" type="Blog"--%>
    <%--@elvariable id="categories" type="List<Category>"--%>
    <%--@elvariable id="post" type="Post"--%>
    <%--@elvariable id="posts" type="List<Post>"--%>
    <%--@elvariable id="categoryName" type="String"--%>
    <body>
        <c:import url="/WEB-INF/views/common/header.jsp" />
        <h1>body</h1>

        <h2>post</h2>
        <c:choose>
            <c:when test="${empty user}">
                <h2>Guest(Anonymous)</h2>
                <h3>${bloger.userNo}</h3>
            </c:when>
            <c:when test="${user.userNo eq bloger.userNo }">
                <h2>Autherized user</h2>
                <h3>${user.userNo}, ${bloger.userNo}</h3>
            </c:when>
            <c:otherwise>
                <h2>Guest(${user.nickname})</h2>
                <h3>${user.userNo}, ${bloger.userNo}</h3>
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
                <li><a href="<c:url value="/${user.nickname}/${post.postNo}" />">${post.title}</a></li>
            </c:forEach>
        </ul>

        <fmt:parseDate value="${post.registerDate}" pattern="yyyy-MM-dd'T'HH:mm" var="registerLDT" type="both" />
        <fmt:parseDate value="${post.modifyDate}" pattern="yyyy-MM-dd'T'HH:mm" var="modifyLDT" type="both" />

        <fmt:formatDate value="${registerLDT}" pattern="yyyy년 MM월 dd일" var="postRegisterDate" />
        <fmt:formatDate value="${modifyLDT}" pattern="yyyy년 MM월 dd일" var="postModifyDate" />
        <!-- READ A POST -->
        <!-- FIX -->

        <h1>${post.title}</h1>
        <p>Created: ${postRegisterDate}, Modified: ${postModifyDate}, count: ${post.count}</p>
        <h2>${post.postFromCategory.category}</h2>
        <p>${post.body}</p>
        <c:choose>
            <c:when test="${empty user}">
                <h2>Guest(Anonymous)</h2>
                <h3>${bloger.userNo}</h3>
            </c:when>
            <c:when test="${user.userNo eq bloger.userNo }">
                <h2>Autherized user</h2>
                <h3>${user.userNo}, ${bloger.userNo}</h3>
                <a href="<c:url value="/${user.nickname}/update-post" />">포스트 수정</a>
            </c:when>
            <c:otherwise>
                <h2>Guest(${user.nickname})</h2>
                <h3>${user.userNo}, ${bloger.userNo}</h3>
<%--                <form action="<c:url value="/${user.nickname}/write" />" method="POST">--%>

<%--                </form>--%>
            </c:otherwise>
        </c:choose>




<%--        <form action="<c:url value="/${user.get().nickname}/${category.get().categoryNo}" />" method="POST">--%>
<%--        </form>--%>

        <c:import url="/WEB-INF/views/common/footer.jsp" />
    </body>
</html>
