<jsp:useBean id="currentUser" scope="session" class="com.ncist.mymusic.entity.User"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:include page="web_header.jsp"/>
<div class="container" style="padding: 0px;background: white;">
    <div class="post minHeight">
        <img src="/assets/img/res/404.png" style="position: absolute;top: 70px;left: 50px">
        <div style="width: 100%;margin-left: 470px;margin-top: 70px">
            <h2>登录云米音乐</h2>
            <h3><small>查看并管理你的私房音乐，方便地随时随地收听</small></h3><br>
            <a data-toggle="modal" data-target="#loginModal" class="btn btn-primary btn-lg"> 立 即 登 录 </a>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
<jsp:include page="audio_controller.jsp"/>
<script type="text/javascript" src="/js/web.js">

</script>
</body>
</html>