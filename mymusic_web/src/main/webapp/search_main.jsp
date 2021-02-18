<jsp:useBean id="currentUser" scope="session" class="com.ncist.mymusic.entity.User"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:include page="web_header.jsp"/>
<div class="container" style="padding: 0px;background: white;">
    <div class="post minHeight">
        <h3>搜索结果 <small class="titleLinkBar"><a href="/search/music/${name}/1">音乐</a><a href="/search/album/${name}/1">专辑</a> <a href="/search/collection/${name}/1">歌单</a><a href="/search/artist/${name}/1">艺人</a></small></h3>
        <hr>
        <c:if test="${not empty MUSIC_LIST}">
            <h4>音乐</h4>
            <hr>
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
                    <c:forEach items="${MUSIC_LIST}" var="MUSIC">
                        <tr>
                            <td>
                                <div class="musicListTableTdIndex">${index}</div>
                                <div class="musicListTableTdPlayBtn" onclick="appendMusic(${MUSIC.id})"><span
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
        <c:if test="${not empty ALBUM_LIST}">
            <h4>专辑</h4>
            <hr>
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
                                <div onmouseleave="enableParentLink(this)" onmouseover="disableParentLink(this)" class="InputCoverOperationBar" onclick="addAlbumToList(${ALBUM.id})">
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
        </c:if>
        <c:if test="${not empty COLLECTION_LIST}">
            <h4>歌单</h4>
            <hr>
            <c:forEach items="${COLLECTION_LIST}" var="COLLECTION">
                <div class="mediaBox">
                    <div class="InputCoverBox">
                        <div class="InputCover3"></div>
                        <div class="InputCover2"></div>
                        <a href="/collection/detail/${COLLECTION.id}">
                            <div class="InputCover1" style="background-image: url('/${COLLECTION.cover}');">
                                <div class="InputCoverClickNumBox">
                                    <span class="icon glyphicon-play pull-left"></span> ${COLLECTION.clickRate}
                                </div>
                                <div onmouseleave="enableParentLink(this)" onmouseover="disableParentLink(this)" class="InputCoverOperationBar"  onclick="addCollectionToList(${COLLECTION.id})">
                                    <span class="fa fa-play-circle-o icon-orange" aria-hidden="true"></span>
                                </div>
                            </div>
                        </a>
                    </div>
                    </a>
                    <div class="mediaInfo">
                        <div class="mediaName">
                            <span>${COLLECTION.name}</span>
                        </div>
                        <div class="mediaAuthor">
                            <a href="/user/zone/${COLLECTION.userId}">${COLLECTION.uploaderInfo.name}</a>
                        </div>
                        <div class="mediaAuthor">
                            <span><fmt:formatDate value="${COLLECTION.pubDate}" type="date"/></span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${not empty ARTIST_LIST}">
            <h4>艺人</h4>
            <hr>
            <c:forEach items="${ARTIST_LIST}" var="ARTIST">
                <div class="mediaBox">
                    <a href="/artist/detail/${ARTIST.id}">
                        <img src="/${ARTIST.avatar}" class="img-circle center-block artistCover">
                    </a>
                    <div class="artistName">
                        <a href="/artist/detail/${ARTIST.id}">${ARTIST.name}</a>
                        <span>语种 : ${ARTIST.language}</span>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty MUSIC_LIST and empty ALBUM_LIST and empty COLLECTION_LIST and empty ARTIST_LIST }">
            <h2>没有找到结果</h2>
        </c:if>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
<jsp:include page="audio_controller.jsp"/>
<script type="text/javascript" src="/js/web.js">

</script>
</body>
</html>