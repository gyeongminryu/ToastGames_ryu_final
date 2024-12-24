<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
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
                    <li class="tst_title_item tst_title_item_active">
                        <h1>회의실 사용 예약 현황</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <!-- 회의실 필터 -->
                <select id="meeting_room_select">
                    <option value="5">회의실 1</option>
                    <option value="{회의실idx}">{회의실명}</option>
                </select>

                <!-- 내가 포함된 회의만 보기 필터 -->
                <fieldset>                                                                                           <!-- 로그인 생성전 임시값 -->
                    <input type="checkbox" name="meeting_mine" id="meeting_only_mine" value="10003"/>내가 포함된 회의만 보기
                </fieldset>

                <div id="calendar"></div>

            </div>
        </div>
    </div>
</div>
<c:import url="approval_writing_write_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/meeting.js"></script>
</html>