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
<html>
    <head>
        <title>Title</title>
    </head>
    <body>
        <c:import url="/WEB-INF/views/common/header.jsp" />
        <h1>body</h1>
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
