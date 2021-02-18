<jsp:useBean id="currentUser" scope="session" class="com.ncist.mymusic.entity.User"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:include page="web_header.jsp"/>
<div class="container" style="padding: 0px;background: white;">
    <div class="post minHeight">
        <h3>${TITLE}</h3>
        <hr>
        <c:if test="${not empty ARTIST_LIST}">
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
                        <a href="${QUERY}/${pageInfo.prePage}" aria-label="Previous">
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
                            <a href="${QUERY}/${index}">${index}</a>
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
                        <a href="${QUERY}/${pageInfo.nextPage}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
        </c:if>
        <c:if test="${empty ARTIST_LIST}">
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