<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--@elvariable id="user" type="User"--%>
<%--@elvariable id="bloger" type="User"--%>
<%--@elvariable id="replies" type="List<Reply>"--%>
<c:forEach items="${replies}" var="reply">
    <div class="reply-list">
        <span class="reply-no">${reply.replyNo}</span>
        <c:choose>
            <c:when test="${reply.isBlind eq false}">
                <strong>@${reply.replyFromUser.nickname}</strong>
                <p>${reply.reply}</p>
            </c:when>
            <c:otherwise>
                <strong>@${reply.replyFromUser.nickname}</strong>
                <p>블라인드 처리된 댓글입니다.</p>
            </c:otherwise>
        </c:choose>
        <div class="reply-button-box">
            <c:if test="${not empty user}">
                <c:choose>
                    <c:when test="${user.userNo eq reply.replyFromUser.userNo}">
                        <button class="btn btn-primary btn-sm update-reply-btn" type="button" value="${reply.replyNo}">수정</button>
                        <button class="btn btn-danger btn-sm delete-reply-btn" type="button" value="${reply.replyNo}">삭제</button>
                    </c:when>
                    <c:when test="${user.userNo eq bloger.userNo}">
                        <c:choose>
                            <c:when test="${reply.isBlind eq false}">
                                <button class="btn btn-warning btn-sm blind-enable-reply-btn" type="button" value="${reply.replyNo}">블라인드</button>
                            </c:when>
                            <c:when test="${reply.isBlind eq true}">
                                <button class="btn btn-warning btn-sm blind-disable-reply-btn" type="button" value="${reply.replyNo}">블라인드 해제</button>
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