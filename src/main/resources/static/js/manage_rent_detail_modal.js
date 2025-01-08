let isConfirmed = false;  // true 또는 false 값을 반환하기 위한 변수
let isReturned = false;

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




// 물품 등록 확인 (true 값 반환)
function confirmRegistration() {
    isConfirmed = true;  // 등록 확인
    tst_modal_close('tst_modal_rent');  // 모달 닫기
    console.log('등록: ' + isConfirmed);  // true 출력 (디버깅 용도)
}

// 물품 등록 취소 (false 값 반환)
function cancelRegistration() {
    isConfirmed = false;  // 등록 취소
    tst_modal_close('tst_modal_rent');  // 모달 닫기
    console.log('등록 취소: ' + isConfirmed);  // false 출력 (디버깅 용도)
}

// 외부에서 등록 여부 확인
function getConfirmationStatus() {
    return isConfirmed;
}





//반납 확인 (true 값 반환)
function confirmReturn() {
    isReturned = true;  // 등록 확인
    tst_modal_close('tst_modal_return');  // 모달 닫기
    console.log('등록: ' + isReturned);  // true 출력 (디버깅 용도)
}

// 반납 취소 (false 값 반환)
function cancelReturn() {
    isReturned = false;  // 등록 취소
    tst_modal_close('tst_modal_return');  // 모달 닫기
    console.log('등록 취소: ' + isReturned);  // false 출력 (디버깅 용도)
}

// 외부에서 반납 여부 확인
function getReturnStatus() {
    return isReturned;
}
