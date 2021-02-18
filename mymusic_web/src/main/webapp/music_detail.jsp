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
                <div class="musicCoverBox">
                    <img src="/${MUSIC.cover}" class="img-circle img-thumbnail musicCover center-block"/>
                </div>
            </div>
            <div class="col-lg-9">
                <div class="musicDetailBox">
                    <div class="titleBar">
                        <h3>${MUSIC.name}</h3>
                        <div class="key-valueBox">
                            <span class="keySpan">所属专辑 :</span>
                            <a href="/album/detail/${MUSIC.albumId}">${MUSIC.albumInfo.name}</a>
                        </div>
                        <div class="key-valueBox">
                            <span class="keySpan">作者 :</span>
                            <a href="/artist/detail/${MUSIC.artistId}">${MUSIC.player}</a>
                        </div>
                    </div>
                    <div class="musicBtnGroup">
                        <a onclick="appendMusic(${MUSIC.id})" class="btn btn-primary roundBtn">&ensp;<span
                                class="icon glyphicon-play"></span>&ensp;播放&ensp;</a>
                        <a onclick="shareBtn_Click(${MUSIC.id})" class="btn btn-primary roundBtn">&ensp;<span class="icon glyphicon-share"></span>&ensp;分享&ensp;</a>
                        <a onclick="addMusicToCollectionLi_Click(${MUSIC.id})" class="btn btn-primary roundBtn">&ensp;<span class="icon glyphicon-share"></span>&ensp;加入歌单&ensp;</a>
                        <a class="btn btn-primary roundBtn" type="button" data-toggle="collapse"
                           data-target="#collapseLrc"
                           aria-expanded="false" aria-controls="collapseExample">&ensp;<span
                                class="icon glyphicon-text-background"></span>&ensp;歌词&ensp;
                        </a>
                        <hr/>
                    </div>
                    <div class="lrcBox">
                        <div class="collapse" id="collapseLrc">
                            <div class="well">
                                <h4>歌词</h4>
                                <br/>
                                <c:forEach items="${LRC}" var="line">
                                    <p>${line}</p>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="musicCommentBox">
                    <div class="musicCommentBoxTitle">
                        <h3>评论</h3>
                    </div>
                    <c:if test="${currentUser.id ne 0}">
                        <c:if test="${currentUser.level>=3}">
                        <form action="/music/comment" method="post">
                            <input type="hidden" name="workId" value="${MUSIC.id}">
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
                        <c:if test="${not empty MUSIC_COMMENTS}">
                            <c:forEach items="${MUSIC_COMMENTS}" var="COMMENT">
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
                                                <a onclick="delMusicComment(this,${COMMENT.id})">删除</a>
                                            </c:if>
                                        </div>
                                    </div>
                                    <hr/>
                                </div>
                            </c:forEach>
                        </c:if>
                        <!--/a comment-->
                        <c:if test="${empty MUSIC_COMMENTS}">
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
