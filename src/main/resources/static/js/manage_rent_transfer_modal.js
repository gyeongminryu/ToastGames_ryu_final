let isDisposed = false;  // true 또는 false 값을 반환하기 위한 변수


function tst_modal_call(cls) {
    document.getElementsByClassName(cls)[0].style.display = 'flex';
}

function tst_modal_call_param(cls, param) {
    document.getElementsByClassName(cls)[0].style.display = 'flex';
    document.getElementById('tst_modal_param').value = param;
}

function tst_modal_close(cls) {
    document.getElementsByClassName(cls)[0].style.display = 'none';
    console.log('현재수정: ' + isDisposed);
}


// 물품 등록 확인 (true 값 반환)
function confirmDispose() {
    isDisposed = true;  // 등록 확인
    tst_modal_close('tst_modal_dispose');  // 모달 닫기
    console.log('등록: ' + isDisposed);  // true 출력 (디버깅 용도)
}

// 물품 등록 취소 (false 값 반환)
function cancelDispose() {
    isDisposed = false;  // 등록 취소
    tst_modal_close('tst_modal_dispose');  // 모달 닫기
    console.log('등록 취소: ' + isDisposed);  // false 출력 (디버깅 용도)
}

// 외부에서 등록 여부 확인
function getDisposeStatus() {
    return isDisposed;
}
