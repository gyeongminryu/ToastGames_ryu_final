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
                console.log(data);
                alert('반려되었습니다.');
                location.href = "/approval_received_detail.go?doc_idx="+doc_idx+"&type="+'received';

            },error : function (e){
                console.log(e);
            }
        });
    }else{
        alert('반려 사유를 입력해주세요!');
    }

}