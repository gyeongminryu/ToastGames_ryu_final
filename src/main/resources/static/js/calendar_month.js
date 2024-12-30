
//나의 일정 종류별 보기
document.getElementById('schedule_category_name').addEventListener('change', function () {
    if (calendar) {
        const is_schedule = this.checked;
        console.log(is_schedule ? "내가 포함된 회의만 보기 활성화" : "전체 회의 보기");
        calendar.refetchEvents(); // FullCalendar 이벤트 갱신
    } else {
        console.error('FullCalendar 인스턴스가 초기화되지 않았습니다.');
    }
});





document.getElementById('schedule_start_time').addEventListener('change', function () {
    console.log('시작 시간:', this.value); // ISO 형식(예: 2024-12-19T10:30)
});

document.getElementById('schedule_end_time').addEventListener('change', function () {
    console.log('종료 시간:', this.value); // ISO 형식(예: 2024-12-19T11:30)
});


        let calendar = null;
        let Alldata = {};
        $(function(){

            let calendarEl = $('#calendar')[0];

             calendar = new FullCalendar.Calendar(calendarEl, { 
            	timeZone: 'local',
                expandRows: true, // 화면에 맞게 높이 재설정
                slotMinTime: '09:00:00',    // Day 캘린더에서 시작 시간
                slotMaxTime: '18:00:00',    // Day 캘린더에서 종료 시간
                editable: true,
                eventResizableFromStart: true,
                selectable: true, // 달력 일자 드래그 설정가능
                nowIndicator: true, // 현재 시간 마크
                dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
                locale: 'ko', // 한국어 설정
                headerToolbar: {
                    left: 'dayGridMonth,timeGridWeek',
                    center: 'prev,title,next',
                    right: 'today'
                },
                initialView: 'dayGridMonth',
                slotDuration: '00:30:00',   // 시간 슬롯을 15분 단위로 설정
                slotLabelInterval: '00:30:00', // 라벨도 15분 간격으로 설정
        	    slotLabelFormat: {
        	        hour: '2-digit',    // 시간 두 자리로 표시
        	        minute: '2-digit',  // 분 두 자리로 표시
        	        hour12: false       // 24시간 형식 사용
        	    },
        	    //일정 불러오기
                events: function (fetchInfo, successCallback, failureCallback) {
                	
                	const schedule_type_name = $('input[name="schedule_type_name"]:checked').val();
                	console.log(schedule_type_name);
                    // AJAX 요청으로 일정 데이터 가져오기
                    $.ajax({
                        url: '/getSchedules.do',
                        type: 'POST',
                        contentType: 'application/json', // JSON 형식으로 요청
                        data: JSON.stringify({ schedule_type_name: schedule_type_name }),
                        success: function(data) {
                            var events = data.map(function(event) {
                                // eventColor로 색을 지정
                                var color;
                                switch (event.sche_type) {
                                    case 1: // 개인
                                        color = 'green'; 
                                        break;
                                    case 2: // 부서
                                        color = 'skyblue'; 
                                        break;
                                    case 3: // 프로젝트
                                        color = 'orange'; 
                                        break;
                                    case 4: // 기타
                                        color = 'purple'; 
                                        break;
                                    default:
                                        color = 'gray'; 
                                }

                                // eventColor 사용
                                return {
                                	sche_idx:event.sche_idx,
                                    title: event.title,
                                    start: event.start,
                                    end: event.end,
                                    description: event.description,
                                    sche_type: event.sche_type,
                                    parti: event.parti,
                                    backgroundColor: color,  // 배경 색상
                                    borderColor: color, 
                                    allDay: event.allDay,
                                    empl:event.empl
                                };
                            });
                            successCallback(events); // FullCalendar에 일정 데이터 추가
                        },
                        error: function () {
                            alert('일정 데이터를 불러오는 중 오류가 발생했습니다.');
                            failureCallback();
                        }
                     });
                 },
                
/*                 //일정 추가되었을때 이벤트인데 사라질 가능성 농후함
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

                     
                }, */
                eventClick: function(info) {
                    console.log(info);

                    // 모달 제목 변경
                    $('#schedule_modal_title').text('일정 확인');

                    // 기존 데이터 채우기
                    $('#schedule_title').val(info.event.title).prop('readonly', true);
                    $('#schedule_content').val(info.event.extendedProps.description).prop('readonly', true);
                    $('#schedule_empl_idx').val(info.event.extendedProps.empl).prop('readonly', true);
                    $('#schedule_start_time').val(schedule_format_date_time(info.event.start));
                    $('#schedule_end_time').val(schedule_format_date_time(info.event.end));

                    // 일정 종류 라디오 버튼 상태 업데이트
                    var schedule_type = info.event.extendedProps.sche_type; // 서버에서 가져온 schedule_type 값
                    $('input[name="schedule_type"]').each(function() {
                        if ($(this).val() == schedule_type) {
                            $(this).prop('checked', true).prop('disabled', true);
                        } else {
                            $(this).prop('checked', false).prop('disabled', true);
                        }
                    });                    
                    
                    // 기존 참여자 데이터 가져오기
                    var participants = info.event.extendedProps.parti; // 배열 형태로 저장된 참여자 ID

                    // 체크박스 상태 업데이트
        		    $('input[name="schedule_parti"]').each(function() {
        		        var value = $(this).val(); // 체크박스의 값
        		        if (participants.includes(parseInt(value))) { // 체크박스 값을 숫자로 변환
        		            $(this).prop('checked', true).prop('disabled', true);
        		        } else {
        		            $(this).prop('checked', false).prop('disabled', true);
        		        }
        		    });


                    // 버튼 초기화 및 추가
                    $('#schedule_modal_buttons').empty().append(
                        $('<button>', {
                            text: '수정',
                            id: 'schedule_edit_button',
                            type: 'button',
                            click: function() {
                                // 수정 가능 상태로 전환
                                $('#schedule_title, #schedule_content, #schedule_empl_idx').prop('readonly', false);
                                $('input[name="schedule_parti"]').prop('disabled', false);
                                $('input[name="schedule_type"]').prop('disabled', false);
                                // 버튼 교체: 수정 -> 수정 확인
                                $('#schedule_modal_buttons').empty().append(
                                    $('<button>', {
                                        text: '수정 확인',
                                        id: 'schedule_update_check',
                                        type: 'button',
                                        click: function() {
                                            if (confirm('수정하시겠습니까?')) {
                                                // 수정 로직
                                                const scheduleData = {
                                                	sche_idx:info.event._def.extendedProps["sche_idx"],
                                                    title: $('#schedule_title').val(),
                                                    content: $('#schedule_content').val(),
                                                    empl_idx: $('#schedule_empl_idx').val(),
                                                    sche_type: $('input[name="schedule_type"]:checked').val(),
                                                    start: schedule_format_local($('#schedule_start_time').val()),
                                                    end: schedule_format_local($('#schedule_end_time').val()),
                                                    allday: info.event.allDay,
                                                    sche_parti: $('input[name="schedule_parti"]:checked').map(function() {
                                                        return $(this).val();
                                                    }).get()
                                                };

                                                info.event.setProp('title', scheduleData.title);
                                                info.event.setExtendedProp('description', scheduleData.content);
                                                info.event.setExtendedProp('empl_idx', scheduleData.empl_idx);
                                                info.event.setExtendedProp('schedule_type', scheduleData.sche_type);
                                                info.event.setExtendedProp('participants', scheduleData.sche_parti);
                                                info.event.setStart(scheduleData.start);
                                                info.event.setEnd(scheduleData.end);

                                                schedule_update(scheduleData);
                                                schedule_close_modal();
                                            }
                                        }
                                    })
                                );
                            }
                        }),
                        $('<button>', {
                            text: '삭제',
                            id: 'schedule_delete_button',
                            type: 'button',
                            click: function() {
                                if (confirm('일정을 삭제하시겠습니까?')) {
                                    info.event.remove(); // 이벤트 삭제
                                    schedule_delete(info.event._def.extendedProps["sche_idx"]); // 서버로 삭제 요청
                                    schedule_close_modal();
                                }
                            }
                        })
                    );

                    // 모달 열기
                    schedule_open_modal();
                },

                //일정 옮기기
                eventDrop: function(obj) {
                	
                	// 드래그 후 이벤트의 날짜 변경 처리 로직
                    // 선택한 이벤트 정보
        			console.log(obj);
                    $.ajax({
                        url: '/scheduleDrop.do',
                        type: 'post',
                        contentType: 'application/json',  // JSON 형식으로 요청
                        data: JSON.stringify({
                            sche_idx: obj.event._def.extendedProps["sche_idx"],
                            start: schedule_format_local(obj.event.start),
                            end: schedule_format_local(obj.event.end),
                            allday:obj.event._def["allDay"]
                        }),  //데이터 형식 주의 안넘어가면 바꿔볼것
        				 success:function(data, textStatus, xhr){
        					 console.log(data);	 
        				 },
        				 error:function(xhr, status, error){
        					 console.log(error);
        				 }

                    });
        			
                    
                },
                
                //일정 시간 늘리고 줄이기
                eventResize: function(obj) {
                	
                	// 드래그 후 이벤트의 날짜 변경 처리 로직
                    // 선택한 이벤트 정보
                   let event = obj.event;
        			console.log(event);
        			console.log(obj);
                    $.ajax({
                        url: '/scheduleResize.do',
                        type: 'post',
                        contentType: 'application/json',  // JSON 형식으로 요청
                        data: JSON.stringify({
                            sche_idx: obj.event._def.extendedProps["sche_idx"],
                            start: schedule_format_local(obj.event.start),
                            end: schedule_format_local(obj.event.end),
                            allday:obj.event._def["allDay"]
                        }),  //데이터 형식 주의 안넘어가면 바꿔볼것
        				 success:function(data, textStatus, xhr){
        					 console.log(data);	 
        				 },
        				 error:function(xhr, status, error){
        					 console.log(error);
        				 }

                    });
                },
                
                //일정 선택
                select: function(arg) {
                    // 시작/종료 시간 출력
                    console.log('arg.start:', arg.start);
                    console.log('arg.end:', arg.end);
                    console.log('arg.allDay:', arg.allDay);
                    
                    
                    // 모달 초기화
                    $('#schedule_modal_title').text('새 일정 추가');
                    $('#schedule_title').val('');
                    $('#schedule_content').val('');
                    //$('#schedule_empl_idx').val('');
                    $('input[name="schedule_type"]').prop('checked', false); // 라디오 버튼 초기화
                    $('input[name="schedule_parti"]').prop('checked', false); // 체크박스 초기화

                    // 종일 여부에 따라 시작/종료 시간 필드 설정
                    if (arg.allDay) {
                        $('#schedule_start_time').val(schedule_format_date_time(arg.start)); // 'YYYY-MM-DD' 형식
                        $('#schedule_end_time').val(schedule_format_date_time(arg.end));     // 'YYYY-MM-DD' 형식
                        $('#schedule_start_time').prop('readonly', true);
                        $('#schedule_end_time').prop('readonly', true);   // 시간 필드 비활성화
                        $('#schedule_allday').prop('checked', true);      // 종일 체크 활성화
                    } else {
                        $('#schedule_start_time').val(schedule_format_date_time(arg.start)); // 'YYYY-MM-DDTHH:mm' 형식
                        $('#schedule_end_time').val(schedule_format_date_time(arg.end));     // 'YYYY-MM-DDTHH:mm' 형식
                        $('#schedule_start_time').prop('disabled', false); // 시간 필드 활성화
                        $('#schedule_end_time').prop('disabled', false);   // 시간 필드 활성화
                        $('#schedule_allday').prop('checked', false);      // 종일 체크 비활성화
                    }
                    // 모달 버튼 설정
                    $('#schedule_modal_buttons').empty().append(
                        $('<button>', {
                            text: '일정 추가',
                            id: 'addSchedule',
                            type: 'button',
                            click: function() {
                                // 데이터 수집
                                const title = $('#schedule_title').val();
                                const content = $('#schedule_content').val();
                                const empl_idx = $('#schedule_empl_idx').val();
                                const sche_type = $('input[name="schedule_type"]:checked').val(); // 선택된 일정 종류
                                const start = $('#schedule_start_time').val();
                                const end = $('#schedule_end_time').val();
                                const sche_parti = [];

                                // 참여자 체크박스 선택값 수집
                                $('input[name="schedule_parti"]:checked').each(function() {
                                	sche_parti.push($(this).val());
                                });

                                console.log('Collected Data:', { title, content, empl_idx, sche_type, start, end, sche_parti });

                                // 입력 값 유효성 검사  //allday추가
                                if (title && content && empl_idx && sche_type) {
                                    const scheduleData = {
                                        title:title,
                                        content:content,
                                        empl_idx:empl_idx,
                                        sche_type:sche_type,
                                        start:start,
                                        end:end,
                                        allday:arg.allDay,
                                        sche_parti:sche_parti
                                    };

                                    // 서버로 데이터 전송
                                    schedule_add(scheduleData);
                                    schedule_close_modal(); // 모달 닫기
                                } else {
                                    alert('제목, 내용, 사원번호, 일정 종류를 모두 입력해주세요.');
                                }
                            }
                        })
                    );

                    // 모달 열기
                    schedule_open_modal();
                }
            });
            // 캘린더 랜더링
            calendar.render();

        });
        
        

//일정 추가
function schedule_add(scheduleData) {
        	
	console.log(scheduleData);
	//document.getElementById("submenu").style.display = "block";

	$.ajax({
		url: "/scheduleAdd.do",
		type: "POST",
		contentType: "application/json", // JSON 형식으로 Content-Type 지정
		data: JSON.stringify(scheduleData),   //데이터 형식 주의 안넘어가면 바꿔볼것
		success:function(data, textStatus, xhr){
			console.log(data);	
			calendar.refetchEvents();
		},
		error:function(xhr, status, error){
			console.log(error);
		}
	});
}


//일정 수정
function schedule_update(scheduleData) {
        	
	console.log(scheduleData);

	$.ajax({
		url: "/scheduleUpdate.do",
		type: "POST",
		contentType: "application/json", // JSON 형식으로 Content-Type 지정
		data: JSON.stringify(scheduleData),   //데이터 형식 주의 안넘어가면 바꿔볼것
		success:function(data, textStatus, xhr){
			console.log(data);	
			calendar.refetchEvents();
		},
		error:function(xhr, status, error){
			console.log(error);
		}
	});
}
    

//일정 삭제
function schedule_delete(sche_idx) {
        	
	console.log(sche_idx);

	$.ajax({
		url: "/scheduleDelete.do",
		type: "POST",
		contentType: "application/json", // JSON 형식으로 Content-Type 지정
		data:JSON.stringify({ sche_idx: sche_idx }),   //데이터 형식 주의 안넘어가면 바꿔볼것
		success:function(data, textStatus, xhr){
			console.log(data);	
			calendar.refetchEvents();
		},
		error:function(xhr, status, error){
			console.log(error);
		}
	});
}

//모달 열기: 중앙에 띄움
function schedule_open_modal() {
	const modal = document.getElementById('schedule_event_modal');
	modal.style.display = 'flex';
}



// 모달 닫기
function schedule_close_modal() {
	const modal = document.getElementById('schedule_event_modal');
	modal.style.display = 'none';
}


//날짜 형식을 YYYY-MM-DD HH:MM으로 변환
function schedule_format_date_time(dateTimeStr) {
	var date = new Date(dateTimeStr); // 클라이언트의 시간대
	var year = date.getFullYear();
	var month = (date.getMonth() + 1).toString().padStart(2, '0');
	var day = date.getDate().toString().padStart(2, '0');
	var hours = (date.getHours()).toString().padStart(2, '0');
	var minutes = date.getMinutes().toString().padStart(2, '0');
            
	return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
}

function schedule_format_local(dateString) {
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