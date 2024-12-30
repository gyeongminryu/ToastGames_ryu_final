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
                <select onchange="calendar_select_to_radiobtn(this)" class="meeting_room_select btn_primary">
                    <option value="1" selected>개인 일정</option>
                    <option value="2">부서 일정</option>
                    <option value="3">프로젝트 일정</option>
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
                <ul class="list_no_desc list_no_desc list_inline">
                    <li><button class="btn_subtle" onclick="tst_modal_call('tst_modal_write')">예약하기</button></li>
                    <li><button class="btn_subtle" onclick="tst_modal_call('tst_modal_detail')">예약 확인하기</button></li>
                    <li><button class="btn_subtle" onclick="tst_modal_call('tst_modal_update')">예약 수정하기</button></li>
                </ul>
                <!-- //기능 완성시 삭제해 주세요 -->




                <!-- 입력/확인 모달 -->
                <div id="schedule_event_modal" class="schedule_modal">
                    <div class="schedule_modal_content">
                        <span class="close" onclick="schedule_close_modal()">닫기</span>
                        <form id="schedule_event_form">
                            <h2 id="schedule_modal_title">일정 추가</h2>
                            제목: <input type="text" id="schedule_title"><br>
                            내용: <input type="text" id="schedule_content"><br>
                            사원번호: <input type="text" id="schedule_empl_idx" value="${my_empl_idx}" readonly><br>
                            <label for="schedule_start_time">시작 시간:</label>
                            <input type="datetime-local" id="schedule_start_time"><br>

                            <label for="schedule_end_time">종료 시간:</label>
                            <input type="datetime-local" id="schedule_end_time"><br>
                            <!-- 일정 종류 라디오 버튼 -->
                            <label>일정 종류:</label><br>
                            <input type="radio" name="schedule_type" value="1"> 개인<br>
                            <input type="radio" name="schedule_type" value="2"> 부서<br>
                            <input type="radio" name="schedule_type" value="3"> 프로젝트<br>
                            <input type="radio" name="schedule_type" value="4"> 기타<br>
                            <!-- 참여자 선택 -->
                            <div>
                                <select id="search_option">
                                    <option value="name">이름</option>
                                    <option value="dept">부서</option>
                                </select>
                                <input type="text" id="search_input" placeholder="이름 또는 부서를 검색하세요" onkeyup="search_parti()">
                            </div>
                            <fieldset id="participant_list">
                                <c:forEach items="${partiList}" var="parti">
                                    <div class="participant" data-name="${parti.empl_name}" data-dept="${parti.dept_name}">
                                        <input type="checkbox" name="schedule_parti" value="${parti.empl_idx}" />
                                        <span>
                                                ${parti.empl_idx} ${parti.empl_name} ${parti.dept_name} ${parti.position_name} ${parti.duty_name}
                                        </span>
                                    </div>
                                </c:forEach>
                            </fieldset>
                            <div id="schedule_modal_buttons"></div>
                        </form>
                    </div>
                </div>





            </div>
        </div>
    </div>
</div>
<c:import url="meeting_room_calendar_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/calendar_month.js"></script>
<script src="resources/js/calendar_select_to_radiobtn.js"></script>
<script src="resources/js/approval_send_modal.js"></script>
</html>