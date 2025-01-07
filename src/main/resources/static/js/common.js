// 프로필 열기
function tst_view_profile(no) {
	console.log("제대로 넘어왔니? " + no);
    document.getElementsByClassName('tst_modal_profile_min')[0].style.display = 'flex';
    document.getElementById('tst_modal_employee_idx').value = no;

    // XMLHttpRequest 생성
    var xhr = new XMLHttpRequest();
    // GET 방식으로 요청할 때, URL에 파라미터를 추가
    xhr.open("GET", "profileDetail?tst_modal_employee_idx=" + no, true);  // URL에 파라미터를 추가하여 GET 요청 보내기
    xhr.setRequestHeader("Accept", "application/json");  // 응답 형식 설정

    // 서버로부터 데이터를 받은 후 모달 내용 업데이트
    xhr.onload = function() {
        if (xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            // 서버 응답에 따라 모달 내용 업데이트
            document.querySelector(".topnav_modal_profile_image").src = "memberFiles/" + response.empl_profile;
            document.querySelector("#empl_name").textContent = response.empl_name;
            document.querySelector("#dept_name").textContent = response.dept_name;
            document.querySelector("#duty_name").textContent = response.duty_name || '미정';
            document.querySelector("#empl_cmp_phone").textContent = response.empl_cmp_phone;
            document.querySelector("#empl_cmp_email").textContent = response.empl_cmp_email;
        } else {
            console.error("서버에서 오류 발생:", xhr.statusText);
        }
    };

    // 요청 보내기
    xhr.send();
}


// 프로필 닫기
function tst_close_profile() {
    document.getElementsByClassName('tst_modal_profile_min')[0].style.display = 'none';
}



// 알림창 열기
function tst_view_alertlist() {
    document.getElementsByClassName('tst_offcanvas_alert_list')[0].style.display = 'flex';
    document.getElementsByTagName('body')[0].style.overflow = 'hidden';
}

// 알림창 닫기
function tst_close_alertlist() {
    document.getElementsByClassName('tst_offcanvas_alert_list')[0].style.display = 'none';
    document.getElementsByTagName('body')[0].style.overflow = 'auto';
}