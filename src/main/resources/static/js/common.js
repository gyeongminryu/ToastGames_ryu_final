function tst_view_profile(no) {
    document.getElementsByClassName('tst_modal_profile_min')[0].style.display = 'flex';
    document.getElementById('tst_modal_employee_idx').value = no;
}

function tst_close_profile() {
    document.getElementsByClassName('tst_modal_profile_min')[0].style.display = 'none';
}