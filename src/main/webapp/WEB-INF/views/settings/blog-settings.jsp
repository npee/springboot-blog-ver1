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
        <%-- 기본설정/카테고리설정 분기 --%>
        <h2>블로그 프로필 수정</h2>

        <h1>카테고리 설정</h1>

        <%-- 생성/수정/삭제 폼 분기 --%>
        <h2><a href="<c:url value="/${user.nickname}/settings?categoryNo=0&isCreateCategory=true" />">카테고리 생성</a></h2>
        <c:choose>
            <c:when test="${param.isCreateCategory eq true}">
                <h3>TRUE</h3>
                <h3>카테고리 생성 폼</h3>
                <form action="<c:url value="/${user.nickname}/category" />" method="POST">
                    <label for="categoryName">카테고리 이름</label>
                    <input type="text" id="categoryName" name="categoryName" placeholder="카테고리 이름"><br>
                    <label for="categoryDescription">카테고리 설명(선택)</label>
                    <input type="text" id="categoryDescription" name="categoryDescription" placeholder="카테고리 설명"><br>
                    <input type="submit" id="create-category" value="생성">
                </form>
            </c:when>
            <c:otherwise>
                <h3>FALSE</h3>
            </c:otherwise>
        </c:choose>

        <h2><a href="<c:url value="/${user.nickname}/settings?isUpdateCategory=true&categoryNo=0" />">카테고리 수정</a></h2>
        <h3>카테고리 목록</h3>
        <c:choose>
            <c:when test="${empty categories}">
                <p>카테고리 목록이 비어있습니다. 새 카테고리를 생성해주세요.</p>
            </c:when>
            <c:otherwise>
                <c:forEach items="${categories}" var="category">
                    <ul>
                        <li><a href="<c:url value="/${user.nickname}/settings?isUpdateCategory=true&categoryNo=${category.categoryNo}" />">${category.category}</a></li>
                    </ul>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <c:if test="${param.isUpdateCategory eq true}">
            <c:forEach items="${categories}" var="category" >
                <c:if test="${(category.categoryNo - param.categoryNo) eq 0}">
                    <h3>카테고리 수정 폼</h3>
                    <form action="<c:url value="/${user.nickname}/update-category" />" method="POST">
                        <input type="hidden" name="updateCategoryNo" value="${param.categoryNo}">
                        <label for="update-category-name">카테고리 이름</label>
                        <input type="text" id="update-category-name" name="categoryName" value="${category.category}"><br>
                        <label for="update-category-description">카테고리 설명(선택)</label>
                        <input type="text" id="update-category-description" name="categoryDescription" value="${category.description}"><br>
                        <input type="submit" id="update-category" value="수정">
                    </form>
                </c:if>
            </c:forEach>
        </c:if>

        <h2><a href="<c:url value="/${user.nickname}/settings?categoryNo=0&isDeleteCategory=true" />">카테고리 삭제</a></h2>
        <c:choose>
            <c:when test="${param.isDeleteCategory eq true}">
                <c:choose>
                    <c:when test="${empty categories}">
                        <p>카테고리 목록이 비어있습니다. 새 카테고리를 생성해주세요.</p>
                    </c:when>
                    <c:otherwise>
                        <h3>TRUE</h3>
                        <h3>카테고리 삭제 폼</h3>
                        <form action="<c:url value="/${user.nickname}/delete-category" />" method="POST">
                            <label for="category-selectbox">Select Category</label>
                            <select name="deleteCategoryNo" id="category-selectbox">
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category.categoryNo}">${category.category}</option>
                                </c:forEach>
                            </select><br>
                            <input type="submit" id="delete-category" value="삭제">
                        </form>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <h3>FALSE</h3>
            </c:otherwise>
        </c:choose>
    </body>
</html>
