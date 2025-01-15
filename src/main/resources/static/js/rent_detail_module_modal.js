function tst_modal_call(cls) {
    document.getElementsByClassName(cls)[0].style.display = 'flex';
}

function tst_modal_call(cls, data) {
    document.getElementsByClassName(cls)[0].style.display = 'flex';

}

function tst_modal_close(cls) {
    document.getElementsByClassName(cls)[0].style.display = 'none';
}

function validateForm(event) {
    // 필드 값을 가져오기
    const prodExpDate = document.getElementById('prod_exp_date').value.trim();
    const prodRentReason = document.getElementById('prod_rent_reason').value.trim();

    // 값 검증
    if (!prodExpDate) {
        alert('반납 예정일을 입력해주세요.');
        return false; // 폼 제출 중단
    }

    if (!prodRentReason) {
        alert('대여 사유를 입력해주세요.');
        return false; // 폼 제출 중단
    }

    // 모든 값이 올바르면 true를 반환 (폼 제출 허용)
    return true;
}
