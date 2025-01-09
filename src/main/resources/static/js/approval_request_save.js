

//임시 저장
function approval_write_temporal_save(){
    console.log("임시 저장 함수 실행");
    approval_set_save_data();
    refer_save_doc();
    return true;
}
//저장 함수
function approval_write_save(){
    console.log("save 함수 실행");
    approval_set_save_data();
    refer_save_doc();
    //ajax 처리 끝나면 이동
    location.href = "/approval_writing_list.go";

}

//form안에 필요한 값들을 저장 전 세팅해주는 함수
function approval_set_save_data(){

    //현재 시간 구하기
    approval_write_current_date();

    //doc_content_sub ( //보고 내용 (*quill 에디터에 작성한 내용)) -> form에 넣어주기
    var doc_content_sub = editor2.getHTMLCode();
    console.log(doc_content_sub);
    $('input[name="doc_content_sub"]').val(doc_content_sub);


    //doc : form 내용 - form에 저장
    var doc_content = editor1.getHTMLCode();
    console.log(doc_content);
    $('input[name="doc_content"]').val(doc_content);


    approval_save_data_send();


}

//작성 일자 및 최종 업데이트 일자 구하고 세팅해주기 위한 함수 -> 저장 혹은 임시 저장 클릭 시에만 작동
function approval_write_current_date(){

    let today = new Date(); //오늘 날짜에 대한 전체 정보

    let year = today.getFullYear();//년도 구하기
    let month = today.getMonth()+1;
    month = month.toString().padStart(2, '0'); //달 구하기 -> 1월 = 0,12월 = 11
    let date = today.getDate().toString().padStart(2, '0'); // 일 구하기

    let hours = today.getHours().toString().padStart(2, '0');
    let minutes = today.getMinutes().toString().padStart(2, '0');
    let seconds = today.getSeconds().toString().padStart(2, '0');

    //format
    var doc_date_time= year+'-'+month+'-'+date+ ' ' + hours+':'+minutes+':'+seconds;

    var doc_date= year+'-'+month+'-'+date;

    console.log("작성 일자:",doc_date);

    //작성하던 코드 copy에 저장
    getHtmlCode();

    //현재 시간 구한 것 copy 문서 양식에 넣어주기
    $('#send_date_left').html(doc_date_time);
    $('#send_date_right').html(doc_date);

    //copy 코드 리치텍스트에 저장
    setHtmlCode();

    // 작성 일자 - <form>에 넣기
    $('#hidden_doc_date').val(doc_date_time);


}

//ajax로 formData 값 보내서 저장하는 것
function approval_save_data_send(){
    //문서 저장
    approval_save_doc();
}

//문서만 저장
function approval_save_doc(){
    console.log("문서 저장 함수 실행");
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
            console.log("문서 저장 성공");

        },error : function (e){
            console.log(e);
        }
    });
}

//문서 기반으로 file 저장



//문서의 참조를 저장 요청하는 함수
function refer_save_doc(){
    console.log("문서 참조 저장 요청");
    var r_empl_line = $('input[name = "r_empl_line"]').map(function(){
        return $(this).val();
    }).get(); //배열
    console.log("r_empl_line",r_empl_line);

    var doc_idx = $('.hidden_doc_idx').val();
    console.log("doc_idx",doc_idx);
    console.log("Object.keys(r_empl_line).length",Object.keys(r_empl_line).length);
    if(Object.keys(r_empl_line).length>0){
        $.ajax({
            type :'POST',
            url:'refer_save_doc.ajax',
            data: JSON.stringify({
                refer_line: r_empl_line,  // r_empl_line 값
                doc_idx: doc_idx        // doc_idx 값 배열
            }),
            contentType: 'application/json',
            dataType: 'JSON',
            success : function (data){
                console.log(data);
            },error : function (e){
                console.log(e);
            }
        });
    }

}
