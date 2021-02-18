<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:include page="web_header.jsp"/>
<jsp:useBean id="currentUser" scope="session" class="com.ncist.mymusic.entity.User"/>
<div class="container" style="padding: 0px;background: white;">
    <div class="post minHeight">
        <div id="mainRow" class="row clearfix">
            <div class="col-lg-3">
                <div class="userBox">
                    <div class="userAvatar">
                        <img class="center-block img-circle img-thumbnail avatarController"
                             src="/${currentUser.avatar}"/>
                        <div class="userName">
                            ${currentUser.name}
                        </div>
                    </div>
                    <div class="socialBox notSelect">
                        <div class="followBox">
                            <h5>关注</h5>
                            <a href="/user/followList/${currentUser.id}/1">${currentUser.followNum}</a>
                        </div>
                        <div class="fanBox">
                            <h5>粉丝</h5>
                            <a href="/user/fanList/${currentUser.id}/1">${currentUser.fanNum}</a>
                        </div>
                    </div>
                    <div class="userInfo">
                        <div class="well">${currentUser.info}</div>
                    </div>
                </div>
            </div>
            <div class="col-lg-9">
                <div class="shareListBox">
                    <div class="titleBar">
                        <h3>动态</h3>
                        <a onclick="shareBtn_Click(0)" class="btn  operationBtn roundBtn">
                            <span class="icon glyphicon-plus"></span> 发表动态
                        </a>
                        <hr/>
                    </div>
                    <div class="shareBox">
                        <c:set var="index" value="1"/>
                        <c:forEach items="${SHARE_LIST}" var="SHARE">
                            <div class="media">
                                <div class="media-left media-top">
                                    <a href="/user/zone/${SHARE.userId}">
                                        <img class="media-object avatarLarge img-circle"
                                             src="/${SHARE.user.avatar}" alt="...">
                                    </a>
                                </div>
                                <div class="media-body">
                                    <h5 class="media-heading">${SHARE.user.name}</h5>
                                    <h5>
                                        <small><fmt:formatDate value="${SHARE.pubTime}" type="both" dateStyle="short"
                                                               timeStyle="short"/></small>
                                    </h5>
                                    <div class="mediaTextBox">
                                            ${SHARE.content}
                                    </div>
                                    <c:if test="${SHARE.musicId ne 0}">
                                        <div class="shareMusicBox">
                                            <div class="media">
                                                <div class="media-left">
                                                    <div class="shareMusicCover">
                                                        <img class="media-object coverSmall"
                                                             src="/${SHARE.music.cover}"
                                                             alt="...">
                                                        <div class="sharePlayBtn">
                                                            <span onclick="appendMusic(${SHARE.music.id})"
                                                                  class="fa fa-play-circle-o icon-red"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="media-body">
                                                    <h5 class="media-heading">
                                                        <a href="/music/detail/${SHARE.music.id}"class="font-black">${SHARE.music.name}
                                                        </a>
                                                    </h5>
                                                    <h5>
                                                        <small>
                                                            <a href="/artist/detail/${SHARE.music.artistId}"
                                                                  class="font-gray">${SHARE.music.player}</a>
                                                        </small>
                                                    </h5>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <span class="pull-right">
                                        <a data-toggle="collapse" href="#collapse${index}" aria-expanded="false"
                                           aria-controls="collapseExample">评论</a>
                                        <c:if test="${SHARE.userId eq currentUser.id}">丨 <a
                                                onclick="delShare(this,${SHARE.id})">删除</a></c:if>
                                    </span>
                                    <div class="shareCommentBox">
                                        <div class="collapse" id="collapse${index}">
                                            <div class="well max-width">
                                                <h4>评论</h4>
                                                <c:if test="${currentUser.level>=3}">
                                                <div class="form-group">
                                                    <textarea class="form-control" rows="3" wrap="hard"
                                                              placeholder="说点友善的话"></textarea>
                                                </div>
                                                <button onclick="shareComment(this,${SHARE.id},${currentUser.id})"
                                                        class="btn btn-info">评论
                                                </button>
                                                </c:if>
                                                <c:if test="${currentUser.level<3}">
                                                    <div class="form-group">
                                                    <textarea class="form-control" rows="3" wrap="hard"
                                                              placeholder="说点友善的话"></textarea>
                                                    </div>
                                                    <button class="btn btn-info" disabled>您已被禁言</button>
                                                </c:if>
                                                <hr>
                                                <c:set var="commentIndex" value="1"/>
                                                <div class="shareCommentBox">
                                                    <c:forEach items="${SHARE.commentList}" var="COMMENT">
                                                        <div class="media">
                                                            <div class="media-left media-top">
                                                                <a href="/user/zone/${COMMENT.uploaderId}">
                                                                    <img class="media-object img-circle img-thumbnail coverSmall"
                                                                         src="/${COMMENT.uploaderInfo.avatar}">
                                                                </a>
                                                            </div>
                                                            <div class="media-body">
                                                                <h5 class="media-heading">${COMMENT.uploaderInfo.name}</h5>
                                                                <h5>
                                                                    <small><fmt:formatDate value="${COMMENT.uploadTime}" type="both"/>
                                                                        <c:if test="${currentUser.id eq COMMENT.uploaderId}"><a onclick="delShareComment(this,${COMMENT.id})"> 删除</a></c:if>
                                                                    </small>
                                                                </h5>
                                                                <div class="mediaTextBox">
                                                                        ${COMMENT.content}
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <hr/>
                                                        <c:set var="commentIndex" value="${commentIndex+1}"/>
                                                    </c:forEach>
                                                </div>
                                                后面还有更多精彩评论 <a href="/share/detail/${SHARE.id}/1">去看看</a>
                                                <span class="icon glyphicon-remove pull-right icon-black"
                                                      data-toggle="collapse" href="#collapse${index}"
                                                      aria-expanded="false" aria-controls="collapseExample"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <hr/>
                            </div>
                            <c:set var="index" value="${index +1}"/>
                        </c:forEach>
                    </div>
                </div>
                <c:if test="${not empty SHARE_LIST}">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${pageInfo.isFirstPage}">
                            <li class="disabled">
                                <a href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${not pageInfo.isFirstPage}">
                            <li>
                                <a href="/share/myList/${pageInfo.prePage}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="index">
                            <c:if test="${index eq pageInfo.pageNum}">
                                <li class="active">
                                    <span>${index}</span>
                                </li>
                            </c:if>
                            <c:if test="${index ne pageInfo.pageNum}">
                                <li>
                                    <a href="/share/myList/${index}">${index}</a>
                                </li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.isLastPage}">
                            <li class="disabled">
                                <a href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${not pageInfo.isLastPage}">
                            <li>
                                <a href="/share/myList/${pageInfo.nextPage}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
                </c:if>
                <c:if test="${empty SHARE_LIST}">
                    <h1><small>发条动态见证当下</small></h1>
                </c:if>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</div>


<jsp:include page="audio_controller.jsp"/>
<script type="text/javascript" src="/js/web.js"></script>
</body>
</html>