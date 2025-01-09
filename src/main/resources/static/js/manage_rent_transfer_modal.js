let isTransfer = false;  // true 또는 false 값을 반환하기 위한 변수


//부서별 직원 가져오기
function get_dept_empl(dept_idx) {
	$.ajax({
        type: 'GET',
        url: '/getDeptEmpl.ajax', 
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
        url: '/getTeamEmpl.ajax', 
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
            content += '<tr onclick="select_transfer_empl(\'' + itemData + '\')">';
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

var take_empl ='';
//직원선택
function select_transfer_empl(itemData) {
    // JSON 문자열을 객체로 파싱
    const item = JSON.parse(decodeURIComponent(itemData));

    // <input> 필드에 값 설정
    take_empl = item.empl_name + ' (' + item.dept_name + '/' + item.position_name + ')';
    // <input> 필드에 값 설정
    document.getElementById('take_empl_idx').value = take_empl;
    document.getElementById('take_empl_idx').setAttribute('data-empl-idx', item.empl_idx);
	tst_modal_close('tst_modal_select');

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
        url: '/takeEmplSearch.ajax',
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




// 물품 등록 확인 (true 값 반환)
function confirmTransfer() {
    isTransfer = true;  // 등록 확인
    tst_modal_close('tst_modal_transfer');  // 모달 닫기
    console.log('등록: ' + isTransfer);  // true 출력 (디버깅 용도)
}

// 물품 등록 취소 (false 값 반환)
function cancelTransfer() {
    isTransfer = false;  // 등록 취소
    tst_modal_close('tst_modal_transfer');  // 모달 닫기
    console.log('등록 취소: ' + isTransfer);  // false 출력 (디버깅 용도)
}

// 외부에서 등록 여부 확인
function getTransferStatus() {
    return isTransfer;
}
