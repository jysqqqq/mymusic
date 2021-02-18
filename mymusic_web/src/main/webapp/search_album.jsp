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
        <c:if test="${not empty ALBUM_LIST}">
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
                        <a href="/search/album/${name}/${pageInfo.prePage}" aria-label="Previous">
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
                            <a href="/search/album/${name}/${index}">${index}</a>
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
                        <a href="/search/album/${name}/${pageInfo.nextPage}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
        </c:if>
        <c:if test="${empty ALBUM_LIST}">
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