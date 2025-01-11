<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/stats_dashboard.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<c:import url="layout_topnav.jsp" />
<div class="tst_container">
    <c:import url="layout_leftnav.jsp" />
    <div class="tst_container_right">
        <div class="tst_contents">
            <div class="tst_contents_inner">

                <!-- 제목 -->
                <ul class="tst_title list_no_desc list_inline">
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/stats_dashboard.go'">
                        <h1>게임 통계</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="dashboard_container">

                    <c:forEach items="${list}" var="list">
                        <div class="list_module list_module_${list.game_idx}">
                            <div class="content_container">
                                <div class="title_container">
                                    <div class="content_block">
                                        <div class="content_thumbnail content_thumbnail_${list.game_idx}" style="background-image:url('${list.data_appmarket.thumbnail}')"></div>
                                    </div>
                                    <div class="content_block">
                                        <h1>${list.game_name}</h1>
                                        <p class="font_subtle">${list.game_type}</p>
                                    </div>
                                </div>
                                <div class="summary_container">
                                    <div class="content_block">
                                        <h4 class="font_subtle">GOOGLE PLAY</h4>
                                        <table>
                                            <colgroup>
                                                <col style="width: 100px" />
                                                <col style="width: auto" />
                                            </colgroup>
                                            <tbody>
                                            <tr>
                                                <th>별점</th>
                                                <td><i class="bi bi-star-fill"></i> ${list.data_google.grade}</td>
                                            </tr>
                                            <tr>
                                                <th>리뷰</th>
                                                <td>${list.data_google.cntReview}</td>
                                            </tr>
                                            <tr>
                                                <th>다운로드 수</th>
                                                <td>${list.data_google.downloads}</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div class="content_block">
                                        <h4 class="font_subtle">APPSTORE</h4>
                                        <table>
                                            <colgroup>
                                                <col style="width: 100px" />
                                                <col style="width: auto" />
                                            </colgroup>
                                            <tbody>
                                            <tr>
                                                <th>별점</th>
                                                <td><i class="bi bi-star-fill"></i> ${list.data_appmarket.grade}</td>
                                            </tr>
                                            <tr>
                                                <th>리뷰</th>
                                                <td>${list.data_appmarket.cntReview}</td>
                                            </tr>
                                            <tr>
                                                <th>마켓 내 순위</th>
                                                <td>${list.data_appmarket.ranking}</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="button_container">
                                    <i onclick="tst_modal_call_param('tst_modal_review', '${list.game_idx}')" class="bi bi-arrow-right-circle tst_pointer"></i>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>

            </div>
        </div>
    </div>
</div>
<c:import url="stats_dashboard_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<!-- <script src="resources/js/stats_dashboard.js"></script> -->
</html>