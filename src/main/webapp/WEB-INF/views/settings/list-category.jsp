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
    <div class="col-md-1">
        <%-- <img id="delete-category-icon" src="<c:url value="/assets/icons/dash-square.svg" />" alt="" title="Dash"> --%>
    </div>
    <div class="col-md-3">
        <p class="category-name">${category.category}</p>
    </div>
    <div class="col-md-8">
        <p class="category-description">${category.description}</p>
    </div>
</c:forEach>