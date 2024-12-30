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
                        <h1>회의실 사용 예약 현황</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <!-- 회의실 필터 -->
                <select id="meeting_room_select" name="room_idx" class="meeting_room_select fc_day btn_primary">
                    <option value="5">회의실 1</option>
                    <option value="{회의실idx}">{회의실명}</option>
                </select>
                <!-- //회의실 필터 -->

                <!-- 예약 방법 안내 -->
                <p class="how_to_reserv font_subtle">빈 공간을 클릭하면 예약할 수 있습니다.</p>
                <!-- //예약 방법 안내 -->

                <!-- 내가 포함된 회의만 보기 필터 -->
                <div class="filtering_only_me fc_day align_right">
                    <div class="tst_filtering_container tst_pointer">
                        <div class="tst_filtering_off" onclick="filtering_on()">
                            <i class="bi bi-toggle-off"></i>
                            <span>내가 포함된 회의만 보기</span>
                        </div>
                        <div class="tst_filtering_on disp_hide" onclick="filtering_off()">
                            <i class="bi bi-toggle-on"></i>
                            <span>내가 포함된 회의만 보기</span>
                        </div>
                    </div>
                    <fieldset class="disp_hide">
                        <input type="checkbox" name="meeting_mine" id="meeting_only_mine" value="10003" />
                    </fieldset>
                </div>
                <!-- //내가 포함된 회의만 보기 필터 -->

                <!-- 달력 -->
                <div id="calendar"></div>
                <!-- //달력 -->

                <!-- 기능 완성시 삭제해 주세요 -->
                <ul class="list_no_desc list_no_desc list_inline">
                    <li><button class="btn_subtle" onclick="tst_modal_call('tst_modal_write')">예약하기</button></li>
                    <li><button class="btn_subtle" onclick="tst_modal_call('tst_modal_detail')">예약 확인하기</button></li>
                    <li><button class="btn_subtle" onclick="tst_modal_call('tst_modal_update')">예약 수정하기</button></li>
                </ul>
                <!-- //기능 완성시 삭제해 주세요 -->

            </div>
        </div>
    </div>
</div>
<c:import url="meeting_room_calendar_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/meeting.js"></script>
<script src="resources/js/meeting_room_calendar.js"></script>
<script src="resources/js/approval_send_modal.js"></script>
</html>