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
        <title>글쓰기</title>
        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="<c:url value="/assets/dist/css/bootstrap.css" />">

        <style>
            .bd-placeholder-img {
                font-size: 1.125rem;
                text-anchor: middle;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
            }

            @media (min-width: 768px) {
                .bd-placeholder-img-lg {
                    font-size: 3.5rem;
                }
            }

            #category2-label {
                width: 40%;
            }
            #category2 {
                width: 60%;
            }
            #post-title2-label {
                width: 20%;
            }
            #post-title2 {
                width: 80%;
            }

        </style>
        <!-- Custom styles for this template -->
        <link href="https://fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link rel="stylesheet" href="<c:url value="/assets/custom/blog.css" />" />
    </head>
    <body>
        <c:import url="/WEB-INF/views/common/header.jsp" />
        <main role="main" class="container">
            <!-- Bootstrap form -->
            <form>
                <div class="form-row">
                    <div class="col-md-12 my-3">
                        <h1 class="my-2">글쓰기</h1>
                    </div>

                    <div class="col-md-4 form-inline mb-3">
                        <label id="category2-label" for="category2">카테고리</label>
                        <select class="custom-select" name="categoryNo2" id="category2">
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
                        </select>
                    </div>
                    <div class="col-md-8 form-inline mb-3">
                        <label id="post-title2-label" for="post-title2">제목</label>
                        <input type="text" class="form-control" width="100%" id="post-title2" value="${post.title}">
                    </div>

                    <div class="col-md-12">
                        <label class="sr-only" for="post-body2">본문</label>
                        <textarea class="form-control" id="post-body2" rows="10">${post.body}</textarea>
                    </div>
                    <c:choose>
                        <c:when test="${empty post.postFromCategory}">
                            <c:set var="value" value="0" />
                            <c:set var="btnText" value="작성" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="value" value="${post.postNo}" />
                            <c:set var="btnText" value="수정" />
                        </c:otherwise>
                    </c:choose>
                    <input id="category2-value" type="hidden" name="postNo" value="${value}">
                    <button id="post-btn" class="btn btn-primary mx-2 my-2" type="button">${btnText}</button>
                </div>
            </form>
        </main>
        <c:import url="/WEB-INF/views/common/footer.jsp" />
        <script src="<c:url value="/webjars/jquery/3.4.1/jquery.min.js" />"></script>
        <script>
            $(function() {
                $(document).on("click", "#post-btn", function() {
                    $.ajax({
                        url: '<c:url value="/${user.nickname}/write" />',
                        method: 'POST',
                        data: {
                            postNo: $("#category2-value").val(),
                            categoryNo: $("#category2").find(":selected").val(),
                            postTitle: $("#post-title2").val(),
                            postBody: $("#post-body2").val(),
                        },
                        success: function() {
                            if ("작성" === $("#post-btn").text()) {
                                alert("포스트가 등록되었습니다.");
                            } else {
                                alert("포스트가 수정되었습니다.");
                            }
                            location.href = "./";
                        },
                        error: function(data) {
                            alert("error" + data);
                        }
                    });
                });
            });
        </script>
    </body>
</html>
