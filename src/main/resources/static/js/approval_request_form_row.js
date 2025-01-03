//양식 열 조정 + 수정하는 js

//+버튼 누르면 열 추가
//append
var i = 2;
$('#dynamic_table1').addEventListener('click','#plus1',function(){

    console.log("추가버튼");
    var content = '<tr class="copyRow"><td class="BCel center copyRowNo1 dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l"><p>'+i+'</p></td><td class="BCel center dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l" contenteditable="false"></td><td class="BCel center dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l" contenteditable="false"></td><td class="BCel center dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l" contenteditable="false"></td><td class="BCel center dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l" contenteditable="false"></td><td class="BCel center dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l" contenteditable="false"></td></tr>';
    console.log(content);
    $('.copyRow').last().after(content);
    i++;

});


//-버튼 누르면 열 삭제

$('#dynamic_table1').addEventListener('click','#minus1',function(){
    console.log("삭제버튼");
    if(i>2){
        $('.copyRow').last().remove();
        i--;
    }
});