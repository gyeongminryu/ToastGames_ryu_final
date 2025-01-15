function approval_read_file(input){
    console.log(input.files);
    console.log(input.files.file);

    var files = input.files;
    var content ='';
    //var i = 1;
    var form_data = new FormData;

    for (var i = 0; i < files.length; i++) {
        console.log('files',files[i]);
        form_data.append('files', files[i]);  // 'files' 이름이 서버의 파라미터 이름과 일치해야 합니다.
    }

    // FormData에 추가된 내용을 콘솔로 확인하는 방법
    for (var pair of form_data.entries()) {
        console.log("form_data",pair[0]+ ', ' + pair[1]);
    }


approval_file_save(form_data);

}

function approval_file_save(form_data){
    //doc_idx form_data에 저장
    var doc_idx = $('.hidden_doc_idx').val();
    console.log("doc_idx",doc_idx);

    form_data.append('doc_idx',doc_idx);

    // AJAX 요청 (jQuery 사용)
    $.ajax({
        type: 'POST',
        url: '/approval_file_save.ajax', // 파일을 처리할 서버 URL
        data: form_data,
        contentType: false,  // 자동으로 'Content-Type' 헤더를 설정하지 않도록 지정
        processData: false,  // 데이터를 자동으로 쿼리 문자열로 변환하지 않도록 지정
        success: function(data) {
            console.log(data);
            console.log("data.file",data.file);
            content = approval_file_draw(data.file);
            $('#file_preview').html(content);

        },
        error: function(e) {
            console.log(e);
        }
    });
}


function approval_file_draw(files) {
    content ='';
    //html에 추가하기
    for(var file of files) {
        console.log(file);
        console.log(file.ori_filename);
        console.log(file.file_size);

        content += '<tr class="file_box"><td class="td_align_left">' + file.ori_filename + '(' + file.file_size + 'kb)</td><td><button type="button" onclick="approval_delete_file(this,\'' + file.file_idx + '\')" class="btn_primary btn_min">삭제하기</button></td>';
    }

    return content;
}

function approval_delete_file(input,file_idx) {
    //html
    console.log(input);
    input.closest('.file_box').remove();

    //file 삭제
    $.ajax({
        url:'/approval_file_delete.ajax',
        type:'POST',
        data:{'file_idx':file_idx},
        dataType :'JSON',
        success : function(data){
            console.log(data);
        },error : function(e){
            console.log(e);
        }


    })


}