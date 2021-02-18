<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:include page="web_header.jsp"/>
<jsp:useBean id="currentUser" class="com.ncist.mymusic.entity.User" scope="session"/>
<div class="container" style="padding: 0px;background: white;">
    <div class="post" style="min-height: 700px;">
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
                <div class="media-left media-top">
                    <a href="/user/zone/${SHARE.userId}">
                        <img class="media-object avatarController img-circle"
                             src="/${SHARE.user.avatar}" alt="...">
                    </a>
                </div>
                <div class="media-body">
                    <h3 class="media-heading">${SHARE.user.name}
                        <small> <fmt:formatDate value="${SHARE.pubTime}" type="both" dateStyle="short"
                               timeStyle="short"/></small></h3>

                    <div class="mediaTextBox">
                        <p>${SHARE.content}</p>
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
                </div>
                <div class="musicCommentBox">
                    <div class="musicCommentBoxTitle">
                        <h3>评论</h3>
                    </div>
                    <c:if test="${currentUser.id ne 0}">
                        <c:if test="${currentUser.level>=3}">
                        <form action="/share/commentFromDetail" method="post">
                            <input type="hidden" name="workId" value="${SHARE.id}">
                            <input type="hidden" name="uploaderId" value="${currentUser.id}">
                            <div class="inputCommentBox">
                                <div class="inputCommentAvatar">
                                    <img src="/${currentUser.avatar}" class="img-circle img-thumbnail avatarController">
                                </div>
                                <div class="inputComment">
                                    <div class="form-group">
                                        <textarea id="InputInfo" name="content" class="form-control" rows="3"
                                                  placeholder="评论"></textarea>
                                    </div>
                                    <button type="submit" class="pull-right btn btn-info">提交</button>
                                </div>
                            </div>
                        </form>
                        </c:if>
                        <c:if test="${currentUser.level<3}">
                            <div class="inputCommentBox">
                                <div class="inputCommentAvatar">
                                    <img src="/${currentUser.avatar}" class="img-circle img-thumbnail avatarController">
                                </div>
                                <div class="inputComment">
                                    <form>
                                        <div class="form-group">
                                        <textarea class="form-control" rows="3"
                                                  placeholder="评论"></textarea>
                                        </div>
                                        <button class="pull-right btn btn-info" disabled="disabled">您已被禁言</button>
                                    </form>
                                </div>
                            </div>
                        </c:if>
                    </c:if>
                    <c:if test="${currentUser.id eq 0}">
                        <div class="inputCommentBox">
                            <div class="inputCommentAvatar">
                                <img src="/assets/img/timg.jpg" class="img-circle img-thumbnail avatarController">
                            </div>
                            <div class="inputComment">
                                <form>
                                    <div class="form-group">
                                        <textarea class="form-control" rows="3"
                                                  placeholder="评论"></textarea>
                                    </div>
                                    <button class="pull-right btn btn-info" disabled="disabled">请先登录</button>
                                </form>
                            </div>
                        </div>
                    </c:if>
                    <div class="commentAreaBox">
                        <hr/>
                        <!--a comment-->
                        <c:if test="${not empty SHARE_COMMENTS}">
                            <c:forEach items="${SHARE_COMMENTS}" var="COMMENT">
                                <div class="comment">
                                    <div class="commentLeft">
                                        <img src="/${COMMENT.avatar}" class="img-circle img-thumbnail avatarLarge"/>
                                    </div>
                                    <div class="commentRight">
                                        <div class="commentUserInfo">${COMMENT.uploaderName}</div>
                                        <div class="commentContent">
                                            <p>${COMMENT.content}</p></div>
                                        <div class="commentInfo">
                                            <span><fmt:formatDate value="${COMMENT.uploadTime}" type="date"/></span>
                                            <c:if test="${currentUser.id eq COMMENT.uploaderId}">
                                                <a onclick="delShareComment(this,${COMMENT.id})">删除</a>
                                            </c:if>
                                        </div>
                                    </div>
                                    <hr/>
                                </div>
                            </c:forEach>
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
                                            <a href="/share/detail/{${SHARE.id}/${pageInfo.prePage}" aria-label="Previous">
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
                                                <a href="/share/detail/{${SHARE.id}/${index}">${index}</a>
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
                                            <a href="/share/detail/{${SHARE.id}/${pageInfo.nextPage}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>
                        <!--/a comment-->
                        <c:if test="${empty SHARE_COMMENTS}">
                            <div class="comment">
                                <h3>评论区空空如也, 快来发表第一条评论吧</h3>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
<jsp:include page="audio_controller.jsp"/>
<script type="text/javascript" src="/js/web.js"></script>
</body>
</html>
