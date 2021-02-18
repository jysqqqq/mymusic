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
                    <img src="/${ARTIST.avatar}" class="img-circle img-thumbnail musicCover center-block"/>
                </div>
                <div class="sideInfoBox">
                    <div class="key-valueBox">
                        <div class="well">
                            <h4>介绍</h4>
                            ${ARTIST.info}
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-9">
                <div class="musicDetailBox">
                    <div class="titleBar">
                        <h3>${ARTIST.name}</h3>
                    </div>
                    <div class="key-valueBox">
                        <span class="keySpan">艺人语种 :</span>
                        ${ARTIST.language}
                    </div>
                    <div class="musicBtnGroup">
                        <a onclick="addArtistHotMusicToList(${ARTIST.id})" class="btn btn-primary roundBtn">&ensp;<span class="icon glyphicon-play"></span>&ensp;播放热门&ensp;
                        </a>
                        <hr/>
                    </div>
                </div>
                <div id="hotMusicListBox">
                    <div class="titleBar">
                        <h3>热门歌曲</h3>
                        <a href="/music/artistHotMusic/${ARTIST.id}/1" class="moreBtn">更多</a>
                        <hr/>
                    </div>
                    <div class="musicListBox">
                        <c:if test="${not empty MUSIC_LIST}">
                            <table class="table table-hover table-striped musicListTable sideTable">
                                <thead>
                                <th>#</th>
                                <th>名称</th>
                                <th>专辑</th>
                                <th>播放量</th>
                                <th>时长</th>
                                </thead>
                                <tbody>
                                <c:set var="index" value="1"/>
                                <c:forEach items="${MUSIC_LIST}" var="MUSIC">
                                    <tr>
                                        <td>
                                            <div class="musicListTableTdIndex">${index}</div>
                                            <div class="musicListTableTdPlayBtn"
                                                 onclick="appendMusic(${MUSIC.id})"><span
                                                    class="icon glyphicon-play-circle"></span></div>
                                        </td>
                                        <td><a href="/music/detail/${MUSIC.id}">${MUSIC.name}</a></td>
                                        <td><a href="/album/detail/${MUSIC.albumId}">${MUSIC.albumInfo.name}</a></td>
                                        <td>${MUSIC.playTimes}</td>
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
                <div id="favoriteAlbumBox" class="recommendedBox">
                    <div class="titleBar">
                        <h3>发布的专辑</h3>
                        <a href="/album/artistAlbum/${id}/1" class="moreBtn">更多</span>
                        </a>
                        <hr/>
                    </div>
                    <c:forEach items="${ALBUM_LIST}" var="ALBUM">
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
                                    <span><fmt:formatDate value="${ALBUM.pubDate}" type="date"/></span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
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
