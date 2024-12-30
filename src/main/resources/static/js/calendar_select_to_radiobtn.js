function calendar_select_to_radiobtn(elem) {
    switch (elem.value) {
        case '1':
            document.getElementsByName('schedule_type_name')[0].checked = true;
            break;
        case '2':
            document.getElementsByName('schedule_type_name')[1].checked = true;
            break;
        case '3':
            document.getElementsByName('schedule_type_name')[2].checked = true;
            break;
        case '4':
            document.getElementsByName('schedule_type_name')[3].checked = true;
            break;
    }
    calendar.refetchEvents();
}