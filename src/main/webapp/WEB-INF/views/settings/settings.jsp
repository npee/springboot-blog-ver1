<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020-06-09
  Time: 오후 6:40
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
<%--@elvariable id="colorList" type="List<String>>"--%>
<html>
    <head>
        <title>블로그 설정</title>
        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="<c:url value="/assets/dist/css/bootstrap.css" />">
        <!-- Custom styles for this template -->
        <link href="https://fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link rel="stylesheet" href="<c:url value="/assets/custom/blog.css" />" />
        <link rel="stylesheet" href="<c:url value="/assets/custom/settings.css" />" />
        <style>
            .category-box > div, .category-box-head > div {
                height: 40px;
                line-height: 40px;
            }

            #category-box-head {
                border-bottom-style: solid;
                border-bottom-color: #5a6268;
            }

            .category-box-head > div:first-child {
                text-align: center;
            }

        </style>
    </head>
    <body>
        <c:import url="/WEB-INF/views/common/header.jsp" />

        <main role="main" class="container">
            <div class="row">
                <div class="col-md-8 blog-main">
                    <h3 class="pt-2 pb-3 mb-4 border-bottom selected-category">
                        Settings
                    </h3>
                    <div id="settings"></div>
                    <hr>
                    <div>
                        <div id="blog-category">
                            <div id="category-box-head" class="form-row">
                                <div class="col-md-1"></div>
                                <div class="col-md-3"><p class="category-name">카테고리</p></div>
                                <div class="col-md-8"><p class="category-description">설명</p></div>
                            </div>
                            <div id="category-box"></div>
                            <div class="category-form form-row">
                                <div class="form-group col-md-1">
                                    <img id="create-category-icon" src="<c:url value="/assets/icons/plus-square.svg" />" alt="" title="카테고리 추가">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="category-name"></label>
                                    <input type="text" class="form-control" id="category-name">
                                </div>
                                <div class="form-group col-md-8">
                                    <label for="category-description"></label>
                                    <input type="text" class="form-control" id="category-description">
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <aside class="col-md-4 blog-sidebar">
                    <div class="p-4 mb-3 bg-light rounded">
                        <h4 class="">${bloger.nickname}님의 블로그</h4>
                        <p class="mb-0">email: ${bloger.email}</p>
                        <p class="mb-0">기타 프로필</p>
                    </div>

                    <div class="p-4">
                        <h4>메뉴</h4>
                        <ol class="list-unstyled mb-0">
                            <c:forEach items="${categories}" var="category">
                                <li><a href="<c:url value="/${bloger.nickname}?selectedCategory=${category.category}" />">${category.category}</a></li>
                            </c:forEach>
                        </ol>
                    </div>
                </aside>

            </div><!-- /.row -->
        </main><!-- /.container -->

        <c:import url="/WEB-INF/views/common/footer.jsp" />
        <script src="<c:url value="/webjars/jquery/3.4.1/jquery.min.js" />"></script>
        <script>
            $(document).ready(function() {
                let userNo = '<c:out value="${user.userNo}" />';
                let blogTitle = '<c:out value="${blog.title}" />';
                let blogerNickname = '<c:out value="${bloger.nickname}" />';

                function fetch_settings() {

                    $.ajax({
                        url: "<c:url value="/${bloger.nickname}/blog-settings" />",
                        method: "GET",
                        success: function(data) {
                            $("#settings").html(data);
                            $("#blog-title").val(blogTitle);
                            $("#user-nickname").val(blogerNickname);
                        },
                        error: function () {
                            alert("error");
                        }
                    });
                }

                $(document).on("click", "#update-blog-btn", function () {
                    const updatedBlogTitle = $("#blog-title").val();
                    const updatedUserNickname = $("#user-nickname").val();
                    $.ajax({
                        url: "<c:url value="/${bloger.nickname}/blog-settings" />",
                        method: "POST",
                        data: {
                            title: updatedBlogTitle,
                            updatedNickname: updatedUserNickname,
                            image: "white",
                        },
                        success: function () {
                            alert("내 정보가 변경되었습니다.");
                            blogTitle = updatedBlogTitle;
                            blogerNickname = updatedUserNickname;
                            location.href = "../../" + updatedUserNickname + "/settings";
                        },
                        error: function (data) {
                            alert("error" + data);
                        }
                    });
                });

                function fetch_category() {
                    $.ajax({
                        url: "<c:url value="/${bloger.nickname}/categories" />",
                        method: "GET",
                        success: function(data) {
                            $("#category-box").html(data);
                        },
                        error: function () {
                            alert("error");
                        }
                    });
                }

                fetch_settings();
                fetch_category();

                $(document).on("click", "#create-category-icon", function () {
                    const inputCategoryName = $("#category-name");
                    const inputCategoryDesc = $("#category-description");

                    if (inputCategoryName.val().trim() === '') {
                        alert("카테고리 이름을 입력해 주세요.");
                        inputCategoryName.focus();
                    } else if (inputCategoryDesc.val().trim() === '') {
                        alert("카테고리 설명을 입력해 주세요.");
                        inputCategoryDesc.focus();
                    } else {
                        $.ajax({
                            url: "<c:url value="/${bloger.nickname}/category" />",
                            method: "POST",
                            data: {
                                categoryName: inputCategoryName.val(),
                                categoryDescription: inputCategoryDesc.val(),
                            },
                            success: function() {
                                alert("카테고리가 등록되었습니다.");
                                inputCategoryName.val("");
                                inputCategoryDesc.val("");
                                fetch_category();
                            },
                            error: function(data) {
                                alert("error" + data);
                            }
                        });
                    }
                });

                $(document).on("click", ".update-category-icon", function() {
                    $(".update-category-icon").css("display", "none");
                    $(this).parent().siblings(".update-category-box").css("display", "block");
                    $(this).parent().siblings(".form-group").children(".category-p").css("display", "none");
                    $(this).parent().siblings(".form-group").children(".update-input").css("display", "block");
                });

                $(document).on("click", ".cancel-icon", function() {
                    if (confirm("수정을 취소하시겠습니까?")) {
                        fetch_category();
                    }
                });

                $(document).on("click", ".confirm-icon", function() {
                    const inputUpdateCategoryName = $(this).parent().siblings(".form-group").children(".input-update-category-name");
                    const inputUpdateCategoryDesc = $(this).parent().siblings(".form-group").children(".input-update-category-description");
                    const categoryNo = $(this).siblings(".category-no").text();

                    if (confirm("수정하시겠습니까?")) {
                        $.ajax({
                            url: "<c:url value="/${bloger.nickname}/update-category" />",
                            method: "POST",
                            data: {
                                updateCategoryNo: categoryNo,
                                categoryName: inputUpdateCategoryName.val(),
                                categoryDescription: inputUpdateCategoryDesc.val(),
                            },
                            success: function() {
                                fetch_category();
                            },
                            error: function(data) {
                                alert("error" + data);
                            }
                        });
                    }
                });

                $(document).on("click", ".delete-icon", function () {
                    const categoryNo = $(this).siblings(".category-no").text();
                    if (confirm("카테고리를 삭제하시겠습니까?")) {
                        $.ajax({
                            url: "<c:url value="/${bloger.nickname}/delete-category" />",
                            method: "POST",
                            data: {
                                deleteCategoryNo: categoryNo,
                            },
                            success: function() {
                                fetch_category();
                            },
                            error: function(data) {
                                alert("error" + data);
                            }
                        });
                    } else {
                        fetch_category();
                    }
                });

            });
         </script>
    </body>
</html>
