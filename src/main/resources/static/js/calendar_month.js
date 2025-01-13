function calendar_select_to_radiobtn(elem) {
    switch (elem.value) {
        case '1':
            document.getElementsByName('schedule_type_name')[0].checked = true;
            break;
        case '2':
            document.getElementsByName('schedule_type_name')[1].checked = true;
            break;
        case '3':
            document.getElementsByName('schedule_type_name')[2].checked = true;
            break;
        case '4':
            document.getElementsByName('schedule_type_name')[3].checked = true;
            break;
    }
    calendar.refetchEvents();
}



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

$(function () {
    let calendarEl = $('#calendar')[0];

    calendar = new FullCalendar.Calendar(calendarEl, {
        timeZone: 'local',
        expandRows: true, // 화면에 맞게 높이 재설정
        slotMinTime: '09:00:00', // Day 캘린더에서 시작 시간
        slotMaxTime: '18:00:00', // Day 캘린더에서 종료 시간
        editable: true,
        eventResizableFromStart: true,
        selectable: true, // 달력 일자 드래그 설정 가능
        nowIndicator: true, // 현재 시간 마크
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        locale: 'ko', // 한국어 설정
        headerToolbar: {
            left: 'dayGridMonth,timeGridWeek',
            center: 'prev,title,next',
            right: 'today',
        },
        initialView: 'dayGridMonth',
        slotDuration: '00:30:00', // 시간 슬롯을 30분 단위로 설정
        slotLabelInterval: '00:30:00', // 라벨도 30분 간격으로 설정
        slotLabelFormat: {
            hour: '2-digit', // 시간 두 자리로 표시
            minute: '2-digit', // 분 두 자리로 표시
            hour12: false, // 24시간 형식 사용
        },
        events: function (fetchInfo, successCallback, failureCallback) {
            const schedule_type_name = $('input[name="schedule_type_name"]:checked').val();
            console.log(schedule_type_name);

            $.ajax({
                url: '/getSchedules.do',
                type: 'POST',
                contentType: 'application/json', // JSON 형식으로 요청
                data: JSON.stringify({ schedule_type_name: schedule_type_name }),
                success: function (data) {
                    const events = data.map(function (event) {
                        let color;
                        switch (event.sche_type) {
                            case 1:
                                color = 'green'; // 개인
                                break;
                            case 2:
                                color = 'skyblue'; // 부서
                                break;
                            case 3:
                                color = 'orange'; // 프로젝트
                                break;
                            case 4:
                                color = 'purple'; // 기타
                                break;
                            default:
                                color = 'gray';
                                break;
                        }

                        return {
                            sche_idx: event.sche_idx,
                            title: event.title,
                            start: event.start,
                            end: event.end,
                            description: event.description,
                            sche_type: event.sche_type,
                            parti: event.parti,
                            backgroundColor: color,
                            borderColor: color,
                            allDay: event.allDay,
                            empl: event.empl,
                        };
                    });
                    successCallback(events); // FullCalendar에 일정 데이터 추가
                },
                error: function () {
                    alert('일정 데이터를 불러오는 중 오류가 발생했습니다.');
                    failureCallback();
                },
                
            });
        },
        eventClick: function (info) {
            Alldata = info;
            console.log(Alldata);
			//var sessionEmplIdx = sessionStorage.getItem('empl_idx');  // session에서 empl_idx 가져오기
            const sessionEmplIdx = 10003;

            if (info.event.extendedProps.empl !== sessionEmplIdx) {
                $('#schedule_title_detail').text(info.event.title);
                $('#schedule_start_time_detail').text(schedule_format_date_time(info.event.start));
                $('#schedule_end_time_detail').text(schedule_format_date_time(info.event.end));
                $('#schedule_content_detail').text(info.event.extendedProps.description);

                const scheType = info.event.extendedProps.sche_type;
                const scheduleTypeElement = document.getElementById('schedule_type_detail');

                switch (scheType) {
                    case '1':
                        scheduleTypeElement.innerHTML = '개인 일정';
                        break;
                    case '2':
                        scheduleTypeElement.innerHTML = '부서 일정';
                        break;
                    case '3':
                        scheduleTypeElement.innerHTML = '프로젝트 팀 일정';
                        break;
                    case '4':
                        scheduleTypeElement.innerHTML = '기타 일정';
                        break;
                    default:
                        scheduleTypeElement.innerHTML = '알 수 없는 일정 유형';
                }

                const participants = info.event.extendedProps.parti;
                const participantsContainer = $('#schedule_participants_detail');
                participantsContainer.empty();

                if (Array.isArray(participants) && participants.length > 0) {
                    participants.forEach(function (participant) {
                        const participantElement = `
                            <span onclick="tst_view_profile('${participant.meet_parti_empl_idx}')" 
                                  class="tst_pointer tst_badge_min btn_subtle margin_right">
                                ${participant.empl_name}
                            </span>`;
                        participantsContainer.append(participantElement);
                    });
                } else {
                    participantsContainer.append('<span>참석자가 없습니다.</span>');
                }

                tst_modal_call('tst_modal_detail');
            } else {
                $('#schedule_title_update').val(info.event.title);
                $('#schedule_start_time_update').val(schedule_format_date_time(info.event.start));
                $('#schedule_end_time_update').val(schedule_format_date_time(info.event.end));
                $('#schedule_content_update').val(info.event.extendedProps.description);

                const sche_type = info.event.extendedProps.sche_type;
                const selectElement = document.querySelector('select[name="schedule_type_update"]');
                selectElement.value = sche_type;
                
                updateParticipantsFromEvent(info);

                tst_modal_call('tst_modal_update');
            }
        },
        eventDrop: function (obj) {
            $.ajax({
                url: '/scheduleDrop.do',
                type: 'post',
                contentType: 'application/json',
                data: JSON.stringify({
                    sche_idx: obj.event._def.extendedProps.sche_idx,
                    start: schedule_format_local(obj.event.start),
                    end: schedule_format_local(obj.event.end),
                    allday: obj.event._def.allDay,
                }),
                success: function (data) {
                    console.log(data);
                },
                error: function (xhr, status, error) {
                    console.log(error);
                },
            });
        },
        eventResize: function (obj) {
            $.ajax({
                url: '/scheduleResize.do',
                type: 'post',
                contentType: 'application/json',
                data: JSON.stringify({
                    sche_idx: obj.event._def.extendedProps.sche_idx,
                    start: schedule_format_local(obj.event.start),
                    end: schedule_format_local(obj.event.end),
                    allday: obj.event._def.allDay,
                }),
                success: function (data) {
                    console.log(data);
                },
                error: function (xhr, status, error) {
                    console.log(error);
                },
            });
        },
        select: function (arg) {
        
        	selectedEmplList = [];
            console.log('arg.start:', arg.start);
            console.log('arg.end:', arg.end);
            console.log('arg.allDay:', arg.allDay);

            $('#schedule_title').val('');
            $('#schedule_content').val('');

            if (arg.allDay) {
                $('#schedule_start_time').val(schedule_format_date_time(arg.start));
                $('#schedule_end_time').val(schedule_format_date_time(arg.end));
                $('#schedule_start_time').prop('readonly', true);
                $('#schedule_end_time').prop('readonly', true);
                $('#schedule_allday').prop('checked', true);
            } else {
                $('#schedule_start_time').val(schedule_format_date_time(arg.start));
                $('#schedule_end_time').val(schedule_format_date_time(arg.end));
                $('#schedule_start_time').prop('disabled', false);
                $('#schedule_end_time').prop('disabled', false);
                $('#schedule_allday').prop('checked', false);
            }

            $('#add_schedule').click(function () {
                const title = $('#schedule_title').val();
                const content = $('#schedule_content').val();
                const sche_type = $('select[name="schedule_type"]').val();
                const start = $('#schedule_start_time').val();
                const end = $('#schedule_end_time').val();

                const emplIdx = selectedEmplList.map((empl) => empl.empl_idx);
                const sche_parti = emplIdx;

                console.log('Collected Data:', { title, content, emplIdx, sche_type, start, end, sche_parti });

                if (title && content && emplIdx.length && sche_type) {
                    const scheduleData = {
                        title:title,
                        content:content,
                        sche_type:sche_type,
                        start:start,
                        end:end,
                        allday: arg.allDay,
                        sche_parti:sche_parti,
                    };

                    schedule_add(scheduleData);
                    tst_modal_close('tst_modal_write');
                } else {
                    alert('제목, 내용, 사원번호, 일정 종류를 모두 입력해주세요.');
                }
            });

            tst_modal_call('tst_modal_write');
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
        updateScheduleEmpl();
    }
}


function updateScheduleEmpl() {
    // tbody 선택
    var emplTableBody = document.getElementById('empl_update');

    // 기존 참석자 행 초기화 (버튼 행 제외)
    var addRow = document.getElementById('add-participant-row-update');
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
    updateScheduleEmpl();
}


//일정 추가
function schedule_add(scheduleData) {
        	
	console.log(scheduleData);

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

function schedule_update_modal() {
	const info=Alldata;
	
	const emplIdx = selectedEmplList.map(function (empl) {
		return empl.empl_idx;
	});

	if (confirm('수정하시겠습니까?')) {
	// 수정 로직
	const scheduleData = {
		sche_idx:info.event._def.extendedProps["sche_idx"],
		title: $('#schedule_title_update').val(),
		content: $('#schedule_content_update').val(),
		empl_idx: $('#schedule_empl_idx_update').val(),
		sche_type: $('select[name="schedule_type_update"]').val(),
		start: schedule_format_local($('#schedule_start_time_update').val()),
		end: schedule_format_local($('#schedule_end_time_update').val()),
		allday: info.event.allDay,
		sche_parti: emplIdx
		};
	schedule_update(scheduleData);
	}
	// 모달 닫기
	tst_modal_close('tst_modal_update');
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
function schedule_delete() {
    let sche_idx =Alldata.event.extendedProps.sche_idx;	
	console.log(sche_idx);

	$.ajax({
		url: "/scheduleDelete.do",
		type: "POST",
		contentType: "application/json", // JSON 형식으로 Content-Type 지정
		data:JSON.stringify({ sche_idx: sche_idx }),   //데이터 형식 주의 안넘어가면 바꿔볼것
		success:function(data, textStatus, xhr){
			console.log(data);	
			location.reload();
		},
		error:function(xhr, status, error){
			console.log(error);
		}
	});
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
