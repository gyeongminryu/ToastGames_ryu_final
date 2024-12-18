

//+버튼 누르면 열 추가
//append
var i = 2;
$('#html_rendering').on('click','#plus1',function(){
    console.log("추가버튼");
    var copy_row = '<tr class="copyRow"><td class="BCel center copyRowNo1 dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l"><p>'+i+'</p></td><td class="BCel center dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l" contenteditable="false"></td><td class="BCel center dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l" contenteditable="false"></td><td class="BCel center dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l" contenteditable="false"></td><td class="BCel center dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l" contenteditable="false"></td><td class="BCel center dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l" contenteditable="false"></td></tr>';
    console.log(copy_row);
    $('.copyRow').last().after(copy_row);
    i++;

});


//-버튼 누르면 열 삭제

$('#html_rendering').on('click','#minus1',function(){
    console.log("삭제버튼");
    console.log(i);

    if(i>2){
        $('.copyRow').last().remove();
        i--;
    }
});
