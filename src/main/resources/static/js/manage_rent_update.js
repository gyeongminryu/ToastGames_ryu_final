












// 카테고리 항목 변경시 내용연한 및 사용연수 변경
function change_category_life(selectElement) {
    const selected_option = selectElement.options[selectElement.selectedIndex]; // 선택된 옵션
    const prod_life = parseInt(selected_option.getAttribute('data-prod-life'), 10); // 내용연수 값 가져오기

    if (!isNaN(prod_life)) {
        // 내용연수 표시
        document.getElementById('useful_life').innerText = `내용연수|${prod_life}년`;

        // 사용연한 계산
        use_date = calculate_use_date(prod_life);

        // 사용연한 표시
        document.getElementById('due_date').innerText = `사용연한|${use_date}`;

    } else {
        // 초기화
        alert('물품의 카테고리를 선택해주세요');
        document.getElementById('useful_life').innerText = `내용연수|`;
        document.getElementById('due_date').innerText = `사용연한|`;

    }
}


//사용연한 계산
function calculate_use_date(prod_life) {
    const currentDate = new Date(); // 현재 날짜
    currentDate.setDate(currentDate.getDate() + prod_life * 365); // prod_life(년) * 365일 추가
    return currentDate.toISOString().split('T')[0]; // YYYY-MM-DD 형식 반환
}

// 첨부 파일 삭제
/*function delete_attach(elem, no) {
    elem.parentElement.previousElementSibling.classList.add('font_cancellation');
    elem.parentElement.previousElementSibling.classList.add('font_subtle');
    elem.parentElement.innerHTML = '<button type="button" onclick="delete_cancel(this, \''+no+'\')" class="btn_secondary btn_min">삭제 취소</button>';

}*/
    // 첨부 파일 삭제시 작동하는 함수를 하단에 작성해 주세요

// 첨부 파일 삭제 취소
/*function delete_cancel(elem, no) {
    elem.parentElement.previousElementSibling.classList.remove('font_cancellation');
    elem.parentElement.previousElementSibling.classList.remove('font_subtle');
    elem.parentElement.innerHTML = '<button type="button" onclick="delete_attach(this, \''+no+'\')" class="btn_primary btn_min">삭제하기</button>';

}*/
    // 첨부 파일 삭제 취소시 작동하는 함수를 하단에 작성해 주세요





// 업로드된 파일 관리 배열
var uploadedFiles = [];

// 파일 업로드 처리
function file_upload(event) {
    var file_list = event.target.files;
    var fileTableBody = document.getElementById('file_list');

    for (var i = 0; i < file_list.length; i++) {
        var file = file_list[i];

        // 파일 크기가 0인지 확인
        if (file.size === 0) {
            console.warn(file.name + " 파일 크기가 0입니다. 업로드하지 않습니다.");
            continue;
        }

        // 이미 업로드된 파일인지 확인
        if (uploadedFiles.some(function (item) { return item.file.name === file.name; })) {
            console.log(file.name + " 파일이 이미 목록에 있습니다.");
            continue;
        }

        uploadedFiles.push({ file: file, deleted: false });

        // 파일 목록 UI 업데이트
        var newRow = document.createElement('tr');
        newRow.innerHTML = `
            <td class="td_align_left">${file.name} (${Math.round(file.size / 1024)} KB)</td>
            <td>
                <button type="button" onclick="delete_attach(this, '${file.name}')" class="btn_primary btn_min">삭제하기</button>
            </td>
        `;
        fileTableBody.appendChild(newRow);
    }

    event.target.value = ''; // 파일 선택 초기화
}



document.getElementById("product_update_button").addEventListener("click", function () {
    if (getConfirmationStatus()) {
        submitUpdateForm();
    } else {
        alert("수정이 취소되었습니다. 다시 시도해주세요.");
    }
});




// 폼 제출 처리 (삭제되지 않은 파일만 전송)
function submitUpdateForm() {

    var form = document.querySelector("form[action='productUpdate.do']");
    var formData = new FormData(form);
    
    // use_date 확인 (빈 값 또는 undefined 아닌지 확인)
    if (!use_date) {
        console.error("use_date 값이 설정되지 않았습니다.");
        return;
    }

    // 'due_date' 추가
    formData.append('due_date', use_date);

    // 삭제되지 않은 파일만 추가
    uploadedFiles.forEach(function (item) {
        if (!item.deleted) {
            formData.append('attached_file', item.file);
        }
    });
    
        // FormData에 파일이 없는 경우 처리
    if (formData.getAll('attached_file').length === 0) {
        console.warn("첨부된 파일이 없습니다.");
    }

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/productAdd.do", true);

    // 응답 형식을 JSON으로 설정
    xhr.responseType = 'json';
    
	xhr.onload = function() {
	    if (xhr.status === 200) {
	        var response = xhr.response;
	        if (response.status === "success") {
	            // 리다이렉트 수행
	            window.location.href = response.redirectUrl;
	        } else {
	            console.error(response.message);
	        }
	    } else {
	        console.error('Error:', xhr.statusText);
	    }
	};

    // 폼 데이터를 서버로 전송
    xhr.send(formData);
}