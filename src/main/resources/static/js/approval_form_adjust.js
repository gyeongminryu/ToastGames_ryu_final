
//contenteditable = true처리
function approval_content_edit(){
    console.log('content_edit 함수 실행');
    var edits= document.querySelectorAll('td[name="edit"]');

    edits.forEach(function (item){
        console.log(item);
        item.setAttribute("contenteditable","true");
        //$('td').attr("contenteditable","true");
    });
}

//문서 번호/작성 일시/작성 부서/ 작성자 자동 기입
function approval_form_data_insert(){

}