<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020-05-05
  Time: 오후 7:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>title</title>
  </head>
  <%--@elvariable id="blogs" type="List<Blog>"--%>
  <body>
    <c:import url="/WEB-INF/views/common/header.jsp" />
    <h1>body</h1>
    <c:choose>
      <c:when test="${not empty blogs}">
        <c:forEach items="${blogs}" var="blog">
          <li><a href="/${blog.userTable.nickname}">${blog.title}</a></li>
        </c:forEach>
      </c:when>
    </c:choose>
    <c:import url="/WEB-INF/views/common/footer.jsp" />
  </body>
</html>
