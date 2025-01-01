window.onload = function initialize(){
    approval_content_none_edit();
}

//contenteditable = false 처리
//저장될 때 contenteditable = true되니까
function approval_content_none_edit(){
    console.log('content_edit 함수 실행');
    var edits= document.querySelectorAll('td[name="edit"]');
    var copy_row= document.querySelectorAll('.copyRow');


    edits.forEach(function (item){
        console.log(item);
        item.setAttribute("contenteditable","false");
        //$('td').attr("contenteditable","true");
    });


    //열추가하는 css 제외하기
    copy_row.forEach(function (item){
        console.log(item);
        item.setAttribute("contenteditable","false");
        //$('td').attr("contenteditable","true");
    });
}