<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:useBean id="currentUser" class="com.ncist.mymusic.entity.User" scope="session"/>
<html>
<head>
    <meta charset="utf-8"/>
    <title></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/web.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/audioController.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/sweetalert.min.js"></script>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top" style="background: white;">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <a href="#"><img style="margin-top: 10px;margin-right: 15px;" src="/assets/img/res/logoko-small.png"></a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li>
                    <a href="/cloudmi/index"><strong>发现音乐</strong></a>
                </li>
                <c:if test="${currentUser.id ne 0}">
                <li>
                    <a href="/cloudmi/myMusic">我的音乐</a>
                </li>
                <li>
                    <a href="/share/myList/1">动态</a>
                </li>
                </c:if>
                <c:if test="${currentUser.id eq 0}">
                    <li>
                        <a data-toggle="modal" data-target="#loginModal">我的音乐</a>
                    </li>
                    <li>
                        <a data-toggle="modal" data-target="#loginModal">动态</a>
                    </li>
                </c:if>
            </ul>
            <c:if test="${currentUser.id ne 0}">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="#">欢迎您，${currentUser.name}</a>
                    </li>
                    <li class="dropdown">
                        <img src="/${currentUser.avatar}" style="margin-top: 10px;"
                             class="img-circle avatarSmall dropdown-toggle" data-toggle="dropdown" role="button"
                             aria-haspopup="true" aria-expanded="false"/>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="/user/edit">修改信息</a>
                            </li>
                            <li>
                                <a href="/user/password#">修改密码</a>
                            </li>
                            <li role="separator" class="divider"></li>
                            <li>
                                <a href="/user/logout">退出登录</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </c:if>
            <c:if test="${currentUser.id eq 0}">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <p class="navbar-text"><a data-toggle="modal" data-target="#loginModal">登录</a> /
                            <a data-toggle="modal" data-target="#registerModal">注册</a></p>
                    </li>
                    <li class="dropdown">
                        <img src="/assets/img/timg.jpg" style="margin-top: 10px;"
                             class="img-circle img-thumbnail avatarSmall dropdown-toggle" data-toggle="dropdown"
                             role="button"
                             aria-haspopup="true" aria-expanded="false"/>
                    </li>
                </ul>
            </c:if>
            <div class="navbar-form navbar-right">
                <div class="form-group has-feedback">
                    <input id="searchBarInput" type="text" class="form-control roundBtn" placeholder="站内搜索"
                           onkeydown="if(event.keyCode==13){searchMusic(this);}" autocomplete="off">
                    <span class="glyphicon glyphicon-search form-control-feedback icon-black" aria-hidden="true"></span>
                </div>
            </div>
        </div>
    </div>
</nav>
<!-- 登录框 -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel">
    <div class="modal-dialog" role="document">
        <div id="LoginForm" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="loginModalLabel">登录</h4>
                </div>
                <div class="modal-body" style="padding: 20px;">
                    <div class="form-group">
                        <label for="LoginInputAccount">账号</label>
                        <input type="text" name="account" class="form-control" id="LoginInputAccount"
                               placeholder="请输入账号" required>
                    </div>
                    <div class="form-group">
                        <label for="LoginInputPassword">密码</label>
                        <input type="password" name="password" class="form-control" id="LoginInputPassword"
                               placeholder="请输入密码" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button onclick="login()" class="btn btn-primary">确认</button>
                    <button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<!-- 注册框 -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel">
    <div class="modal-dialog" role="document">
        <form action="/user/register" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="registerModalLabel">注册</h4>
                </div>
                <div class="modal-body" style="padding: 20px;">
                    <div class="form-group">
                        <label for="RegisterInputName">昵称</label>
                        <input type="text" name="name" class="form-control" id="RegisterInputName"
                               placeholder="请输入昵称" required>
                    </div>
                    <div id="AccountBox" class="form-group has-feedback">
                        <label id="RegisterInputAccountLabel" for="RegisterInputAccount">账号</label>
                        <input onchange="checkAccount(this)" type="text" name="account" class="form-control"
                               id="RegisterInputAccount"
                               placeholder="请输入账号" required>
                    </div>
                    <div class="form-group">
                        <label for="RegisterInputPassword">密码</label>
                        <input type="password" name="password" class="form-control" id="RegisterInputPassword"
                               placeholder="请输入密码" required>
                    </div>
                    <div class="form-group">
                        <label for="RegisterInputPassword2">确认密码</label>
                        <input type="password" name="password2" class="form-control" id="RegisterInputPassword2"
                               placeholder="请再输入一次密码" oninput="checkPassword()" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="SubmitBtn" type="submit" class="btn btn-primary">确认</button>
                    <button id="" type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- ShareModal -->
<div class="modal fade" id="ShareModal" tabindex="-1" role="dialog" aria-labelledby="ShareModalLabel">
    <form action="/share/input" method="post" onkeydown="if(event.keyCode==13){return false;}">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="ShareModalLabel">分享</h4>
                </div>
                <div class="modal-body">
                    <div class="searchBar">
                        <div class="form-group">
                            <div class="input-group">
                                <input onkeydown="if(event.keyCode==13){$('#searchBtn').click();}"
                                       id="shareInputMusicName"
                                       type="text" class="form-control" placeholder="选首喜欢的音乐">
                                <span class="input-group-btn">
                            <button id="searchBtn" onclick="queryMusicByNameForShare()" class="btn btn-default"
                                    type="button">搜索</button>
                            </span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <textarea name="content" class="form-control" rows="3" placeholder="分享新发现"></textarea>
                        <input id="shareInputMusicId" class="hidden" name="mId" value="">
                    </div>
                    <div id="shareMusicBox" class="shareMusicBox center-block hidden">
                        <div class="media">
                            <div class="media-left">
                                <div class="shareMusicCover">
                                    <img id="shareMusicCoverImg" class="media-object coverSmall"
                                         src="/assets/img/res/default-album.jpg">
                                    <div id="shareMusicPlayBtn" class="sharePlayBtn">
                                        <span class="fa fa-play-circle-o icon-red"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="media-body">
                                <h5 class="media-heading"><a id="shareMusicName" class="font-black">你的名字</a></h5>
                                <h5>
                                    <small><a id="shareMusicAuthor" class="font-gray">你的作者</a></small>
                                </h5>
                            </div>
                        </div>
                    </div>
                    <h4 id="shareResultBoxTitle" class="resultBoxTitle"></h4>
                    <div id="shareResultBox" class="resultBox" style="max-height: 400px;">
                        <table id="shareResultTalbe" class="table table-hover">
                            <tbody id="shareResultTalbeTbody" class="resultTalbeTbody">
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="reset" class="btn btn-default" data-dismiss="modal">返回</button>
                    <button type="submit" class="btn btn-primary">分享</button>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    function checkPassword() {
        var p1 = $("#RegisterInputPassword").val();
        var p2 = $("#RegisterInputPassword2").val();
        if (p1 != "" && p2 != "" && p1 == p2) {
            $("#SubmitBtn").html("确认");
            $("#SubmitBtn").attr("disabled", false);
        } else {
            $("#SubmitBtn").html("密码不一致");
            $("#SubmitBtn").attr("disabled", true);
        }
    }

    function checkAccount(obj) {
        var account = obj.value;
        $.ajax({
            url: "/user/checkAccount/" + account,
            type: "GET",
            success: function (result) {
                if (result == "true") {
                    $("#AccountBox").removeClass("has-success").addClass("has-error");
                    $("#RegisterInputAccountLabel").html("账号 该账号已被占用");
                    $("#SubmitBtn").attr("disabled", true);
                } else {
                    $("#AccountBox").removeClass("has-error").addClass("has-success");
                    $("#RegisterInputAccountLabel").html("账号 该账号可以使用");
                    $("#SubmitBtn").attr("disabled", false);
                }
            }
        })
    }
</script>