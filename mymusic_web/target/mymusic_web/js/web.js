var audio = $(window.parent.frames["musicPlayerFrame"].document).find("#player").get(0);
var webSocket = null;
function isAllChindeseText(str) {
    if (str.length != 0) {
        if (str.match(/^[\u4e00-\u9fa5]+$/)) {
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }
}
function login() {
    var account = $("#LoginInputAccount").val();
    var password = $("#LoginInputPassword").val();
    $.ajax({
        url: "/user/login",
        type: "POST",
        data: {
            "account":account,
            "password":password
        },
        success: function (result) {
            if(result=="banned"){
                swal({
                    title: "登录失败",
                    text: "该用户已被封禁",
                    icon: "warning"
                })
                    .then(function (value) {
                        if(value){
                            $(location).prop('href', '/cloudmi/index');
                        }
                    })
                }else if(result=="fail"){
                    swal({
                        title: "登录失败",
                        text: "用户名或密码错误",
                        icon: "warning"
                    })
                }else {
                    $(location).prop('href', '/cloudmi/index');
                }
        }
    });
}
function addAlbumToList(id) {
    $.ajax({
        url: "/audio/addAlbumToList/" + id,
        type: "GET",
        success: function (music) {
            addPlayerListToBox();
            playThis(music, 0);
        }
    })
}

function addCollectionToList(id) {
    $.ajax({
        url: "/audio/addCollectionToList/" + id,
        type: "GET",
        success: function (music) {
            addPlayerListToBox();
            playThis(music, 0);
        }
    })
}

function addArtistHotMusicToList(id) {
    $.ajax({
        url: "/audio/addArtistHotMusicToList/" + id,
        type: "GET",
        success: function (music) {
            addPlayerListToBox();
            playThis(music, 0);
        }
    })
}

function addFavoriteMusicToList(id) {
    $.ajax({
        url: "/audio/addFavoriteMusicToList/" + id,
        type: "GET",
        success: function (music) {
            addPlayerListToBox();
            playThis(music, 0);
        }
    })
}

function delMusicFromList(obj) {
    var index = $(obj).parent().parent().parent().find(".playerListTableTdIndex").children("a").html()-1;
    $.ajax({
        url: "/audio/delMusicFromList/" + index,
        type: "POST",
        success: function (result) {
            if (result == "success") {
                $(obj).parent().parent().parent().remove();
                var i = 0;
                $(".playerListTableTdIndex").each(function () {
                    i++;
                    $(this).html("<a>"+i+"</a>");
                })
                $(".playerListFooter").html("共"+i+"首");
            }
        }
    })

}

function skipToThisTime(time) {
    audio.currentTime = time;
}

function changeToThisMusicFromPlayerList(obj) {
    var index = $(obj).next().children("a").html()-1;
    $.ajax({
        url: "/audio/getMusicByIndexFromPlayerList/" + index,
        type: "GET",
        success: function (music) {
            playThis(music, index);
        }
    });
}

function reNewPlayerList(index) {
    var i = 0;
    $("#playerListBox").children("tr").each(function () {
        $(this).removeClass("playerListTableTrActive");
        if (i == index) {
            $(this).addClass("playerListTableTrActive");
        }
        i++;
    })
}

function playThis(music, index) {
    if (music != null) {
        audio.src = "https://potato-bucket-1301217747.cos.ap-shanghai.myqcloud.com/" + music.address;
        console.log(audio.src);
        addLrcToLrcBox();
        reNewPlayerList(index);
        flushPlayerBar(music);
        $("#Play").children("span").removeClass("glyphicon-play").addClass("glyphicon-pause");
        $("#audioPlayerBar").show(500);
        audio.play();
    } else {
        $(".playerListBox").fadeOut(100);
        $("#audioPlayerBar").hide(500);
        audio.src="";
    }
}

function addPlayerListToBox() {
    $.ajax({
        url: "/audio/addPlayerListToBox",
        type: "POST",
        success: function (listMap) {
            flushPlayerList(listMap.list, listMap.currentIndex);
        }
    })
}

function flushPlayerList(playerList, currentIndex) {
    $("#playerListBox").children("tr").remove();
    var trHtml = "";
    var trHead = "";
    for (var i = 0; i < playerList.length; i++) {
        if (i == currentIndex) {
            trHead = "<tr class='playerListTableTrActive'>\n";
        } else {
            trHead = "<tr>\n";
        }
        trHtml = trHead +
            "                            <td>\n" +
            "                                <div class=\"playerListTableTdPlayBtn\" onclick=\"changeToThisMusicFromPlayerList(this)\">" +
            "                                    <span class=\"fa fa-play-circle-o icon-black\"></span>\n" +
            "                                </div>\n" +
            "                                <div class=\"playerListTableTdIndex\"><a>" + (i + 1) + "</a></div>\n" +
            "                            </td>\n" +
            "                            <td class=\"playerListTableTd\">\n" +
            "                                <div class=\"playerListTableTd\"><a href=/music/detail/" + playerList[i].id + ">" + playerList[i].name + "</a></div>\n" +
            "                            </td>\n" +
            "                            <td class=\"playerListTableTd\">\n" +
            "                                <div class=\"playerListTableTd\"><a href=/artist/detail/" + playerList[i].artistId + ">" + playerList[i].player + "</a></div>\n" +
            "                            </td>\n" +
            "                            <td class=\"playerListTableTd\">\n" +
            "                                <div class=\"playerListTableTdTrackLength\"><a>" + playerList[i].trackLength + "</a></div>\n" +
            "                                <div class=\"playerListTableTdOperation\">\n" +
            "                                    <a onclick='delMusicFromList(this)' class='icon glyphicon-trash icon-black'></a>" +
            "                                    <a href='/" + playerList[i].address + "' download='" + playerList[i].name + ".mp3'><span class=\"icon glyphicon-download icon-black\"></span></a>\n" +
            "                                </div>\n" +
            "                            </td>\n" +
            "                        </tr>";
        $("#playerListBox").append(trHtml);
    }
    $("#playerListFooter").html("共" + playerList.length + "首");
}

function addLrcToLrcBox() {
    $.ajax({
        url: "/audio/addLrcToLrcBox",
        type: "GET",
        success: function (lrcMap) {
            flushLrcBox(lrcMap.lrc);
        }
    })
}

function flushPlayerBar(music) {
    $("#coverMusicName").html("");
    $("#coverAuthorName").html("");
    $("#MoreBtnDownloadLi").html("");
    $("#MoreBtnCommentLi").html("");
    $("#MoreBtnAddCollectionLi").html("");
    $("#loveButton").html("");

    if (music.favorite) {
        $("#loveButton").append("<span onclick='favoriteMusic(this," + music.id + ")' class='fa fa-heart fa-icon-sm icon-red'></span>")
    } else {
        $("#loveButton").append("<span onclick='favoriteMusic(this," + music.id + ")' class='fa fa-heart-o fa-icon-sm icon-red'></span>")
    }
    $("#coverMusicName").append("<a href='/music/detail/" + music.id + "'>" + music.name + "</a>");
    $("#coverAuthorName").append("<a href='/artist/detail/" + music.artistId + "'>" + music.player + "</a>");
    $("#MoreBtnDownloadLi").append("<a href='/" + music.address + "' download='" + music.name + ".mp3'>下载</a>");
    $("#MoreBtnCommentLi").append("<a href='/music/detail/" + music.id + "'>评论</a>");
    $("#MoreBtnAddCollectionLi").append("<a onclick='addMusicToCollectionLi_Click(" + music.id + ")'>加入歌单</a>");
    $("#coverImg").attr("src", "/" + music.cover);
}

function flushLrcBox(lrc) {
    $(".playerLrcFlow").html("");
    $(".playerLrcFlow").css("top", 0);
    var lrcArr = lrc.split("["); //[ "0:1.0]xxxxxx" , "0:2.0]xxxxxx" ]
    var index = 0;
    for (var i = 0; i < lrcArr.length; i++) {
        var lrcLineArr = lrcArr[i].split("]");//[ "0:1.0" , "xxxxx" ]
        if (lrcLineArr[0].match("[a-zA-Z]")) {
            continue;
        }
        var rowLrcTimeArr = lrcLineArr[0].split("."); //[ "0:1" , "0" ]
        var lrcTimeArr = rowLrcTimeArr[0].split(":"); //["0" , "1"];
        var timeCut = lrcTimeArr[0] * 60 + lrcTimeArr[1] * 1; // 0*60 + 1*1
        if (lrcLineArr[1]) {
            //判断是否是[外文,中文]型歌词
            if (lrcLineArr[1].indexOf(",") != -1) {
                var languageArr = lrcLineArr[1].split(",");
                $(".playerLrcFlow").append("<p id=" + timeCut + " class='lrcText' name=" + index + " onclick=skipToThisTime(" + timeCut + ") >" + languageArr[0] + "</p>");
                index++;
                $(".playerLrcFlow").append("<p id=" + timeCut + " class='lrcText' name=" + index + " onclick=skipToThisTime(" + timeCut + ") >" + languageArr[1] + "</p>");
                index++;
            } else {
                $(".playerLrcFlow").append("<p id=" + timeCut + " class='lrcText' name=" + index + " onclick=skipToThisTime(" + timeCut + ") >" + lrcLineArr[1] + "</p>");
                index++;
            }

        }
    }
}

function delMusicComment(obj, id) {
    $.ajax({
        url: "/music/delComment/" + id,
        type: "POST",
        success: function () {
            $(obj).parent().parent().parent().remove();
        }
    })
}

function shareComment(obj, shareId, userId) {
    var content = $(obj).parent().find("textarea").val();
    if (content.trim() != "") {
        $.ajax({
            url: "/share/comment",
            type: "POST",
            data: {
                "workId": shareId,
                "uploaderId": userId,
                "content": content
            },
            success: function (commentList) {
                var commentArea = $(obj).parent().find(".shareCommentBox");
                flushCommentArea(commentArea, commentList, userId);
                $(obj).parent().find("textarea").val("");
            }
        })
    }
}

function flushCommentArea(commentArea, commentList, userId) {
    $(commentArea).html("");
    var delhtml = "<a onclick='delShareComment(" + userId + ")'> 删除</a>";
    var htmlhead = ""
    for (var i = 0; i < commentList.length; i++) {
        var date = new Date(commentList[i].uploadTime);
        var dateString = dateFtt("yyyy-MM-dd hh:mm:ss", date);
        if (userId != commentList[i].uploaderId) {
            $(commentArea).append(" <div class='media'>\n" +
                "<div class='media-left media-top'>\n" +
                "<a href='/user/zone/" + commentList[i].userId + "'>\n" +
                "<img class='media-object img-circle img-thumbnail coverSmall'\n" +
                "src='/" + commentList[i].uploaderInfo.avatar + "'></a>\n" +
                "</div>\n" +
                "<div class='media-body'>\n" +
                "<h5 class='media-heading'>" + commentList[i].uploaderInfo.name + "</h5>\n" +
                "<h5>\n" +
                "<small>" + dateString + "</small>\n" +
                "</h5><div class='mediaTextBox'>\n" + commentList[i].content +
                "</div></div>\n" +
                "</div>\n" +
                " <hr/>");
        } else {
            $(commentArea).append(" <div class='media'>\n" +
                "<div class='media-left media-top'>\n" +
                "<a href='/user/zone/" + commentList[i].userId + "'>\n" +
                "<img class='media-object img-circle img-thumbnail coverSmall'\n" +
                "src='/" + commentList[i].uploaderInfo.avatar + "'></a>\n" +
                "</div>\n" +
                "<div class='media-body'>\n" +
                "<h5 class='media-heading'>" + commentList[i].uploaderInfo.name + "</h5>\n" +
                "<h5>\n" +
                "<small>" + dateString + "<a onclick='delShareComment(this," + userId + ")'> 删除</a></small>\n" +
                "</h5><div class='mediaTextBox'>\n" + commentList[i].content +
                "</div></div>\n" +
                "</div>\n" +
                " <hr/>");
        }
    }

}

function delShareComment(obj, id) {
    swal({
        title: "操作确认",
        text: "该操作不能撤销,是否确认?",
        icon: "warning",
        buttons: ["算了", "删！"],
        dangerMode: true
    })
        .then((willDelete) => {
        if(willDelete) {
            swal({
                title: "删除成功",
                icon: "success",
            })
                .then(value => {
                $.ajax({
                    url: "/share/delComment/" + id,
                    type: "POST",
                    success: function (result) {
                        $(obj).parent().parent().parent().parent().remove();
                    }
                })
            }
        )
        }
    }
)
}

function appendMusic(id) {
    $.ajax({
        url: "/audio/appendMusic/" + id,
        type: "POST",
        success: function (result) {
            addPlayerListToBox();
            playThis(result.music, result.index);
        }
    })
}

function favoriteMusic(obj, id) {
    $.ajax({
        url: "/favorite/music/" + id,
        type: "POST",
        success: function (result) {
            if (result == "noUser") {
                $('#loginModal').modal('show');
            } else if (result == "add") {
                $(obj).removeClass("fa-heart-o").addClass("fa-heart");
            } else {
                $(obj).removeClass("fa-heart").addClass("fa-heart-o");
            }
        }
    })
}

function favoriteAlbum(obj, id) {
    $.ajax({
        url: "/favorite/album/" + id,
        type: "POST",
        success: function (result) {
            if (result == "noUser") {
                $('#loginModal').modal('show');
            } else if (result == "add") {
                $(obj).children("span").addClass("icon-red");
            } else {
                $(obj).children("span").removeClass("icon-red")
            }
        }
    })

}

function favoriteCollection(obj, id) {
    $.ajax({
        url: "/favorite/collection/" + id,
        type: "POST",
        success: function (result) {
            if (result == "noUser") {
                $('#loginModal').modal('show');
            } else if (result == "add") {
                $(obj).children("span").addClass("icon-red");
            } else {
                $(obj).children("span").removeClass("icon-red")
            }
        }
    })

}

function disableParentLink(obj) {
    $(obj).parent().parent().attr("onclick", "return false;");
}

function enableParentLink(obj) {
    $(obj).parent().parent().removeAttr("onclick");
}

function rankingListChangeCover(cover) {
    $("#rankingListContentCover").css("background-image", "url('" + cover + "')");
    $("#rankingListBackgroundBox").css("background-image", "url('" + cover + "')");
}

function addMusicToCollectionLi_Click(musicId) {
    $.ajax({
        url: "/collection/queryCollectionFromCurrentUser",
        data: {
            "musicId": musicId
        },
        type: "GET",
        success: function (result) {
            if (result.result == "noUser") {
                $('#loginModal').modal('show');
            } else {
                var collectionList = result.collections;
                $("#resultCollectionList").html("");
                for (var i = 0; i < collectionList.length; i++) {
                    $("#resultCollectionList").append("<tr>\n" +
                        "                                <td><img class=\"img-rounded img-thumbnail coverSmall\" src='/" + collectionList[i].cover + "'></td>\n" +
                        "                                <td>" + collectionList[i].name + "</td>\n" +
                        "                                <td><a onclick=\"addMusicToCollectionFromAudio(" + musicId + "," + collectionList[i].id + ")\">添加</a></td>\n" +
                        "                              </tr>")
                }
                $('#CollectionModal').modal('show');
            }
        }
    })
}

function shareBtn_Click(musicId) {
    if (musicId == 0) {
        $("#ShareModal").modal("show");
    } else {
        shareThisMusic(musicId);
        $("#ShareModal").modal("show");
    }
}

function delShare(obj, id) {
    swal({
        title: "操作确认",
        text: "该操作不能撤销,是否确认?",
        icon: "warning",
        buttons: ["算了", "删！"],
        dangerMode: true
    })
        .then((willDelete) => {
        if(willDelete) {
            swal({
                title: "删除成功",
                icon: "success",
            })
                .then(value => {
                $.ajax({
                    url: "/share/del/" + id,
                    type: "POST",
                    success: function (result) {
                        $(obj).parent().parent().parent().remove();
                    }
                })
            }
        )
        }
    }
)
}

function queryMusicByNameForShare() {
    if ($("#shareInputMusicName").val().trim() !== "") {
        var name = $("#shareInputMusicName").val();
        $.ajax({
            url: "/music/queryMusicList",
            type: "GET",
            data: {
                "name": name
            },
            success: function (musicList) {
                $("#shareResultBoxTitle").html("查询结果");
                flushShareModal(musicList);
            }
        })
    }
}

function flushShareModal(musicList) {
    $("#shareResultTalbeTbody").html("");
    for (var i = 0; i < musicList.length; i++) {
        $("#shareResultTalbeTbody").append("<tr>\n" +
            "    <td>" + musicList[i].name + "</td>\n" +
            "    <td>" + musicList[i].player + "</td>\n" +
            "    <td>" + musicList[i].trackLength + "</td>\n" +
            "    <td><a onclick='shareThisMusic(" + musicList[i].id + ")'>选择</a></td>\n" +
            "</tr>");
    }
}

function shareThisMusic(id) {
    $.ajax({
        url: "/music/queryMusic",
        type: "GET",
        data: {
            "id": id
        },
        success: function (music) {
            $("#shareInputMusicId").val(music.id);
            $("#shareMusicCoverImg").attr("src", "/" + music.cover);
            $("#shareMusicPlayBtn").attr("onclick", "appendMusic(" + music.id + ")");
            $("#shareMusicName").html(music.name);
            $("#shareMusicAuthor").html(music.player);
            $("#shareMusicBox").removeClass("hidden");
        }
    })
}

function addMusicToCollectionFromAudio(musicId, collectionId) {
    $.ajax({
        url: "/collection/addMusicToCollection",
        type: "POST",
        data: {
            "musicId": musicId,
            "collectionId": collectionId
        },
        success: function () {
            swal({
                title: "成功",
                text: "已加入歌单",
                icon: "success",
                button: "确认"
            });
            $('#CollectionModal').modal('hide');
        }
    })
}

function follow(obj, userId) {
    $.ajax({
        url: "/user/follow/" + userId,
        type: "POST",
        success: function (result) {
            if (result == "noUser") {
                $('#loginModal').modal('show');
            } else {
                $(obj).html("<span class=\"icon glyphicon-minus\"></span> 取消关注</button>");
                $(obj).removeAttr("onclick").attr("onclick", "unfollow(this," + userId + ")");
                $(".fanBox").find("a").html(parseInt($(".fanBox").find("a").html()) + 1);
            }
        }
    })
}

function unfollow(obj, userId) {
    $.ajax({
        url: "/user/unfollow/" + userId,
        type: "POST",
        success: function (result) {
            if (result == "noUser") {
                $('#loginModal').modal('show');
            } else {
                $(obj).html("<span class=\"icon glyphicon-plus\"></span> 关注</button>");
                $(obj).removeAttr("onclick").attr("onclick", "follow(this," + userId + ")");
                $(".fanBox").find("a").html($(".fanBox").find("a").html() - 1);
            }
        }

    })
}

function searchMusic(obj) {
    var name = $(obj).val().trim();
    while (name.indexOf('%')!=-1){
        name = name.replace('%','');
    }
    if (name != "") {
        window.location.href = "/search/" + name + "/1";
    }else {
        $(obj).val("");
    }
}

function dateFtt(fmt, date) {
    var o = {
        "M+": date.getMonth() + 1,                 //月份
        "d+": date.getDate(),                    //日
        "h+": date.getHours(),                   //小时
        "m+": date.getMinutes(),                 //分
        "s+": date.getSeconds(),                 //秒
        "q+": Math.floor((date.getMonth() + 3) / 3), //季度
        "S": date.getMilliseconds()             //毫秒
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}