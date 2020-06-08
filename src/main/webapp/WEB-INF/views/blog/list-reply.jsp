<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--@elvariable id="user" type="User"--%>
<%--@elvariable id="bloger" type="User"--%>
<%--@elvariable id="replies" type="List<Reply>"--%>
<c:forEach items="${replies}" var="reply">
    <div class="reply-list">
        <c:choose>
            <c:when test="${reply.isBlind eq false}">
                <p><strong>@${reply.replyFromUser.nickname} </strong>${reply.reply}</p>
            </c:when>
            <c:otherwise>
                <p><strong>@${reply.replyFromUser.nickname} </strong>블라인드 처리된 댓글입니다.</p>
            </c:otherwise>
        </c:choose>
        <div class="reply-button-box">
            <c:if test="${not empty user}">
                <c:choose>
                    <c:when test="${user.userNo eq reply.replyFromUser.userNo}">
                        <button id="update-reply-btn" class="btn btn-primary btn-sm" type="button">수정</button>
                        <button id="delete-reply-btn" class="btn btn-danger btn-sm" type="button">삭제</button>
                    </c:when>
                    <c:when test="${user.userNo eq bloger.userNo}">
                        <c:choose>
                            <c:when test="${reply.isBlind eq false}">
                                <button id="blind-enable-reply-btn" class="btn btn-warning btn-sm" type="button">블라인드</button>
                            </c:when>
                            <c:when test="${reply.isBlind eq true}">
                                <button id="blind-disable-reply-btn" class="btn btn-warning btn-sm" type="button">블라인드 해제</button>
                            </c:when>
                            <c:otherwise>
                                <p>Blind confusion?</p>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                </c:choose>
            </c:if>
        </div>
    </div>
</c:forEach>