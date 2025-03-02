var search = document.getElementById('search');

//console.log(search);
var search_val ='';
search.addEventListener('keyup',function(e){

    if(e.key === 'Enter'){ //keyCode 대신 대체
       /* var search_val = $('#search').val();
        console.log(search_val);*/


        console.log(location.pathname); //hostname(도메인)을 제외한 나머지 주소

        //location.path 기준으로 검색 함수 실행
        switch (location.pathname){
            //결재 양식 찾을 경우
            case '/approval_form_list.go':
                approval_form_search();
                break;
            case '/approval_send_list.go':
                approval_list('sent');
                break;
            case '/approval_received_list.go':
                approval_list('received');
                break;
            case '/approval_writing_list.go':
                approval_list('writing');
                break;
        }
    }
});

//폼 양식 검색 함수
function approval_form_search(){
    search_val = $('#search').val();
    console.log("폼 양식 검색 함수 실행!");
    $.ajax({
        type : 'GET',
        url : 'approval_form_search.ajax',
        data : {'search_val' :search_val},
        dataType : 'JSON',
        success : function (data){
            console.log(data);
            approval_list_form(data.list);
        },error : function(e){
            console.log(e);
        }
    });

}


//내가 보낸 결재 검색 함수
function approval_list(){
    search_val = $('#search').val();
    console.log("내가 보낸 결재 검색 함수 실행!",search_val);
    approval_pageCall(1,search_val,"검색");
}