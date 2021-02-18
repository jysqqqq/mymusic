<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<jsp:useBean id="CurrentAudioList" class="com.ncist.mymusic.entity.AudioList" scope="session"/>
<html>
<head>
</head>
<body>
<c:if test="${not empty CurrentAudioList.musicList}">
<audio id="player" src="/${CurrentAudioList.currentMusic.address}" controls="controls"></audio>
</c:if>
<c:if test="${empty CurrentAudioList.musicList}">
    <audio id="player" src="" controls="controls"></audio>
</c:if>
</body>
</html>
