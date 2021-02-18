<jsp:useBean id="currentAdmin" scope="session" type="com.ncist.mymusic.entity.Admin"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="backend_top.jsp"></jsp:include>
<div>
    <div class="container">
        <div class="mainBar">
            <h1 class="text-center">编辑信息</h1>
            <br />
            <div class="panel panel-info" style="margin-bottom: 0;">
                <div class="panel-heading">
                    基本信息
                </div>
                <div class="panel-body" style="height: 320px;">
                    <form action="/backend/admin/admin-edit" method="post">
                        <input type="hidden" name="id" value="${currentAdmin.id}">
                        <input type="hidden" name="status" value="${currentAdmin.status}">
                        <input type="hidden" name="postType" value="${currentAdmin.postType}">
                        <input type="hidden" name="password" value="${currentAdmin.password}">
                        <input type="hidden" name="avatar" value="${currentAdmin.avatar}">
                        <div id="AccountBox" class="form-group has-feedback">
                            <label id="AccountLabel" class="control-label" for="InputAccount">账号 *</label>
                            <input type="text" class="form-control" id="InputAccount" name="account" onchange="checkAccount()"  placeholder="请输入账号" value="${currentAdmin.account}">
                            <span id="AccountFeedbackError" class="glyphicon glyphicon-remove form-control-feedback hidden" aria-hidden="true"></span>
                            <span id="AccountFeedbackSuccess" class="glyphicon glyphicon-ok form-control-feedback hidden" aria-hidden="true"></span>
                        </div>
                        <div class="form-group">
                            <label for="InputName">姓名</label>
                            <input type="text" class="form-control" id="InputName" name="name" placeholder="请输入姓名" value="${currentAdmin.name}">
                        </div>
                        <div class="form-group">
                            <label for="InputPhone">手机号码</label>
                            <input type="tel" class="form-control" id="InputPhone" name="phone" placeholder="请输入手机号码" value="${currentAdmin.phone}">
                        </div>
                        <button id="SubmitBtn" type="submit" class="btn btn-info" >提交</button>
                        <button type="reset" class="btn btn-default" onclick="javascript:window.history.go(-1);">返回</button>
                    </form>
                </div>
            </div>
            <div class="panel panel-info">
                <div class="panel-heading">
                    修改头像
                </div>
                <div class="panel-body" style="height: 200px;">
                    <form action="admin-setAvatar" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="exampleInputFile">File input</label>
                            <input type="file" id="exampleInputFile" name="avatar" accept="image/bmp,image/jpeg,image/png,image/gif">
                        </div>
                        <button id="SubmitAvatarBtn" type="submit" class="btn btn-info" >提交</button>
                        <button type="reset" class="btn btn-default" onclick="javascript:window.history.go(-1);">返回</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

<script type="text/javascript">
    $('input[id=lefile]').change(function() {
        $('#photoCover').val($(this).val());
        $("#SubmitAvatarBtn").attr("disabled",false);
    });

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

        if (account == "${currentAdmin.account}"){
            $("#AccountLabel").text("账号 *");
            $("#AccountBox").removeClass("has-error");
            $("#AccountBox").removeClass("has-success");
            $("#AccountFeedbackSuccess").addClass("hidden");
            $("#AccountFeedbackError").addClass("hidden");
            $("#SubmitBtn").attr("disabled",false);
            return;
        }
        $.get("/backend/admin/check-account/"+account,function (data,status) {
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