
//서버에 보낼 값 업뎃
document.addEventListener('DOMContentLoaded', function() {
    const dueDateInput = document.getElementById('due_date_input');
    if (dueDateInput) {
        console.log('due_date_input found:', dueDateInput);
    }
});

//카테고리 변경,내용연수 계산 함수 호출
function change_category_life(selectElement) {
    const selected_option = selectElement.options[selectElement.selectedIndex]; // 선택된 옵션
    const prod_life = parseInt(selected_option.getAttribute('data-prod-life'), 10); // 내용연수 값 가져오기

    if (!isNaN(prod_life)) {
        // 내용연수 표시
        document.getElementById('useful_life').innerText = `내용연수|${prod_life}년`;

        // 사용연한 계산
        const use_date = calculate_use_date(prod_life);

        // 사용연한 표시
        document.getElementById('due_date').innerText = `사용연한|${use_date}`;

        // 숨겨진 필드에 사용연한 값 설정
        const dueDateInput = document.getElementById('due_date_input');
        if (dueDateInput) {
            dueDateInput.value = use_date;
        }
    } else {
        // 초기화
        alert('물품의 카테고리를 선택해주세요');
        document.getElementById('useful_life').innerText = `내용연수|`;
        document.getElementById('due_date').innerText = `사용연한|`;
        const dueDateInput = document.getElementById('due_date_input');
        if (dueDateInput) {
            dueDateInput.value = '';
        }
    }
}

//사용연한 계산
function calculate_use_date(prod_life) {
    const currentDate = new Date(); // 현재 날짜
    currentDate.setDate(currentDate.getDate() + prod_life * 365); // prod_life(년) * 365일 추가
    return currentDate.toISOString().split('T')[0]; // YYYY-MM-DD 형식 반환
}









// 파일 업로드 처리
function handleFileUpload(event) {
    const fileList = event.target.files;  // 선택한 파일들
    const fileTableBody = document.getElementById('fileList');  // 파일 목록을 추가할 tbody

    // 선택한 파일들에 대해 반복문을 돌며 테이블에 추가
    for (let i = 0; i < fileList.length; i++) {
        const file = fileList[i];
        
        // 파일 정보 표시 및 삭제 버튼 추가
        const newRow = document.createElement('tr');
        newRow.innerHTML = `
            <td class="td_align_left">${file.name} (${Math.round(file.size / 1024)} KB)</td>
            <td>
                <button type="button" onclick="delete_attach(this, '${file.name}')" class="btn_primary btn_min">삭제하기</button>
            </td>
        `;
        
        // 파일 목록에 추가
        fileTableBody.appendChild(newRow);
    }
}

// 파일 삭제
function delete_attach(elem, fileName) {
    const row = elem.closest('tr');  // 현재 행 (삭제 버튼이 있는 행)
    row.querySelector('td:first-child').classList.add('font_cancellation');
    row.querySelector('td:first-child').classList.add('font_subtle');
    
    // 삭제 취소 버튼으로 변경
    row.querySelector('td:last-child').innerHTML = `
        <button type="button" onclick="delete_cancel(this, '${fileName}')" class="btn_secondary btn_min">삭제 취소</button>
    `;

    // 삭제할 파일을 추가로 처리할 경우 여기에 추가 처리 코드를 작성
    console.log(`${fileName} 파일 삭제됨`);
}

// 파일 삭제 취소
function delete_cancel(elem, fileName) {
    const row = elem.closest('tr');  // 현재 행 (삭제 취소 버튼이 있는 행)
    row.querySelector('td:first-child').classList.remove('font_cancellation');
    row.querySelector('td:first-child').classList.remove('font_subtle');
    
    // 삭제 버튼으로 돌아가게 변경
    row.querySelector('td:last-child').innerHTML = `
        <button type="button" onclick="delete_attach(this, '${fileName}')" class="btn_primary btn_min">삭제하기</button>
    `;
    
    // 취소된 파일 처리 (실제 서버로 전달하지 않도록 할 수 있음)
    console.log(`${fileName} 파일 삭제 취소됨`);
}


