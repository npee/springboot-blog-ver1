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
                            <button id="post-write" type="submit">작성 완료</button>
                        </c:when>
                        <c:otherwise>
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
