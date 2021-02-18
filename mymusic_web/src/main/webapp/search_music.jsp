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
                <table class="table table-hover table-striped musicListTable sideTable">
                    <thead>
                    <th>#</th>
                    <th>名称</th>
                    <th>歌手</th>
                    <th>专辑</th>
                    <th>时长</th>
                    </thead>
                    <tbody>
                    <c:set var="index" value="${(pageInfo.pageNum-1)*20 + 1}"/>
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
                        <a href="/search/music/${name}/${pageInfo.prePage}" aria-label="Previous">
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
                            <a href="/search/music/${name}/${index}">${index}</a>
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
                        <a href="/search/music/${name}/${pageInfo.nextPage}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
        </c:if>
        <c:if test="${empty MUSIC_LIST}">
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