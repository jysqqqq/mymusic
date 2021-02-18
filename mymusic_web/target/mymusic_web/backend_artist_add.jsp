<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<head>
    <meta http-equiv="Content-Type" content="multipart/form-data">
</head>
<jsp:include page="backend_top.jsp"></jsp:include>
<div>
    <div class="container">
        <div class="mainBar">
            <h1 class="text-center">添加艺人</h1>
            <br/>
            <div class="panel panel-info">
                <div class="panel-heading">
                    添加新艺人
                </div>
                <div class="panel-body" style="height: 600px;">
                    <form id="AlbumForm" action="/backend/artist/artist-add" method="post" enctype="multipart/form-data">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>头像</label>
                                <div class="InputCoverBox">
                                    <div class="InputCover1" style="background-image: url('/assets/img/avatar/artist_default_avatar.jpg')"></div>
                                    <div class="InputCoverBtn" onclick="$('#InputCover').click();">
                                        <span class="glyphicon glyphicon-plus changeBlack"></span>
                                    </div>
                                </div>
                                <input id="InputCover" type="file" id="InputCover" accept="image/*" name="coverFile"
                                       style="display: none;">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="InputName">艺人名称</label>
                                <input type="text" class="form-control" id="InputName" name="name" placeholder="请输入艺人名称" oninput="inputName_input()" onchange="inputAlias_change()"  autocomplete="off" >
                            </div>
                            <div id="AliasBox" class="form-group has-feedback">
                                <label id="AliasLabel" for="InputAlias">艺人别名</label>
                                <input type="text" class="form-control" id="InputAlias" name="alias"
                                       placeholder="请输入艺人别名"  onchange="inputAlias_change()" autocomplete="off" >
                            </div>
                            <div class="form-group">
                                <label for="InputLanguage">艺人语种</label>
                                <input type="text" class="form-control" id="InputLanguage" name="language"
                                       placeholder="请输入艺人语种">
                            </div>
                            <div class="form-group">
                                <label for="InputInfo">简介</label>
                                <textarea id="InputInfo" wrap="hard" name="info" class="form-control" rows="3"
                                          placeholder="请输入艺人简介"></textarea>
                            </div>
                            <button id="submitBtn" type="submit" class="btn btn-info ">提交</button>
                            <button type="reset" class="btn btn-default" onclick="javascript:window.history.go(-1);">
                                返回
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript ">
    $("#InputCover").change(function () {
        var data = new FormData($("#AlbumForm")[0]);
        $.ajax({
            url: "/backend/artist/showCover",
            type: "POST",
            data: data,
            processData: false,//告诉ajax不要处理和编码这些数据，直接提交
            contentType: false,//不使用默认的内容类型
            success: function (result) {
                var path = "/" + result + "?id=" + Math.random();
                //alert(path);
                $(".InputCover1").css("background-image", "url(" + path + ")");
            }
        });
    });
    function inputName_input() {
        var name = $("#InputName").val();
        $("#InputAlias").val(name);
    }
    function inputAlias_change() {
        var name = $("#InputAlias").val();
        if(name==""){
            return;
        }
        $.ajax({
            url: "/backend/artist/check-alias/"+name,
            type: "GET",
            data: name,
            success:function (result) {
                if(result=="false"){
                    $("#AliasBox").removeClass("has-error").addClass("has-success");
                    $("#AliasLabel").html("艺人别名 该别名可以使用");
                    $("#submitBtn").removeAttr("disabled");
                }else {
                    $("#AliasBox").removeClass("has-success").addClass("has-error");
                    $("#AliasLabel").html("艺人别名 该别名已被占用");
                    $("#submitBtn").attr("disabled","disabled");
                }
            }
        })
    }
</script>
</html>