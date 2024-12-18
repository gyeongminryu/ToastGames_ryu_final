var editor = new RichTextEditor("#div_editor", config);
window.onload = function initialize(){



    $.ajax({
        type : 'get',
        url : 'doc_get.ajax',
        data : {'doc_idx': doc_idx},
        dataType : 'JSON',
        success : function(data){
            console.log(data);
            console.log(data.doc_content);
            //editor.setHTMLCode(data.form_content);//편집기 안의 HTML code 설정

            $('#form_content').html(data.doc_content);
            content_edit();
        },
        error : function(e){
            console.log(e);
        }
    });


}





//richtexteditor 상세 설정
var config = {}
config.toolbar = "default";

config.editorResizeMode="none";

//파일 업로드 시 설정
config.file_upload_handler = function(file,pathReplace){ //파일객체, 경로변경 함수

    console.log(file);

    if(file.size>(2*1024*1024)){
        alert('2MB 이상의 파일은 올릴 수 없습니다.');
        pathReplace('/img/no_image.png');
    }
}