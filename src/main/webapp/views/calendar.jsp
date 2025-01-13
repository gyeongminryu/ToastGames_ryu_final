<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_calendar.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_table.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/approval.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/approval_send_modal.css" />
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
                        <h1>일정 관리</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <!-- 일정 종류 필터링 -->
                <select onchange="calendar_select_to_radiobtn(this)" class="meeting_room_select fc_month">
                    <option value="1" selected>개인 일정</option>
                    <option value="2">부서 일정</option>
                    <option value="3">프로젝트 팀 일정</option>
                    <option value="4">기타 일정</option>
                </select>

                <fieldset id="schedule_category" class="disp_hide">
                    <label id="schedule_category_name">
                        <input type="radio" name="schedule_type_name" value="1" checked><!-- 개인 -->
                        <input type="radio" name="schedule_type_name" value="2"><!-- 부서 -->
                        <input type="radio" name="schedule_type_name" value="3"><!-- 프로젝트 -->
                        <input type="radio" name="schedule_type_name" value="4"><!-- 기타 -->
                    </label>
                </fieldset>
                <!-- //일정 종류 필터링 -->

                <!-- 달력 -->
                <div id="calendar-container">
                    <div id="calendar"></div>
                </div>
                <!-- //달력 -->

                <!-- 기능 완성시 삭제해 주세요 -->
				<!-- <ul class="list_no_desc list_no_desc list_inline">
                    <li><button class="btn_subtle" onclick="tst_modal_call('tst_modal_write')">일정추가하기</button></li>
                    <li><button class="btn_subtle" onclick="tst_modal_call('tst_modal_detail')">일정 확인하기</button></li>
                    <li><button class="btn_subtle" onclick="tst_modal_call('tst_modal_update')">일정 수정하기</button></li>
                </ul> -->
                <!-- //기능 완성시 삭제해 주세요 -->

            </div>
        </div>
    </div>
</div>
<c:import url="calendar_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/calendar_month.js"></script>
<script src="resources/js/calendar_select_to_radiobtn.js"></script>
</html>