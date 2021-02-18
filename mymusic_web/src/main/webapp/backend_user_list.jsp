<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:include page="backend_top.jsp"></jsp:include>
<div>
    <div class="container">
        <div class="mainBar">
            <h1 class="text-center">查找用户</h1>
            <br/>
            <div class="panel panel-info" style="margin-bottom: 0;">
                <div class="panel-heading">
                    搜索用户
                </div>
                <div class="panel-body" style="height: 200px;">
                    <form action="/backend/user/query" method="post">
                        <div class="form-group">
                            <div class="input-group">
                                <input id="InputAccount" type="text" class="form-control" name="account"
                                       placeholder="请输入想要查找的用户账号" autocomplete='off'>
                                <span class="input-group-btn"><button class="btn btn-default" type="submit">搜索</button></span>
                            </div>
                        </div>
                    </form>
                    <table class="table">
                        <thead>
                        <tr>
                            <th>账号</th>
                            <th>名称</th>
                            <th>性别</th>
                            <th>状态</th>
                            <th>邮箱</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <c:if test="${not empty USER}">
                            <tbody>
                            <tr>
                                <td>${USER.account}</td>
                                <td>${USER.name}</td>
                                <td>${USER.sex}</td>
                                <c:if test="${USER.level eq 1}">
                                    <td>封禁中</td>
                                </c:if>
                                <c:if test="${USER.level eq 2}">
                                    <td>禁言中</td>
                                </c:if>
                                <c:if test="${USER.level eq 3}">
                                    <td>正常</td>
                                </c:if>
                                <td>${USER.email}</td>
                                <td>
                                    <a href="/backend/user/del/${USER.id}" class="btn btn-sm btn-danger"
                                       onclick="return del();">删除</a>
                                    <c:if test="${USER.level eq 3}">
                                        <a href="/backend/user/ban/${USER.id}" class="btn btn-sm btn-info">封禁</a>
                                        <a href="/backend/user/mute/${USER.id}" class="btn btn-sm btn-warning">禁言</a>
                                    </c:if>
                                    <c:if test="${USER.level eq 2}">
                                        <a href="/backend/user/ban/${USER.id}" class="btn btn-sm btn-info">封禁</a>
                                        <a href="/backend/user/undoMute/${USER.id}" class="btn btn-sm btn-success">解封</a>
                                    </c:if>
                                    <c:if test="${USER.level eq 1}">
                                        <a href="/backend/user/mute/${USER.id}" class="btn btn-sm btn-warning">禁言</a>
                                        <a href="/backend/user/undoBan/${USER.id}" class="btn btn-sm btn-success">解封</a>
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
                    全部用户
                </div>
                <div class="panel-body" style="height: 500px;">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th>账号</th>
                            <th>名称</th>
                            <th>性别</th>
                            <th>状态</th>
                            <th>邮箱</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${LIST}" var="USER">
                            <tr>
                                <td>${USER.account}</td>
                                <td>${USER.name}</td>
                                <td>${USER.sex}</td>
                                <c:if test="${USER.level eq 1}">
                                    <td>封禁中</td>
                                </c:if>
                                <c:if test="${USER.level eq 2}">
                                    <td>禁言中</td>
                                </c:if>
                                <c:if test="${USER.level eq 3}">
                                    <td>正常</td>
                                </c:if>
                                <td>${USER.email}</td>
                                <td>
                                    <a href="/backend/user/del/${USER.id}" class="btn btn-sm btn-danger"
                                       onclick="return del();">删除</a>
                                    <c:if test="${USER.level eq 3}">
                                        <a href="/backend/user/ban/${USER.id}" class="btn btn-sm btn-info">封禁</a>
                                        <a href="/backend/user/mute/${USER.id}" class="btn btn-sm btn-warning">禁言</a>
                                    </c:if>
                                    <c:if test="${USER.level eq 2}">
                                        <a href="/backend/user/ban/${USER.id}" class="btn btn-sm btn-info">封禁</a>
                                        <a href="/backend/user/undoMute/${USER.id}" class="btn btn-sm btn-success">解封</a>
                                    </c:if>
                                    <c:if test="${USER.level eq 1}">
                                        <a href="/backend/user/mute/${USER.id}" class="btn btn-sm btn-warning">禁言</a>
                                        <a href="/backend/user/undoBan/${USER.id}" class="btn btn-sm btn-success">解封</a>
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
                                    <a href="/backend/user/list/${pageInfo.prePage}" aria-label="Previous">
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
                                        <a href="/backend/user/list/${index}">${index}</a>
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
                                    <a href="/backend/user/list/${pageInfo.nextPage}" aria-label="Next">
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