<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020-05-19
  Time: 오후 7:01
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
        <title>블로그 설정</title>
    </head>
    <body>
        <h1>기본 설정</h1>
        <h2>블로그 프로필 수정</h2>
        <h1>카테고리 설정</h1>
        <h2>카테고리 생성</h2>
        <h2>카테고리 수정, 삭제</h2>
        <h3>카테고리 목록</h3>
        <ul>
            <c:forEach items="${categories}" var="category">
                <li><a href="<c:url value="/${nickname}/settings?categoryNo=${category.categoryNo}" />">${category.category}</a></li>
            </c:forEach>
        </ul>

        <c:forEach items="${categories}" var="category" >
            <c:if test="${(category.categoryNo - param.categoryNo) eq 0}">
                <h3>카테고리 수정 폼</h3>
                <form action="<c:url value="/${nickname}/settings" />" method="POST">
                    <ul>
                        <li>카테고리 넘버: ${category.categoryNo}</li>
                        <li>카테고리 이름: <input type="text" name="newCategoryName" value="${category.category}"></li>
                        <li>카테고리 설명 : <input type="text" name="newCategoryDescription" value="${category.description}"></li>
                        <input type="submit" name="submit-btn" value="전송">
                    </ul>
                </form>
            </c:if>
        </c:forEach>
    </body>
</html>
