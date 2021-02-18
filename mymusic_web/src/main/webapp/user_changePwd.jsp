<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:include page="web_header.jsp"/>
<jsp:useBean id="currentUser" class="com.ncist.mymusic.entity.User" scope="session"/>
<div class="container" style="padding: 0px;background: white;">
    <div class="post" style="min-height: 700px;">
        <form   id="UserForm" action="/user/changePassword" method="post" enctype="multipart/form-data">
            <div id="mainRow" class="row clearfix">
                <div class="col-lg-3">
                    <img id="collectionCover" src="/${currentUser.avatar}" class="img-circle img-thumbnail artistCover center-block"/>
                </div>
                <div class="col-lg-9">
                    <div class="musicDetailBox">
                        <h3>修改密码</h3>
                        <hr/>
                        <div class="collectionInputBox">
                            <div class="form-group">
                                <label for="InputOldPwd"><h4>旧密码</h4></label>
                                <input type="password" onchange="checkPassword()" name="oldPassword" class="form-control" id="InputOldPwd" placeholder="请输入旧密码" required>
                            </div>
                            <div class="form-group">
                                <label for="InputNewPwd"><h4>新密码</h4></label>
                                <input type="password" onchange="checkPassword()" class="form-control"  id="InputNewPwd" placeholder="请输入新密码" required>
                            </div>
                            <div class="form-group">
                                <label for="InputNewPwd2"><h4>确认密码</h4></label>
                                <input type="password" onchange="checkPassword()" name="password" class="form-control"  id="InputNewPwd2" placeholder="请再输入一次密码" required>
                            </div>
                            <button id="submitBtn" type="submit" class="btn btn-info " disabled>提交</button>
                            <button type="reset" class="btn btn-default" onclick="javascript:window.history.go(-1);">返回</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
<jsp:include page="audio_controller.jsp"/>
<script type="text/javascript" src="/js/web.js"></script>
<script>
    function checkPassword() {
        var p1 = $("#InputNewPwd").val();
        var p2 = $("#InputNewPwd2").val();
        var oldP = $("#InputOldPwd").val();
        if (p1 != "" && p2 != "" && p1 == p2 && oldP ==${currentUser.password}) {
            $("#submitBtn").attr("disabled", false);
        } else {
            $("#submitBtn").attr("disabled", true);
        }
    }
</script>
</body>
</html>
