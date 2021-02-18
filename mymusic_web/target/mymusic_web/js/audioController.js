$(document).ready(function () {
    var $audio = $(window.parent.frames["musicPlayerFrame"].document).find("#player");
    var audio = $(window.parent.frames["musicPlayerFrame"].document).find("#player").get(0);
    var isdragProcessBar = false;
    var currentLrcIndex = 0;
    if ($("#Play").children().hasClass('glyphicon-play') && !audio.paused) {
        $("#Play").children("span").removeClass("glyphicon-play").addClass("glyphicon-pause");
    }
    //播放按钮被点击了
    $("#Play").on('click', function () {
        if (audio.paused) {
            if ($(this).children().hasClass('glyphicon-play')) {
                Play();
            }
        } else {
            Pause();
        }
    }); // Button cilick

    function Play() {
        $("#Play").children("span").removeClass("glyphicon-play").addClass("glyphicon-pause");
        audio.play();
    } //Play()

    $audio.on("play",TimeSpan());
    var timeText = "";
    $audio.on("timeupdate", function () {
        timeText = this.currentTime;
        var timeCut = parseInt(this.currentTime);
        if (document.getElementById(timeCut)) {
            $(".lrcText").each(function () {
                $(this).css("color", "#4a4a4a");
            });
            $("#" + timeCut).css("color", "orangered");
            if (parseInt($("#" + timeCut).attr("name")) >= 0) {
                var index = parseInt($("#" + timeCut).attr("name"));
                scollLrcFlow(index);
            }

        }
    });

    function scollLrcFlow(index) {
        index = index - 5;
        if (index < 0) {
            index = 0;
        }
        var endTop = -index * 24;
        $("#playerLrcFlow").css("top", endTop + "px");
    }


    $audio.on("pause", function () {
        if (audio.ended) {
            audio.currentTime = 0;
            $.ajax({
                url: "/audio/getNextMusic",
                type: "GET",
                success: function (result) {
                    playThis(result.music,result.currentIndex);
                }
            });
        }
    });

    function Pause() {
        $("#Play").children("span").removeClass("glyphicon-pause").addClass("glyphicon-play");
        audio.pause();
    } //Pause()

    function TimeSpan() {
        if (!isdragProcessBar) {
            var ProcessNow = 0;
            setInterval(function () {
                ProcessNow = (audio.currentTime / audio.duration) * 280;
                $(".processNow").css("width", ProcessNow);
                $(".processButton").css("left", ProcessNow);
                var currentTime = timeFormat(audio.currentTime);
                var timeAll = timeFormat(TimeAll());
                $(".songInfo").html(currentTime + " / " + timeAll);
            }, 1000);
        }
    } //TimeSpan()
    function timeFormat(number) {
        var minute = parseInt(number / 60);
        var second = parseInt(number % 60);
        minute = minute >= 10 ? minute : "0" + minute;
        second = second >= 10 ? second : "0" + second;
        return minute + ":" + second;
    } //timeFormat()

    function TimeAll() {
        return audio.duration;
    } //TimeAll()

    var oldX = 0;
    var left = 0;
    var pleft = 0;
    var pleftAll = $(".processAll").width();
    var newLeft = 0;
    $(".processButton").on("mousedown", function (e) {
        oldX = e.pageX;
        left = 0;
        isdragProcessBar = true;
        pleft = $(".processButton").position().left;
        $("#isDrag").html("true ");
    });
    $(document).on("mousemove", function (e) {
        if (isdragProcessBar) {
            left = e.pageX - oldX;
            newLeft = left + pleft;
            if (newLeft < 0) {
                newLeft = 0;
            }
            if (newLeft > pleftAll) {
                newLeft = pleftAll;
            }
            var perDuration = newLeft / $(".processAll").width();
            var time = TimeAll() * perDuration;
            audio.currentTime = time;
            var currentTime = timeFormat(time);
            var timeAll = timeFormat(TimeAll());
            $(".songInfo").html(currentTime + " | " + timeAll);
            $(".processNow").css("width", newLeft);
            $(".processButton").css("left", newLeft);
        }
    });
    $(document).on("mouseup", function () {
        isdragProcessBar = false;
        $("#isDrag").html("false");
    });
    $(".nextButton").on("click", function () {
        audio.currentTime = 0;
        $.ajax({
            url: "/audio/getNextMusic",
            type: "GET",
            success: function (result) {
                playThis(result.music,result.currentIndex);
            }
        });
    });
    $(".preButton").on("click", function () {
        audio.currentTime = 0;
        $.ajax({
            url: "/audio/getLastMusic",
            type: "GET",
            success: function (result) {
                playThis(result.music,result.currentIndex);
            }
        });
    });
    //点击了歌词按钮
    $(".lrcButton").on("click", function () {
        //如果播放列表已打开
        if ($(".listButton").find("span").hasClass("icon-red")) {
            //关闭播放列表
            $(".listButton").find("span").removeClass("icon-red").addClass("icon-black");
            $('.playerList').fadeOut(0);
            $('.playerListBox').fadeOut(0);
        }
        //如果歌词已打开
        if ($(".lrcButton").find("span").hasClass("icon-red")) {
            //关闭歌词
            $(".lrcButton").find("span").removeClass("icon-red").addClass("icon-black");
            $('.playerLrc').fadeOut(200);
            $('.playerListBox').fadeOut(200);
            //如果都没打开
        } else if ($(".lrcButton").find("span").hasClass("icon-black")) {
            //打开歌词
            $(".lrcButton").find("span").removeClass("icon-black").addClass("icon-red");
            $('.playerLrc').fadeIn(200);
            $('.playerListBox').fadeIn(200);
            addLrcToLrcBox();
        }
    });
    //点击了播放列表按钮
    $(".listButton").on("click", function () {
        //如果歌词已打开
        if ($(".lrcButton").find("span").hasClass("icon-red")) {
            //关闭歌词
            $(".lrcButton").find("span").removeClass("icon-red").addClass("icon-black");
            $('.playerLrc').fadeOut(0);
            $('.playerListBox').fadeOut(0);
        }
        //如果播放列表已打开
        if ($(".listButton").find("span").hasClass("icon-red")) {
            //关闭播放列表
            $(".listButton").find("span").removeClass("icon-red").addClass("icon-black");
            $('.playerList').fadeOut(200);
            $('.playerListBox').fadeOut(200);
            //如果都没打开
        } else if ($(".listButton").find("span").hasClass("icon-black")) {
            //打开播放列表
            $(".listButton").find("span").removeClass("icon-black").addClass("icon-red");
            addPlayerListToBox();
            $('.playerList').fadeIn(200);
            $('.playerListBox').fadeIn(200);
        }
    });

    $(function () {
        var num = 0;

        function goLeft() {
            if (num == -150) {
                num = 30;
            }
            num -= 1;
            $("#coverMusicName").css({
                left: num
            })
        }

        //设置滚动速度
        var timer;
        //设置鼠标经过时滚动
        $("#coverMusicNameBox").hover(function () {
                var musicNameWidth = document.getElementById("coverMusicName").scrollWidth;
                var musicNameBoxWidth = $("#coverMusicNameBox").width();
                if(musicNameWidth>musicNameBoxWidth){
                    timer = setInterval(goLeft, 30);
                }
            },
            function () {
                clearInterval(timer);
                num = 0;
                $("#coverMusicName").css({
                    left: 0
                })
            })

    });

});

function favoriteMusicFromAudio(obj,id) {
    $.ajax({
        url:"/audio/favorite/"+id,
        type:"POST",
        success:function (result) {
            if (result=="noUser"){
                $('#loginModal').modal('show');
            }else if(result=="add"){
                $(obj).removeClass("fa-heart-o").addClass("fa-heart");
            }else {
                $(obj).removeClass("fa-heart").addClass("fa-heart-o");
            }
        }
    })
}

