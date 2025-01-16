window.onload = function initialize(){
    console.log("filter",filter);
    var class_name = '';

    if(filter!='전체'){

        $('.tst_tablist_item_active').removeClass('tst_tablist_item_active');

        switch (filter){
            case '읽지 않음':
            case '결재 대기':
                class_name = '.unread'
                break;

            case '결재중':
            case '결재 진행':
                class_name = '.continue';
                break;

            case '승인':
            case '최종 승인':
                class_name = '.approved';
                break;

            case '반려':
                class_name = '.reject';
                break;

        }
            $(class_name).addClass('tst_tablist_item_active');

    }

   /* if(filter === '전체'){
        class_name = '.all'

    }else if(filter ==='읽지 않음'|| filter === '결재 대기'){
        $('.tst_tablist_item_active').removeClass('tst_tablist_item_active');
        class_name = '.unread'
    }else if(filter ==='결재중'|| filter === '결재 진행'){
        $('.tst_tablist_item_active').removeClass('tst_tablist_item_active');
        class_name = '.continue';
    }else if(filter==='승인'|| filter === '최종 승인'){
        $('.tst_tablist_item_active').removeClass('tst_tablist_item_active');
        class_name = '.approved';
    }else if(filter === '반려'){
        $('.tst_tablist_item_active').removeClass('tst_tablist_item_active');
        class_name = '.reject';
    }

    $(class_name).addClass('tst_tablist_item_active');*/
}

//탭 클릭 시 조회 + 선택한 탭으로 색 바뀌는 함수
//탭 및 검색 기능 사용 시에
function approval_list_filter(filter,type,list_type,evt){


    console.log('filter',filter);
    console.log('type',type);

    if(list_type === 'sent'){
        location.href = '/approval_send_list.go?filter=' + filter + '&type=' + type;
        if(filter==='전체'){
            location.href='/approval_send_list.go';
        }

    }else if(list_type==='received'){
        location.href = '/approval_received_list.go?filter=' + filter + '&type=' + type;
        if(filter==='전체'){
            location.href='/approval_received_list.go';
        }
    }else if(list_type==='writing') {
        location.href = '/approval_writing_list.go?filter=' + filter + '&type=' + type;
    }

    //탭 색깔 바꾸기
    document.getElementsByClassName('tst_tablist_item_active')[0].classList.remove('tst_tablist_item_active');
    $(this).addClass('tst_tablist_item_active');
}