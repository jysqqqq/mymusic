<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:include page="web_header.jsp"/>
<jsp:useBean id="currentUser" class="com.ncist.mymusic.entity.User" scope="session"/>
<div class="container" style="padding: 0px;background: white;">
    <div class="post" style="min-height: 700px;">
        <div id="mainRow" class="row clearfix">
            <div class="col-lg-3">
                <div class="albumCoverBox">
                    <img src="/${COLLECTION.cover}" class="img-rounded img-thumbnail musicCover center-block"/>
                </div>
                <div class="typeBadgeBox">
                    <c:if test="${not empty COLLECTION.typeTag}">
                        <c:forEach items="${COLLECTION.typeTag}" var="TYPE">
                            <span class="label label-success typeBadge">${TYPE}</span>
                        </c:forEach>
                    </c:if>
                </div>
                <div class="well">
                    <h4>介绍</h4>
                    ${COLLECTION.info}
                </div>
            </div>
            <div class="col-lg-9">
                <div class="musicDetailBox">
                    <div class="titleBar">
                        <h3>${COLLECTION.name}</h3>
                        <h4>
                            <small>发布时间 : <fmt:formatDate value="${COLLECTION.pubDate}" type="date"/></small>
                        </h4>
                        <div class="key-valueBox">
                            <span class="keySpan">作者 :</span>
                            <a href="/user/zone/${COLLECTION.userId}">${COLLECTION.uploaderInfo.name}</a>
                        </div>
                    </div>
                    <div class="musicBtnGroup">
                        <a onclick="addCollectionToList(${COLLECTION.id})" class="btn btn-primary roundBtn">&ensp;<span
                                class="icon glyphicon-play"></span>&ensp;播放&ensp;
                        </a>
                        <c:if test="${COLLECTION.favorite}">
                            <a onclick="favoriteCollection(this,${COLLECTION.id})" id="albumLoveBtn"
                               class="btn btn-primary roundBtn">&ensp;<span
                                    class="fa fa-heart icon-red"></span>&ensp;收藏&ensp;
                            </a>
                        </c:if>
                        <c:if test="${!COLLECTION.favorite}">
                            <a onclick="favoriteCollection(this,${COLLECTION.id})" id="albumLoveBtn"
                               class="btn btn-primary roundBtn">&ensp;<span
                                    class="fa fa-heart"></span>&ensp;收藏&ensp;
                            </a>
                        </c:if>
                        <c:if test="${COLLECTION.userId eq currentUser.id}">
                            <a onclick="addMusicToCollectionBtn_Click(${COLLECTION.userId},${COLLECTION.id})"
                               class="btn btn-primary roundBtn">&ensp;<span
                                    class="icon glyphicon-plus"></span>&ensp;添加歌曲&ensp;
                            </a>
                            <a href="/collection/edit/${COLLECTION.id}" class="btn btn-primary roundBtn">&ensp;<span
                                    class="icon glyphicon-edit"></span>&ensp;编辑歌单&ensp;
                            </a>
                            <a  onclick="delCollection(${COLLECTION.id})"
                               class="btn btn-danger roundBtn">&ensp;<span
                                    class="icon glyphicon-trash"></span>&ensp;删除歌单&ensp;
                            </a>
                        </c:if>
                        <hr/>
                    </div>
                    <div class="musicListBox">
                        <table class="table table-hover table-striped musicListTable sideTable">
                            <thead>
                            <th>#</th>
                            <th>名称</th>
                            <th>歌手</th>
                            <th>专辑</th>
                            <th>时长</th>
                            </thead>
                            <tbody id="collectionMusicList">
                            <c:set var="index" value="1"/>
                            <c:forEach items="${MUSIC_LIST}" var="MUSIC">
                                <tr>
                                    <td>
                                        <div class="musicListTableTdIndex">${index}</div>
                                        <div class="musicListTableTdPlayBtn"
                                             onclick="appendMusic(${MUSIC.id})"><span
                                                class="icon glyphicon-play-circle"></span></div>
                                    </td>
                                    <td><a href="/music/detail/${MUSIC.id}">${MUSIC.name}</a></td>
                                    <td><a href="/artist/detail/${MUSIC.artistId}">${MUSIC.player}</a></td>
                                    <td><a href="/album/detail/${MUSIC.albumId}">${MUSIC.albumInfo.name}</a></td>
                                    <td>
                                        <div class="musicListTableTdTrackLength">
                                                ${MUSIC.trackLength}
                                        </div>
                                        <div class="musicListTableTdOperation">
                                            <c:if test="${MUSIC.favorite}">
                                                    <span onclick="favoriteMusic(this,${MUSIC.id})"
                                                          class="fa fa-heart icon-red"></span>
                                            </c:if>
                                            <c:if test="${!MUSIC.favorite}">
                                                    <span onclick="favoriteMusic(this,${MUSIC.id})"
                                                          class="fa fa-heart-o icon-red"></span>
                                            </c:if>
                                            <a href="/${MUSIC.address}" download="${MUSIC.name}.mp3"><span
                                                    class="fa fa-download icon-black"></span></a>
                                            <c:if test="${currentUser.id eq COLLECTION.userId}">
                                                <a onclick="delMusicFromCollection(this,${MUSIC.id},${COLLECTION.id})"><span
                                                        class="fa fa-trash icon-black"></span></a>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                                <c:set var="index" value="${index+1}"/>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="albumBox">

                </div>
            </div>

        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
<!-- addMusicModal -->
<div class="modal fade" id="addMusicModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="addMusicLabel">添加歌曲</h4>
            </div>
            <div class="modal-body">
                <div class="searchBar">
                    <div class="input-group">
                        <input onkeydown="if(event.keyCode==13){$('#addBtn').click();}" id="InputMusicName" type="text" class="form-control" placeholder="查找歌曲">
                        <span class="input-group-btn">
                            <button id="addBtn" onclick="queryMusicByNameForCollection(${COLLECTION.id})" class="btn btn-default"
                                    type="button">搜索</button>
                        </span>
                    </div>
                </div>
                <h4 id="resultBoxTitle" class="resultBoxTitle">收藏的歌曲</h4>
                <div id="resultBox" class="resultBox ">
                    <table id="resultTalbe" class="table table-hover">
                        <tbody id="resultTalbeTbody" class="resultTalbeTbody">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="audio_controller.jsp"/>
<script type="text/javascript" src="/js/web.js"></script>
<script>
    function addMusicToCollectionBtn_Click(userId, collectionId) {
        $.ajax({
            url: "/collection/queryFavoriteMusicList",
            type: "GET",
            data: {
                "userId": userId,
                "collectionId": collectionId
            },
            success: function (musicList) {
                $("#resultBoxTitle").html("收藏的歌曲");
                flushMusicModal(musicList, collectionId);
                $("#addMusicModal").modal('show');
            }
        })

    }

    function addMusicToCollection(obj, musicId, collectionId) {
        $.ajax({
            url: "/collection/addMusicToCollection",
            type: "POST",
            data: {
                "musicId": musicId,
                "collectionId": collectionId
            },
            success: function (music) {
                $(obj).parent().html("").append("<td>已添加</td>");
                var index = $("#collectionMusicList").children("tr").length + 1;
                var html = "";
                if (music.favorite) {
                    html = "<span onclick='favoriteMusic(this," + music.id + ")' class='fa fa-heart icon-red'></span>"
                } else {
                    html = "<span onclick='favoriteMusic(this," + music.id + ")' class='fa fa-heart-o icon-red'></span>"
                }
                $("#collectionMusicList").append("<tr>\n" +
                    "                                        <td>\n" +
                    "                                            <div class=\"musicListTableTdIndex\">" + index + "</div>\n" +
                    "                                            <div class=\"musicListTableTdPlayBtn\"\n" +
                    "                                                 onclick=\"appendMusic(" + music.id + ")\"><span\n" +
                    "                                                    class=\"icon glyphicon-play-circle\"></span></div>\n" +
                    "                                        </td>\n" +
                    "                                        <td><a href=\"/music/detail/" + music.id + "\">" + music.name + "</a></td>\n" +
                    "                                        <td><a href=\"/artist/detail/" + music.artistId + "\">" + music.player + "</a></td>\n" +
                    "                                        <td><a href=\"/album/detail/" + music.albumId + "\">" + music.albumInfo.name + "</a></td>\n" +
                    "                                        <td>\n" +
                    "                                            <div class=\"musicListTableTdTrackLength\">\n" +
                    "                                                    " + music.trackLength + "\n" +
                    "                                            </div>\n" +
                    "                                            <div class=\"musicListTableTdOperation\">\n" + html +
                    "                                                <a href=\"/" + music.address + "\" download=\"" + music.name + ".mp3\"><span class=\"fa fa-download icon-black\"></span></a>" +
                    "                                                <a onclick='delMusicFromCollection(this," + music.id + "," + collectionId + ")' ><span class='fa fa-trash icon-black'></span></a>" +
                    "                                            </div>\n" +
                    "                                        </td>\n" +
                    "                                    </tr>");

            }
        })
    }

    function delMusicFromCollection(obj, musicId, collectionId) {
        $.ajax({
            url: "/collection/delMusicFromCollection",
            type: "POST",
            data: {
                "musicId": musicId,
                "collectionId": collectionId
            },
            success: function () {
                $(obj).parent().parent().parent().remove();
                var index = 1;
                $("#collectionMusicList").children("tr").each(function () {
                    $(this).find(".musicListTableTdIndex").html(index);
                    index++;
                })
            }

        })
    }

    function queryMusicByNameForCollection(collectionId) {
        if ($("#InputMusicName").val().trim() !== "") {
            var name = $("#InputMusicName").val();
            $.ajax({
                url: "/collection/queryMusicForCollection",
                type: "GET",
                data: {
                    "collectionId": collectionId,
                    "name": name
                },
                success: function (musicList) {
                    $("#resultBoxTitle").html("查询结果");
                    flushMusicModal(musicList, collectionId);
                }
            })
        }
    }

    function flushMusicModal(musicList, collectionId) {
        $("#resultTalbeTbody").html("");
        for (var i = 0; i < musicList.length; i++) {
            if (musicList[i].select) {
                $("#resultTalbeTbody").append("<tr>\n" +
                    "    <td>" + musicList[i].name + "</td>\n" +
                    "    <td>" + musicList[i].player + "</td>\n" +
                    "    <td>" + musicList[i].trackLength + "</td>\n" +
                    "    <td>已添加</td>\n" +
                    "</tr>");
            } else {
                $("#resultTalbeTbody").append("<tr>\n" +
                    "    <td>" + musicList[i].name + "</td>\n" +
                    "    <td>" + musicList[i].player + "</td>\n" +
                    "    <td>" + musicList[i].trackLength + "</td>\n" +
                    "    <td><a onclick='addMusicToCollection(this," + musicList[i].id + "," + collectionId + ")'>添加</a></td>\n" +
                    "</tr>");
            }
        }
    }

    function delCollection(id) {
        swal({
            title: "操作确认",
            text: "该操作不能撤销,是否确认?",
            icon: "warning",
            buttons: ["算了", "删！"],
            dangerMode: true
        })
        .then((willDelete) => {
            if (willDelete) {
                swal("删除成功", {
                    icon: "success",
                })
                .then((value) =>{
                    $(location).prop('href', '/collection/del/'+id)
                });
            }
        });
    }
</script>
</body>
</html>
