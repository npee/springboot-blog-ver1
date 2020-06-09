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

            /*
            #reply-box {
                padding: 10px;
                background-color: #ededed;
            }
            */

            #input-reply {
                margin: 10px;
                padding: 10px;
                resize: none;
            }

            #create-reply-btn {
                margin-left: 10px;
            }

            .reply-list {
                display: flex;
                justify-content: space-between;
                flex-direction: column;
                height: 120px;
            }

            .reply-list .reply-no {
                display: none;
            }

            .reply-list:nth-child(2n-1) {
                /* height: 100px; */
                background-color: #eeeeee;
            }

            .reply-list:nth-child(2n) {
                background-color: #e1e1e1;
            }

            .reply-button-box {
                padding: 10px;
            }

            .reply-list p {
                padding: 10px;
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

            <div> 댓글 컨테이너


                <div>
                    <a class="auth-btn btn btn-sm btn-outline-secondary" href="<c:url value="/${bloger.nickname}/${post.postNo}?isCreateReply=true&isUpdateReply=false&isDeleteReply=false" />;return false;">댓글 작성하기</a>
                    <a class="auth-btn btn btn-sm btn-outline-secondary" href="<c:url value="/${bloger.nickname}/${post.postNo}?isCreateReply=false&isUpdateReply=true&isDeleteReply=false" />;return false;">댓글 수정하기</a>
                    <a class="auth-btn btn btn-sm btn-outline-secondary" href="<c:url value="/${bloger.nickname}/${post.postNo}?isCreateReply=false&isUpdateReply=false&isDeleteReply=true" />;return false;">댓글 삭제하기</a>
                </div>
                <div> 댓글 작성란

                </div>
                <div>댓글 목록

                </div>

            </div>
        </main><!-- /.container -->

        <c:import url="/WEB-INF/views/common/footer.jsp" />
        <%--
        <c:choose>
            <c:when test="${empty user}">
                <h2>Guest(Anonymous)</h2>
                <h3>${bloger.userNo}</h3>
            </c:when>
            <c:when test="${user.userNo eq bloger.userNo }">
                <h2>Autherized user</h2>
                <h3>${user.userNo}, ${bloger.userNo}</h3>
            </c:when>
            <c:otherwise>
                <h2>Guest(${user.nickname})</h2>
                <h3>${user.userNo}, ${bloger.userNo}</h3>
            </c:otherwise>
        </c:choose>


        <h3>post list</h3>
        <ul id="post-list">
            <c:forEach items="${posts}" var="post">
                <li><a href="<c:url value="/${bloger.nickname}/${post.postNo}" />">${post.title}</a></li>
            </c:forEach>
        </ul>


        <fmt:parseDate value="${post.modifyDate}" pattern="yyyy-MM-dd'T'HH:mm" var="modifyLDT" type="both" />

        <fmt:formatDate value="${modifyLDT}" pattern="yyyy년 MM월 dd일" var="postModifyDate" />

        <c:if test="${user.userNo eq bloger.userNo }">
            <a href="<c:url value="/${bloger.nickname}/update-post" />">포스트 수정</a>
            <a href="<c:url value="/${bloger.nickname}/delete-post?postNo=${post.postNo}" />">포스트 삭제</a>
        </c:if>
        --%>
        <%-- 댓글 --%>
        <h3>댓글</h3>
       <c:choose>
            <c:when test="${empty user}">
                <h2>Author: Guest(Anonymous)</h2>
                <h3>Bloger: ${bloger.userNo}</h3>
                <p>로그인후 댓글을 작성할 수 있습니다.</p>
            </c:when>
            <c:when test="${user.userNo eq bloger.userNo }">
                <h2>Author: Bloger(permitAll)</h2>
                <h3>${user.userNo}, ${bloger.userNo}</h3>

                <c:if test="${param.isCreateReply eq true}">
                    <h4>댓글 작성하기(내 포스트)</h4>
                    <%-- 댓글 작성 폼 --%>
                    <form action="<c:url value="/${bloger.nickname}/${post.postNo}/create-reply" />" method="POST">
                        <input type="hidden" name="userNo" value="${user.userNo}">
                        <label for="bloger-reply">댓글: </label>
                        <input type="text" name="newReply" id="bloger-reply"><br>
                        <input type="submit" value="댓글 작성">
                    </form>
                </c:if>

            </c:when>
            <c:otherwise>
                <h2>Author: Guest(${user.nickname})</h2>
                <h3>${user.userNo}, ${bloger.userNo}</h3>

                <c:if test="${param.isCreateReply eq true}">
                    <h4>댓글 작성하기(${bloger.nickname}의 포스트)</h4>
                    <%-- 댓글 작성 폼 --%>
                    <form action="<c:url value="/${bloger.nickname}/${post.postNo}/create-reply" />" method="POST">
                        <input type="hidden" name="userNo" value="${user.userNo}">
                        <label for="guest-reply">댓글: </label>
                        <input type="text" name="newReply" id="guest-reply"><br>
                        <input type="submit" value="댓글 작성">
                    </form>
                </c:if>

            </c:otherwise>
        </c:choose>

        <h4>댓글 목록</h4>
        <%-- 댓글 리스트 출력 & 수정, 삭제--%>
        <c:choose>
            <c:when test="${empty user}">
                <c:choose>
                    <c:when test="${empty replies}">
                        <ul>
                            <li>${emptyReplyMessage}</li>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <ul>
                            <c:forEach items="${replies}" var="reply">
                                <li>
                                    <p>작성자: ${reply.replyFromUser.nickname}</p>
                                    <c:choose>
                                        <c:when test="${reply.isBlind eq true}">
                                            <p>블라인드 처리된 댓글입니다.</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p>내용: ${reply.reply}</p>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:when test="${user.userNo eq bloger.userNo }">
                <c:choose>
                    <c:when test="${empty replies}">
                        <ul>
                            <li>${emptyReplyMessage}</li>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <ul>
                            <c:choose>
                                <c:when test="${param.isCreateReply eq true or empty param}">
                                    <c:forEach items="${replies}" var="reply">
                                        <li>
                                            <p>작성자: ${reply.replyFromUser.nickname}</p>
                                            <c:choose>
                                                <c:when test="${reply.isBlind eq true}">
                                                    <p>블라인드 처리된 댓글입니다.</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p>내용: ${reply.reply}</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </c:forEach>
                                </c:when>
                                <c:when test="${param.isUpdateReply eq true}">
                                    <p>댓글 수정 폼</p>
                                    <c:if test="${not empty param.updateReplyNo}">
                                        <form action="<c:url value="/${bloger.nickname}/${post.postNo}/update-reply" />" method="POST">
                                            <c:forEach items="${replies}" var="reply">
                                                <c:choose>
                                                    <c:when test="${reply.replyNo eq param.updateReplyNo and reply.replyFromUser.userNo eq user.userNo}">
                                                        <label>내용:</label>
                                                        <input type="hidden" name="userNo" value="${user.userNo}">
                                                        <input type="hidden" name="replyNo" value="${reply.replyNo}">

                                                        <input type="text" name="updatedReply" value="${reply.reply}"><br>
                                                        <input type="submit" value="수정 완료">
                                                    </c:when>
                                                    <c:when test="${reply.replyNo eq param.updateReplyNo and param.isBlind eq false}">
                                                        <label>내용:</label>
                                                        <input type="hidden" name="userNo" value="${user.userNo}">
                                                        <input type="hidden" name="replyNo" value="${reply.replyNo}">

                                                        <input type="hidden" name="isBlind" value="true">
                                                        <input type="hidden" name="updatedReply" value="${reply.reply}">
                                                        <p>${reply.reply}</p>
                                                        <input type="submit" value="블라인드">
                                                    </c:when>
                                                    <c:when test="${reply.replyNo eq param.updateReplyNo and param.isBlind eq true}">
                                                        <label>내용:</label>
                                                        <input type="hidden" name="userNo" value="${user.userNo}">
                                                        <input type="hidden" name="replyNo" value="${reply.replyNo}">

                                                        <input type="hidden" name="isBlind" value="false">
                                                        <input type="hidden" name="updatedReply" value="${reply.reply}">
                                                        <p>${reply.reply}</p>
                                                        <input type="submit" value="블라인드 해제">
                                                    </c:when>
                                                </c:choose>
                                            </c:forEach>
                                        </form>
                                    </c:if>
                                    <c:forEach items="${replies}" var="reply">
                                        <c:choose>
                                            <c:when test="${user.userNo eq reply.replyFromUser.userNo}">
                                                <li>
                                                    <p>작성자: ${reply.replyFromUser.nickname}</p>
                                                    <p>내용: ${reply.reply}</p>
                                                    <a href="<c:url value="/${bloger.nickname}/${post.postNo}?isUpdateReply=true&updateReplyNo=${reply.replyNo}" />">수정하기</a>
                                                </li>
                                            </c:when>
                                            <c:when test="${reply.isBlind eq false}">
                                                <li>
                                                    <p>작성자: ${reply.replyFromUser.nickname}</p>
                                                    <p>내용: ${reply.reply}</p>
                                                    <a href="<c:url value="/${bloger.nickname}/${post.postNo}?isUpdateReply=true&updateReplyNo=${reply.replyNo}&isBlind=false" />">블라인드</a>
                                                </li>
                                            </c:when>
                                            <c:when test="${reply.isBlind eq true}">
                                                <li>
                                                    <p>작성자: ${reply.replyFromUser.nickname}</p>
                                                    <p>블라인드 처리된 댓글입니다.</p>
                                                    <a href="<c:url value="/${bloger.nickname}/${post.postNo}?isUpdateReply=true&updateReplyNo=${reply.replyNo}&isBlind=true" />">블라인드 해제</a>
                                                </li>
                                            </c:when>
                                        </c:choose>
                                    </c:forEach>
                                </c:when>
                                <c:when test="${param.isDeleteReply eq true}">
                                    <p>댓글 삭제 폼</p>
                                    <c:if test="${param.isDeleteReply eq true}">
                                        <c:forEach items="${replies}" var="reply">
                                            <c:if test="${reply.replyNo eq param.deleteReplyNo and reply.replyFromUser.userNo eq user.userNo}">
                                                <form action="<c:url value="/${bloger.nickname}/${post.postNo}/delete-reply" />" method="POST">
                                                    <input type="hidden" name="userNo" value="${user.userNo}">
                                                    <input type="hidden" name="replyNo" value="${reply.replyNo}">
                                                    <p>내용</p>
                                                    <p>${reply.reply}</p>
                                                    <input type="submit" value="삭제">
                                                </form>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <c:forEach items="${replies}" var="reply">
                                        <c:choose>
                                            <c:when test="${user.userNo eq reply.replyFromUser.userNo}">
                                                <li>
                                                    <p>작성자: ${reply.replyFromUser.nickname}</p>
                                                    <p>내용: ${reply.reply}</p>
                                                    <a href="<c:url value="/${bloger.nickname}/${post.postNo}?isDeleteReply=true&deleteReplyNo=${reply.replyNo}" />">삭제</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li>
                                                    <p>작성자: ${reply.replyFromUser.nickname}</p>
                                                    <c:choose>
                                                        <c:when test="${reply.isBlind eq true}">
                                                            <p>블라인드 처리된 댓글입니다.</p>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p>내용: ${reply.reply}</p>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </c:when>
                            </c:choose>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${empty replies}">
                        <ul>
                            <li>${emptyReplyMessage}</li>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <ul>
                            <c:choose>
                                <c:when test="${param.isCreateReply eq true or empty param}">
                                    <c:forEach items="${replies}" var="reply">
                                        <li>
                                            <p>작성자: ${reply.replyFromUser.nickname}</p>
                                            <c:choose>
                                                <c:when test="${reply.isBlind eq true}">
                                                    <p>블라인드 처리된 댓글입니다.</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p>내용: ${reply.reply}</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </c:forEach>
                                </c:when>
                                <c:when test="${param.isUpdateReply eq true}">
                                    <p>댓글 수정 폼</p>
                                    <c:if test="${not empty param.updateReplyNo}">
                                        <form action="<c:url value="/${bloger.nickname}/${post.postNo}/update-reply" />" method="POST">
                                            <c:forEach items="${replies}" var="reply">
                                                <c:if test="${reply.replyNo eq param.updateReplyNo and reply.replyFromUser.userNo eq user.userNo}">
                                                    <label>내용:</label>
                                                    <input type="hidden" name="isBlind" value="${false}">
                                                    <input type="hidden" name="userNo" value="${user.userNo}">
                                                    <input type="hidden" name="replyNo" value="${reply.replyNo}">
                                                    <input type="text" name="updatedReply" value="${reply.reply}"><br>
                                                    <input type="submit" value="수정 완료">
                                                </c:if>
                                            </c:forEach>
                                        </form>
                                    </c:if>
                                    <c:forEach items="${replies}" var="reply">
                                        <c:choose>
                                            <c:when test="${user.userNo eq reply.replyFromUser.userNo}">
                                                <li>
                                                    <p>작성자: ${reply.replyFromUser.nickname}</p>
                                                    <p>내용: ${reply.reply}</p>
                                                    <a href="<c:url value="/${bloger.nickname}/${post.postNo}?isUpdateReply=true&updateReplyNo=${reply.replyNo}" />">수정하기</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li>
                                                    <p>작성자: ${reply.replyFromUser.nickname}</p>
                                                    <c:choose>
                                                        <c:when test="${reply.isBlind eq true}">
                                                            <p>블라인드 처리된 댓글입니다.</p>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p>내용: ${reply.reply}</p>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </c:when>
                            </c:choose>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
        <script src="<c:url value="/webjars/jquery/3.4.1/jquery.min.js" />"></script>
        <script>
            $(function() {
                window.onbeforeunload = function () {
                    window.scrollTo(0, 0);
                }

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

                // 댓글 등록
                $(document).on("click", "#create-reply-btn", function () {
                    const inputReply = $("#input-reply");
                    const userNo = '<c:out value="${user.userNo}" />';
                    if (inputReply.length === 0) {
                        alert("댓글을 입력해주세요");
                        inputReply.focus();
                        return false;
                    }
                    $.ajax({
                        url: "<c:url value="/${bloger.nickname}/${post.postNo}/create-reply" />",
                        method: "POST",
                        data: {
                            userNo: userNo,
                            newReply: inputReply,
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
                });
                // 댓글 수정
                $(document).on("click", ".update-reply-btn", function () {
                    const userNo = '<c:out value="${user.userNo}" />';
                });
                // 댓글 블라인드
                $(document).on("click", ".blind-enable-reply-btn", function () {
                    const userNo = '<c:out value="${user.userNo}" />';
                });
                // 댓글 블라인드 해제
                $(document).on("click", ".blind-disable-reply-btn", function () {
                    const userNo = '<c:out value="${user.userNo}" />';
                });
                // 댓글 삭제
                $(document).on("click", ".delete-reply-btn", function () {
                    const userNo = '<c:out value="${user.userNo}" />';
                    <%-- 포스트의 모든 댓글의 번호를 불러오는 중이다. --%>
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
                        // alert(replyNo);
                    } else {
                        fetch_reply();
                    }
                });
            });
        </script>
    </body>
</html>
