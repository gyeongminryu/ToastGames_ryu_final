


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




