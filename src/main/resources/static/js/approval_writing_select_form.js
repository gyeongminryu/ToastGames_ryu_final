
//클릭한 양식을 미리보기하기 위해 양식 정보를 가져오는 함수+ no_data에 disp_hide 추가
function approval_data_form_preview(idx) {
    console.log("form_idx", idx);
    document.getElementsByClassName('approval_received_no_data')[0].classList.add('disp_hide');
    //document.getElementsByClassName('html_rendering disp_hide')[0].classList.remove('disp_hide');

    if (idx != 0) {
        $.ajax({
            type: 'GET',
            url: 'approval_form.ajax',
            data: { 'form_idx': idx },
            dataType: 'JSON',
            success: function (data) {
                console.log("form의 정보들", data);
                approval_draw_form_preview(data.form_content, data.form_idx);
            },
            error: function (e) {
                console.log(e);
            }
        });
    } else {
        approval_draw_form_preview('', 0);
    }
}

//클릭한 양식을 미리보기로 띄우는 함수
function approval_draw_form_preview(content, form_idx) {
    var editor = new RichTextEditor("#div_editor", configViewNone);

    console.log("content", content);
    console.log("draw_html_idx", form_idx);
    var button_html = '<tr><td class="td_align_left"><button onClick="location.href=\'/approval_write.go?form_idx=' + form_idx + '\'\" class="btn_primary">문서 양식 선택하기</button></td></tr>';
    // 화면 단에 보이는 값 넣기

    editor.setHTMLCode(content);

    document.getElementById('form_select').innerHTML = document.getElementById('form_select').innerHTML = button_html;

}

//검색으로 조회된 결재 양식들 목록 jsp단에 보여주는 함수
function approval_list_form(datas) {

    var content = '';

    console.log("datas",datas);
    if(datas.length === 0){
        $('.tst_form_list_container').html('');
    }

    for (var data of datas) {
        console.log(data.form_subject); // 분리한 이름 목록에 넣어주기
        console.log(data.form_idx);
        content += '<tr><td class="td_align_left"><a onclick="approval_data_form_preview(' + data.form_idx + ')">' + data.form_subject + '</a></td><td><button onclick="location.href=\'/approval_write.go?form_idx=' + data.form_idx + '\'" class="btn_subtle btn_min">선택하기</button></td></tr>';

        $('.tst_form_list_container').html(content);
    }

    console.log(content);
}



