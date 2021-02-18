<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="CurrentAudioList" class="com.ncist.mymusic.entity.AudioList" scope="session"/>
<div class="playerListBox">
    <div class="playerList">
        <div class="playerListTitle">
            <h4>播放列表</h4>
            <hr>
        </div>
        <div class="playerListTable">
            <table class="table-hover notSelect">
                <tbody id="playerListBox">

                </tbody>
            </table>
        </div>
        <div id="playerListFooter" class="playerListFooter">
            <span>共 ${CurrentAudioList.musicList.size()} 首</span>
        </div>
    </div>
    <div class="playerLrc">
        <div class="playerListTitle">
            <h4>歌词</h4>
            <hr>
        </div>
        <div id="playerLrcBox" class="playerLrcBox">
            <div id="playerLrcFlow" class="playerLrcFlow">

            </div>
        </div>
    </div>
</div>

<div class=" navbar-fixed-bottom" style="background: white;border-top: ghostwhite 1px solid;">
    <div class="container">
        <div class="col-lg-12">
            <c:if test="${empty CurrentAudioList.musicList}">
            <div id="audioPlayerBar" class="playerBar notSelect " style="display: none;">
                </c:if>
                <c:if test="${not empty CurrentAudioList.musicList}">
                    <div id="audioPlayerBar" class="playerBar notSelect ">
                    </c:if>
                    <div class="coverBar">
                        <c:if test="${not empty CurrentAudioList.musicList}">
                            <div class="coverBox">
                                <img id="coverImg" class="img-thumbnail coverImg"
                                     src="/${CurrentAudioList.currentMusic.cover}"/>
                            </div>
                            <div id="coverMusicNameBox" class="coverMusicNameBox">
                            <span id="coverMusicName"
                                  class="coverMusicName"><a
                                    href="/music/detail/${CurrentAudioList.currentMusic.id}">${CurrentAudioList.currentMusic.name}</a></span>
                            </div>
                            <div class="coverAuthormNameBox">
                        <span id="coverAuthorName"
                              class="coverAuthorName"><a
                                href="/artist/detail/${CurrentAudioList.currentMusic.artistId}">${CurrentAudioList.currentMusic.player}</a></span>
                            </div>
                        </c:if>
                        <c:if test="${empty CurrentAudioList.musicList}">
                            <div class="coverBox">
                                <img id="coverImg" class="img-thumbnail coverImg"
                                     src="/assets/img/res/default-album.jpg"/>
                            </div>
                            <div class="coverMusicNameBox">
                                <span id="coverMusicName" class="coverMusicName"> </span>
                            </div>
                            <div class="coverAuthormNameBox">
                        <span id="coverAuthorName"
                              class="coverAuthorName"> </span>
                            </div>
                        </c:if>
                    </div>
                    <div class="controllerBar">
                        <div class="preButton">
                            <span class='icon glyphicon-step-backward icon-sm icon-red'></span>
                        </div>
                        <div id="Play" class="playButton">
                            <span class="icon glyphicon-play icon-default icon-red"></span>
                        </div>
                        <div class="nextButton">
                            <span class="icon glyphicon-step-forward icon-sm icon-red"></span>
                        </div>
                    </div>
                    <div class="processBar">
                        <div class="processAll"></div>
                        <div class="processNow"></div>
                        <div class="processButton"></div>
                        <div class="songInfoBox">
                            <span class="songInfo">00:00&nbsp;/&nbsp;00:00</span>
                        </div>
                    </div>
                    <div class="othersBar">
                        <c:if test="${not empty CurrentAudioList.musicList}">
                            <c:if test="${!CurrentAudioList.currentMusic.favorite}">
                                <div id="loveButton" class="loveButton">
                            <span onclick="favoriteMusicFromAudio(this,${CurrentAudioList.currentMusic.id})"
                                  class="fa fa-heart-o fa-icon-sm icon-red"></span>
                                </div>
                            </c:if>
                            <c:if test="${CurrentAudioList.currentMusic.favorite}">
                                <div id="loveButton" class="loveButton">
                                <span onclick="favoriteMusicFromAudio(this,${CurrentAudioList.currentMusic.id})"
                                      class="fa fa-heart fa-icon-sm icon-red"></span>
                                </div>
                            </c:if>
                        </c:if>
                        <c:if test="${empty CurrentAudioList.musicList}">
                            <div id="loveButton" class="loveButton">
                                <span class="fa fa-heart-o fa-icon-sm icon-red"></span>
                            </div>
                        </c:if>
                        <div class="listButton">
                            <span class="fa fa-bars fa-icon-sm  icon-black"></span>
                        </div>
                        <div class="lrcButton">
                            <span class="icon fa-icon-sm icon-black">词</span>
                        </div>
                        <c:if test="${empty CurrentAudioList.musicList}">
                            <div class="moreButton">
                                <div class="dropup">
                            <span class="icon glyphicon-option-horizontal fa-icon-sm  icon-black"
                                  data-toggle="dropdown"></span>
                                    <ul class="dropdown-menu">
                                        <li id="MoreBtnDownloadLi">
                                            <a href="">下载</a>
                                        </li>
                                        <li id="MoreBtnCommentLi">
                                            <a href="#">评论</a>
                                        </li>
                                        <li id="MoreBtnAddCollectionLi">
                                            <a href="#">加入歌单</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty CurrentAudioList.musicList}">
                            <div class="moreButton">
                                <div class="dropup">
                            <span class="icon glyphicon-option-horizontal fa-icon-sm  icon-black"
                                  data-toggle="dropdown"></span>
                                    <ul class="dropdown-menu">
                                        <li id="MoreBtnDownloadLi">
                                            <a href="/${CurrentAudioList.currentMusic.address}"
                                               download="${CurrentAudioList.currentMusic.name}.mp3">下载</a>
                                        </li>
                                        <li id="MoreBtnCommentLi">
                                            <a href="/music/detail/${CurrentAudioList.currentMusic.id}">评论</a>
                                        </li>
                                        <li id="MoreBtnAddCollectionLi">
                                            <a onclick="addMusicToCollectionLi_Click(${CurrentAudioList.currentMusic.id})">加入歌单</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- CollectionModal -->
    <div class="modal fade" id="CollectionModal" tabindex="-1" role="dialog" aria-labelledby="CollectionModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="CollectionModalLabel">添加到歌单</h4>
                </div>
                <div class="modal-body">
                    <div id="resultBox" class="resultBox">
                        <table id="collectionTalbe" class="table table-hover">
                            <tbody id="resultCollectionList" class="resultTalbeTbody">

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>