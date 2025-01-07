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
                //첫번째 결재자 가져오기
                console.log("target_user:",data.target_user);


                //알림
                var sender_idx = $('.hidden_empl_idx').val();
                console.log("sender_idx:",sender_idx);



                //제목
                var doc_subject = $('input[name="doc_subject"]').val();

                //내용
                //richtexteditor 내용
                var doc_subject ='';
                doc_subject += $('.hidden_empl_name').val();
                doc_subject += '가 결재를 요청한 문서가 있습니다. (결재 마감일시 : ';
                doc_subject += $('#doc_end_date').val();
                doc_subject +=')';

                //결재 요청했으면 received 그걸로 넣기
                ///approval_received_detail.go?doc_idx=511&type=received

                //첫번째 결재자
                approval_insert_notify('approval_received_detail.go?doc_idx='+doc_idx+'&type=received',data.target_user,sender_idx,doc_subject,'',1);

                //웹소켓
                //approval_set_notify(data.target_user,location.pathname,sender_idx);

                //리스트로 이동
                location.href ="/approval_writing_list.go";

            },error : function(e){
                console.log(e);
                alert('문서 상신에 실패했습니다.');
            }

        })
    }else{
        alert('문서 저장 및 상신에 실패했습니다.');
    }

}

