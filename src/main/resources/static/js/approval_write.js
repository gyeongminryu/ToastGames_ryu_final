//var editor = new RichTextEditor("#div_editor", config);
window.onload = function initialize(){

    $.ajax({
        type : 'get',
        url : 'approval_doc_get.ajax',
        data : {'doc_idx': doc_idx},
        dataType : 'JSON',
        success : function(data){
            console.log(data);

            console.log(data.doc_content);
            console.log(data.doc_idx);
            console.log(data.empl_name);
            //editor.setHTMLCode(data.form_content);//편집기 안의 HTML code 설정

            //document.getElementById('form_content').innerHTML =data.doc_content;
            $('#form_content').html(data.doc_content);

            //문서 정보란에 1차 정보 기입 (문서번호, 작성자, 부서명* -> 추가예정)
            $('#doc_idx').html(data.doc_idx);
            $('#hidden_doc_idx').val(data.doc_idx);
            $('#doc_write_empl').html(data.empl_name);

            setInterval(approval_write_temporal_save, 10000);
            approval_content_edit();

        },
        error : function(e){
            console.log(e);
        }
    });


}

function approval_write_temporal_save(){
    approval_get_written_data();

}
//저장 함수
function approval_write_save(){
   approval_get_written_data();

    console.log("form_data:",form_data);
}


//최종 작성된 값들을 가져와서 form안, 결재 양식 안에 넣어주는 함수
function approval_get_written_data(){
    //보고 내용 (*quill 에디터에 작성한 내용) - form에 저장
    const quill_content = quill.getContents();
    console.log(quill_content.ops[0]);
    console.log(quill_content.ops[0].insert);

    $('input[name="doc_content_sub"]').val(quill_content.ops[0].insert);

    //form 내용 - form에 저장
    var form_content = $('#form_content').html()
    //console.log(form_content);
    $('input[name="doc_content"]').val(form_content);

    //(작성 일시)현재 시간 js단에서 구하기
    var doc_write_date = approval_write_current_date();
    console.log("작성한 일시:",doc_write_date);
    //작성 일자 - 양식에 넣기
    $('#doc_date').html(doc_write_date);

    //작성 일자 - <form>에 넣기
    $('#hidden_doc_date').val(doc_write_date);
}

/*보고 함수*/
//보고할 때 알럿 로직 필요
//마감 날짜 작성하지 않음 (보고할 때는 마감 날짜가 작성 날짜보다 앞선 날짜면 알럿)
//결재선 설정 안했을 때


//작성 일자 및 최종 업데이트 일자 구하기 위한 함수
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
    return doc_date;
}



