// 카테고리 항목 변경시 내용연한 및 사용연수 변경
function change_category(elem) {
    // 카테고리 항목 변경시 내용연한 및 사용연수를 변경하는 함수를 작성해 주세요
}

// 첨부 파일 삭제
function delete_attach(elem, no) {
    elem.parentElement.previousElementSibling.classList.add('font_cancellation');
    elem.parentElement.previousElementSibling.classList.add('font_subtle');
    elem.parentElement.innerHTML = '<button type="button" onclick="delete_cancel(this, \''+no+'\')" class="btn_secondary btn_min">삭제 취소</button>';

    // 첨부 파일 삭제시 작동하는 함수를 하단에 작성해 주세요
}

// 첨부 파일 삭제 취소
function delete_cancel(elem, no) {
    elem.parentElement.previousElementSibling.classList.remove('font_cancellation');
    elem.parentElement.previousElementSibling.classList.remove('font_subtle');
    elem.parentElement.innerHTML = '<button type="button" onclick="delete_attach(this, \''+no+'\')" class="btn_primary btn_min">삭제하기</button>';

    // 첨부 파일 삭제 취소시 작동하는 함수를 하단에 작성해 주세요
}