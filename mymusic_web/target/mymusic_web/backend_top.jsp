<jsp:useBean id="randomNum" scope="session" class="com.ncist.mymusic.global.RandomNum"/>
<jsp:useBean id="currentAdmin" scope="session" type="com.ncist.mymusic.entity.Admin"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
    <meta charset="utf-8"/>
    <title></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>

<body>
<nav class="navbar navbar-default navBar">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/backend/admin/index">后台管理</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a>欢迎您, ${currentAdmin.name}</a>
                </li>
            </ul>
            <ul class="nav  navbar-right">
                <li>
                <li class="dropdown">
                    <a id="btn-avatar" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true" aria-expanded="false">
                        <img class="img-circle avatarSmall"
                             src="${pageContext.request.contextPath}/${currentAdmin.avatar}?random=${randomNum.random}"/>
                    </a>
                    <ul class="dropdown-menu" id="drop-down-menu">
                        <li>
                            <a href="/backend/admin/edit"><span class="glyphicon glyphicon-edit"></span> 编辑信息</a>
                        </li>
                        <li>
                            <a href="/backend/admin/password"><span class="glyphicon glyphicon-cog "></span> 修改密码</a>
                        </li>
                        <li role="separator" class="divider"></li>
                        <li>
                            <a href="/backend/admin/logout"><span class="glyphicon glyphicon-off"></span> 退出登录</a>
                        </li>
                    </ul>
                </li>
                </li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>
<div class="pull-left asideBar" id="aside">
    <div class="selfWidget">
        <div style="display: inline;width: 45px;float: left;margin-right: 10px;">
            <img class="img-circle avatarMedium"
                 src="${pageContext.request.contextPath}/${currentAdmin.avatar}?random=${randomNum.random}"
                 style="display: inline-block"/>
        </div>
        <div style="display: inline;width: 45px;">
            <div style="width: 120px;height: 25px;float: left;">
                <span class="widgetNameText">${currentAdmin.name}</span>
            </div>
            <a href="/backend/admin/logout">
                <div class="widgetLogoutBox">
                    <span class="glyphicon glyphicon-off widgetOperationText"> 注销</span>
                </div>
            </a>
        </div>
    </div>
    <hr style="background-color: gray; height: 1px; border: none;margin-left: 15px; margin-right: 25px;"/>
    <ul style="padding-left: 0; ">
        <c:if test="${currentAdmin.postType eq '高级管理员'}">
        <li class="operationLi ">
            <span class="operationText "><span class="glyphicon glyphicon-edit"></span> 管理员管理</span>
        </li>
        <li class="operationLi ">
            <a href="/backend/admin/list/1"><span class="operationMinText "><span
                    class="glyphicon glyphicon-search "></span> 查找管理员</span></a>
        </li>
        <li class="operationLi ">
            <a href="/backend/admin/add"><span class="operationMinText "><span
                    class="glyphicon glyphicon-plus "></span> 添加管理员</span></a>
        </li>
        </c:if>
        <li class="operationLi ">
            <span class="operationText "><span class="glyphicon glyphicon-user "></span> 用戶管理</span>
        </li>
        <li class="operationLi ">
            <a href="/backend/user/list/1">
                <span class="operationMinText "><span class="glyphicon glyphicon-search "></span> 查找用戶</span></a>
        </li>
        <li class="operationLi ">
            <span class="operationText "><span class="fa fa-user-circle"></span> 艺人管理</span>
        </li>
        <li class="operationLi ">
            <a href="/backend/artist/list/1">
                <span class="operationMinText "><span class="glyphicon glyphicon-search "></span> 查找艺人</span></a>
        </li>
        <li class="operationLi ">
            <a href="/backend/artist/add">
                <span class="operationMinText "><span class="glyphicon glyphicon-plus "></span> 添加艺人</span></a>
        </li>
        <li class="operationLi ">
            <span class="operationText "><span class="fa fa-paint-brush"></span> 流派管理</span>
        </li>
        <li class="operationLi ">
            <a href="/backend/musicType/list/1">
                <span class="operationMinText "><span class="glyphicon glyphicon-search "></span> 查找流派</span></a>
        </li>
        <li class="operationLi ">
            <a href="/backend/musicType/add">
                <span class="operationMinText "><span class="glyphicon glyphicon-plus "></span> 添加流派</span></a>
        </li>
        <li class="operationLi ">
            <span class="operationText "><span class="glyphicon glyphicon-cd"></span> 资源管理</span>
        </li>
        <li class="operationLi ">
            <a href="/backend/album/list/1">
                <span class="operationMinText "><span class="glyphicon glyphicon-search "></span> 查找专辑</span></a>
        </li>
        <li class="operationLi ">
            <a href="/backend/album/add">
                <span class="operationMinText "><span class="glyphicon glyphicon-plus "></span> 添加专辑</span></a>
        </li>
    </ul>
</div>
<script>
    $(document).ready(function () {
        $("#btn-avatar").click(function () {
            showMenu();
        });
        $("#btn-avatar").blur(function () {
            hideMenu();
        });
    });

    function showMenu() {
        $("#drop-down-menu").show(300);
    }

    function hideMenu() {
        setTimeout(function () {
            $("#drop-down-menu").hide(300);
        }, 50);
    }
</script>
