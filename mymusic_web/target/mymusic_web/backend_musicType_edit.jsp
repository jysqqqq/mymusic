
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="backend_top.jsp"></jsp:include>
<div>
    <div class="container">
        <div class="mainBar">
            <h1 class="text-center">编辑流派</h1>
            <br />
            <div class="panel panel-info" style="margin-bottom: 0;">
                <div class="panel-heading">
                    编辑流派
                </div>
                <div class="panel-body" style="height: 320px;">
                    <form action="/backend/musicType/musicType-edit" method="post">
                        <input type="hidden" name="id" value="${MUSIC_TYPE.id}">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="InputName">中文名</label>
                                <input type="text" class="form-control" id="InputName" name="name" placeholder="请输入中文名" value="${MUSIC_TYPE.name}" required>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="InputEname">英文名</label>
                                <input type="tel" class="form-control" id="InputEname" name="enName" value="${MUSIC_TYPE.enName}" placeholder="请输入英文名" required>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="InputInfo">简介</label>
                                <textarea id="InputInfo" wrap="hard" name="info" class="form-control" rows="3" placeholder="请输入简介">${MUSIC_TYPE.info}</textarea>
                            </div>
                            <button id="SubmitBtn" type="submit" class="btn btn-info">提交</button>
                            <button type="reset" class="btn btn-default" onclick="javascript:window.history.go(-1);">返回</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">

</script>
</html>