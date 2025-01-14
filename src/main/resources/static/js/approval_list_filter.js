

//탭 클릭 시 조회 + 선택한 탭으로 색 바뀌는 함수
//탭 및 검색 기능 사용 시에
function approval_list_filter(filter,type,list_type,evt){
    console.log('filter',filter);
    console.log('type',type);

    if(list_type === 'sent'){
        location.href = '/approval_send_list.go?filter=' + filter + '&type=' + type;
    }else if(list_type==='received'){
        location.href = '/approval_received_list.go?filter=' + filter + '&type=' + type;
    }else if(list_type==='writing'){
        location.href = '/approval_writing_list.go?filter=' + filter + '&type=' + type;
    }
}


