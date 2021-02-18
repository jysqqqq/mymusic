<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>

<head>
    <meta charset="utf-8" />
    <title>后台管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <style>
        body {
            background-image: url(/assets/img/res/login-background.jpg);
            height: 100%;
            width: 100%;
            overflow: hidden;
            background-size: cover;
        }
    </style>
</head>

<body>
<nav class="navbar navbar-inverse navbar-static-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">后台管理</a>
        </div>
        <p class="navbar-text">欢迎使用后台管理系统</p>
    </div>
    <!-- /.container-fluid -->
</nav>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="center-block loginContainer loginPanel">
                <h3 class="text-center loginText">后台管理系统</h3>
                <hr/>
                <form action="/backend/admin/admin-login" method="post">
                    <div class="form-group">
                        <label for="InputAccount" class="loginText">账号</label>
                        <input type="text" class="form-control loginInput" id="InputAccount" name="account" placeholder="请输入账号" value="${ACCOUNT}">
                    </div>
                    <div class="form-group">
                        <label for="InputPassword" class="loginText">密码</label>
                        <input type="password" class="form-control loginInput" id="InputPassword" name="password" placeholder="请输入密码"value="${PASSWORD}">
                    </div>
                    <div class="checkbox">
                        <label>
                            <c:if test="${not empty ACCOUNT}"><input type="checkbox" checked name="isRemember" class="loginInput" value="true"><span class="loginText">记住我</span></c:if>
                            <c:if test="${empty ACCOUNT}"><input type="checkbox" name="isRemember" class="loginInput" value="true"><span class="loginText">记住我</span></c:if>
                        </label>
                    </div>
                    <button type="submit" class="btn btn-default center-block loginButton"> 登 录  </button>
                </form>
            </div>
        </div>
    </div>

</html>