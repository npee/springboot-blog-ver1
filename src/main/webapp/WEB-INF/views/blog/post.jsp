<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020-05-14
  Time: 오후 3:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:parseDate value="${post.registerDate}" pattern="yyyy-MM-dd'T'HH:mm" var="registerLDT" type="both" />
<fmt:formatDate value="${registerLDT}" pattern="yyyy년 MM월 dd일" var="postRegisterDate" />
<%--@elvariable id="user" type="User"--%>
<%--@elvariable id="bloger" type="User"--%>
<%--@elvariable id="blog" type="Blog"--%>
<%--@elvariable id="categories" type="List<Category>"--%>
<%--@elvariable id="post" type="Post"--%>
<%--@elvariable id="posts" type="List<Post>"--%>
<%--@elvariable id="categoryName" type="String"--%>
<%--@elvariable id="replies" type="List<Reply>"--%>
<%--@elvariable id="emptyReplyMessage" type="String"--%>
<html>
    <head>
        <title>post</title>
        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="<c:url value="/assets/dist/css/bootstrap.css" />">

        <style>
            .bd-placeholder-img {
                font-size: 1.125rem;
                /* text-anchor: middle; */
                /* -webkit-user-select: none; */
                /* -moz-user-select: none; */
                /* -ms-user-select: none; */
                /* user-select: none; */
                height: 40px;
                color: #eceeef;
                background-color: #55595c;
                text-align: center;
                line-height: 40px;
            }


            @media (min-width: 768px) {
                .bd-placeholder-img-lg {
                    font-size: 3.5rem;
                }
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
            <div class="row">
                <div class="col-md-8 blog-main">
                    <h3 class="pt-2 pb-3 mb-4 border-bottom selected-category">
                        ${post.postFromCategory.category}
                    </h3>
                    <div class="blog-post">
                        <h2 class="blog-post-title">${post.title}</h2>
                        <p class="blog-post-meta">포스트 생성일: ${postRegisterDate} | 작성자: <a href="#">${bloger.nickname}</a></p>
                        <p>조회수: ${post.count}</p>
                        <c:if test="${user.userNo eq bloger.userNo }">
                            <a class="auth-btn btn btn-sm btn-outline-secondary" href="<c:url value="/${bloger.nickname}/update-post" />">포스트 수정</a>
                            <a class="auth-btn btn btn-sm btn-outline-secondary" href="<c:url value="/${bloger.nickname}/delete-post?postNo=${post.postNo}" />">포스트 삭제</a>
                        </c:if>
                        <hr>
                        ${post.body}
                    </div><!-- /.blog-post -->

                    <div class="row mb-2">
                        <div class="col-md-6">
                            <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative card-box">
                                <div class="col p-4 d-flex flex-column position-static">
                                    <strong class="d-inline-block mb-2 text-primary">Before</strong>
                                    <h3 class="mb-0 card-text">${post.title}</h3>
                                    <div class="mb-1 text-muted">${postRegisterDate}</div>
                                    <p class="card-text mb-auto">${post.body}</p>
                                    <a href="#" class="stretched-link">포스팅으로 이동</a>
                                </div>
                                <div class=" d-none d-lg-block">
                                    <div class="bd-placeholder-img">이전 포스트</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative card-box">
                                <div class="col p-4 d-flex flex-column position-static">
                                    <strong class="d-inline-block mb-2 text-primary">After</strong>
                                    <h3 class="mb-0 card-text">${post.title}</h3>
                                    <div class="mb-1 text-muted">${postRegisterDate}</div>
                                    <p class="card-text mb-auto">${post.body}</p>
                                    <a href="#" class="stretched-link">포스팅으로 이동</a>
                                </div>
                                <div class="d-none d-lg-block">
                                    <div class="bd-placeholder-img">다음 포스트</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div>
                        <div class="input-group mb-3 reply-input-box">
                            <label for="input-reply"></label>
                            <textarea name="" id="input-reply" cols="100%" rows="4" placeholder="댓글 입력란"></textarea>
                            <button class="btn btn-primary btn-sm" type="button" id="create-reply-btn">등록</button>
                        </div>
                    </div>
                    <hr>
                    <div id="reply-box">
                    </div>

                </div><!-- /.blog-main -->

                <aside class="col-md-4 blog-sidebar">
                    <div class="p-4 mb-3 bg-light rounded">
                        <h4 class="">${bloger.nickname}님의 블로그</h4>
                        <p class="mb-0">email: ${bloger.email}</p>
                        <p class="mb-0">기타 프로필</p>
                    </div>

                    <div class="p-4">
                        <h4 class="font-italic">카테고리</h4>
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
            $(function() {
                window.onbeforeunload = function () {
                    window.scrollTo(0, 0);
                }

                let userNo = '<c:out value="${user.userNo}" />';

                function fetch_reply() {
                    $.ajax({
                        url: "<c:url value="/${bloger.nickname}/${post.postNo}/reply" />",
                        method: "GET",
                        success: function(data) {
                            $("#reply-box").html(data);
                        },
                        error: function () {
                            alert("error");
                        }
                    });
                }

                fetch_reply();

                $(document).on("click", "#create-reply-btn", function () {
                    const inputReply = $("#input-reply");

                    if (userNo == null || userNo === '') {
                        alert("로그인이 필요한 서비스입니다.");
                    } else if (inputReply.val().trim() === '') {
                        alert("댓글을 입력해주세요");
                        inputReply.focus();
                    } else {
                        $.ajax({
                            url: "<c:url value="/${bloger.nickname}/${post.postNo}/create-reply" />",
                            method: "POST",
                            data: {
                                userNo: userNo,
                                newReply: inputReply.val(),
                            },
                            success: function() {
                                alert("댓글이 등록되었습니다.");
                                inputReply.val("");
                                fetch_reply();
                            },
                            error: function(data) {
                                alert("error" + data);
                            }
                        });
                    }
                });

                $(document).on("click", ".update-reply-btn", function () {
                    $(".reply-button-box button").attr("disabled", "true");
                    $("#create-reply-btn").attr("disabled", "true");
                    const replyNo = $(this).parent().parent().children(".reply-no").text();
                    const currentReply = $(this).parent().siblings("p").text();
                    const replyBox = $(this).parent().parent(".reply-list");
                    replyBox.children("strong").css("display", "none");
                    replyBox.children("p").css("display", "none");
                    replyBox.prepend('<div id="update-reply-box"></div>');
                    $("#update-reply-box").append('<div class="input-group reply-input-box"><textarea name="" id="update-reply" cols="100%" rows="4">' + currentReply + '</textarea></div>');
                    replyBox.children(".reply-button-box").children("button").css("display", "none");
                    replyBox.children(".reply-button-box").append('<button class="btn btn-primary btn-sm update-reply-confirm-btn" type="button">확인</button>');
                    replyBox.children(".reply-button-box").append('<button class="btn btn-danger btn-sm update-reply-reset-btn" type="button">취소</button>');

                    $(document).on("click", ".update-reply-confirm-btn", function() {
                        if (confirm("댓글을 수정하시겠습니까?")) {
                            const updatedReply = $("#update-reply").val();
                            $.ajax({
                                url: "<c:url value="/${bloger.nickname}/${post.postNo}/update-reply" />",
                                method: "POST",
                                data: {
                                    userNo: userNo,
                                    replyNo: replyNo,
                                    updatedReply: updatedReply,
                                },
                                success: function() {
                                    fetch_reply();
                                    $("#create-reply-btn").attr("disabled", "false");
                                },
                                error: function(data) {
                                    alert("error" + data);
                                }
                            });
                        } else {
                            fetch_reply();
                        }
                    });
                    $(document).on("click", ".update-reply-reset-btn", function() {
                        fetch_reply();
                        $("#create-reply-btn").attr("disabled", "false");
                    });
                });

                $(document).on("click", ".blind-enable-reply-btn", function () {
                    const replyNo = $(this).parent().parent().children(".reply-no").text();
                    if (confirm("블라인드 처리하시겠습니까?")) {
                        $.ajax({
                            url: "<c:url value="/${bloger.nickname}/${post.postNo}/update-reply" />",
                            method: "POST",
                            data: {
                                userNo: userNo,
                                replyNo: replyNo,
                                isBlind: "true",
                            },
                            success: function() {
                                fetch_reply();
                            },
                            error: function(data) {
                                alert("error" + data);
                            }
                        });
                    } else {
                        fetch_reply();
                    }
                });

                $(document).on("click", ".blind-disable-reply-btn", function () {
                    const replyNo = $(this).parent().parent().children(".reply-no").text();
                    if (confirm("블라인드 해제하시겠습니까?")) {
                        $.ajax({
                            url: "<c:url value="/${bloger.nickname}/${post.postNo}/update-reply" />",
                            method: "POST",
                            data: {
                                userNo: userNo,
                                replyNo: replyNo,
                                isBlind: "false",
                            },
                            success: function() {
                                fetch_reply();
                            },
                            error: function(data) {
                                alert("error" + data);
                            }
                        });
                    } else {
                        fetch_reply();
                    }
                });

                $(document).on("click", ".delete-reply-btn", function () {
                    const replyNo = $(this).parent().parent().children(".reply-no").text();
                    if (confirm("댓글을 삭제하시겠습니까?")) {
                        $.ajax({
                            url: "<c:url value="/${bloger.nickname}/${post.postNo}/delete-reply" />",
                            method: "POST",
                            data: {
                                userNo: userNo,
                                replyNo: replyNo,
                            },
                            success: function() {
                                fetch_reply();
                            },
                            error: function(data) {
                                alert("error" + data);
                            }
                        });
                    } else {
                        fetch_reply();
                    }
                });
            });
        </script>
    </body>
</html>
