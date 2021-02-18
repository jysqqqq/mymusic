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
                <div class="albumCoverBox">
                    <img src="/${ALBUM.coverAddress}" class="img-rounded img-thumbnail musicCover center-block"/>
                </div>
                <div class="musicDetailBox">
                    <div class="albumInfoBox">
                        <div class="key-valueBox">
                            <span class="keySpan">专辑语种 :</span>
                            ${ALBUM.language}
                        </div>
                        <div class="key-valueBox">
                            <span class="keySpan">发行公司 :</span>
                            ${ALBUM.company}
                        </div>
                    </div>
                </div>
                <div class="key-valueBox">
                    <div class="well">
                        <h4>介绍</h4>
                        ${ALBUM.info}
                    </div>
                </div>
            </div>
            <div class="col-lg-9">
                <div class="musicDetailBox">
                    <div class="titleBar">
                        <h3>${ALBUM.name}</h3>
                        <h4>
                            <small>发布时间 : <fmt:formatDate value="${ALBUM.pubDate}" type="date"/></small>
                        </h4>
                        <div class="key-valueBox">
                            <span class="keySpan">作者 :</span>
                            <a href="/artist/detail/${ALBUM.artistId}">${ALBUM.artist.name}</a>
                        </div>
                    </div>
                    <div class="musicBtnGroup">
                        <a onclick="addAlbumToList(${ALBUM.id})" class="btn btn-primary roundBtn">&ensp;<span
                                class="icon glyphicon-play"></span>&ensp;播放&ensp;
                        </a>
                        <c:if test="${ALBUM.favorite}">
                            <a onclick="favoriteAlbum(this,${ALBUM.id})" id="albumLoveBtn" class="btn btn-primary roundBtn">&ensp;<span class="fa fa-heart icon-red"></span>&ensp;收藏&ensp;
                            </a>
                        </c:if>
                        <c:if test="${!ALBUM.favorite}">
                            <a onclick="favoriteAlbum(this,${ALBUM.id})" id="albumLoveBtn" class="btn btn-primary roundBtn">&ensp;<span class="fa fa-heart"></span>&ensp;收藏&ensp;
                            </a>
                        </c:if>
                        <hr/>
                    </div>
                    <div class="musicListBox">
                        <c:if test="${not empty MUSIC_LIST}">
                            <table class="table table-hover table-striped musicListTable sideTable">
                                <thead>
                                <th>#</th>
                                <th>名称</th>
                                <th>歌手</th>
                                <th>播放量</th>
                                <th>时长</th>
                                </thead>
                                <tbody>
                                <c:set var="index" value="1"/>
                                <c:forEach items="${MUSIC_LIST}" var="MUSIC">
                                    <tr>
                                        <td>
                                            <div class="musicListTableTdIndex">${index}</div>
                                            <div class="musicListTableTdPlayBtn" onclick="appendMusic(${MUSIC.id})"><span
                                                    class="icon glyphicon-play-circle"></span></div>
                                        </td>
                                        <td><a href="/music/detail/${MUSIC.id}">${MUSIC.name}</a></td>
                                        <td><a href="/artist/detail/${MUSIC.artistId}">${MUSIC.player}</a></td>
                                        <td>${MUSIC.playTimes}</td>
                                        <td>
                                            <div class="musicListTableTdTrackLength">
                                                    ${MUSIC.trackLength}
                                            </div>
                                            <div class="musicListTableTdOperation">
                                                <c:if test="${MUSIC.favorite}">
                                                    <span onclick="favoriteMusic(this,${MUSIC.id})" class="fa fa-heart icon-red"></span>
                                                </c:if>
                                                <c:if test="${!MUSIC.favorite}">
                                                    <span onclick="favoriteMusic(this,${MUSIC.id})" class="fa fa-heart-o icon-red"></span>
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
                <div id="albumBox">

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
