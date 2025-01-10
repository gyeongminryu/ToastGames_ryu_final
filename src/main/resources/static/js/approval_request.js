function approval_request() {
    // 임시 저장 후 결재 상신


    /*approval_write_temporal_save_promise().then(function (){
        return approval_request_do_promise();
    }) .then(function () {
        // 성공 시 추가 처리 (필요시)
        console.log("결재 요청이 성공적으로 처리되었습니다.");
    })
        .catch(function (error) {
            // 오류 처리
            console.log("문서 상신에 실패했습니다:", error);
        });*/

}

function approval_request_do_promise() {
    return new Promise(function(resolve, reject) {
        $.ajax({
            type: 'GET',
            url: '/approval_request.ajax',
            data: {"doc_idx": doc_idx},
            dataType: 'JSON',
            success: function (data) {

            },
            error: function (e) {
                console.log(e);
                alert('문서 상신에 실패했습니다.');
            }
        });
    });
}

function approval_write_temporal_save_promise() {
    return new Promise(function(resolve, reject) {
        resolve();  // 비동기 작업이 완료되었음을 알림
    });
}
