<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<head>
    <style>
        .albumControllerBar {
            position: relative;
            overflow-y: scroll;
            height: 500px;
        }

        .albumControllerBar::-webkit-scrollbar {
            display: none;
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
        .tdUploaderId,
        .tdAddress,
        .tdTrackLength,
        .tdPlayTimes,
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
                    <form action="/backend/music/append" id="MusicForm" method="post" enctype="multipart/form-data">
                        <input class="hidden" name="hiddenAlbumId" value="${ALBUM.id}">
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
                                            onclick="$('#InputLrcFiles').click();">添加歌词
                                    </button>
                                    <input id="InputLrcFiles" name="lrcFiles" type="file" multiple="multiple"
                                           accept=".lrc"
                                           style="display: none;"/>
                                    <button id="submitBtn" type="submit" class="btn btn-default">
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
                                    <td class="tdId"><input class="hidden" type="text"></td>
                                    <td class="tdName"><input type="text"></td>
                                    <td class="tdAlias">
                                        <input type="text" data-toggle="tooltip" data-title="该艺人不存在"
                                               onchange="inputAuthor_change(this)" oninput="inputAuthor_input(this)"
                                               autocomplete="off">
                                        <datalist>
                                        </datalist>
                                    </td>
                                    <td class="tdUploaderId"><input type="text"></td>
                                    <td class="tdAddress"><input type="text"></td>
                                    <td class="tdTrackLength"><input type="text"></td>
                                    <td class="tdType">
                                        <select class="select" ondblclick="select_dbClick(this)">
                                            <c:forEach items="${TYPE_LIST}" var="TYPE" >
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
                                <c:if test="${not empty musicList}">
                                    <c:set var="musicIndex" value="1"/>
                                    <c:forEach items="${musicList}" var="MUSIC">
                                        <tr>
                                            <td class="tdIndex">${musicIndex}</td>
                                            <td class="tdId"><input class="hidden" type="text" name="id"
                                                                    value="${MUSIC.id}"></td>
                                            <td class="tdName"><input type="text" name="name" value="${MUSIC.name}">
                                            </td>
                                            <td class="tdAlias">
                                                <input type="text" data-toggle="tooltip" data-title="该艺人不存在"
                                                       list="list${MUSIC.id}" name="alias" value="${MUSIC.artist.alias}"
                                                       onchange="inputAuthor_change(this)"
                                                       oninput="inputAuthor_input(this)" autocomplete="off">
                                                <datalist id="list${MUSIC.id}">
                                                </datalist>
                                            </td>
                                            <td class="tdUploaderId"><input type="text" name="uploaderId"
                                                                            value="${MUSIC.uploaderId}"></td>
                                            <td class="tdAddress"><input type="text" name="address"
                                                                         value="${MUSIC.address}"></td>
                                            <td class="tdTrackLength"><input type="text" name="trackLength"
                                                                             value="${MUSIC.trackLength}"></td>
                                            <td class="tdType">
                                                <select class="select" name="typeId" ondblclick="select_dbClick(this)">
                                                    <c:forEach items="${TYPE_LIST}" var="TYPE" >
                                                        <c:if test="${TYPE.id eq MUSIC.typeId}">
                                                            <option selected="selected"  value="${TYPE.id}">${TYPE.name}&nbsp;${TYPE.enName}</option>
                                                        </c:if>
                                                        <c:if test="${TYPE.id ne MUSIC.typeId}">
                                                            <option value="${TYPE.id}">${TYPE.name}&nbsp;${TYPE.enName}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td class="tdAlbumId"><input type="text" name="albumId"
                                                                         value="${MUSIC.albumId}"></td>
                                            <td class="tdLrcFile">
                                                <button type="button" class="btn btn-danger btn-sm"
                                                        onclick="delBtnOnClick('${MUSIC.id}','${MUSIC.name}',this);"><span
                                                        class="glyphicon glyphicon-trash"></span></button>
                                                <c:if test="${MUSIC.hasLrc eq true}">
                                                    <a class="btn  btn-sm disabled btn-success">已匹配</a>
                                                    <input class="hidden" name="hasLrc" type="text" value="true">
                                                </c:if>
                                                <c:if test="${MUSIC.hasLrc eq false}">
                                                    <a class="btn  btn-sm disabled btn-info">未匹配</a>
                                                    <input class="hidden" name="hasLrc" type="text" value="false">
                                                </c:if>
                                            </td>
                                        </tr>
                                        <c:set var="musicIndex" value="${musicIndex + 1}"/>
                                    </c:forEach>
                                </c:if>
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
                    url: "/backend/music/musicFile-append",
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
            $(".tdId").not(":first").each(function () {
                var id = arr[index].id;
                $(this).children("input").val(id);
                $(this).children("input").attr("name", "id");
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
                $(this).children("input").attr("list", "list" + index);
                $(this).children("datalist").attr("id", "list" + index);
                index++;
            });
            index = 0;
            $(".tdPlayTimes").not(":first").each(function () {
                var playeTimes = arr[index].playeTimes;
                $(this).children("input").val(playeTimes);
                $(this).children("input").attr("name", "playeTimes");
                index++;
            });
            index = 0;
            $(".tdTrackLength").not(":first").each(function () {
                var trackLength = arr[index].trackLength;
                $(this).children("input").val(trackLength);
                $(this).children("input").attr("name", "trackLength");
                index++;
            });
            index = 0;
            $(".tdAddress").not(":first").each(function () {
                var address = arr[index].address;
                $(this).children("input").val(address);
                $(this).children("input").attr("name", "address");
                index++;
            });
            index = 0;
            $(".tdUploaderId").not(":first").each(function () {
                var uploaderId = arr[index].uploaderId;
                $(this).children("input").val(uploaderId);
                $(this).children("input").attr("name", "uploaderId");
                index++;
            });
            index = 0;
            $(".tdType").not(":first").each(function () {
                var typeId = arr[index].typeId;
                typeId = typeId.toString();
                $(this).children("select").attr("name", "typeId");
                var select = $(this).children("select")[0];
                $(select).children("option").each(function () {
                    if (typeId == this.value) {
                        $(this).attr("selected", "selected");
                    }
                });
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
    });

    function delBtnOnClick(id, name, thisObj) {
        var albumId = ${ALBUM.id};
        delMusic(id, name, albumId);
        $(thisObj).parent().parent().remove();
    }

    function delMusic(id, name, albumId) {
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

    function inputAuthor_input(obj) {
        $("#submitBtn").attr("disabled", "disabled");
        var $obj = $(obj);
        var name = $obj.val();
        console.log("obj:" + name);
        if (name == "") {
            return;
        }
        $.ajax({
            url: "/backend/artist/queryByName/" + name,
            type: "GET",
            data: name,
            success: function (result) {
                $obj.parent().children("datalist").children().filter("option").remove();
                var artistList = result.list;
                for (var i = 0; i < artistList.length; i++) {
                    $obj.parent().children("datalist").append("<option value=" + artistList[i].alias + ">" + artistList[i].name + "</option>");
                }
            }
        })
    }

    function inputAuthor_change(obj) {
        var $obj = $(obj);
        var name = $obj.val();
        if (name == "") {
            return;
        }
        $.ajax({
            url: "/backend/artist/check-alias/" + name,
            type: "GET",
            data: name,
            success: function (result) {
                if (result == "false") {
                    $obj.tooltip('show');
                    $("#submitBtn").attr("disabled", "disabled");
                } else {
                    $obj.tooltip('destroy');
                    $("#submitBtn").removeAttr("disabled");
                }
            }
        })
    }

    function select_dbClick(obj) {
        var selectedOpt = obj.value;
        console.log(selectedOpt);
        $("select").not(":first").each(function (){
            $(this).val(selectedOpt);
        })
    }
</script>

</html>