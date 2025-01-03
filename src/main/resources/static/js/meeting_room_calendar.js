const filter = document.getElementById('meeting_only_mine');

show_filtering_state();

function show_filtering_state() {
    calendar.refetchEvents();
    if (filter.checked) {
        document.getElementsByClassName('tst_filtering_off')[0].classList.add('disp_hide');
        document.getElementsByClassName('tst_filtering_on')[0].classList.remove('disp_hide');
    } else {
        document.getElementsByClassName('tst_filtering_off')[0].classList.remove('disp_hide');
        document.getElementsByClassName('tst_filtering_on')[0].classList.add('disp_hide');
    }
}

function filtering_on() {
    filter.checked = true;
    show_filtering_state();
}

function filtering_off() {
    filter.checked = false;
    show_filtering_state();
}






