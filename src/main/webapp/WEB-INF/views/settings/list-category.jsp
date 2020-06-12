<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020-06-09
  Time: 오후 6:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:forEach items="${categories}" var="category">
<div class="form-row">
    <div class="form-group col-md-1">
        <img class="update-category-icon" src="<c:url value="/assets/icons/pencil-square.svg" />" alt="" title="카테고리 수정">
    </div>
    <div class="form-group col-md-3">
        <input type="text" class="form-control update-input input-update-category-name" value="${category.category}">
        <p class="category-p category-name">${category.category}</p>
    </div>
    <div class="form-group col-md-8">
        <input type="text" class="form-control update-input input-update-category-description" value="${category.description}">
        <p class="category-p category-description">${category.description}</p>
    </div>
    <div class="col-md-1 update-category-box"></div>
    <div class="col-md-3 update-category-box update-icon-box">
        <span class="category-no">${category.categoryNo}</span>
        <img class="update-icon delete-icon" src="<c:url value="/assets/icons/dash-square.svg" />" alt="" title="카테고리 삭제">
        <img class="update-icon cancel-icon" src="<c:url value="/assets/icons/x-square.svg" />" alt="" title="수정 취소">
        <img class="update-icon confirm-icon" src="<c:url value="/assets/icons/check-square.svg" />" alt="" title="수정 확인">
    </div>
    <div class="col-md-8 update-category-box">
        <p class="category-desc-dummy">&nbsp;</p>
    </div>
</div>
</c:forEach>