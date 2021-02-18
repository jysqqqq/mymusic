<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:include page="web_header.jsp"/>
<jsp:useBean id="currentUser" class="com.ncist.mymusic.entity.User" scope="session"/>
<div class="container" style="padding: 0px;background: white;">
    <div class="post" style="min-height: 700px;">
        <form   id="CollectionForm" action="/collection/collection-add" method="post" enctype="multipart/form-data">
            <div id="mainRow" class="row clearfix">
                <div class="col-lg-3">
                    <div class="albumCoverBox">
                        <img id="collectionCover" src="/assets/img/res/gray.png" class="img-rounded img-thumbnail musicCover center-block"/>
                        <div class="InputCoverBtn" onclick="$('#InputCover').click()">
                            <span class="glyphicon glyphicon-plus changeBlack"></span>
                        </div>
                        <input id="InputCover" onchange="collectionUploadCover()" type="file" accept="image/*" name="coverFile" class="hidden">
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="musicDetailBox">
                        <h3>创建歌单</h3>
                        <hr/>
                        <div class="collectionInputBox">
                            <div class="form-group">
                                <label for="InputName">标题</label>
                                <input type="text" name="name" class="form-control" id="InputName" placeholder="请输入标题" required>
                            </div>
                            <div class="form-group" style="width: 50%">
                                <label for="InputType">标签</label>
                                <input type="text" name="type" class="form-control" id="InputType" placeholder="请输入歌单类型 用 ; 隔开">
                            </div>
                            <div class="form-group">
                                <label for="InptInfo">简介</label>
                                <textarea name="info"  class="form-control" rows="5"  id="InptInfo" placeholder="请输入简介"></textarea>
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
    function collectionUploadCover() {
        var data = new FormData($("#CollectionForm")[0]);
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
</script>
</body>
</html>
