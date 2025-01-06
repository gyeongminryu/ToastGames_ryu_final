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

                //첫번째 결재자 가져오기
                var url = location.pathname;


                //알림
                //approval_set_notify(data.target,location.pathname);

                console.log(data);
                alert('반려되었습니다.');

                approval_insert_notify(location.pathname+location.search,data.target_user,empl_idx,doc_subject,doc_content_sub,2);


                location.href = "/approval_received_detail.go?doc_idx="+doc_idx+"&type="+'received';

            },error : function (e){
                console.log(e);
            }
        });
    }else{
        alert('반려 사유를 입력해주세요!');
    }

}