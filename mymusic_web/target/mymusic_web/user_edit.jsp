<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:include page="web_header.jsp"/>
<jsp:useBean id="currentUser" class="com.ncist.mymusic.entity.User" scope="session"/>
<div class="container" style="padding: 0px;background: white;">
    <div class="post" style="min-height: 700px;">
        <form   id="UserForm" action="/user/user-edit" method="post" enctype="multipart/form-data">
            <div id="mainRow" class="row clearfix">
                <div class="col-lg-3">
                    <div class="albumCoverBox">
                        <img id="collectionCover" src="/${USER.avatar}" class="img-circle img-thumbnail artistCover center-block"/>
                        <div class="userBox">
                            <a class="btn btn-info center-block followBtn" onclick="$('#InputCover').click()">修改头像</a>
                        </div>
                        <input id="InputCover" onchange="userUploadAvatar()" type="file" accept="image/*" name="coverFile" class="hidden">
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="musicDetailBox">
                        <h3>修改信息</h3>
                        <hr/>
                        <div class="collectionInputBox">
                            <input type="hidden" value="${USER.id}" name="id">
                            <input type="hidden" value="${USER.avatar}" name="avatar">
                            <input type="hidden" value="${USER.password}" name="password">
                            <div class="form-group">
                                <label for="InputName"><h4>昵称</h4></label>
                                <input type="text" name="name" class="form-control" value="${USER.name}" id="InputName" placeholder="请输入昵称" required>
                            </div>
                            <div id="form-group-account" class="form-group has-feedback">
                                <label id="accountLabel" for="InputAccount"></h4></label>
                                <input type="text" onchange="checkAccount(this)" name="account" class="form-control" value="${USER.account}" id="InputAccount" placeholder="请输入账号" required>
                            </div>
                            <div class="form-group">
                                <label for="InputEmail"><h4>邮箱</h4></label>
                                <input type="email" name="email" class="form-control" id="InputEmail" value="${USER.email}" placeholder="请输入邮箱">
                            </div>
                            <div class="form-group">
                                <h4>性别</h4>
                                <c:if test="${USER.sex eq '男'}">
                                <label class="radio-inline">
                                    <input type="radio" name="sex"  value="男" checked> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="sex"  value="女"> 女
                                </label>
                                </c:if>
                                <c:if test="${USER.sex eq '女'}">
                                    <label class="radio-inline">
                                        <input type="radio" name="sex" value="男" > 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="sex" value="女" checked> 女
                                    </label>
                                </c:if>
                            </div>
                            <div class="form-group">
                                <label for="InputInfo"><h4>简介</h4></label>
                                <textarea rows="3" id="InputInfo" class="form-control" name="info">${USER.info}</textarea>
                            </div>
                            <button id="submitBtn" type="submit" class="btn btn-info ">提交</button>
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
    function userUploadAvatar() {
        var data = new FormData($("#UserForm")[0]);
        $.ajax({
            url: "/user/uploadImg",
            type: "POST",
            data: data,
            processData: false,//告诉ajax不要处理和编码这些数据，直接提交
            contentType: false,//不使用默认的内容类型
            success: function (result) {
                var path = "/" + result + "?id=" + Math.random();
                //alert(path);
                $("#collectionCover").attr("src",path);
            }
        });
    }
    function checkAccount(obj) {
        var account = obj.value;
        if(account == '${USER.account}'){
            $("#form-group-account").removeClass("has-success").removeClass("has-error");
            $("#accountLabel").html("<h4>账号<small> 最多20个字符</small></h4>");
            $("#submitBtn").attr("disabled", false);
            return;
        }
        $.ajax({
            url: "/user/checkAccount/" + account,
            type: "GET",
            success: function (result) {
                if (result == "true") {
                    $("#form-group-account").removeClass("has-success").addClass("has-error");
                    $("#accountLabel").html("<h4>账号 该账号已被占用<small> 最多20个字符</small></h4>");
                    $("#submitBtn").attr("disabled", true);
                } else {
                    $("#form-group-account").removeClass("has-error").addClass("has-success");
                    $("#accountLabel").html("<h4>账号 该账号可以使用<small> 最多20个字符</small></h4>");
                    $("#submitBtn").attr("disabled", false);
                }
            }
        })
    }
</script>
</body>
</html>
