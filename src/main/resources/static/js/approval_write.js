//var editor = new RichTextEditor("#div_editor", config);
window.onload = function initialize(){

    $.ajax({
        type : 'get',
        url : 'doc_get.ajax',
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
            $('#hidden_doc_idx').html(data.doc_idx);


            $('#doc_write_empl').html(data.empl_name);



            approval_content_edit();

        },
        error : function(e){
            console.log(e);
        }
    });


}


function approval_write_save(){

    //결재 잘못 작성했을 때 알럿
    approval_write_save_alert();

    //보고 내용 (*quill 에디터에 작성한 내용) - form에 저장
    const quill_content = quill.getContents();
    console.log(quill_content.ops[0]);
    console.log(quill_content.ops[0].insert);

    $('input[name="content"]').val(quill_content.ops[0].insert);

    //form 내용 - form에 저장
    var form_content = $('#form_content').html()
    //console.log(form_content);
    $('input[name="form_content"]').val(form_content);
    $('form').submit();
}


function approval_write_save_alert(){
    //만약 결재 마감일이 작성일보다
}