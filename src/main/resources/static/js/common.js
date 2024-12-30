// 프로필 열기
function tst_view_profile(no) {
    document.getElementsByClassName('tst_modal_profile_min')[0].style.display = 'flex';
    document.getElementById('tst_modal_employee_idx').value = no;
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