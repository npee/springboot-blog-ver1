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
<%--@elvariable id="colorList" type="List<String>>"--%>
<div id="settings-blog">
    <div id="user-basic" class="form-row">
        <div class="form-group col-md-4">
            <p class="blog-p">닉네임</p>
        </div>
        <div class="form-group col-md-8">
            <input type="text" id="user-nickname" class="form-control" value="">
        </div>
    </div>
    <hr>
    <div id="blog-basic" class="form-row">
        <div class="form-group col-md-4">
            <p class="blog-p">블로그 제목</p>
        </div>
        <div class="form-group col-md-8">
            <input type="text" id="blog-title" class="form-control" value="">
        </div>
    </div>
    <hr>
    <div class="form-row">
        <div class="form-group col-md-4">
            <p> </p>
        </div>
        <div class="form-group col-md-6">
            <p> </p>
        </div>
        <div class="form-group col-md-2">
            <button id="update-blog-btn" class="btn btn-outline-dark" type="button">적용</button>
        </div>
    </div>

</div>