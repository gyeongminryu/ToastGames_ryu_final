
function manage_empl_add_row() {

    var content ='';

    content += '<tr id = "row_'+identi_length+'">';
    content += '<td><i class="bi bi-dash-circle-dotted" onclick="tst_modal_call_regist(\'tst_modal_delete\',' + identi_length + ')"></i></td>';

    var col_add_length = document.getElementsByClassName('col_names').length;
    console.log("col_add_length",col_add_length);

    for(var i = 0 ; i<col_add_length;i++){
        //열의 수만큼
        col_name = document.getElementsByClassName('empl_info_input')[i].name;
        console.log(col_name);
        if(col_name==='empl_per_email'){
            content += '<td><input type="email" name="'+col_name+'" value="" required/></td>';
        }else if(col_name === 'empl_pw'){
            content += '<td><input type="password" name="'+col_name+'" value="" required/></td>';
        }else{
            content += '<td><input type="text" name="'+col_name+'" value="" required/></td>';
        }
    }
    content+='</tr>';

    $('#empl_infos').append(content);


    identi_length++;
    //총 열의 개수는 tr 요소의 개수들을 세었음
    var length = document.getElementById('empl_infos').getElementsByTagName('tr').length;

    console.log("length",length);

    $('#count').html('(총 ' + length + '건)');

    console.log("identi_length", identi_length);
}



function tst_modal_call_regist(cls,param) {
    document.getElementsByClassName(cls)[0].style.display = 'flex';

    if(cls=== 'tst_modal_delete'){
        document.getElementById('tst_modal_param').value = param;
    }
    set_modal(cls);
}


function set_modal(cls) {
    //만약 열 삭제 모달이면
    if(cls === 'tst_modal_delete') {
        var value = $('input[name="tst_modal_param"]').val();
        console.log("value", value);

        var row = "row_" + value;
        console.log("row", row);

        var row_element = document.getElementById(row);
        console.log("row_element", row_element);


        //조회한 열 아래에서 input 요소 찾기
        var row_element_input = row_element.querySelector('input[name="empl_name"]');
        console.log("row_element_input", row_element_input.value);

        $('.delete_empl_info h3').html(row_element_input.value);
    }else if(cls === 'tst_modal_insert'){
        var length = document.getElementById('empl_infos').getElementsByTagName('tr').length;
        console.log("length",length);
        $('#cnt').html(length);
    }


}


function manage_empl_row_delete() {

    var param = $('#tst_modal_param').val();

    var row = "row_" + param;

    var row_element = document.getElementById(row);
    console.log("row_element", row_element);

    row_element.remove();


    //총 열의 개수는 tr 요소의 개수들을 세었음
    var length = document.getElementById('empl_infos').getElementsByTagName('tr').length;
    console.log("length",length);

    $('#count').html('(총 ' + length + '건)');

    tst_modal_close('tst_modal_delete');
}
