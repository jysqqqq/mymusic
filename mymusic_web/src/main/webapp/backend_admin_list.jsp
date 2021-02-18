<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<head>
    <style>
        .tdBtnGroup{
            width: 260px;
        }
    </style>
</head>
<jsp:include page="backend_top.jsp"></jsp:include>
<div>
    <div class="container">
        <div class="mainBar">
            <h1 class="text-center">查找管理员</h1>
            <br/>
            <div class="panel panel-info" style="margin-bottom: 0;">
                <div class="panel-heading">
                    搜索管理员
                </div>
                <div class="panel-body" style="height: 200px;">
                    <form action="/backend/admin/query" method="post">
                        <div class="form-group">
                            <div class="input-group">
                                <input id="InputAccount" type="text" class="form-control" name="account"
                                       placeholder="请输入想要查找的管理员账号">
                                <span class="input-group-btn"><button class="btn btn-default" type="submit">搜索</button></span>
                            </div>
                        </div>
                    </form>
                    <table class="table">
                        <thead>
                        <tr>
                            <th>账号</th>
                            <th>姓名</th>
                            <th>职务</th>
                            <th>手机号码</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <c:if test="${not empty ADMIN}">
                            <tbody>
                            <tr>
                                <td>${ADMIN.account}</td>
                                <td>${ADMIN.name}</td>
                                <td>${ADMIN.postType}</td>
                                <td>${ADMIN.phone}</td>
                                <td>${ADMIN.status}</td>
                                <td class="tdBtnGroup">
                                    <c:if test="${ADMIN.id ne currentAdmin.id}">
                                        <a href="/backend/admin/del/${ADMIN.id}" class="btn btn-sm btn-danger"
                                           onclick="return del();">删除</a>
                                        <c:if test="${ADMIN.status eq '正常'}">
                                            <a href="/backend/admin/ban/${ADMIN.id}" class="btn btn-sm btn-info">封禁</a>
                                        </c:if>
                                        <c:if test="${ADMIN.status eq '封禁中'}">
                                            <a href="/backend/admin/undoBan/${ADMIN.id}" class="btn btn-sm btn-info">解封</a>
                                        </c:if>
                                        <c:if test="${ADMIN.postType eq '初级管理员'}">
                                            <a href="/backend/admin/promote/${ADMIN.id}" class="btn btn-sm btn-success">提升</a>
                                        </c:if>
                                    </c:if>
                                </td>
                            </tr>
                            </tbody>
                        </c:if>
                    </table>
                </div>
            </div>
            <div class="panel panel-info">
                <div class="panel-heading">
                    全部管理员
                </div>
                <div class="panel-body" style="height: 500px;">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th>账号</th>
                            <th>姓名</th>
                            <th>职务</th>
                            <th>手机号码</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${LIST}" var="ADMIN">
                            <tr>
                                <td>${ADMIN.account}</td>
                                <td>${ADMIN.name}</td>
                                <td>${ADMIN.postType}</td>
                                <td>${ADMIN.phone}</td>
                                <td>${ADMIN.status}</td>
                                <td>
                                    <c:if test="${ADMIN.id ne currentAdmin.id}">
                                        <a href="/backend/admin/del/${ADMIN.id}" class="btn btn-sm btn-danger"
                                           onclick="return del();">删除</a>
                                        <c:if test="${ADMIN.status eq '正常'}">
                                            <a href="/backend/admin/ban/${ADMIN.id}" class="btn btn-sm btn-info">封禁</a>
                                        </c:if>
                                        <c:if test="${ADMIN.status eq '封禁中'}">
                                            <a href="/backend/admin/undoBan/${ADMIN.id}" class="btn btn-sm btn-info">解封</a>
                                        </c:if>
                                        <c:if test="${ADMIN.postType eq '初级管理员'}">
                                            <a href="/backend/admin/promote/${ADMIN.id}" class="btn btn-sm btn-success">提升</a>
                                        </c:if>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <c:if test="${pageInfo.isFirstPage}">
                                <li class="disabled">
                                    <a href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${not pageInfo.isFirstPage}">
                                <li>
                                    <a href="/backend/admin/list/${pageInfo.prePage}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:forEach items="${pageInfo.navigatepageNums}" var="index">
                                <c:if test="${index eq pageInfo.pageNum}">
                                    <li class="active">
                                        <span>${index}</span>
                                    </li>
                                </c:if>
                                <c:if test="${index ne pageInfo.pageNum}">
                                    <li>
                                        <a href="/backend/admin/list/${index}">${index}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            <c:if test="${pageInfo.isLastPage}">
                                <li class="disabled">
                                    <a href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${not pageInfo.isLastPage}">
                                <li>
                                    <a href="/backend/admin/list/${pageInfo.nextPage}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript ">
    function del() {
        if (!confirm("该操作不可撤销，确定要删除？ ")) {
            window.event.returnValue = false;
        }
    }
</script>

</html>