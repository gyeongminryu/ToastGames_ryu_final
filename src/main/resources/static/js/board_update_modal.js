function submitForm() {
    var deptSelect = document.getElementById('deptFilter'); // 부서
    var typeSelect = document.getElementById('typeFilter'); // 유형
    var deptValue = deptSelect.value;
    var typeValue = typeSelect.value;

    var titleInput = document.querySelector('input[name="board_title"]'); // 제목
    var contentTextarea = document.querySelector('textarea[name="board_content"]'); // 내용
    var titleValue = titleInput.value.trim();
    var contentValue = contentTextarea.value.trim();

    // 필수 입력값 검사 및 유효성 검사
    if (deptValue === "") {
        alert("부서를 선택하세요.");
        deptSelect.focus(); // 부서 셀렉트박스에 포커스 이동
        tst_modal_close('tst_modal_write');
        return false; // 폼 제출을 막음
    }

    if (typeValue === "") {
        alert("유형을 선택하세요.");
        typeSelect.focus(); // 유형 셀렉트박스에 포커스 이동
        tst_modal_close('tst_modal_write');
        return false; // 폼 제출을 막음
    }
    
    if (titleValue === "") {
        alert("제목을 입력하세요.");
        titleInput.focus(); // 제목 입력창에 포커스 이동
        tst_modal_close('tst_modal_write');      
        return false; // 폼 제출을 막음
    }

    if (contentValue === "") {
        alert("내용을 입력하세요.");
        contentTextarea.focus(); // 내용 입력창에 포커스 이동
        tst_modal_close('tst_modal_write');
        return false; // 폼 제출을 막음
    }
    
    // 모든 항목이 정상이라면 폼을 제출
    document.forms[0].submit(); // 폼 제출
}
