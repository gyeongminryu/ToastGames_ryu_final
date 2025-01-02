function show_team_list(elem, no){
    // no: 부서 번호
    let number = "'"+no+"'";
    elem.parentElement.parentElement.nextElementSibling.classList.remove('disp_hide');
    elem.parentElement.innerHTML = '<i class="bi bi-caret-down-fill" onclick="hide_team_list(this, '+number+')"></i>';
}

function hide_team_list(elem, no){
    // no: 부서 번호
    let number = "'"+no+"'";
    elem.parentElement.parentElement.nextElementSibling.classList.add('disp_hide');
    elem.parentElement.innerHTML = '<i class="bi bi-caret-right-fill" onclick="show_team_list(this, '+number+')"></i>';
}

function accessible_filtering_on(elem) {
    elem.classList.add("disp_hide");
    elem.nextElementSibling.classList.remove("disp_hide");
}

function accessible_filtering_off(elem) {
    elem.classList.add("disp_hide");
    elem.previousElementSibling.classList.remove("disp_hide");
}