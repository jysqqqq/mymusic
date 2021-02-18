<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:useBean id="currentUser" class="com.ncist.mymusic.entity.User" scope="session"/>
<jsp:include page="web_header.jsp"/>
<div class="container" style="padding: 0px;background: white;">
    <div class="post">
        <div id="mainRow" class="row clearfix">
            <div class="col-lg-3">
                <div class="operationListGroup">
                    <li class="recommendedTitleLi"><span class="recommendedLiTitle">全部流派</span></li>
                    <c:forEach items="${MUSIC_TYPE_LIST}" var="TYPE">
                        <li class="recommendedLi"><a href="/musicType/list/${TYPE.id}"><span class="recommendedMinText">${TYPE.name} ${TYPE.enName}</span></a></li>
                    </c:forEach>
                </div>
            </div>
            <div class="col-lg-9">
                <div id="musicListBox">
                    <div class="titleBar">
                        <h3>${MUSIC_TYPE.name}</h3>
                        <a href="/music/type-list/${MUSIC_TYPE.id}/1" class="moreBtn">更多</a>
                        <p>${MUSIC_TYPE.info}</p>
                        <hr/>
                    </div>
                    <div class="musicListBox">
                        <c:if test="${not empty MUSIC_LIST}">
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
    <jsp:include page="audio_controller.jsp"/>
    <script type="text/javascript" src="/js/web.js"></script>
    </body>
    </html>
