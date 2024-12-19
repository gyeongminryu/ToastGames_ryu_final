<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<title>Insert title here</title>

<link rel="stylesheet" href="/resources/css/meeting.css" />
    
</head>
<body>
	<a href="meetingRoomAdd.go">회의실 등록</a>

	<!-- 회의실 필터 -->
	<select id="meeting_room_select">
		<c:forEach items="${roomList}" var="room">
			<option value="${room.room_idx}">${room.room_name}</option>
		</c:forEach>
	</select>
	<a href="#" id="meeting_room_link">회의실 보기</a>

	<!-- 내가 포함된 회의만 보기 필터 -->
	<fieldset>                                                                                           <!-- 로그인 생성전 임시값 -->
		<input type="checkbox" name="meeting_mine" id="meeting_only_mine" value="10003"/>내가 포함된 회의만 보기
	</fieldset>
	
	
	<div id='calendar'></div>
	
	<!-- 입력/확인 모달 --> <!-- 참여자 추가 만들어야함 -->
	<div id="meeting_event_modal" class="modal">
	    <div class="modal_content">
	        <span class="close" onclick="meeting_close_modal()">닫기</span>
	        <form id="meeting_event_form">
	            <h2 id="meeting_modal_title" class="meeting_add_modal">일정 추가</h2>                     
	            제목: <input type="text" id="meeting_title"><br>
	            내용: <input type="text" id="meeting_content"><br>
	            예약 사원번호: <input type="text" id="meeting_room_empl"><br>
	            시작 시간: <input type="text" id="meeting_start_time" readonly><br>
	            종료 시간: <input type="text" id="meeting_end_time" readonly><br>
	            <label for="meeting_room_name">회의실:</label>
	            <select id="meeting_room_select_modal">
	                <c:forEach items="${roomList}" var="room">
	                    <option value="${room.room_idx}">${room.room_name}</option>
	                </c:forEach>
	            </select>
	            <fieldset>
	            	<c:forEach items="${partiList}" var="parti">
	            		<input type="checkbox" name="meeting_parti" value="${parti.empl_idx}"/> ${parti.empl_name}
	            	</c:forEach>
	            </fieldset>
	            <!-- 버튼 컨테이너 -->
	            <div id="meeting_modal_buttons"></div>
	        </form>
	    </div>
	</div>

</body>
<script src="/resources/js/meeting.js"></script>
</html>