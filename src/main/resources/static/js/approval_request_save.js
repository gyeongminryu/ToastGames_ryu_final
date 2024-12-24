//임시 저장
function approval_write_temporal_save(){
    console.log("임시 저장 함수 실행");
    approval_set_save_data();
}
//저장 함수
function approval_write_save(){
    console.log("save 함수 실행");
    approval_set_save_data();
    //ajax 처리 끝나면 이동
    location.href = "/approval_writing_list.go";
}

//form안에 필요한 값들을 저장 전 세팅해주는 함수
function approval_set_save_data(){

    //현재 시간 구하기
    approval_write_current_date();

    //doc_content_sub ( //보고 내용 (*quill 에디터에 작성한 내용)) -> form에 넣어주기
    const quill_content = quill.getContents();
    console.log(quill_content.ops[0].insert);

    $('input[name="doc_content_sub"]').val(quill_content.ops[0].insert);


    //doc : form 내용 - form에 저장
    var doc_content = $('#form_content').html()
    console.log(doc_content);
    $('input[name="doc_content"]').val(doc_content);


    approval_save_data_send();


}

//작성 일자 및 최종 업데이트 일자 구하고 세팅해주기 위한 함수 -> 저장 혹은 임시 저장 클릭 시에만 작동
function approval_write_current_date(){

    let today = new Date(); //오늘 날짜에 대한 전체 정보

    let year = today.getFullYear();//년도 구하기
    let month = today.getMonth(); //달 구하기
    let date = today.getDate(); // 일 구하기

    let hours = today.getHours();
    let minutes = today.getMinutes();
    let seconds = today.getSeconds();

    //format
    var doc_date= year+'-'+month+'-'+date+ ' ' + hours+':'+minutes+':'+seconds;
    console.log("작성 일자:",doc_date);

    //현재 시간 구한 것 문서 양식에 넣어주기
    $('#doc_date').html(doc_date);

    // 작성 일자 - <form>에 넣기
    $('#hidden_doc_date').val(doc_date);
}

//ajax로 formData 값 보내서 저장하는 것
function approval_save_data_send(){
    //문서 저장
    approval_save_doc();
}

function approval_save_doc(){
    var form = new FormData($('form')[0]);
    $.ajax({
        type : 'POST',
        url : 'approval_doc_write.ajax',
        enctype : 'multipart/form-data',
        processData: false,
        contentType : false,
        data : form,
        dataType : 'JSON',
        success : function(data){
            console.log(data);
        },error : function (e){
            console.log(e);
        }
    });
}


