<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="backend_top.jsp"></jsp:include>
<div>
    <div class="container">
        <div class="mainBar">
            <h1 class="text-center">修改密码</h1>
            <br />
            <div id="PwdPanel" class="panel panel-info" style="margin-bottom: 0;">
                <div class="panel-heading">
                    <span class="glyphicon glyphicon-info-sign"></span> <span id="PwdInfo">修改密码后需重新登录</span>
                </div>
                <div class="panel-body" style="height: 320px;">
                    <form action="admin-password" method="post">
                        <input type="hidden" name="id" value="${currentAdmin.id}">
                        <div class="form-group">
                            <label for="InputOldPassword">旧密码</label>
                            <input type="password" class="form-control" id="InputOldPassword" name="oldPassword" placeholder="请输入旧密码">
                        </div>
                        <div class="form-group">
                            <label for="InputPassword">新密码</label>
                            <input type="password" class="form-control" id="InputPassword" name="password" placeholder="请输入新密码"  oninput="checkPassword()">
                        </div>
                        <div class="form-group">
                            <label for="InputPassword2">确认密码</label>
                            <input type="password" class="form-control" id="InputPassword2" name="password2" placeholder="请再确认一次新密码" oninput="checkPassword()">
                        </div>
                        <button type="submit" id="SubmitBtn" class="btn btn-info" disabled="disabled">提交</button>
                        <button type="reset" class="btn btn-default" onclick="javascript:window.history.go(-1);">返回</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

<script type="text/javascript">
    function checkPassword() {
        var p1 = $("#InputPassword").val();
        var p2 = $("#InputPassword2").val();
        if(p1!="" && p2!="" &&p1 == p2){
            $("#SubmitBtn").attr("disabled",false);
        }else {
            $("#SubmitBtn").attr("disabled",true);
        }
    }
    if("${result}" == "false"){
        $("#PwdPanel").addClass("panel-danger");
        $("#PwdInfo").text("${msg} - 修改密码后需重新登录");
    }
</script>

</html>