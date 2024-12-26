function approval_write_delete(){
    console.log("approval_write_delete 함수 실행");
    //삭제할 것 : 해당 doc_idx 가진
    $.ajax({
        type: 'GET',
        url:'approval_write_delete.ajax',
        data : {"doc_idx":doc_idx},
        dataType :'JSON',
        success : function(data){
            console.log(data);
            location.href = "/approval_writing_list.go";
        },error : function (e){
            console.log(e);
        }

    })



}