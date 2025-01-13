var editor1 = new RichTextEditor("#div_editor", configViewNone);

window.onload = function initialize(){

    //approval_content_none_edit();
    //doc_content 가져오기
    approval_get_doc_content();
}

//contenteditable = false 처리
//저장될 때 contenteditable = true되니까
/*function approval_content_none_edit(){
    console.log('content_edit 함수 실행');
    var edits= document.querySelectorAll('td[name="edit"]');
    var copy_row= document.querySelectorAll('.copyRow');


    edits.forEach(function (item){
        console.log(item);
        item.setAttribute("contenteditable","false");
        //$('td').attr("contenteditable","true");
    });


    //열추가하는 css 제외하기
    copy_row.forEach(function (item){
        console.log(item);
        item.setAttribute("contenteditable","false");
        //$('td').attr("contenteditable","true");
    });
}*/

function approval_get_doc_content(){
    //리치텍스트에 doc_idx의 html코드 가져와서 뿌리기
    var doc_idx = $('#doc_idx').val();
    console.log('doc_idx:',doc_idx);

    $.ajax({
        type : 'POST',
        url : 'appr_doc_form_content.ajax',
        data : {'doc_idx':doc_idx},
        dataType : 'JSON',
        success : function (data){
            console.log(data.form_content);

            document.getElementById('div_editor_copy').innerHTML = data.form_content;
            setHtmlCode();

        },error : function(e){
            console.log(e);
        }
    })

}