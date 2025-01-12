function tst_modal_call(cls) {
    document.getElementsByClassName(cls)[0].style.display = 'flex';
}

function tst_modal_call_param(cls, param) {
    document.getElementsByClassName(cls)[0].style.display = 'flex';
    document.getElementById('tst_modal_param').value = param;
}

function tst_modal_close(cls) {
    document.getElementsByClassName(cls)[0].style.display = 'none';
}


//부서별 직원 가져오기
function get_dept_empl(dept_idx) {
	$.ajax({
        type: 'GET',
        url: '/getDeptEmplMeeting.ajax', 
        data: {
        	'dept_idx':dept_idx
        },
        dataType: 'json', 
        success: function(data) {
					console.log(data);
					empl_list(data.emplList);		
        },
        error: function(e) {
            console.log("오류 발생", e);
        }       
    });

}


//팀별 직원 가져오기
function get_team_empl(team_idx) {
	$.ajax({
        type: 'GET',
        url: '/getTeamEmplMeeting.ajax', 
        data: {
        	'team_idx':team_idx
        },
        dataType: 'json', 
        success: function(data) {
					console.log(data);
					empl_list(data.emplList);		
        },
        error: function(e) {
            console.log("오류 발생", e);
        }       
    });

}


function empl_list(emplList) {
    let content = '';

    if (Array.isArray(emplList) && emplList.length > 0) {
        for (let item of emplList) {
        	const itemData = encodeURIComponent(JSON.stringify(item));
            content += '<tr onclick="select_meeting_empl(\'' + itemData + '\')">';
            content += '<td class="td_align_top td_no_padding">';
            content += '<img src="' + (item.profile_img || 'http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png') + '" ';
            content += 'alt="' + item.empl_name + '의 프로필 사진" ';
            content += 'class="approval_profile_image" />';
            content += '</td>';
            content += '<td>';
            content += '<p>' + item.empl_name + ' (' + item.dept_name + '/' + item.position_name + ')</p>';
            content += '<p class="min font_subtle">' + item.duty_name + '</p>';
            content += '</td>';
            content += '</tr>';
        }
    }

    // 결과를 HTML에 삽입
    document.getElementById('empl_list').innerHTML = content;
}


var selectedEmplList = []; // 참석자 정보를 저장하는 배열

//직원선택
function select_meeting_empl(itemData) {
    // JSON 문자열을 객체로 변환
    var item = JSON.parse(decodeURIComponent(itemData));

    // 중복 확인
    var isDuplicate = false;
    for (var i = 0; i < selectedEmplList.length; i++) {
        if (selectedEmplList[i].empl_idx === item.empl_idx) {
            isDuplicate = true;
            break;
        }
    }

    if (!isDuplicate) {
        // 참석자 배열에 추가
        selectedEmplList.push({
            empl_idx: item.empl_idx,
            dept_name: item.dept_name,
            empl_name: item.empl_name,
            position_name: item.position_name,
            duty_name: item.duty_name
        });

        // 테이블 업데이트
        updateMeetingEmplTable();
        updateMeetingEmpl();
    }

    // 모달 닫기
    tst_modal_close('tst_modal_select');
}


function updateMeetingEmplTable() {
    // tbody 선택
    var emplTableBody = document.getElementById('emplTableBody');

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
            '<i class="bi bi-dash-circle-dotted" onclick="removeMeetingEmpl(' +
            i +
            ')"></i>';
        row.appendChild(actionCell);

        emplTableBody.appendChild(row);
    }
}

function removeMeetingEmpl(index) {
    // 해당 인덱스의 참석자를 배열에서 제거
    selectedEmplList.splice(index, 1);

    // 테이블 업데이트
    updateMeetingEmplTable();
}


//인수자 검색
function take_empl_search(event) {
    // 폼 기본 제출 동작 방지
    event.preventDefault();

    // 선택된 옵션 값 가져오기
    const option = document.getElementById('tst_search_select_category').value;

    // 입력된 검색어 가져오기
    const keyword = document.getElementById('search_keyword').value.trim();

    if (!keyword) {
        alert("검색어를 입력하세요.");
        return false;
    }

    // 검색 함수 호출
    empl_search(option, keyword);
    return false; // 폼 제출 방지
}


//검색함수
function empl_search(option, keyword) {
    console.log("검색 실행:", option, keyword);
    // 예: AJAX 요청을 통한 검색 처리
    $.ajax({
        type: 'POST',
        url: '/emplSearchMeeting.ajax',
        data:{
        	'option' : option,
        	'keyword': keyword
        },
        dataType: 'json',
        success: function(data) {
					console.log(data);
					empl_list(data.emplList);
        },
        error: function(e) {
            console.log("오류 발생", e);
        } 
    });
}

function reset_parti() {
	selectedEmplList = [];

	var addRow = document.getElementById('add-participant-row');
    emplTableBody.innerHTML = '';
    emplTableBody.appendChild(addRow);
}

function show_team_list(elem, no){
    elem.parentElement.parentElement.nextElementSibling.classList.remove('disp_hide');
    elem.parentElement.innerHTML = '<i class="bi bi-caret-down-fill" onclick="hide_team_list(this)"></i>';
}

function hide_team_list(elem, no){
    elem.parentElement.parentElement.nextElementSibling.classList.add('disp_hide');
    elem.parentElement.innerHTML = '<i class="bi bi-caret-right-fill" onclick="show_team_list(this)"></i>';
}


function show_second_team_list(elem) {
	console.log(elem);
    // `nextElementSibling`이 부서원 목록을 가리키는지 확인
    let teamListRow = elem.closest("tr").nextElementSibling;

    // 부서원 목록 행의 'disp_hide' 클래스 제거
    if (teamListRow && teamListRow.classList.contains('disp_hide')) {
        teamListRow.classList.remove('disp_hide');
    }

    if(elem.outerHTML === '<td onclick="show_second_team_list(this)" class="tst_pointer">부서</td>'){
		elem.outerHTML = '<td onclick="hide_second_team_list(this)" class="tst_pointer">부서</td>';
    } else{
    	elem.outerHTML = '<td onclick="hide_second_team_list(this)" class="tst_pointer">팀</td>';
    }
}

function hide_second_team_list(elem) {
	console.log(elem);
    // `nextElementSibling`이 부서원 목록을 가리키는지 확인
    let teamListRow = elem.closest("tr").nextElementSibling;

    // 부서원 목록 행에 'disp_hide' 클래스 추가
    if (teamListRow && !teamListRow.classList.contains('disp_hide')) {
        teamListRow.classList.add('disp_hide');
    }
    
    if(elem.outerHTML === '<td onclick="hide_second_team_list(this)" class="tst_pointer">부서</td>'){
		elem.outerHTML = '<td onclick="show_second_team_list(this)" class="tst_pointer">부서</td>';
    }	else{
    	elem.outerHTML = '<td onclick="show_second_team_list(this)" class="tst_pointer">팀</td>';
    }
}


