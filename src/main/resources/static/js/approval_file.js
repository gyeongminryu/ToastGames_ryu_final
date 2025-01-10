function approval_read_file(input){
    console.log(input.files);

    var content ='';
    //var i = 1;
    for(var file of input.files) {
        console.log(file);
        console.log(file.name);
        console.log(file.size / 1024);
        var file_size = Math.round(file.size / 1024);//반올림

        content += '<tr class = "file_box"><td class="td_align_left">' + file.name + '(' + file_size + 'kb)</td>';

        //content += '<td><button type="button" data-index="'+i+'" onClick="approval_delete_file(this)" class="btn_primary btn_min">삭제하기</button></td></tr>';
        //i++;
    }
    $('#file_preview').html(content);
}

function approval_delete_file(input){
    console.log(input);
    input.closest('.file_box').remove();

}