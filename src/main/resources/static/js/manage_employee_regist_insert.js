function manage_empl_add_row() {

  /*  var content = '<tr id = "row_'+identi_length+'">';

        content += $('#empl_infos tr').html();
        content+= '</tr>';
    console.log(content);
    $('#empl_infos').append(content);
*/

    var content ='';
    content += '<tr id = "row_"+identi_length>';
    content += '<td><i class="bi bi-dash-circle-dotted" onclick="tst_modal_call_regist(\'tst_modal_delete\',' + identi_length + ')"></i></td>';

    for(var i = 0 ; i<col_length;i++){
        //열의 수만큼
        col_name = document.getElementsByClassName('empl_info_input')[i].name;
        console.log(col_name);
        content += '<td><input type="text" name="'+col_name+'" value=""/></td>'
        content+='</tr>';
    }

    $('#empl_infos').append(content);

    /* '<tr id = "row_"+identi_length>'
    '<td><i class="bi bi-dash-circle-dotted" onclick="tst_modal_call_regist(\'tst_modal_delete\',' + identi_length + ')"></i></td>';
    <td><input type="text" name="${entry.key}" value="${entry.value}"/></td>
    <td><input type="text" name="${entry.key}" value="${entry.value}"/></td>
    <td><input type="text" name="${entry.key}" value="${entry.value}"/></td>
    '</tr>'
*/

    identi_length++;
    col_length++;
    $('#count').html('(총 ' + row_length + '건)');

    console.log("identi_length", identi_length);
}


function tst_modal_call_regist(cls, param) {
    document.getElementsByClassName(cls)[0].style.display = 'flex';
    document.getElementById('tst_modal_param').value = param;

    set_modal();
}


function set_modal() {

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


}


function manage_empl_row_delete() {

    var param = $('#tst_modal_param').val();

    var row = "row_" + param;

    var row_element = document.getElementById(row);
    console.log("row_element", row_element);

    row_element.remove();

    row_length--;

    $('#count').html('(총 ' + row_length + '건)');

    tst_modal_close('tst_modal_delete');
}