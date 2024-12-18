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
<style type="text/css">
  /* 전체 타이틀 스타일 */
  .fc-toolbar-title {
    text-align: center; /* 가운데 정렬 */
    display: block;     /* 컨테이너 블록으로 설정 */
    line-height: 1.2;   /* 줄 간격 조정 */
  }

  /* 월(yearMonth)와 날짜 범위(dayRange) 스타일 */
  .fc-toolbar-title .year-month {
    font-size: 24px; /* 기본 크기 */
    font-weight: bold;
  }

  .fc-toolbar-title .day-range {
    font-size: 18px; /* 작은 크기 */
    color: gray; /* 선택 사항: 색상 변경 */
    display: block; /* 줄바꿈 유지 */
  }
 

  /* 버튼 컨테이너 스타일 */
  .fc-toolbar-chunk:first-child {
    display: flex;
    justify-content: flex-start;
    align-items: center;
  }

  .fc-toolbar-chunk:last-child {
    display: flex;
    justify-content: flex-end;
    align-items: center;
  }
  

  
	#calendar {
	  width: 80%; /* 원하는 너비 */
	  height: 80%; /* 원하는 높이 */
	}

	    /* 모달 배경 스타일 */
    .modal {
        display: none; /* 기본적으로 숨김 */
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
    }

    /* 모달 콘텐츠 스타일 */
    .modal_content {
        background-color: #fff;
        margin: 10% auto;
        padding: 15px;
        border: 1px solid #888;
        width: 40%;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
    }

    /* 닫기 버튼 스타일 */
    .close {
        color: #aaa;
        float: right;
        font-size: 20px;
        font-weight: bold;
        cursor: pointer;
        padding: 5px;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
    }
    
    .meeting_add_modal {
    	margin: 10px 0px;
    	padding:0px;
    }
    
</style>
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
<script>

let calendar;

//회의실 정보 상세보기
document.addEventListener('DOMContentLoaded', function() {
    var selectElement = document.getElementById('meeting_room_select');
    var linkElement = document.getElementById('meeting_room_link');

    // 선택된 값으로 URL을 초기화
    var selectedRoomIdx = selectElement.value;
    linkElement.href = "meetingRoom.detail?room_idx=" + selectedRoomIdx;

    // select 변경 시 URL 업데이트
    selectElement.addEventListener('change', function() {
        var selectedRoomIdx = this.value;
        linkElement.href = "meetingRoom.detail?room_idx=" + selectedRoomIdx;
    });
});

//회의실 선택 이벤트 핸들러
document.getElementById('meeting_room_select').addEventListener('change', function() {
    if (calendar) {
        calendar.refetchEvents(); // events 콜백 실행
    } else {
        console.error('FullCalendar 인스턴스가 초기화되지 않았습니다.');
    }
});


//회의실+내가 포함된 회의
document.getElementById('meeting_only_mine').addEventListener('change', function () {
    if (calendar) {
        const is_mine = this.checked;
        console.log(is_mine ? "내가 포함된 회의만 보기 활성화" : "전체 회의 보기");
        calendar.refetchEvents(); // FullCalendar 이벤트 갱신
    } else {
        console.error('FullCalendar 인스턴스가 초기화되지 않았습니다.');
    }
});

//달력
document.addEventListener('DOMContentLoaded', function() {
	const calendarEl = document.getElementById('calendar');
	calendar = new FullCalendar.Calendar(calendarEl, {
		timeZone: 'local',
		initialView: 'timeGridFiveDay',
        slotDuration: '00:15:00',   // 시간 슬롯을 15분 단위로 설정
        slotLabelInterval: '00:15:00', // 라벨도 15분 간격으로 설정
        slotMinTime: '09:00:00',    // 시작 시간
        slotMaxTime: '18:00:00',    // 끝 시간
        nowIndicator: true,
		editable:true,
		selectable: true,
		locale: 'ko',
		//contentHeight: 'auto',
	    slotLabelFormat: {
	        hour: '2-digit',    // 시간 두 자리로 표시
	        minute: '2-digit',  // 분 두 자리로 표시
	        hour12: false       // 24시간 형식 사용
	    },
	    datesSet: function(info) {
	        // datesSet 이벤트로 타이틀 커스터마이징
	        var toolbarTitle = document.querySelector('.fc-toolbar-title');
	        var currentStart = info.start;
	        var currentEnd = info.end;

	        // 월과 날짜 범위 구하기
	        var yearMonth = currentStart.getFullYear() + '년 ' + (currentStart.getMonth() + 1) + '월';
	        var dayRange = currentStart.getDate() + '일 - ' + (currentEnd.getDate() - 1) + '일'; // end는 다음 날을 가리킴

	        // 줄바꿈 형식으로 타이틀 업데이트
	        toolbarTitle.innerHTML =
	            '<span class="year-month">' +
	            yearMonth +
	            '</span><span class="day-range">' +
	            dayRange +
	            '</span>';
	    },
	    views: {
	        timeGridFiveDay: {
	          type: 'timeGrid',
	          duration: { days: 5 },
	          buttonText: '5 day',
	          allDaySlot: false
	        }
	    },
	    headerToolbar: {
	        left: 'prev,today',
	        center: 'title',
	        right: 'next'
	    },
	      // 일정 가져오기(회의실별) + 내가 포함된 회의 일정 보기
        events: function (fetchInfo, successCallback, failureCallback) {
            // AJAX 요청으로 일정 데이터 가져오기
            var selectedRoomIdx = document.getElementById('meeting_room_select').value;
            
            var my_meeting = document.getElementById('meeting_only_mine').checked .value 
            ? document.getElementById('meeting_only_mine').value 
            : null;
            
            $.ajax({
                url: '/meeting/getMeeting.do',  // 실제 경로에 맞게 수정
                type: 'POST',
                contentType: 'application/json', // 서버가 JSON을 처리하도록 설정
                data: JSON.stringify({ // JSON 형식으로 데이터를 보냄
                	room: selectedRoomIdx,
                	my_meeting: my_meeting}), 
                success: function(data) {
                    console.log(data);
                    successCallback(data); // FullCalendar에 일정 데이터 추가
                },
                error: function(xhr, status, error) {
                    alert('일정 데이터를 불러오는 중 오류가 발생했습니다.');
                    failureCallback();
                }
            });
		},
    
        //select일정 입력
        select: function(arg) {
        	
        	console.log('arg.start:'+arg.start);
        	console.log('arg.start format:'+meeting_format_local(arg.start));
        	
        	
        	const participantFieldset = document.querySelector('fieldset');
        	// 모달 제목 변경
            $('#meeting_modal_title').text('일정 추가');
        	
        	
            // 필드 초기화 및 활성화
            $('#meeting_title').val('');
            $('#meeting_content').val('');
            $('#meeting_room_empl').val('');
            $('#meeting_start_time').val(meeting_format_date_time(arg.start));
            $('#meeting_end_time').val(meeting_format_date_time(arg.end));
            $('#meeting_room_select_modal').prop('disabled', false).val($('#meeting_room_select').val());

            // 버튼 초기화 및 추가
			$('#meeting_modal_buttons').empty().append(
				$('<button>', {
					text: '예약',
					id: 'addMeeting',
					type: 'button',
					click: function() {
                        // 예약 처리 로직
						const title = $('#meeting_title').val();
						const content = $('#meeting_content').val();
						const empl = $('#meeting_room_empl').val();
						const room = $('#meeting_room_select_modal').val();
						const start =  meeting_format_local($('#meeting_start_time').val());
						const end =  meeting_format_local($('#meeting_end_time').val());
			            // 체크된 참여자 가져오기
			            const meeting_parti = Array.from(
			                document.querySelectorAll('input[name="meeting_parti"]:checked')
			            ).map(function(input) {
			                return input.value;
			            });
						console.log('title:'+title);
						console.log('content:'+content);
						console.log('empl:'+empl);
						console.log('room:'+room);
						console.log('start:'+start);
						console.log('end:'+end);
						console.log('parti:'+meeting_parti);
						
                		// 입력 값이 모두 채워졌는지 확인
		                if (title && content && empl) {

		                    const meeting_add_data = {
		                            title: title,
		                            start: start,
		                            end: end,
		                            content: content,
		                            empl: empl,
		                            room: room,
		                            meeting_parti: meeting_parti 
		                        };


		                    meeting_add(meeting_add_data); // 서버로 전송
		                    meeting_close_modal(); // 모달 닫기
		                    
		                    
		                    
		                } else {
		                    alert('제목, 내용, 예약 사원을 모두 입력해주세요.');
		                }
            		}
				})
			);
            // 모달 열기
            meeting_open_modal();
            
        },
		//수정, 삭제
        // 확인 모달: 기존 일정 확인
        eventClick: function(info) {
        	console.log(info);
        
            // 모달 제목 변경
            $('#meeting_modal_title').text('일정 확인');

            // 기존 데이터 채우기
            $('#meeting_title').val(info.event.title).prop('readonly', true);
            $('#meeting_content').val(info.event.extendedProps.description).prop('readonly', true);
            $('#meeting_room_empl').val(info.event.extendedProps.empl).prop('readonly', true);
            $('#meeting_start_time').val(meeting_format_date_time(info.event.start));
            $('#meeting_end_time').val(meeting_format_date_time(info.event.end));
            $('#meeting_room_select_modal').val(info.event.extendedProps.room).prop('disabled', true);

            // 기존 참여자 데이터 가져오기
            var participants = info.event.extendedProps.parti; // 배열 형태로 저장된 참여자 ID

            // 체크박스 상태 업데이트
		    $('input[name="meeting_parti"]').each(function() {
		        var value = $(this).val(); // 체크박스의 값
		        if (participants.includes(parseInt(value))) { // 체크박스 값을 숫자로 변환
		            $(this).prop('checked', true).prop('disabled', true);;
		        } else {
		            $(this).prop('checked', false);
		        }
		    });
            
            // 버튼 초기화 및 추가
            $('#meeting_modal_buttons').empty().append(
                $('<button>', {
                    text: '수정',
                    id: 'meeting_edit_button',
                    type: 'button',
                    click: function() {
                        // 수정 가능 상태로 전환
                        $('#meeting_title, #meeting_content, #meeting_room_empl').prop('readonly', false);
                        $('#meeting_room_select_modal').prop('disabled', false);
                        $('input[name="meeting_parti"]').prop('disabled', false);
                        
                        // 버튼 교체: 수정 -> 수정 확인
                        $('#meeting_modal_buttons').empty().append(
                            $('<button>', {
                                text: '수정 확인',
                                id: 'meeting_update_check',
                                type: 'button',
                                click: function() {
                                    if (confirm('수정하시겠습니까?')) {
                                        // 수정 로직
                                        info.event.setProp('title', $('#meeting_title').val());
                                        info.event.setExtendedProp('description', $('#meeting_content').val());
                                        info.event.setExtendedProp('empl', $('#meeting_room_empl').val());
                                        info.event.setExtendedProp('room', $('#meeting_room_select_modal').val());
                                        info.event.setStart($('#meeting_start_time').val());
                                        info.event.setEnd($('#meeting_end_time').val());
                                        
                			            var meeting_parti = Array.from(
                				                document.querySelectorAll('input[name="meeting_parti"]:checked')
                				            ).map(function(input) {
                				                return input.value;
                				            });
                			            
                                        // 서버 전송
                                        const meeting_update_data = {
                                            title: $('#meeting_title').val(),
                                            content: $('#meeting_content').val(),
                                            empl: $('#meeting_room_empl').val(),
                                            room: $('#meeting_room_select_modal').val(),
                                            start: meeting_format_local($('#meeting_start_time').val()),
                                            end: meeting_format_local($('#meeting_end_time').val()),
                                            rent_idx: info.event._def.extendedProps["meet_rent_idx"],
                                            meeting_parti:meeting_parti
                                        };
                                        meeting_update(meeting_update_data);

                                        meeting_close_modal();
                                    }
                                }
                            })
                        );
                    }
                }),
                $('<button>', {
                    text: '삭제',
                    id: 'meeting_delete_button',
                    type: 'button',
                    click: function() {
                        if (confirm('회의실 예약을 취소하시겠습니까?')) {
                            info.event.remove(); // 이벤트 삭제
                            meeting_delete(info.event._def.extendedProps["meet_rent_idx"]); // 서버로 삭제 요청
                            meeting_close_modal();
                        }
                    }
                })
            );

            // 모달 열기
            meeting_open_modal();
        },
        eventDrop: function(obj) {

        	// 드래그 후 이벤트의 날짜 변경 처리 로직
            // 선택한 이벤트 정보
            let event = obj.event;
			console.log(obj.event.start);
            $.ajax({
                url: '/meeting/meetingResize.do',
                type: 'post',
                data:{
                	rent_idx:obj.event._def.extendedProps["meet_rent_idx"],
                    start: meeting_format_local(obj.event.start),
                    end: meeting_format_local(obj.event.end)
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
        	// 드래그 후 이벤트의 날짜 변경 처리 로직
            // 선택한 이벤트 정보
           let event = obj.event;
			console.log(event);
			console.log('시간길이조절'+obj.event._instance.range["start"]);
            $.ajax({
                url: '/meeting/resizeMeeting.do',
                type: 'post',
                data:{
                	rent_idx:obj.event._def.extendedProps["meet_rent_idx"],
                    start: meeting_format_local(obj.event.start),
                    end: meeting_format_local(obj.event.end)
                },  //데이터 형식 주의 안넘어가면 바꿔볼것
				 success:function(data, textStatus, xhr){
					 console.log(data);	 
				 },
				 error:function(xhr, status, error){
					 console.log(error);
				 }

            });
        }
	});
	calendar.render();
});



//일정 DB 저장(회의일정 추가 + 참여자 추가)
function meeting_add(allData) {
    console.log('서버에 전송할 이벤트 데이터:', allData);
    $.ajax({
        url: '/meeting/meetingAdd.do',
        type: 'POST',  // POST 요청으로 보내야 합니다.
        contentType: 'application/json',
        data: JSON.stringify(allData),
        success: function(data) {
            console.log('서버 응답:', data);
            calendar.refetchEvents();
        },
        error: function(xhr, status, error) {
            console.error('서버 요청 실패:', error);
        }
    });
}

//일정 DB 수정(회의일정 수정)
function meeting_update(meeting_update_data) {
    $.ajax({
        url: '/meeting/meetingUpdate.do',  // 수정된 일정 전송 URL
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(meeting_update_data), // 수정된 이벤트 데이터 전송
        success: function(data) {
            console.log('일정 수정 성공:', data);
            calendar.refetchEvents();
        },
        error: function(xhr, status, error) {
            console.error('일정 수정 요청 실패:', error);
        }
    });
}


//일정 DB 삭제(회의일정 삭제)
function meeting_delete(rent_idx) {
    $.ajax({
        url: '/meeting/meetingDelete.do',  // 수정된 일정 전송 URL
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(rent_idx), // 수정된 이벤트 데이터 전송
        success: function(data) {
            console.log('일정 수정 성공:', data);
        },
        error: function(xhr, status, error) {
            console.error('일정 수정 요청 실패:', error);
        }
    });
}



// 모달 열기
function meeting_open_modal() {
    document.getElementById('meeting_event_modal').style.display = 'block';
}

// 모달 닫기
function meeting_close_modal() {
    document.getElementById('meeting_event_modal').style.display = 'none';
}


//날짜 형식을 YYYY-MM-DD HH:MM으로 변환
function meeting_format_date_time(dateTimeStr) {
    var date = new Date(dateTimeStr); // 클라이언트의 시간대
    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString().padStart(2, '0');
    var day = date.getDate().toString().padStart(2, '0');
    var hours = (date.getHours()).toString().padStart(2, '0');
    var minutes = date.getMinutes().toString().padStart(2, '0');
    
    return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
}

function meeting_format_local(dateString) {
    // Date 객체로 변환
    const date = new Date(dateString);
  
    // local 기준으로 날짜와 시간 추출
    const local_year = date.getFullYear();
    const local_month = String(date.getMonth() + 1).padStart(2, '0'); // 월 (0부터 시작)
    const local_day = String(date.getDate()).padStart(2, '0');
    const local_hours = String(date.getHours()).padStart(2, '0');
    const local_minutes = String(date.getMinutes()).padStart(2, '0');
  
    // 원하는 형식으로 조합
    return local_year+'-'+local_month+'-'+local_day+'T'+local_hours+':'+local_minutes;
}


function convertToISO(inputDateString) {
    // 입력 문자열을 Date 객체로 변환
    const date = new Date(inputDateString);
    
    // Date 객체를 ISO 8601 UTC 형식으로 변환
    return date.toISOString();
}




</script>
</html>