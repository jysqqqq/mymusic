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
        <c:forEach items="${USER_LIST}" var="USER">
            <div class="userListItemBox">
                <div class="userListItem">
                    <div class="userListItemAvatar"><img src="/${USER.avatar}" class="img-thumbnail img-circle"></div>
                    <div class="userListItemInfo">
                        <a href="/user/zone/${USER.id}">${USER.name}</a>
                        <c:if test="${USER.id ne currentUser.id}">
                            <C:if test="${USER.followed}">
                                <button onclick="unfollow(this,${USER.id})" class="userListItemBtn btn btn-info btn-sm"><span class="icon glyphicon-minus"> 取消关注</span>
                                </button>
                            </C:if>
                            <C:if test="${!USER.followed}">
                                <button onclick="follow(this,${USER.id})" class="userListItemBtn btn btn-info btn-sm"><span
                                        class="icon glyphicon-plus"> 关注</span></button>
                            </C:if>
                        </c:if>
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
    </div>
    <jsp:include page="footer.jsp"/>
</div>
<jsp:include page="audio_controller.jsp"/>
<script type="text/javascript" src="/js/web.js">

</script>
</body>
</html>