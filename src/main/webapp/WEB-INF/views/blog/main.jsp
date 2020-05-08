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
<body>
    <c:import url="/WEB-INF/views/common/header.jsp" />
    <h1>body</h1>
    <h2>title: ${blog.get().title}</h2>
    <h3>userNo: ${bloger.get().userNo}</h3>
    <h3>nickname: ${bloger.get().nickname}</h3>
    <h3>email: ${bloger.get().email}</h3>
    <h3>registered: ${bloger.get().registerDate}</h3>
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
