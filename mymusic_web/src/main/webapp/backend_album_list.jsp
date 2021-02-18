<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:include page="backend_top.jsp"/>
<jsp:useBean id="random" class="com.ncist.mymusic.global.RandomNum"/>
<div>
    <div class="container">
        <div class="mainBar">
            <h1 class="text-center">查找专辑</h1>
            <br/>
            <div class="panel panel-info" style="margin-bottom: 0;">
                <div class="panel-heading">
                    搜索专辑
                </div>
                <div class="panel-body" style="height: 700px;">
                    <form action="/backend/album/query" method="get">
                        <div class="form-group">
                            <div class="input-group">
                                <input id="InputAccount" type="text" class="form-control" name="name" placeholder="请输入想要查找的专辑名称">
                                <span class="input-group-btn"><button class="btn btn-default" type="submit">搜索</button></span>
                            </div>
                        </div>
                    </form>
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th>封面</th>
                            <th>专辑名称</th>
                            <th>作者</th>
                            <th>唱片公司</th>
                            <th>语种</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${not empty LIST}">
                            <c:forEach items="${LIST}" var="ALBUM">
                                <tr>
                                    <td><img src="/${ALBUM.coverAddress}?random=${random.random}" class="img-rounded coverSmall"></td>
                                    <td style="max-width: 300px;vertical-align: middle; white-space: nowrap;overflow-x: hidden; text-overflow: ellipsis">${ALBUM.name}</td>
                                    <td class="minTd">${ALBUM.author}</td>
                                    <td class="minTd">${ALBUM.company}</td>
                                    <td class="minTd">${ALBUM.language}</td>
                                    <td style="vertical-align: middle;">
                                        <a class="btn btn-sm btn-danger"
                                           onclick="return del(${ALBUM.id},this);">删除</a>
                                        <button type="button" class="btn btn-sm btn-primary" data-toggle="modal"
                                                data-target="#myModal"
                                                onclick="showDetail(${ALBUM.id})">
                                            详情
                                        </button>
                                        <a href="/backend/album/edit/${ALBUM.id}" class="btn btn-sm btn-success">编辑</a>
                                        <a href="/backend/music/append/${ALBUM.id}" class="btn btn-sm btn-info">添加音乐</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
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
                                    <a href="/backend/album/list/${pageInfo.prePage}" aria-label="Previous">
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
                                        <a href="/backend/album/list/${index}">${index}</a>
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
                                    <a href="/backend/album/list/${pageInfo.nextPage}" aria-label="Next">
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
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel"> 《LAMP》 </h4>
            </div>
            <div class="modal-body">
                <dl class="dl-horizontal">
                    <dt>封面</dt>
                    <dd id="modalCover"><img src="" class="img-rounded coverMedium"></dd>
                    <br/>
                    <dt>作者</dt>
                    <dd id="modalAuthor"></dd>
                    <br/>
                    <dt>发布日期</dt>
                    <dd id="modalPubDate"></dd>
                    <dt>唱片公司</dt>
                    <dd id="modalCompany"></dd>
                    <dt>语种</dt>
                    <dd id="modalLanguage"></dd>
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
    function del(id,thisObj) {
        if (!confirm("该操作不可撤销且会删除其中所有音乐文件，确认要删除？ ")) {
            window.event.returnValue = false;
            return;
        }
        $.ajax({
            url: "/backend/album/del/"+id,
            type: "POST",
            data:id,
            success:function () {
                $(thisObj).parent().parent().fadeOut(200);
                setTimeout(function () {
                    $(thisObj).parent().parent().remove();
                },200);
            }
        })
    }

    function showDetail(id) {
        $.ajax({
            url: "/backend/album/getAlbum/" + id,
            type: "GET",
            data: id,
            success: function (result) {
                var randomNum = Math.random();
                $("#myModalLabel").html("《" + result.name + "》")
                $("#modalCover").children("img").attr("src", "/" + result.coverAddress+"?random="+randomNum);
                $("#modalAuthor").html(result.author);
                var year = new Date(result.pubDate).getFullYear();
                var month = new Date(result.pubDate).getMonth()+1;
                var day = new Date(result.pubDate).getDate();
                var fmtDate = year +"-"+ month +"-"+ day;
                $("#modalPubDate").html(fmtDate);
                $("#modalCompany").html(result.company);
                $("#modalLanguage").html(result.language);
                $("#modalInfo").html(result.info);
            }
        });
    }

</script>

</html>