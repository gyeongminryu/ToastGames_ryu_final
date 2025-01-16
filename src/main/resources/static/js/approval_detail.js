var editor1 = new RichTextEditor("#div_editor", configViewNone);

window.onload = function initialize(){

    //approval_content_none_edit();
    //doc_content 가져오기
    approval_get_doc_content();
    approval_get_stamp();
}


function approval_get_stamp(){
    //결재자의 empl_idx 전달
    var approval_empl_idx = $('#empl_idx').val();
    $.ajax({
        type : 'POST',
        url : '/approval_get_stamp.ajax',
        data : {'approval_empl_idx':approval_empl_idx},
        dataType: 'JSON',
        success : function(data){
            console.log(data);
            console.log(data.stamp);
            document.getElementById('sign_preview').src = data.stamp;

        },error : function(e){
            console.log(e);
        }
    })
}


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