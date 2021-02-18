<jsp:useBean id="currentUser" scope="session" class="com.ncist.mymusic.entity.User"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:include page="web_header.jsp"/>
<div class="container" style="padding: 0px;background: white;">
    <div class="post minHeight">
        <div id="mainRow" class="row clearfix">

            <div class="col-lg-3">
                <div class="userBox">
                    <div class="userAvatar">
                        <img class="center-block img-circle img-thumbnail avatarController"
                             src="/${USER.avatar}"/>
                        <div class="userName">
                            ${USER.name}
                        </div>
                        <c:if test="${currentUser.id ne USER.id}">
                            <c:if test="${USER.followed}">
                                <div class="userInfo">
                                    <button onclick="unfollow(this,${USER.id})" class="btn btn-info btn-sm center-block"><span class="icon glyphicon-minus"></span> 取消关注
                                    </button>
                                </div>
                            </c:if>
                            <c:if test="${not USER.followed}">
                                <div class="userInfo">
                                    <button onclick="follow(this,${USER.id})" class="btn btn-info btn-sm center-block"><span class="icon glyphicon-plus"></span> 关注
                                    </button>
                                </div>
                            </c:if>
                        </c:if>
                    </div>
                    <div class="socialBox notSelect">
                        <div class="followBox">
                            <h5>关注</h5>
                            <a href="/user/followList/${USER.id}/1">${USER.followNum}</a>
                        </div>
                        <div class="fanBox">
                            <h5>粉丝</h5>
                            <a href="/user/fanList/${USER.id}/1">${USER.fanNum}</a>
                        </div>
                    </div>
                    <div class="userInfo">
                        <div class="well">${USER.info}</div>
                    </div>
                </div>
            </div>
            <div class="col-lg-9">
                <div id="privateCollectionBox" class="recommendedBox">
                    <div class="titleBar">
                        <h3>创建的歌单</h3>
                        <c:if test="${USER.id eq currentUser.id}">
                            <a href="/collection/add" class="btn  operationBtn roundBtn">
                                <span class="icon glyphicon-plus"></span> 创建歌单
                            </a>
                        </c:if>
                        <a href="/collection/creat-list/${USER.id}/1" class="moreBtn">更多</a>
                        <hr/>
                    </div>
                    <c:forEach items="${MY_COLLECTION_LIST}" var="COLLECTION">
                        <div class="mediaBox">
                            <div class="InputCoverBox">
                                <div class="InputCover3"></div>
                                <div class="InputCover2"></div>
                                <a href="/collection/detail/${COLLECTION.id}">
                                    <div class="InputCover1" style="background-image: url('/${COLLECTION.cover}');">
                                        <div class="InputCoverClickNumBox">
                                            <span class="icon glyphicon-play pull-left"></span> ${COLLECTION.clickRate}
                                        </div>
                                        <div onmouseleave="enableParentLink(this)" onmouseover="disableParentLink(this)"
                                             class="InputCoverOperationBar"
                                             onclick="addCollectionToList(${COLLECTION.id})">
                                            <span class="fa fa-play-circle-o icon-orange" aria-hidden="true"></span>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="mediaInfo">
                                <div class="mediaName">
                                    <span>${COLLECTION.name}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div id="favoriteCollectionBox" class="recommendedBox">
                    <div class="titleBar">
                        <h3>收藏的歌单</h3>
                        <a href="/collection/favorite-list/${USER.id}/1" class="moreBtn">更多
                        </a>
                        <hr/>
                    </div>
                    <c:forEach items="${FAVORITE_COLLECTION_LIST}" var="COLLECTION">
                        <div class="mediaBox">
                            <div class="InputCoverBox">
                                <div class="InputCover3"></div>
                                <div class="InputCover2"></div>
                                <a href="/collection/detail/${COLLECTION.id}">
                                    <div class="InputCover1" style="background-image: url('/${COLLECTION.cover}');">
                                        <div class="InputCoverClickNumBox">
                                            <span class="icon glyphicon-play pull-left"></span> ${COLLECTION.clickRate}
                                        </div>
                                        <div onmouseleave="enableParentLink(this)" onmouseover="disableParentLink(this)"
                                             class="InputCoverOperationBar"
                                             onclick="addCollectionToList(${COLLECTION.id})">
                                            <span class="fa fa-play-circle-o icon-orange" aria-hidden="true"></span>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="mediaInfo">
                                <div class="mediaName">
                                    <span>${COLLECTION.name}</span>
                                </div>
                                <div class="mediaAuthor">
                                    <a href="/user/zone/${COLLECTION.userId}">${COLLECTION.userName}</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div id="favoriteAlbumBox" class="recommendedBox">
                    <div class="titleBar">
                        <h3>收藏的专辑</h3>
                        <a href="/album/favorite-list/${USER.id}/1" class="moreBtn">更多
                        </a>
                        <hr/>
                    </div>
                    <c:forEach items="${FAVORITE_ALBUM_LIST}" var="ALBUM">
                        <div class="mediaBox">
                            <div class="InputCoverBox">
                                <div class="InputCover3"></div>
                                <div class="InputCover2"></div>
                                <a href="/album/detail/${ALBUM.id}">
                                    <div class="InputCover1" style="background-image: url('/${ALBUM.coverAddress}');">
                                        <div class="InputCoverClickNumBox">
                                            <span class="icon glyphicon-play pull-left"></span> ${ALBUM.clickRate}
                                        </div>
                                        <div onmouseleave="enableParentLink(this)" onmouseover="disableParentLink(this)"
                                             class="InputCoverOperationBar" onclick="addAlbumToList(${ALBUM.id})">
                                            <span class="fa fa-play-circle-o icon-orange" aria-hidden="true"></span>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            </a>
                            <div class="mediaInfo">
                                <div class="mediaName">
                                    <span>${ALBUM.name}</span>
                                </div>
                                <div class="mediaAuthor">
                                    <span>${ALBUM.author}</span>
                                </div>
                                <div class="mediaAuthor">
                                    <span><fmt:formatDate value="${ALBUM.pubDate}" type="date"/></span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div id="favoriteMusicBox">
                    <div class="titleBar">
                        <h3>喜欢的音乐 <a onclick="addFavoriteMusicToList(${USER.id})" class="btn btn-sm btn-warning roundBtn">&ensp;<span class="icon glyphicon-play"></span>&ensp;播放全部&ensp;
                        </a></h3>

                        <a href="/music/favorite-list/${USER.id}/1" class="moreBtn">更多</span>
                        </a>
                        <hr/>
                    </div>
                    <div class="musicListBox">
                        <c:if test="${not empty FAVORITE_MUSIC_LIST}">
                            <table class="table table-hover table-striped musicListTable sideTable">
                                <thead>
                                <th>#</th>
                                <th>名称</th>
                                <th>歌手</th>
                                <th>专辑</th>
                                <th>时长</th>
                                </thead>
                                <tbody>
                                <c:set var="index" value="1"/>
                                <c:forEach items="${FAVORITE_MUSIC_LIST}" var="MUSIC">
                                    <tr>
                                        <td>
                                            <div class="musicListTableTdIndex">${index}</div>
                                            <div class="musicListTableTdPlayBtn"
                                                 onclick="appendMusic(${MUSIC.id})"><span
                                                    class="icon glyphicon-play-circle"></span></div>
                                        </td>
                                        <td><a href="/music/detail/${MUSIC.id}">${MUSIC.name}</a></td>
                                        <td><a href="/artist/detail/${MUSIC.artistId}">${MUSIC.player}</a></td>
                                        <td><a href="/album/detail/${MUSIC.albumId}">${MUSIC.albumInfo.name}</a></td>
                                        <td>
                                            <div class="musicListTableTdTrackLength">
                                                    ${MUSIC.trackLength}
                                            </div>
                                            <div class="musicListTableTdOperation">
                                                <c:if test="${MUSIC.favorite}">
                                                    <span onclick="favoriteMusic(this,${MUSIC.id})"
                                                          class="fa fa-heart icon-red"></span>
                                                </c:if>
                                                <c:if test="${!MUSIC.favorite}">
                                                    <span onclick="favoriteMusic(this,${MUSIC.id})"
                                                          class="fa fa-heart-o icon-red"></span>
                                                </c:if>
                                                <a href="/${MUSIC.address}" download="${MUSIC.name}.mp3"><span
                                                        class="fa fa-download icon-black"></span></a>
                                            </div>
                                        </td>
                                    </tr>
                                    <c:set var="index" value="${index+1}"/>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
<jsp:include page="audio_controller.jsp"/>
<script type="text/javascript" src="/js/web.js">

</script>
</body>
</html>