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

    if (Array.isArray(employeeList) && employeeList.length > 0) {
        for (let item of employeeList) {
            content += '<tr onclick="select_transfer_empl(' + item.empl_idx + ')">';
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











//직원선택
function select_transfer_empl(empl_idx){

}







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



function select_type(type){
    switch (type) {
        case 'sign':
            document.getElementsByClassName('sign_area')[0].style.display = 'block';
            document.getElementsByClassName('stamp_area')[0].style.display = 'none';
            document.getElementsByClassName('item_sign')[0].classList.add('tst_tablist_item_active');
            document.getElementsByClassName('item_stamp')[0].classList.remove('tst_tablist_item_active');
            break;
        case 'stamp':
            document.getElementsByClassName('sign_area')[0].style.display = 'none';
            document.getElementsByClassName('stamp_area')[0].style.display = 'flex';
            document.getElementsByClassName('item_sign')[0].classList.remove('tst_tablist_item_active');
            document.getElementsByClassName('item_stamp')[0].classList.add('tst_tablist_item_active');
            break;
    }
}

function show_team_list(elem, no){
    // no: 부서 번호
    let number = "'"+no+"'";
    elem.parentElement.parentElement.nextElementSibling.classList.remove('disp_hide');
    elem.parentElement.innerHTML = '<i class="bi bi-caret-down-fill" onclick="hide_team_list(this, '+number+')"></i>';
}

function hide_team_list(elem, no){
    // no: 부서 번호
    let number = "'"+no+"'";
    elem.parentElement.parentElement.nextElementSibling.classList.add('disp_hide');
    elem.parentElement.innerHTML = '<i class="bi bi-caret-right-fill" onclick="show_team_list(this, '+number+')"></i>';
}


// 물품 등록 확인 (true 값 반환)
function confirmTransfer() {
    isTransfer = true;  // 등록 확인
    tst_modal_close('tst_modal_dispose');  // 모달 닫기
    console.log('등록: ' + isTransfer);  // true 출력 (디버깅 용도)
}

// 물품 등록 취소 (false 값 반환)
function cancelTransfer() {
    isTransfer = false;  // 등록 취소
    tst_modal_close('tst_modal_dispose');  // 모달 닫기
    console.log('등록 취소: ' + isTransfer);  // false 출력 (디버깅 용도)
}

// 외부에서 등록 여부 확인
function getTransferStatus() {
    return isTransfer;
}
