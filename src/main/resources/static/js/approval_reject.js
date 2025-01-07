var doc_idx = $('#doc_idx').val();
var my_appr_order=$('#my_appr_order').val();

function approval_reject(){
    //var reject_reason = $('#reject_reason').html();
    var reject_reason = $('#reject_reason').val();

    console.log(doc_idx);
    console.log(reject_reason);
    console.log(my_appr_order);

    if(reject_reason!==''){
        $.ajax({
            type :'GET',
            url :'approval_reject.ajax',
            data : {"doc_idx":doc_idx,"reject_reason":reject_reason,"line_order":my_appr_order},
            dataType:'JSON',
            success : function (data){
                //target_user들을 받아오기 - line_order 이전의 사람들
                console.log(data);
                console.log("target_user:",data.target_user);
                //알림
                var target_users = data.target_user;

                let target_user= [];
                for(var target_users_key of Object.keys(target_users)){
                   var target_user_val =  target_users[target_users_key];
                    console.log("target_user_val",target_user_val);
                   console.log("target_user_val.appr_receiver_idx:",target_user_val.appr_receiver_idx)
                   target_user.push(target_user_val.appr_receiver_idx);
                }

                console.log("target_user 배열:",target_user);

                //approval_set_notify(data.target,location.pathname);
                alert('반려되었습니다.');

                //반려 - 이전 결재자 모두
                approval_insert_notify(location.pathname+location.search,target_user,empl_idx,doc_subject,doc_content_sub,3);


                //location.href = "/approval_received_detail.go?doc_idx="+doc_idx+"&type="+'received';

            },error : function (e){
                console.log(e);
            }
        });
    }else{
        alert('반려 사유를 입력해주세요!');
    }

}