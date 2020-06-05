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
<html>
    <head>
        <title>post</title>
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
        </style>
        <!-- Custom styles for this template -->
        <link href="https://fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link rel="stylesheet" href="<c:url value="/assets/custom/blog.css" />" />
    </head>
    <%--@elvariable id="user" type="User"--%>
    <%--@elvariable id="bloger" type="User"--%>
    <%--@elvariable id="blog" type="Blog"--%>
    <%--@elvariable id="categories" type="List<Category>"--%>
    <%--@elvariable id="post" type="Post"--%>
    <%--@elvariable id="posts" type="List<Post>"--%>
    <%--@elvariable id="categoryName" type="String"--%>
    <%--@elvariable id="replies" type="List<Reply>"--%>
    <%--@elvariable id="emptyReplyMessage" type="String"--%>
    <body>
        <c:import url="/WEB-INF/views/common/header.jsp" />
        <main role="main" class="container">
            <div class="row">
                <div class="col-md-8 blog-main">
                    <h3 class="pb-4 mb-4 border-bottom">
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
                            <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                                <div class="col p-4 d-flex flex-column position-static">
                                    <strong class="d-inline-block mb-2 text-primary">World</strong>
                                    <h3 class="mb-0">Featured post</h3>
                                    <div class="mb-1 text-muted">Nov 12</div>
                                    <p class="card-text mb-auto">This is a wider card with supporting text below as a natural lead-in to additional content.</p>
                                    <a href="#" class="stretched-link">Continue reading</a>
                                </div>
                                <div class="col-auto d-none d-lg-block">
                                    <svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: Thumbnail"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                                <div class="col p-4 d-flex flex-column position-static">
                                    <strong class="d-inline-block mb-2 text-success">Design</strong>
                                    <h3 class="mb-0">Post title</h3>
                                    <div class="mb-1 text-muted">Nov 11</div>
                                    <p class="mb-auto">This is a wider card with supporting text below as a natural lead-in to additional content.</p>
                                    <a href="#" class="stretched-link">Continue reading</a>
                                </div>
                                <div class="col-auto d-none d-lg-block">
                                    <svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: Thumbnail"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
                                </div>
                            </div>
                        </div>
                    </div>

                    <nav class="blog-pagination">
                        <a class="btn btn-outline-primary" href="#">Older</a>
                        <a class="btn btn-outline-secondary disabled" href="#" tabindex="-1" aria-disabled="true">Newer</a>
                    </nav>

                </div><!-- /.blog-main -->

                <aside class="col-md-4 blog-sidebar">
                    <div class="p-4 mb-3 bg-light rounded">
                        <h4 class="font-italic">About</h4>
                        <p class="mb-0">Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>
                    </div>

                    <div class="p-4">
                        <h4 class="font-italic">카테고리</h4>
                        <ol class="list-unstyled mb-0">
                            <c:forEach items="${categories}" var="category">
                                <li><a href="<c:url value="/${bloger.nickname}/categories/${category.categoryNo}" />">${category.category}</a></li>
                            </c:forEach>
                        </ol>
                    </div>

                </aside><!-- /.blog-sidebar -->

            </div><!-- /.row -->

        </main><!-- /.container -->

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
        --%>

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
        <%-- 댓글 --%>
        <h3>댓글</h3>
        <a href="<c:url value="/${bloger.nickname}/${post.postNo}?isCreateReply=true&isUpdateReply=false&isDeleteReply=false" />">댓글 작성하기</a>
        <a href="<c:url value="/${bloger.nickname}/${post.postNo}?isCreateReply=false&isUpdateReply=true&isDeleteReply=false" />">댓글 수정하기</a>
        <a href="<c:url value="/${bloger.nickname}/${post.postNo}?isCreateReply=false&isUpdateReply=false&isDeleteReply=true" />">댓글 삭제하기</a>
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
            </c:otherwise>
        </c:choose>
        <c:import url="/WEB-INF/views/common/footer.jsp" />
    </body>
</html>
