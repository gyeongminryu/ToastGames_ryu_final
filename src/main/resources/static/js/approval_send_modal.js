function select_type(type){
    switch (type) {
        case 'sign':
            document.getElementsByClassName('sign_area')[0].style.display = 'block';
            document.getElementsByClassName('stamp_area')[0].style.display = 'none';
            document.getElementsByClassName('item_sign')[0].classList.add('tst_tablist_item_active');
            document.getElementsByClassName('item_stamp')[0].classList.remove('tst_tablist_item_active');
            break;
        case 'stamp':
            document.getElementsByClassName('sign_area')[0].style.display = 'none';
            document.getElementsByClassName('stamp_area')[0].style.display = 'flex';
            document.getElementsByClassName('item_sign')[0].classList.remove('tst_tablist_item_active');
            document.getElementsByClassName('item_stamp')[0].classList.add('tst_tablist_item_active');
            break;
    }
}

function show_team_list(elem, no){
    // no는 원하는대로 변경하시면 됩니다.
    elem.parentElement.parentElement.nextElementSibling.classList.remove('disp_hide');
    elem.parentElement.innerHTML = '<i class="bi bi-caret-down-fill" onclick="hide_team_list(this, \'부서번호\')"></i>';
}

function hide_team_list(elem, no){
    // no는 원하는대로 변경하시면 됩니다.
    elem.parentElement.parentElement.nextElementSibling.classList.add('disp_hide');
    elem.parentElement.innerHTML = '<i class="bi bi-caret-right-fill" onclick="show_team_list(this, \'부서번호\')"></i>';
}