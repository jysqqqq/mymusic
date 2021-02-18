
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="backend_top.jsp"></jsp:include>
<div>
    <div class="container">
        <div class="mainBar">
            <h1 class="text-center">添加管理员</h1>
            <br />
            <div class="panel panel-info" style="margin-bottom: 0;">
                <div class="panel-heading">
                    <span class="glyphicon glyphicon-info-sign"></span> 默认密码为 123
                </div>
                <div class="panel-body" style="height: 320px;">
                    <form action="admin-add" method="post" onkeydown="if(event.keyCode==13)return false;">
                        <div id="AccountBox" class="form-group has-feedback">
                            <label id="AccountLabel" class="control-label" for="InputAccount">账号 *</label>
                            <input type="text" class="form-control" id="InputAccount" name="account" onchange="checkAccount()"  placeholder="请输入账号" required>
                            <span id="AccountFeedbackError" class="glyphicon glyphicon-remove form-control-feedback hidden" aria-hidden="true"></span>
                            <span id="AccountFeedbackSuccess" class="glyphicon glyphicon-ok form-control-feedback hidden" aria-hidden="true"></span>
                        </div>
                        <div class="form-group">
                            <label for="InputName">姓名 *</label>
                            <input type="text" class="form-control" id="InputName" name="name" placeholder="请输入姓名" required>
                        </div>
                        <div class="form-group">
                            <label for="InputPhone">手机号码</label>
                            <input type="tel" class="form-control" id="InputPhone" name="phone" placeholder="请输入手机号码">
                        </div>
                        <button id="SubmitBtn" type="submit" class="btn btn-info" disabled="disabled">提交</button>
                        <button type="reset" class="btn btn-default" onclick="javascript:window.history.go(-1);">返回</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    if("${msg}"!=""){
        alert("${msg}");
    }
    function checkAccount() {
        var account = $("#InputAccount").val();
        if (account == ""){
            $("#AccountLabel").text("账号 *");
            $("#AccountBox").removeClass("has-error");
            $("#AccountBox").removeClass("has-success");
            $("#AccountFeedbackSuccess").addClass("hidden");
            $("#AccountFeedbackError").addClass("hidden");
            $("#SubmitBtn").attr("disabled",true);
            return;
        }
        $.get("check-account/"+account,function (data,status) {
            if (data == "false") {
                $("#AccountBox").removeClass("has-success");
                $("#AccountBox").addClass("has-error");
                $("#AccountFeedbackSuccess").addClass("hidden");
                $("#AccountFeedbackError").removeClass("hidden");
                $("#AccountLabel").text("账号 *   该账号已被占用!");
                $("#SubmitBtn").attr("disabled",true);
            }else {
                $("#AccountBox").removeClass("has-error");
                $("#AccountBox").addClass("has-success");
                $("#AccountFeedbackError").addClass("hidden");
                $("#AccountFeedbackSuccess").removeClass("hidden");
                $("#AccountLabel").text("账号 *   该账号可以使用!");
                $("#SubmitBtn").attr("disabled",false);
            }
        })
    }
</script>
</html>