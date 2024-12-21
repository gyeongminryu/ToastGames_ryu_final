function rent_available_filtering_on(elem) {
    elem.classList.add("disp_hide");
    elem.nextElementSibling.classList.remove("disp_hide");
}

function rent_available_filtering_off(elem) {
    elem.classList.add("disp_hide");
    elem.previousElementSibling.classList.remove("disp_hide");
}