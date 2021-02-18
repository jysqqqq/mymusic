<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:useBean id="currentUser" class="com.ncist.mymusic.entity.User" scope="session"/>
<jsp:include page="web_header.jsp"/>
<div class="container" style="padding: 0px;background: white;">
    <div id="carouselRow" class="row clearfix">
        <div class="col-md-12 column">
            <div class="carousel slide" id="carousel-397889">
                <ol class="carousel-indicators">
                    <li class="active" data-slide-to="0" data-target="#carousel-397889">
                    </li>
                    <li data-slide-to="1" data-target="#carousel-397889">
                    </li>
                    <li data-slide-to="2" data-target="#carousel-397889">
                    </li>
                </ol>
                <div class="carousel-inner">
                    <div class="item active">
                        <img alt="" src="/assets/img/res/ppt1.jpg"/>
                        <div class="carousel-caption">
                        </div>
                    </div>
                    <div class="item">
                        <img alt="" src="/assets/img/res/ppt2.jpg"/>
                        <div class="carousel-caption">
                        </div>
                    </div>
                    <div class="item">
                        <img alt="" src="/assets/img/res/ppt3.jpg"/>
                        <div class="carousel-caption">
                        </div>
                    </div>
                </div>
                <a class="left carousel-control" href="#carousel-397889" data-slide="prev"><span
                        class="glyphicon glyphicon-chevron-left"></span></a>
                <a class="right carousel-control" href="#carousel-397889" data-slide="next"><span
                        class="glyphicon glyphicon-chevron-right"></span></a>
            </div>
        </div>
    </div>
    <div class="post">
        <div id="mainRow" class="row clearfix">
            <div class="col-lg-3">
                <c:if test="${currentUser.id ne 0}">
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
                        <hr/>
                    </div>
                </c:if>
                <c:if test="${currentUser.id eq 0}">
                    <div class="userBox">
                        <div class="userAvatar">
                            <img class="center-block img-circle img-thumbnail avatarController"
                                 src="/assets/img/timg.jpg"/>
                            <div class="userName">
                                请登录
                            </div>
                            <div class="userName">
                                <button class="btn btn-info" data-toggle="modal" data-target="#loginModal">登录</button>
                            </div>
                        </div>
                        <hr/>
                    </div>
                </c:if>
                <div class="operationListGroup">
                    <li class="recommendedTitleLi"><span class="recommendedLiTitle">推荐</span></li>
                    <li class="recommendedLi"><a href="/album/hot/1"><span class="recommendedMinText">专辑</span></a></li>
                    <li class="recommendedLi"><a href="/collection/all/1"><span class="recommendedMinText">歌单</span></a></li>
                    <li class="recommendedLi"><a href="/artist/all/1"><span class="recommendedMinText">艺人</span></a></li>
                    <li class="recommendedLi"><a href="/musicType/list/0"><span class="recommendedMinText">流派</span></a></li>
                </div>
            </div>

            <div class="col-lg-9">
                <div id="hotCollectionBox" class="recommendedBox">
                    <div class="titleBar">
                        <h2>热门歌单</h2>
                        <a href="/collection/hot/1" class="moreBtn">更多</a>
                        <hr/>
                    </div>
                    <c:if test="${empty HOT_COLLECTION_LIST}">
                        <h2 style="text-align: center"><small>这周居然一张歌单都没有...</small></h2>
                    </c:if>
                    <c:forEach items="${HOT_COLLECTION_LIST}" var="COLLECTION">
                        <div class="mediaBox">
                            <div class="InputCoverBox">
                                <div class="InputCover3"></div>
                                <div class="InputCover2"></div>
                                <a href="/collection/detail/${COLLECTION.id}">
                                    <div class="InputCover1" style="background-image: url('/${COLLECTION.cover}');">
                                        <div class="InputCoverClickNumBox">
                                            <span class="icon glyphicon-play pull-left"></span> ${COLLECTION.clickRate}
                                        </div>
                                        <div onmouseleave="enableParentLink(this)" onmouseover="disableParentLink(this)" onclick="addCollectionToList(${COLLECTION.id})" class="InputCoverOperationBar"  >
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
                </div>
                <div id="recommendedBox" class="recommendedBox">
                    <div class="titleBar">
                        <h2>热门专辑</h2>
                        <a href="/album/hot/1" class="moreBtn">更多</a>
                        <hr/>
                    </div>
                    <c:forEach items="${RECOMMEND_ALBUM_LIST}" var="ALBUM">
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
                </div>
                <div id="newMusicBox">
                    <div class="titleBar">
                        <h2>新碟速递</h2>
                        <a href="/album/new/1" class="moreBtn">更多</span>
                        </a>
                        <hr/>
                    </div>
                    <c:forEach items="${NEW_ALBUM_LIST}" var="ALBUM">
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
                </div>
                <c:if test="${empty HOT_MUSIC_LIST}">
                <div id="newMusicBox">
                    <div class="titleBar">
                        <h2>一周热歌榜</h2>
                        <hr/>
                    </div>
                    <h2 style="text-align: center"><small>这周居然一首新歌都没有...</small></h2>
                </div>
                </c:if>
                <c:if test="${not empty HOT_MUSIC_LIST}">
                <div class="rankingListContainer">
                    <div id="rankingListBackgroundBox" class="rankingListBackgroundBox" style="background-image: url('/${HOT_MUSIC_LIST.get(0).cover}')"></div>
                    <div class="rankingListContentBox">
                        <div class="rankingListTitle">
                            <h3>一周热歌榜</h3>
                        </div>
                        <div class="rankingListContentLeft">
                            <div id="rankingListContentCover" class="rankingListContentCover center-block rotate30 pull-left" style="background-image: url('/${HOT_MUSIC_LIST.get(0).cover}')"></div>
                        </div>
                        <div class="rankingListContentRight pull-right">
                            <br/>
                            <table class="table rankingListTable">
                                    <c:set var="index" value="1"/>
                                    <c:forEach items="${HOT_MUSIC_LIST}" var="MUSIC">
                                        <tr onmouseover="rankingListChangeCover('/${MUSIC.cover}')">
                                            <td><span class="indexSpan">0${index}</span>
                                                <span onclick="appendMusic(${MUSIC.id})" class="fa fa-play-circle-o icon-orange  playSpan"></span></td>
                                            <td><a href="/music/detail/${MUSIC.id}">${MUSIC.name}</a></td>
                                            <td><a href="/artist/detail/${MUSIC.artistId}">${MUSIC.player}</a> </td>
                                            <td>${MUSIC.trackLength}</td>
                                        </tr>
                                        <c:set var="index" value="${index +1}"/>
                                    </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>
                </c:if>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
    <jsp:include page="audio_controller.jsp"/>
    <script type="text/javascript" src="/js/web.js"></script>
    </body>
    </html>
