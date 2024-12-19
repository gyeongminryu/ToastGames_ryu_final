<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<style>

</style>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>

</head>
<body>
	<div id='calendar-container'>
	    <div id='calendar'></div>
	</div>
	
	<!-- 입력/확인 모달 -->
	<div id="schedule_event_modal" class="modal">
	    <div class="modal_content">
	        <span class="close" onclick="schedule_close_modal()">닫기</span>
	        <form id="schedule_event_form">
	            <h2 id="schedule_modal_title" class="schedule_add_modal">일정 추가</h2>                     
	            제목: <input type="text" id="schedule_title"><br>
	            내용: <input type="text" id="schedule_content"><br>
	            예약 사원번호: <input type="text" id="schedule_room_empl"><br>
	            시작 시간: <input type="text" id="schedule_start_time" readonly><br>
	            종료 시간: <input type="text" id="schedule_end_time" readonly><br>
	            <fieldset>
	            	<c:forEach items="${partiList}" var="parti">
	            		<input type="checkbox" name="schedule_parti" value="${parti.empl_idx}"/> ${parti.empl_name}
	            	</c:forEach>
	            </fieldset>
	            <!-- 버튼 컨테이너 -->
	            <div id="schedule_modal_buttons"></div>
	        </form>
	    </div>
	</div>
</body>
<script>

        let calendar = null;
        let Alldata = {};
        $(function(){

            let calendarEl = $('#calendar')[0];

             calendar = new FullCalendar.Calendar(calendarEl, { 

                expandRows: true, // 화면에 맞게 높이 재설정
                slotMinTime: '00:01', // Day 캘린더에서 시작 시간
                slotMaxTime: '23:59', // Day 캘린더에서 종료 시간

                headerToolbar: {
                    left: 'prev',
                    center: 'title',
                    right: 'today,dayGridMonth,next'
                },

                initialView: 'dayGridMonth',
                editable: true,
                selectable: true, // 달력 일자 드래그 설정가능
                nowIndicator: true, // 현재 시간 마크
                dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
                locale: 'ko', // 한국어 설정
                eventColor:'green',
                events: function (fetchInfo, successCallback, failureCallback) {
                        // AJAX 요청으로 일정 데이터 가져오기
                    $.ajax({
                        url: '/calendar/getSchedules',
                        type: 'GET',
                        success: function (data) {
                        	console.log(data);
                            successCallback(data); // FullCalendar에 일정 데이터 추가
                        },
                        error: function () {
                            alert('일정 데이터를 불러오는 중 오류가 발생했습니다.');
                            failureCallback();
                        }
                     });
                 },
                
                
                eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
                
                	sDate = 
                	    obj.event._instance.range["start"].getFullYear() + 
                	    '-' + ((obj.event._instance.range["start"].getMonth() + 1).toString().padStart(2, '0')) +
                	    '-' + (obj.event._instance.range["start"].getDate().toString().padStart(2, '0'));

                	eDate = 
                	    obj.event._instance.range["end"].getFullYear() + 
                	    '-' + ((obj.event._instance.range["end"].getMonth() + 1).toString().padStart(2, '0')) +
                	    '-' + (obj.event._instance.range["end"].getDate().toString().padStart(2, '0'));
                	
                	var startDate = new Date(sDate);
                	var frmtStartDate = startDate.toISOString().split('T')[0];
                	var endDate = new Date(eDate);
                	var frmtendDate = endDate.toISOString().split('T')[0];
                	
                	 Alldata = {
                		"id" : obj.event._def["publicId"],
                        "start": frmtStartDate,
                        "end": frmtendDate,
                        "title": obj.event._def["title"],
                        "allday": obj.event._def["allDay"]
                    };

                    //let allEvent = calendar.getEvents();
                    //console.log(allEvent);

                     let jsondata = JSON.stringify(Alldata);
                     console.log("jsondata : " + jsondata);

                     
                },
                eventClick: function (obj) {
                    // 선택한 이벤트 정보
                    let event = obj.event;
					console.log(event);
					console.log(obj);
					
					//일정 확인(후에 링크 있으면 링크 추가)
					$('#eventModal').on('show.bs.modal', function () {
					    $('#schedulecheck').html('<strong>'+obj.event._def["title"]+'</strong>');
					    // 또는 $('#schedulecheck').html('<strong>새로운 일정</strong>이 추가되었습니다.');
					});
					
                    // 모달 띄우기
                    $('#eventModal').modal('show');
                    

                    // 수정 버튼 클릭 이벤트
                    $('#editEventBtn').off('click').on('click', function () {
                    	sDate = 
                    	    obj.event._instance.range["start"].getFullYear() + 
                    	    '-' + ((obj.event._instance.range["start"].getMonth() + 1).toString().padStart(2, '0')) +
                    	    '-' + (obj.event._instance.range["start"].getDate().toString().padStart(2, '0'));

                    	eDate = 
                    	    obj.event._instance.range["end"].getFullYear() + 
                    	    '-' + ((obj.event._instance.range["end"].getMonth() + 1).toString().padStart(2, '0')) +
                    	    '-' + (obj.event._instance.range["end"].getDate().toString().padStart(2, '0'));
                    	
                    	var startDate = new Date(sDate);
                    	var frmtStartDate = startDate.toISOString().split('T')[0];
                    	var endDate = new Date(eDate);
                    	var frmtendDate = endDate.toISOString().split('T')[0];
                    	
                    	
                        let newTitle = prompt('수정할 일정을 입력하세요:', event.title);
                        if (newTitle) {
                        	
                        	
                        	
                        	
                        	
                            event.setProp('title', newTitle); // 제목 수정
                            // 서버에 수정 요청 보내기
                            $.ajax({
                                url: '/calendar/updateSchedule',
                                type: 'POST',
                                data:{
                                    //instanceId: obj.event._def.extendedProps["instanceId"],
                                   //defId:obj.event._def.extendedProps["defId"],
                                    id: obj.event._def["publicId"],
                                    title: newTitle,
                                    start: frmtStartDate,
                                    end: frmtendDate,
                                    allday:obj.event._def["allDay"]
                                },
                                success: function (data) {
                                    alert('일정이 수정되었습니다.');
                                    console.log('수정 결과:', data);
                                },
                                error: function () {
                                    alert('수정 중 오류가 발생했습니다.');
                                }
                            });
                        }
                        $('#eventModal').modal('hide');
                    });

                    // 삭제 버튼 클릭 이벤트
                    $('#deleteEventBtn').off('click').on('click', function () {
                        if (confirm('정말 삭제하시겠습니까?')) {
                            event.remove(); // UI에서 삭제
                            // 서버에 삭제 요청 보내기
                            $.ajax({
                                url: '/calendar/deleteSchedule',
                                type: 'POST',
                                data:{
                                	id: obj.event._def["publicId"]
                            	},
                                success: function (response) {
                                    alert('일정이 삭제되었습니다.');
                                },
                                error: function () {
                                    alert('삭제 중 오류가 발생했습니다.');
                                }
                            });
                        }
                        $('#eventModal').modal('hide');
                    });
                    
                    $('#no').off('click').on('click', function () {
                    	$('#eventModal').modal('hide');
                    });
                },
/*                 eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
                    console.log(obj);

                },
                eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
                    console.log(obj);

                }, */
                eventDrop: function(obj) {
                	
                	sDate = 
                	    obj.event._instance.range["start"].getFullYear() + 
                	    '-' + ((obj.event._instance.range["start"].getMonth() + 1).toString().padStart(2, '0')) +
                	    '-' + (obj.event._instance.range["start"].getDate().toString().padStart(2, '0'));

                	eDate = 
                	    obj.event._instance.range["end"].getFullYear() + 
                	    '-' + ((obj.event._instance.range["end"].getMonth() + 1).toString().padStart(2, '0')) +
                	    '-' + (obj.event._instance.range["end"].getDate().toString().padStart(2, '0'));
                   
                	var startDate = new Date(sDate);
                	var frmtStartDate = startDate.toISOString().split('T')[0];
                	var endDate = new Date(eDate);
                	var frmtendDate = endDate.toISOString().split('T')[0];
                	
                	// 드래그 후 이벤트의 날짜 변경 처리 로직
                    // 선택한 이벤트 정보
                   let event = obj.event;
        			console.log(event);
        			console.log(obj);
                    $.ajax({
                        url: "/calendar/dropSchedule",
                        type: "post",
                        data:{
                            id: obj.event._def["publicId"],
                            title: obj.event._def["title"],
                            start: frmtStartDate,
                            end: frmtendDate,
                            allday:obj.event._def["allDay"]
                        },  //데이터 형식 주의 안넘어가면 바꿔볼것
        				 success:function(data, textStatus, xhr){
        					 console.log(data);	 
        				 },
        				 error:function(xhr, status, error){
        					 console.log(error);
        				 }

                    });
        			
                    
                },
                eventResize: function(obj) {
                    // 이벤트 크기 조정 후 처리 로직
                	sDate = 
                	    obj.event._instance.range["start"].getFullYear() + 
                	    '-' + ((obj.event._instance.range["start"].getMonth() + 1).toString().padStart(2, '0')) +
                	    '-' + (obj.event._instance.range["start"].getDate().toString().padStart(2, '0'));

                	eDate = 
                	    obj.event._instance.range["end"].getFullYear() + 
                	    '-' + ((obj.event._instance.range["end"].getMonth() + 1).toString().padStart(2, '0')) +
                	    '-' + (obj.event._instance.range["end"].getDate().toString().padStart(2, '0'));
                   
                	var startDate = new Date(sDate);
                	var frmtStartDate = startDate.toISOString().split('T')[0];
                	var endDate = new Date(eDate);
                	var frmtendDate = endDate.toISOString().split('T')[0];
                	
                	// 드래그 후 이벤트의 날짜 변경 처리 로직
                    // 선택한 이벤트 정보
                   let event = obj.event;
        			console.log(event);
        			console.log(obj);
                    $.ajax({
                        url: "/calendar/resizeSchedule",
                        type: "post",
                        data:{
                            id: obj.event._def["publicId"],
                            title: obj.event._def["title"],
                            start: frmtStartDate,
                            end: frmtendDate,
                            allday:obj.event._def["allDay"]
                        },  //데이터 형식 주의 안넘어가면 바꿔볼것
        				 success:function(data, textStatus, xhr){
        					 console.log(data);	 
        				 },
        				 error:function(xhr, status, error){
        					 console.log(error);
        				 }

                    });
                },
                
                select: function(arg) { // 캘린더에서이벤트를 생성(FullCalendar내장)
                    let title = prompt('일정 내용을 입력하세요 :');
                    if (title) {
                        calendar.addEvent({
                        	id: uuid.v4(), //고유 id생성
                            title: title,
                            start: arg.start,
                            end: arg.end,
                            allDay: arg.allDay
                        })
                        allSave(Alldata);
                    }
                    calendar.unselect();
                },
            });
            // 캘린더 랜더링
            calendar.render();

        });

        function allSave(Alldata) {
        	
			console.log(Alldata);
			//document.getElementById("submenu").style.display = "block";

             $.ajax({
                 url: "/calendar/userScAdd",
                 type: "post",
                 data: Alldata,   //데이터 형식 주의 안넘어가면 바꿔볼것

				 success:function(data, textStatus, xhr){
					 console.log(data);	 
				 },
				 error:function(xhr, status, error){
					 console.log(error);
				 }

             });
        }


	$('#eventModal').on('shown.bs.modal', function () {
		$('#editEventBtn').focus(); // 모달의 특정 요소에 포커스
	});

</script>
</html>