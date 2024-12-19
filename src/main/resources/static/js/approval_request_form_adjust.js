
//contenteditable = true처리
function approval_content_edit(){
    console.log('content_edit 함수 실행');
    var edits= document.querySelectorAll('td[name="edit"]');
    var copy_row= document.querySelectorAll('.copyRow');


    edits.forEach(function (item){
        console.log(item);
        item.setAttribute("contenteditable","true");
        //$('td').attr("contenteditable","true");
    });

    copy_row.forEach(function (item){
        console.log(item);
        item.setAttribute("contenteditable","true");
        //$('td').attr("contenteditable","true");
    });
}

