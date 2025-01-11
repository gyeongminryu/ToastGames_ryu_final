

//회의실 등록링크 관리자 부서 확인
/*document.addEventListener("DOMContentLoaded", function() {
	const empl_depart_idx = "${my_dept_idx}";
	const room_depart_idx = "108"; // 부서 번호가 108일 때만 보여줌
	const meetingRoomLink = document.getElementById("meetingRoomLink");

	// 부서 번호가 맞지 않으면 링크 숨기기
	if (empl_depart_idx !== room_depart_idx) {
		meetingRoomLink.style.display = "none"; // 링크를 숨김
	}
});*/

let calendar;

//회의실 정보 상세보기
/*document.addEventListener('DOMContentLoaded', function() {
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
});*/

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
		initialView: 'timeGridWeek',
        slotDuration: '00:30:00',   // 시간 슬롯을 30분 단위로 설정
        slotLabelInterval: '00:30:00', // 라벨도 30분 간격으로 설정
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
	    headerToolbar: {
	        left: '',
	        center: 'prev,title,next',
	        right: 'today'
	    },
	      // 일정 가져오기(회의실별) + 내가 포함된 회의 일정 보기
        events: function (fetchInfo, successCallback, failureCallback) {
            // AJAX 요청으로 일정 데이터 가져오기
            var selectedRoomIdx = document.getElementById('meeting_room_select').value;
            
            var my_meeting = document.getElementById('meeting_only_mine').checked
            ? document.getElementById('meeting_only_mine').value 
            : null;
            
            console.log('my_meeting'+my_meeting);
            $.ajax({
                url: '/getMeeting.do',  // 실제 경로에 맞게 수정
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
        	
        	console.log(selectedEmplList);
        	
        	console.log('arg.start:'+arg.start);
        	console.log('arg.start format:'+meeting_format_local(arg.start));
        	
        	
            // 필드 초기화 및 활성화
            $('#meeting_title').val('');
            $('#meeting_content').val('');
            $('#meeting_start_time').val(meeting_format_date_time(arg.start));
            $('#meeting_end_time').val(meeting_format_date_time(arg.end));
            $('#meeting_room_select_modal').prop('disabled', false).val($('#meeting_room_select').val());
            
            // 버튼 초기화 및 추가
			$('#addMeeting').click(function() {
			    // 예약 처리 로직
			    const title = $('#meeting_title').val();
			    const content = $('#meeting_content').val();
			    const room = $('#meeting_room_select_modal').val();
			    const start = meeting_format_local($('#meeting_start_time').val());
			    const end = meeting_format_local($('#meeting_end_time').val());
			
			    // selectedEmplList에서 empl_idx만 추출하여 새로운 배열을 만듬
			    const emplIdx = selectedEmplList.map(function(empl) {
			        return empl.empl_idx;  // empl_idx 추출
			    });
			
			
			    // meeting_parti에 emplIdx 배열을 할당
			    const meeting_parti = emplIdx;
			
			    console.log('title: ' + title);
			    console.log('content: ' + content);
			    console.log('room: ' + room);
			    console.log('start: ' + start);
			    console.log('end: ' + end);
			    console.log('parti: ' + meeting_parti);
			
			    // 입력 값이 모두 채워졌는지 확인
			    if (title && content && meeting_parti.length > 0) {
			        const meeting_add_data = {
			            title: title,
			            start: start,
			            end: end,
			            content: content,
			            room: room,
			            meeting_parti: meeting_parti
			        };
			
			        meeting_add(meeting_add_data); // 서버로 전송
			        meeting_close_modal(); // 모달 닫기
			    } else {
			        alert('제목, 내용, 예약 사원들을 모두 입력해주세요.');
			    }
			});

            // 모달 열기
            meeting_open_modal();
            
        },
        
        // 확인 모달: 기존 일정 확인
		eventClick: function(info) {

		    console.log(info);
			// session에서 현재 사용자 empl_idx 값을 가져옵니다 (여기서는 예시로 sessionStorage를 사용)
    		//var sessionEmplIdx = sessionStorage.getItem('empl_idx');  // session에서 empl_idx 가져오기
    		var sessionEmplIdx = 10003;  // session에서 empl_idx 가져오기
    
    		console.log(info.event.extendedProps.empl);
    		console.log(sessionEmplIdx);
    		// info.event.rent_empl_idx와 session에서 가져온 empl_idx 비교
    		if (info.event.extendedProps.empl !== sessionEmplIdx) {
		    

			    // 회의실 정보
			    $('#meeting_room_detail').text(info.event.extendedProps.roomName); 
			    
			    // 회의 주제
			    $('#meeting_title_detail').text(info.event.title); 
			    
			    // 회의 시작 시간 및 종료 시간
			    $('#meeting_start_time_detail').text(meeting_format_date_time(info.event.start)); 
			    $('#meeting_end_time_detail').text(meeting_format_date_time(info.event.end)); 
			    
			    // 회의 내용
			    $('#meeting_content_detail').text(info.event.extendedProps.description); 
			    
			    // 기존 참석자 목록 가져오기
			    var participants = info.event.extendedProps.parti; // 배열 형태로 저장된 참여자 데이터
			    var participantsContainer = $('#meeting_participants_detail'); // 참가자 정보가 들어갈 컨테이너 (<p> 태그)
			    
			    // 기존 내용 초기화
			    participantsContainer.empty();
			    
			    // 참가자 정보 동적으로 생성
			    if (Array.isArray(participants) && participants.length > 0) {
			        participants.forEach(function(participant) {
			            // 각 참가자에 대해 <span> 요소를 생성하고 추가
			            var participantElement = `
			                <span onclick="tst_view_profile('${participant.meet_parti_empl_idx}')" 
			                      class="tst_pointer tst_badge_min btn_subtle margin_right">
			                    ${participant.empl_name}
			                </span>`;
			            participantsContainer.append(participantElement);
			        });
			    } else {
			        // 참가자가 없을 경우 메시지 표시
			        participantsContainer.append('<span>참석자가 없습니다.</span>');
			    }
			
			    // 모달 열기
			    tst_modal_call('tst_modal_detail');
			} else {    
		        // rent_empl_idx가 session의 empl_idx와 다르면 수정 모달 열기
		        // 예를 들어, 수정용 모달을 열 때 필드에 기존 값 채우기
		        $('#meeting_title_update').val(info.event.title);
		        $('#meeting_room_update').val(info.event.extendedProps.roomName);
		        $('#meeting_start_time_update').val(meeting_format_date_time(info.event.start));
		        $('#meeting_end_time_update').val(meeting_format_date_time(info.event.end));
		        $('#meeting_content_update').val(info.event.extendedProps.description);
				updateParticipantsFromEvent(info);
				
		        // 수정 모달 열기
		        tst_modal_call('tst_modal_update');
		    }

		},

        eventDrop: function(obj) {

        	// 드래그 후 이벤트의 날짜 변경 처리 로직
            // 선택한 이벤트 정보
            let event = obj.event;
			console.log(obj.event.start);
            $.ajax({
                url: '/meetingDrop.do',
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
                url: '/resizeMeeting.do',
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

// 선택된 회의 정보에서 참가자 배열을 받아오는 함수
function updateParticipantsFromEvent(info) {
    // info.event.parti에서 참가자 데이터를 가져와 selectedEmplList에 추가
    if (Array.isArray(info.event.extendedProps.parti)) {
        // 참가자 목록을 selectedEmplList에 추가
        selectedEmplList = info.event.extendedProps.parti;

		console.log(selectedEmplList);
        // updateMeetingEmplTable 호출하여 참석자 목록을 업데이트
        updateMeetingEmpl();
    }
}


function updateMeetingEmpl() {
    // tbody 선택
    var emplTableBody = document.getElementById('empl_update');

    // 기존 참석자 행 초기화 (버튼 행 제외)
    var addRow = document.getElementById('add-participant-row');
    emplTableBody.innerHTML = '';
    emplTableBody.appendChild(addRow);

    // 참석자 배열을 순회하며 행 추가
    for (var i = 0; i < selectedEmplList.length; i++) {
        var empl = selectedEmplList[i];
        var row = document.createElement('tr');
		console.log(empl);
        // 부서명
        var deptCell = document.createElement('td');
        deptCell.innerHTML = '<h3>' + empl.dept_name + '</h3>';
        row.appendChild(deptCell);

        // 직원 정보
        var infoCell = document.createElement('td');
        infoCell.innerHTML =
            '<span onclick="tst_view_profile(\'' +
            empl.empl_idx +
            '\')" class="tst_pointer">' +
            empl.empl_name +
            ' (' +
            empl.position_name +
            '/' +
            empl.duty_name +
            ')</span>';
        row.appendChild(infoCell);

        // 제거 버튼
        var actionCell = document.createElement('td');
        actionCell.className = 'align_left';
        actionCell.innerHTML =
            '<i class="bi bi-dash-circle-dotted" onclick="removeEmpl(' +
            i +
            ')"></i>';
        row.appendChild(actionCell);

        emplTableBody.appendChild(row);
    }
}

function removeEmpl(index) {
    // 해당 인덱스의 참석자를 배열에서 제거
    selectedEmplList.splice(index, 1);

    // 테이블 업데이트
    updateMeetingEmplTable();
}

//일정 DB 저장(회의일정 추가 + 참여자 추가)
function meeting_add(allData) {
    console.log('서버에 전송할 이벤트 데이터:', allData);
    $.ajax({
        url: '/meetingAdd.do',
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


function meeting_update_modal(){
	tst_modal_close('tst_modal_detail');
	tst_modal_call('tst_modal_update');
	
			    // 기존 데이터 채우기
		    $('#meeting_title_update').val(info.event.title).prop('readonly', true);
		    $('#meeting_content_update').val(info.event.extendedProps.description).prop('readonly', true);
		    $('#meeting_start_time_update').val(meeting_format_date_time(info.event.start));
		    $('#meeting_end_time_update').val(meeting_format_date_time(info.event.end));
		    $('#meeting_room_idx_update').val(info.event.extendedProps.room).prop('disabled', true);
	
       // 버튼 초기화 및 추가
    $('#meeting_modal_buttons').empty().append(
       $('<button>', {
			text: '수정',
			id: 'meeting_edit_button',
			type: 'button',
			click: function() {
                        
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
								info.event.setExtendedProp('room', $('#meeting_room_id_update').val());
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
}



//일정 DB 수정(회의일정 수정)
function meeting_update(meeting_update_data) {
    $.ajax({
        url: '/meetingUpdate.do',  // 수정된 일정 전송 URL
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
        url: '/meetingDelete.do',  // 수정된 일정 전송 URL
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

// 추가 모달 열기
function meeting_open_modal() {
    document.getElementById('meeting_event_modal').style.display = 'flex';
}

// 추가 모달 닫기
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


//이름부서검색
function search_parti() {
    const search_option = document.getElementById("search_option").value; // 검색 옵션 (empl_name 또는 dept_name)
    const search_input = document.getElementById("search_input").value.toLowerCase().trim(); // 입력된 검색어
    const participants = document.querySelectorAll("#participant_list .participant"); // 참가자 리스트

    
    console.log(search_option);
    console.log(search_input);
    console.log(participants);
    
    participants.forEach(function(participant) {
        // data-* 속성 값 가져오기
        const data_value = participant.dataset[search_option]; // 'empl_name' 또는 'dept_name'에 해당하는 데이터 값

        console.log("현재 참가자 데이터:", data_value); // 디버깅용 출력

        // 데이터 값이 존재하면 소문자로 변환 후, 검색어가 포함되어 있는지 확인
        if (data_value) {
            const search_value = data_value.toLowerCase().trim(); // 소문자로 변환하고 공백 제거
            if (search_value.includes(search_input)) {
                participant.style.display = ""; // 표시
            } else {
                participant.style.display = "none"; // 숨기기
            }
        } else {
            participant.style.display = "none"; // 데이터가 없으면 숨기기
        }
    });
}

            
