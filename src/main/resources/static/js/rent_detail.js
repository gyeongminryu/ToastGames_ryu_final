var isRequesting = false;  // 요청 중인지 확인하는 변수

window.onload = function() {
  const prod_idx = document.getElementById('prod_idx') ? document.getElementById('prod_idx').innerText : null;

  // prod_idx 값이 유효한지 체크
  if (!prod_idx) {
    console.error('제품 번호(prod_idx)가 유효하지 않습니다.');
    return;  // prod_idx가 유효하지 않으면 더 이상 진행하지 않음
  }

  // 값 출력
  console.log('제품 번호:', prod_idx);

  // 대여 상태 요청 호출
  resource_state(prod_idx);
};

// 대여 상태 함수
function resource_state(prod_idx) {
    if (isRequesting) return;  // 이미 요청 중이면 다시 호출하지 않음
    isRequesting = true;  // 요청 시작

    $.ajax({
        type: 'GET',
        url: '/prodRentDetail.ajax', 
        data: { 'prod_idx': prod_idx },
        dataType: 'json', 
        success: function(data) {
            console.log(data);
            resource_print(data);  // 데이터 출력 함수 호출
        },
        error: function(e) {
            console.log("오류 발생", e);
        },
        complete: function() {
            isRequesting = false;  // 요청 완료 후 상태 리셋
        }
    });
}

// 대여 상태 출력 함수
function resource_print(item) {
    console.log("Received:", item);
    var content = '';

    // 대여 가능 여부 확인
    if (item.prod_rent === 1) { // 대여 가능
        content += '<tr>';
        content += '<th>대여 가능 여부</th>';
        content += '<td>' + item.prod_rent_str + '</td>';
        content += '</tr>';
        content += '<tr>';
        content += '<th>대여 상태</th>';
        content += '<td>' + item.prod_rent_str + '</td>';
        content += '</tr>';
        content += '<tr>';
        content += '<th>반납 예정일</th>';
        content += '<td>' + (item.prod_exp_date == null ? '없음' : formatDateTime(item.prod_exp_date)) + '</td>';
        content += '</tr>';
        content += '<tr>';
        content += '<th colspan="2" class="td_align_center td_bg_subtle">대여 장소는 ' + item.prod_place + ' 입니다.</th>';
        content += '</tr>';
    } else if (item.prod_rent !== 1) {  // 대여 불가인 경우
        content += '<tr>';
        content += '<th>대여 가능 여부</th>';
        content += '<td>대여 불가</td>';
        content += '</tr>';

        if (item.prod_rent_str === "대여 신청중") {
            content += '<tr>';
            content += '<th>대여 상태</th>';
            content += '<td>대여 신청중</td>';
            content += '</tr>';
        } else if (item.prod_rent_str === "대여중") {
            content += '<tr>';
            content += '<th>대여 상태</th>';
            content += '<td>대여중 (' + formatDateTime(item.prod_rent_date) + '부터)</td>';
            content += '</tr>';
        } else if (item.prod_rent_str === "대여 불가") {
            content += '<tr>';
            content += '<th>대여 상태</th>';
            content += '<td>폐기 예정</td>';
            content += '</tr>';
        }

        content += '<tr>';
        content += '<th>반납 예정일</th>';
        content += '<td>' + (item.prod_exp_date == null ? '없음' : formatDateTime(item.prod_exp_date)) + '</td>';
        content += '</tr>';
        content += '<tr>';
        content += '<th colspan="2" class="td_align_center td_bg_subtle disp_hide">대여 장소는 ' + item.prod_place + ' 입니다.</th>';
        content += '</tr>';
    }

    // HTML 업데이트
    document.getElementById('product_state').innerHTML = content;

    // 버튼 표시/숨기기
    const rentRequestButton = document.getElementById("rent_request_button");
    if (rentRequestButton) {
        if (item.prod_rent === 1) {
            rentRequestButton.style.display = "flex"; // 버튼 보이기
        } else {
            rentRequestButton.style.display = "none"; // 버튼 숨기기
        }
    }
}





//날짜 형식 바꾸기
function formatDateTime(dateTimeStr) {
    var date = new Date(dateTimeStr);

    // 년, 월, 일 추출
    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString().padStart(2, '0');
    var day = date.getDate().toString().padStart(2, '0');

    // 시간, 분 추출
    var hours = date.getHours().toString().padStart(2, '0');
    var minutes = date.getMinutes().toString().padStart(2, '0');

    // 원하는 형식으로 반환
    return `${year}-${month}-${day} ${hours}:${minutes}`;
}
