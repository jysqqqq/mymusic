<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="backend_top.jsp"></jsp:include>
<div>
    <div class="container">
        <div class="mainBar">
            <h1 class="text-center">个人信息</h1>
            <br />
            <div class="panel panel-info">
                <div class="panel-heading">
                    账号状态
                </div>
                <ul class="list-group">
                    <li class="list-group-item"><h3 class="text-success text-center">${currentAdmin.status}</h3></li>
                </ul>
                <div class="panel-heading">
                    基本信息
                </div>
                <table class="table">
                    <tr>
                        <td><strong>姓名:</strong></td>
                        <td>${currentAdmin.name}</td>
                    </tr>
                    <tr>
                        <td><strong>账号:</strong></td>
                        <td>${currentAdmin.account}</td>
                    </tr>
                    <tr>
                        <td><strong>职务:</strong></td>
                        <td>${currentAdmin.postType}</td>
                    </tr>
                    <tr>
                        <td><strong>手机号码:</strong></td>
                        <td>${currentAdmin.phone}</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
</body>

</html>
</body>
</html>
