<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<link rel="stylesheet" href="/resources/css/calendar_month.css" />
</head>
<body>

<!-- 일정 종류 라디오-->	
<fieldset id="schedule_category">
	<label id="schedule_category_name">
		<input type="radio" name="schedule_type_name" value="1" checked> 개인<br>
        <input type="radio" name="schedule_type_name" value="2"> 부서<br>
        <input type="radio" name="schedule_type_name" value="3"> 프로젝트<br>
        <input type="radio" name="schedule_type_name" value="4"> 기타<br>
	</label>
</fieldset>	

<div id='calendar-container'>
    <div id='calendar'></div>
</div>

<!-- 입력/확인 모달 -->
<div id="schedule_event_modal" class="schedule_modal">
    <div class="schedule_modal_content">
        <span class="close" onclick="schedule_close_modal()">닫기</span>
        <form id="schedule_event_form">
            <h2 id="schedule_modal_title">일정 추가</h2>
            제목: <input type="text" id="schedule_title"><br>
            내용: <input type="text" id="schedule_content"><br>
            사원번호: <input type="text" id="schedule_empl_idx"><br>
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

</body>
<script src="/resources/js/calendar_month.js"></script>
</html>