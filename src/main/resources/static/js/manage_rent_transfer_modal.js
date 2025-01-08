let isTransfer = false;  // true 또는 false 값을 반환하기 위한 변수

//부서 가져오기
function get_dept() {
	$.ajax({
        type: 'GET',
        url: '/getDeptList.ajax', 
        dataType: 'json', 
        success: function(data) {
					console.log(data);
					dept_list(data.deptList);	
					team_list(data.teamList);		
        },
        error: function(e) {
            console.log("오류 발생", e);
        }       
    });
}



function dept_list(deptList) {
    var deptContent = '';  // 부서 목록을 추가할 문자열 변수

    // deptList가 배열인지 확인하고, 길이가 0보다 큰 경우에만 진행
    if (Array.isArray(deptList) && deptList.length > 0) {
        for (var dept of deptList) {
            deptContent += '<tr>';
            deptContent += '<td onclick="get_dept_empl()">' + dept.dept_name + '</td>';
            deptContent += '</tr>';
        }
    } 

    $('#get_dept').html(deptContent);
}


//부서별 직원 가져오기
function get_dept_empl() {


}

//팀 가져오기
function get_team_empl(){


}

//팀별 직원 가져오기
function get_team_empl() {


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
