
let cancel_request = false;

function tst_modal_call(cls) {
    const element = document.getElementsByClassName(cls)[0];
    if (element) {
        element.style.display = 'flex';
    } else {
        console.error(`요소를 찾을 수 없습니다. 클래스명: ${cls}`);
    }
}

function tst_modal_call_param(cls, param) {
    const element = document.getElementsByClassName(cls)[0];
    if (element) {
        element.style.display = 'flex';
    } else {
        console.error(`요소를 찾을 수 없습니다. 클래스명: ${cls}`);
        return;
    }
    
    const paramElement = document.getElementById('tst_modal_param');
    if (paramElement) {
        paramElement.value = param;
    } else {
        console.error("tst_modal_param 요소를 찾을 수 없습니다.");
    }
}

function tst_modal_close(cls) {
    const element = document.getElementsByClassName(cls)[0];
    if (element) {
        element.style.display = 'none';
    } else {
        console.error(`요소를 찾을 수 없습니다. 클래스명: ${cls}`);
    }
    console.log('현재수정: ' + (typeof isUpdated !== 'undefined' ? isUpdated : "isUpdated 미정의"));
}



// 물품 등록 확인 (true 값 반환)
function request_rent() {
    cancel_request = true;  // 등록 확인
    tst_modal_close('tst_modal_cancel');  // 모달 닫기
    console.log('등록: ' + cancel_request);  // true 출력 (디버깅 용도)
}

// 물품 등록 취소 (false 값 반환)
function cancel_rent() {
    cancel_request = false;  // 등록 취소
    tst_modal_close('tst_modal_cancel');  // 모달 닫기
    console.log('등록 취소: ' + cancel_request);  // false 출력 (디버깅 용도)
}

// 외부에서 등록 여부 확인
function getRentStatus() {
    return cancel_request;
}
