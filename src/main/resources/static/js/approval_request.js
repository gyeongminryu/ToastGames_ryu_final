function approval_request(){
    console.log("approval_request 함수 실행");
    //저장 함수 실행하고 보내기

    if(approval_write_temporal_save()){
        //결재 상신하기
        $.ajax({
            type : 'GET',
            url : '/approval_request.ajax',
            data : {"doc_idx" : doc_idx},
            dataType : 'JSON',
            success : function (data){
                console.log(data);
                location.href ="/approval_writing_list.go"
            },error : function(e){
                console.log(e);
                alert('문서 상신에 실패했습니다.');
            }

        })
    }else{
        alert('문서 저장 및 상신에 실패했습니다.');
    }

}