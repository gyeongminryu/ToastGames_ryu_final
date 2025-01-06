function approval_set_notify(target_user_id,url,sender_idx){
    console.log("approval_set_notify함수 실행");


    var doc_subject= $('input[name="doc_subject"]').val();
    console.log("doc_subject:",doc_subject);

    var noti_content = $('.content').val();

    /*
        if(url){
            doc_subject+='문서에 대한 결재건이 도착했습니다.'; //결재할 경우
        }*/


    approval_send_message(doc_idx, target_user_id,url,doc_subject,noti_content,doc_date,sender_idx);

}