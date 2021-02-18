<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<head>
    <style>
        .albumControllerBar {
            position: relative;
            overflow-y: scroll;
            overflow-x: hidden;
            height: 500px;
        }

        .albumControllerBar::-webkit-scrollbar {/*滚动条整体样式*/
            width: 10px;     /*高宽分别对应横竖滚动条的尺寸*/
            height: 0px;
        }
        .albumControllerBar::-webkit-scrollbar-thumb {/*滚动条里面小方块*/
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
            background: #535353;
        }
        .albumControllerBar::-webkit-scrollbar-track {/*滚动条里面轨道*/
            -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
            border-radius: 10px;
            background: #EDEDED;
        }

        .albumBtnGroup {
            position: relative;
            margin-top: 10px;
            padding-left: 10px;
        }

        .table input {
            /*可输入区域样式*/
            width: 100%;
            height: 100%;
            border: none;
            /* 输入框不要边框 */
            font-family: Arial;
            background: rgba(0, 0, 0, 0);
        }

        .inlineBox {
            display: inline-block;
        }

        .albumControllerLeft {
            display: inline-block;
            position: relative;
            top: 0px;
            left: 0px;
        }

        .albumControllerRight {
            display: inline-block;
            position: absolute;
            padding-left: 15px;
            top: 0px;
            left: 170px;
            width: 650px;
            height: 130px;
        }

        .albumControllerBtnGroup {
            position: absolute;
            bottom: 0px;
        }
        .tdAlbumId,
        .tdId,
        .trClone {
            display: none;
        }

        .tdLrcFile {
            width: 120px;
        }

        .progressBox {
            position: absolute;
            width: 600px;
            top: 60px;
        }
    </style>
</head>
<jsp:include page="backend_top.jsp"></jsp:include>

<div>
    <div class="container">
        <div class="mainBar">
            <h1 class="text-center">添加音乐</h1>
            <br/>
            <div class="panel panel-info">
                <div class="panel-heading">
                    为专辑《${ALBUM.name}》添加音乐
                </div>
                <div class="panel-body" style="height: 750px;">
                    <form action="/backend/music/music-add" id="MusicForm" method="post" enctype="multipart/form-data">
                        <input type="hidden" value="${ALBUM.id}" name="albumId"/>
                        <div class="albumBtnGroup">
                            <div class="albumControllerLeft">
                                <div class="InputCoverBox">
                                    <div class="InputCover3"></div>
                                    <div class="InputCover2"></div>
                                    <div class="InputCover1"
                                         style="background-image: url('/${ALBUM.coverAddress}')"></div>
                                </div>
                            </div>
                            <div class="albumControllerRight">
                                <h2>${ALBUM.name}</h2>
                                <div class="progressBox">
                                    <div id="UploadProgress" class="progress" style="display: none;">
                                        <div class="progress-bar progress-bar-striped active" role="progressbar"
                                             aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"
                                             style="min-width: 2em;">
                                            0%
                                        </div>
                                    </div>
                                </div>
                                <div class="albumControllerBtnGroup">
                                    <button id="InputMusicBtn" type="button" class="btn btn-info"
                                            onclick="$('#InputMusicFiles').click();">
                                        上传音乐
                                    </button>
                                    <input id="InputMusicFiles" type="file" multiple="multiple" accept="audio/*"
                                           name="musicFiles" style="display: none;"/>
                                    <button id="InputLrcFilesBtn" type="button" class="btn btn-success"
                                            onclick="$('#InputLrcFiles').click();" style="display: none;">添加歌词
                                    </button>
                                    <input id="InputLrcFiles" name="lrcFiles" type="file" multiple="multiple"
                                           accept=".lrc"
                                           style="display: none;"/>
                                    <button id="submitBtn" type="submit" class="btn btn-default" style="display: none;">
                                        保存
                                    </button>
                                    <button type="reset" class="btn btn-default"
                                            onclick="javascript:window.history.go(-1);">返回
                                    </button>
                                </div>
                            </div>
                            <hr>
                        </div>
                        <div class="albumControllerBar">
                            <table class="table table-striped table-hover">
                                <thead>
                                <th>#</th>
                                <th>歌曲</th>
                                <th>歌手</th>
                                <th>类型</th>
                                <th>操作</th>
                                </thead>
                                <tbody>
                                <tr class="trClone">
                                    <td class="tdIndex"></td>
                                    <td class="tdName"><input type="text" readonly="readonly"></td>
                                        <td class="tdAlias">
                                            <input type="text" list="aliasList" data-toggle="tooltip" data-title="该艺人不存在"  onchange="inputAuthor_change(this)" oninput="inputAuthor_input(this)" autocomplete="off" >
                                            <datalist id="aliasList">
                                            </datalist>
                                        </td>
                                    <td class="tdType">
                                        <select class="select" ondblclick="select_dbClick(this)">
                                            <c:forEach items="${TYPE_LIST}" var="TYPE">
                                                <option value="${TYPE.id}">${TYPE.name}&nbsp;${TYPE.enName}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td class="tdAlbumId"><input type="text"></td>
                                    <td class="tdLrcFile">
                                        <button type="button" class="btn btn-danger btn-sm"><span
                                                class="glyphicon glyphicon-trash"></span></button>
                                        <a class="btn  btn-sm disabled"></a>
                                        <input class="hidden" type="text">
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script type="text/javascript ">
    $(document).ready(function () {
        $("#InputLrcFiles").change(function () {
            if ($("#InputLrcFiles")[0].files.length != 0) {
                var data = new FormData($("#MusicForm")[0]);
                $.ajax({
                    url: "/backend/music/lrcFile-add",
                    type: "POST",
                    data: data,
                    processData: false,//告诉ajax不要处理和编码这些数据，直接提交
                    contentType: false,//不使用默认的内容类型
                    xhr: function () {
                        //获取xhr
                        var xhr = $.ajaxSettings.xhr();
                        //上传期间的回调函数、每隔xms触发一次
                        xhr.upload.onprogress = function (ev) {
                            //获取当前上传了多少数据、总共是多少数据
                            //console.log("已经上传:" + ev.loaded);
                            //console.log("总计:" + ev.total);
                            //console.log("当前进度:" + (ev.loaded / ev.total) * 100 + "%");
                            $("#InputLrcFilesBtn").addClass("disabled");
                            $("#InputLrcFilesBtn").html("上传中...");
                            $("#UploadProgress").fadeIn(300);
                            var procent = ((ev.loaded / ev.total) * 100).toFixed(2);
                            $(".progress-bar").css('width', procent + "%").text(procent + "%");
                        };
                        xhr.upload.onloadend = function (ev) {
                            $("#InputLrcFilesBtn").removeClass("disabled");
                            $("#InputLrcFilesBtn").html("上传歌词");
                            $("#UploadProgress").fadeOut(300);
                            $(".progress-bar").css('width', 0 + "%").text(0 + "%");
                        };
                        return xhr;
                    },
                    success: function (result) {
                        $("#InputLrcFilesBtn").fadeIn(300);
                        $("#submitBtn").fadeIn(300);
                        console.log("lrcUploaded");
                        var arr = result.musicList;
                        flushTdOperation(arr);
                    }
                });
            }
        });
        $("#InputMusicFiles").change(function () {
            if ($("#InputMusicFiles")[0].files.length != 0) {
                var data = new FormData($("#MusicForm")[0]);
                $.ajax({
                    url: "/backend/music/musicFile-add",
                    type: "POST",
                    data: data,
                    processData: false,//告诉ajax不要处理和编码这些数据，直接提交
                    contentType: false,//不使用默认的内容类型
                    xhr: function () {
                        //获取xhr
                        var xhr = $.ajaxSettings.xhr();
                        //上传期间的回调函数、每隔xms触发一次
                        xhr.upload.onprogress = function (ev) {
                            //获取当前上传了多少数据、总共是多少数据
                            //console.log("已经上传:" + ev.loaded);
                            //console.log("总计:" + ev.total);
                            //console.log("当前进度:" + (ev.loaded / ev.total) * 100 + "%");
                            $("#InputMusicBtn").addClass("disabled");
                            $("#InputMusicBtn").html("上传中...");
                            $("#UploadProgress").fadeIn(300);
                            var procent = ((ev.loaded / ev.total) * 100).toFixed(2);
                            $(".progress-bar").css('width', procent + "%").text(procent + "%");
                        };
                        xhr.upload.onloadend = function (ev) {
                            $("#InputMusicBtn").removeClass("disabled");
                            $("#InputMusicBtn").html("上传音乐");
                            $("#UploadProgress").fadeOut(300);
                            $(".progress-bar").css('width', 0 + "%").text(0 + "%");
                        };
                        return xhr;
                    },
                    success: function (result) {
                        $("#InputLrcFilesBtn").fadeIn(300);
                        $("#submitBtn").fadeIn(300);
                        var arr = result.musicList;
                        flushTable(arr);
                    }
                });
            }
        });

        function flushTable(arr) {
            $("tr").not(":first").each(function () {
                if (!$(this).hasClass("trClone")) {
                    $(this).remove();
                }
            });
            for (var i = 0; i < arr.length; i++) {
                addTr();
            }
            var index = 1;
            $(".tdIndex").not(":first").each(function () {
                $(this).html(index);
                index++;
            });
            index = 0;
            $(".tdName").not(":first").each(function () {
                var name = arr[index].name;
                console.log(name);
                $(this).children("input").val(name);
                $(this).children("input").attr("name", "name");
                index++;
            });
            index = 0;
            $(".tdAlias").not(":first").each(function () {
                $(this).children("input").val("${ALBUM.artist.alias}");
                $(this).children("input").attr("name", "alias");
                $(this).children("input").attr("list", "list"+index);
                $(this).children("datalist").attr("id","list"+index);
                index++;
            });
            index = 0;
            $(".tdType").not(":first").each(function () {
                $(this).children("select").attr("name", "typeId");
                index++;
            });
            index = 0;
            $(".tdAlbumId").not(":first").each(function () {
                var albumId = arr[index].albumId;
                $(this).children("input").val(albumId);
                $(this).children("input").attr("name", "albumId");
                index++;
            });
            flushTdOperation(arr);
        }

        function flushTdOperation(arr) {
            var index = 1;
            $(".tdIndex").not(":first").each(function () {
                $(this).html(index);
                index++;
            });
            index = 0;
            $(".tdLrcFile").not(":first").each(function () {
                var hasLrc = arr[index].hasLrc;
                console.log(hasLrc);
                $(this).children("input").attr("id", "InputLrc" + index);
                $(this).children("input").attr("name", "hasLrc");
                $(this).children("button").attr("id", "Del" + index);
                if (hasLrc) {
                    $(this).children("a").removeClass("btn-info").addClass("btn-success");
                    $(this).children("a").html("已匹配");
                    $(this).children("input").val("true");
                } else {
                    $(this).children("a").removeClass("btn-success").addClass("btn-info");
                    $(this).children("a").html("未匹配");
                    $(this).children("input").val("false");
                }
                $(this).children("button").click(function () {
                    var id = $(this).parent().parent().children(".tdId").children("input").val();
                    var name = $(this).parent().parent().children(".tdName").children("input").val();
                    var albumId = arr[0].albumId;
                    delMusic(id,name, albumId);
                    $(this).parent().parent().remove();
                });
                index++;
            });
        }

        function addTr() {
            var $td = $(".trClone").clone(); //增加一行,克隆第一个对象
            $td.removeClass("trClone");
            $(".table").append($td);
        }

        function delMusic(id,name, albumId) {
            $.ajax({
                url: "/backend/music/del",
                type: "GET",
                data: {
                    id: id,
                    name: name,
                    albumId: albumId
                }
            });
        }
    });

    function inputAuthor_input(obj) {
        $("#submitBtn").attr("disabled","disabled");
        var $obj = $(obj);
        var name = $obj.val();
        console.log("obj:"+name);
        if(name==""){
            return;
        }
        $.ajax({
            url: "/backend/artist/queryByName/"+name,
            type: "GET",
            data: name,
            success:function (result) {
                $obj.parent().children("datalist").children().filter("option").remove();
                var artistList = result.list;
                for (var i = 0; i < artistList.length; i++) {
                    $obj.parent().children("datalist").append("<option value="+ artistList[i].alias +">"+ artistList[i].name +"</option>");
                }
            }
        })
    }
    function inputAuthor_change(obj) {
        var $obj = $(obj);
        var name = $obj.val();
        if(name==""){
            return;
        }
        $.ajax({
            url: "/backend/artist/check-alias/"+name,
            type: "GET",
            data: name,
            success:function (result) {
                if(result=="false"){
                    $obj.tooltip('show');
                    $("#submitBtn").attr("disabled","disabled");
                } else {
                    $obj.tooltip('destroy');
                    $("#submitBtn").removeAttr("disabled");
                }
            }
        })
    }
    function select_dbClick(obj) {
        var selectedOpt = obj.value;
        $("select").not(":first").each(function (){
           $(this).val(selectedOpt);
        })
    }
</script>

</html>