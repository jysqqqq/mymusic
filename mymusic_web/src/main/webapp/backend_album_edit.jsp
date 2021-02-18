<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<head>
    <meta http-equiv="Content-Type" content="multipart/form-data">
</head>
<jsp:include page="backend_top.jsp"></jsp:include>
<div>
    <div class="container">
        <div class="mainBar">
            <h1 class="text-center">编辑专辑</h1>
            <br/>
            <div class="panel panel-info">
                <div class="panel-heading">
                    编辑专辑
                </div>
                <div class="panel-body" style="height: 700px;">
                    <form id="AlbumForm" action="/backend/album/album-edit" method="post" enctype="multipart/form-data">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>封面</label>
                                <div class="InputCoverBox">
                                    <div class="InputCover3"></div>
                                    <div class="InputCover2"></div>
                                    <div class="InputCover1"
                                         style="background-image: url('/${ALBUM.coverAddress}')"></div>
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
                                <label for="InputName">专辑名称</label>
                                <input type="text" class="form-control" id="InputName" name="name" placeholder="请输入专辑名"
                                       value="${ALBUM.name}">
                            </div>
                            <div id="authorBox" class="form-group has-feedback">
                                <label id="authorLabel" for="InputAuthor">作者名称</label>
                                <input type="text" class="form-control" id="InputAuthor" name="alias"
                                       placeholder="请输入作者名" list="aliasList" value="${ALBUM.author}" onchange="inputAuthor_change()" oninput="inputAuthor_input()" autocomplete="off" >
                                <datalist id="aliasList">
                                </datalist>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="InputCompany">唱片公司</label>
                                <input type="text" class="form-control" id="InputCompany" name="company"
                                       placeholder="请输入公司名" value="${ALBUM.company}">
                            </div>
                            <div class="form-group">
                                <label for="InputLanguage">语种</label>
                                <input type="text" class="form-control" id="InputLanguage" name="language"
                                       placeholder="请输入专辑语种" value="${ALBUM.language}">
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="InputInfo">简介</label>
                                <textarea id="InputInfo" name="info" class="form-control" rows="3" placeholder="请输入专辑简介">${ALBUM.info}</textarea>
                            </div>
                            <input class="hidden" type="text" name="id" value="${ALBUM.id}">
                            <input class="hidden" type="text" name="coverAddress" value="${ALBUM.coverAddress}">
                            <button id="submitBtn" type="submit" class="btn btn-info">提交</button>
                            <button type="reset" class="btn btn-default" onclick="javascript:window.history.go(-1);">返回
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
            url: "/backend/album/showCover",
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
    })

    function inputAuthor_input() {
        $("#submitBtn").attr("disabled","disabled");
        var name = $("#InputAuthor").val();
        if(name==""){
            return;
        }
        $.ajax({
            url: "/backend/artist/queryByName/"+name,
            type: "GET",
            data: name,
            success:function (result) {
                $("#aliasList").children().filter("option").remove();
                var artistList = result.list;
                for (var i = 0; i < artistList.length; i++) {
                    $("#aliasList").append("<option value="+ artistList[i].alias +">"+ artistList[i].name +"</option>");
                }
            }
        })
    }
    function inputAuthor_change() {
        var name = $("#InputAuthor").val();
        if(name==""){
            return;
        }
        $.ajax({
            url: "/backend/artist/check-alias/"+name,
            type: "GET",
            data: name,
            success:function (result) {
                if(result=="false"){
                    $("#authorBox").removeClass("has-success").addClass("has-error");
                    $("#authorLabel").html("作者名称 该艺人不存在");
                    $("#submitBtn").attr("disabled","disabled");
                }else {
                    $("#authorBox").removeClass("has-error").addClass("has-success");
                    $("#authorLabel").html("作者名称");
                    $("#submitBtn").removeAttr("disabled");
                }
            }
        })
    }
</script>
</html>