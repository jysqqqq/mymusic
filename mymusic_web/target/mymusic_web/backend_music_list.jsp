<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:include page="backend_top.jsp"/>
<div>
    <div class="container">
        <div class="mainBar">
            <h1 class="text-center">查找音乐</h1>
            <br/>
            <div class="panel panel-info" style="margin-bottom: 0;">
                <div class="panel-heading">
                    搜索音乐
                </div>
                <div class="panel-body" style="height: 200px;">
                    <form action="" method="post">
                        <div class="form-group">
                            <div class="input-group">
                                <input id="InputAccount" type="text" class="form-control" name="name"
                                       placeholder="请输入想要查找的流派">
                                <span class="input-group-btn"><button class="btn btn-default" type="submit">搜索</button></span>
                            </div>
                        </div>
                    </form>
                    <table class="table">
                        <thead>
                        <tr>
                            <th>中文名</th>
                            <th>英文名</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <c:if test="${not empty MUSIC_TYPE}">
                            <tbody>
                            <tr>
                                <td>${MUSIC_TYPE.name}</td>
                                <td>${MUSIC_TYPE.enName}</td>
                                <td class="tdBtnGroup">
                                    <a class="btn btn-sm btn-danger"
                                       onclick="return del(${MUSIC_TYPE.id},this);">删除</a>
                                    <button type="button" class="btn btn-sm btn-primary" data-toggle="modal"
                                            data-target="#myModal"
                                            onclick="showDetail(${MUSIC_TYPE.id})">
                                        详情
                                    </button>
                                    <a href="/backend/musicType/edit/${MUSIC_TYPE.id}" class="btn btn-sm btn-success">编辑</a>
                                </td>
                            </tr>
                            </tbody>
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
                                            <a href="/backend/musicType/list/${pageInfo.prePage}" aria-label="Previous">
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
                                                <a href="/backend/musicType/list/${index}">${index}</a>
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
                                            <a href="/backend/musicType/list/${pageInfo.nextPage}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel"> 曲风详情 </h4>
            </div>
            <div class="modal-body">
                <dl class="dl-horizontal">
                    <dt>中文名</dt>
                    <dd id="modalName"></dd>
                    <br/>
                    <dt>英文名</dt>
                    <dd id="modalEnName"></dd>
                    <br/>
                    <dt>介绍</dt>
                    <dd id="modalInfo">
                    </dd>
                </dl>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript ">
    function del(id, thisObj) {
        if (!confirm("该操作不可撤销，确认要删除？ ")) {
            window.event.returnValue = false;
            return;
        }
        $.ajax({
            url: "/backend/musicType/del/" + id,
            type: "POST",
            data: id,
            success: function () {
                $(thisObj).parent().parent().fadeOut(200);
                setTimeout(function () {
                    $(thisObj).parent().parent().remove();
                }, 200);
            }
        })
    }

    function showDetail(id) {
        $.ajax({
            url: "/backend/musicType/getMusicType/" + id,
            type: "GET",
            data: id,
            success: function (result) {
                if (result != null) {
                    $("#modalName").html(result.name);
                    $("#modalEnName").html(result.enName);
                    $("#modalInfo").text(result.info);
                }
            }
        })
    }

</script>

</html>