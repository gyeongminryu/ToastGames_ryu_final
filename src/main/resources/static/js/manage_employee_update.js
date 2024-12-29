// 성별에 따른 화면 출력
scan_gender();

function scan_gender() {
    let gender = document.getElementsByName('gender')[0].value;
    switch (gender) {
        case '0':
            document.getElementsByClassName('gender_0')[0].classList.remove('btn_empty');
            document.getElementsByClassName('gender_0')[0].classList.add('btn_subtle');
            document.getElementsByClassName('gender_1')[0].classList.remove('btn_subtle');
            document.getElementsByClassName('gender_1')[0].classList.add('btn_empty');
            break;
        default:
            document.getElementsByClassName('gender_0')[0].classList.remove('btn_subtle');
            document.getElementsByClassName('gender_0')[0].classList.add('btn_empty');
            document.getElementsByClassName('gender_1')[0].classList.remove('btn_empty');
            document.getElementsByClassName('gender_1')[0].classList.add('btn_subtle');
            break;
    }
}

function select_gender(gender) {
    let gender_select = gender;
    document.getElementsByName('gender')[0].value = gender_select;
    scan_gender();
}

// 직인 파일 입력시 이미지 미리보기
function img_preview(elem) {
    // 이미지 id는 'employee_stamp'입니다.
}