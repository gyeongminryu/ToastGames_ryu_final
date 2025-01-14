
//임시 저장
function approval_write_temporal_save(){
    console.log("임시 저장 함수 실행");
    approval_set_save_data('save');
    refer_save_doc();

}

//저장 함수
function approval_write_save(){
    console.log("save 함수 실행");
    approval_set_save_data('save');
    refer_save_doc();
    //ajax 처리 끝나면 이동
    location.href = "/approval_writing_list.go";

}

//상신 후 저장 함수
function approval_write_request_save(){
    console.log("임시 저장 함수 실행");

    //결재자 제대로 선택했는지 확인
    //중복을 허용하지 않는 SET을 사용
    var empl_lines = [
        $('#empl_line1').val(),
        $('#empl_line2').val(),
        $('#empl_line3').val()
    ];
    console.log("empl_lines",empl_lines);

    //빈 문자열이 들어가서 빈 문자열의 길이도 세고 있었음
    //결재선이 하나만 들어갈 때 동일한 결재선을 두번 등록할 수 없음으로 뜸



    //동일한 결재선 등록 방지

    if (new Set(empl_lines).size === empl_lines.length) {
        // 모든 값이 다를 경우 처리
        //new Set(empl_lines).size = 중복을 없애고 반환한 내용의 크기
        //empl_lines.length = 중복까지 포함한 길이

        console.log("모든 값이 다릅니다.");

        //제목 및 문서 내용을 필수 항목으로 (기재했는지 확인)
        var doc_subject= $('input[name="doc_subject"]').val();
        var doc_content_sub= editor2.getHTMLCode();
        console.log("doc_content_sub",doc_content_sub);
        if(doc_subject==''){
            alert('문서 제목은 필수로 입력해야 합니다.');
        }else if(doc_content_sub ==''){
            alert('보고 내용은 필수로 입력해야 합니다.');
        }else{
            refer_save_doc();
            approval_set_save_data('request_save');
        }
    } else {
        console.log("값이 중복됩니다.");
        alert('결재선을 비우거나, 동일한 결재선을 두번 등록할 수 없습니다.');
    }
    // 값이 중복되는 경우 & 결재선이 비었을 때 처리






}

var setted = 0;
//form안에 필요한 값들을 저장 전 세팅해주는 함수
function approval_set_save_data(type){
    console.log("form 안에 저장 전 데이터 세팅");
    //현재 시간 구하기
    approval_write_current_date();

    //doc_content_sub (작성 내용) -> form에 넣어주기
    var doc_content_sub = editor2.getHTMLCode();
    console.log(doc_content_sub);
    $('input[name="doc_content_sub"]').val(doc_content_sub);


    //doc : form 내용 - form에 저장
    var doc_content = editor1.getHTMLCode();
    console.log(doc_content);
    $('input[name="doc_content"]').val(doc_content);

    setted = 1;

    if(type === 'request_save'&& setted===1){
        approval_save_and_request();
    }else{
        approval_save_data_send();
    }
}

//작성 일자 및 최종 업데이트 일자 구하고 세팅해주기 위한 함수 -> 저장 혹은 임시 저장 클릭 시에만 작동
function approval_write_current_date(){

    let today = new Date(); //오늘 날짜에 대한 전체 정보

    let year = today.getFullYear();//년도 구하기
    let month = today.getMonth()+1;
    month = month.toString().padStart(2, '0'); //달 구하기 -> 1월 = 0,12월 = 11
    let date = today.getDate().toString().padStart(2, '0'); // 일 구하기

    let hours = today.getHours().toString().padStart(2, '0');
    let minutes = today.getMinutes().toString().padStart(2, '0');
    let seconds = today.getSeconds().toString().padStart(2, '0');

    //format
    var doc_date_time= year+'-'+month+'-'+date+ ' ' + hours+':'+minutes+':'+seconds;

    var doc_date= year+'-'+month+'-'+date;

    console.log("작성 일자:",doc_date);

    //작성하던 코드 copy에 저장
    getHtmlCode();

    //현재 시간 구한 것 copy 문서 양식에 넣어주기
    $('#send_date_left').html(doc_date_time);
    $('#send_date_right').html(doc_date);

    //copy 코드 리치텍스트에 저장
    setHtmlCode();

    // 작성 일자 - <form>에 넣기
    $('#hidden_doc_date').val(doc_date_time);


}

//ajax로 formData 값 보내서 저장하는 것
function approval_save_data_send(){
    console.log("문서 저장 함수 실행");
    var form = new FormData($('form')[0]);
    $.ajax({
        type : 'POST',
        url : 'approval_doc_write.ajax',
        enctype : 'multipart/form-data',
        processData: false,
        contentType : false,
        data : form,
        dataType : 'JSON',
        success : function(data){
            console.log(data);
            console.log("문서 저장 성공");

        },error : function (e){
            console.log(e);
        }
    });
}

//저장 및 상신 + request 알림
function approval_save_and_request(){
    console.log("request 및 문서 저장 함수 실행");
    var form = new FormData($('form')[0]);
    $.ajax({
        type : 'POST',
        url : 'approval_doc_write_and_request.ajax',
        enctype : 'multipart/form-data',
        processData: false,
        contentType : false,
        data : form,
        dataType : 'JSON',
        success : function(data){
            console.log(data);
            console.log("문서 저장 성공");

            // 첫번째 결재자 가져오기
            console.log("target_user:", data.target_user);

            // 알림
            var sender_idx = $('.hidden_empl_idx').val();
            console.log("sender_idx:", sender_idx);

            // 제목
            var doc_subject = $('input[name="doc_subject"]').val();
            doc_subject += $('.hidden_empl_name').val();
            doc_subject += '가 결재를 요청한 문서가 있습니다. (결재 마감일시 : ';
            doc_subject += $('#doc_end_date').val();
            doc_subject += ')';

            // 결재 요청했으면 received 그걸로 넣기
            approval_insert_notify('/approval_received_detail.go?doc_idx=' + doc_idx + '&type=received', data.target_user, sender_idx, doc_subject, '', 1);

            // 웹소켓
            // approval_set_notify(data.target_user, location.pathname, sender_idx);

            // 리스트로 이동
            location.href = "/approval_writing_list.go";

        },error : function (e){
            console.log(e);
        }
    });
}


//문서의 참조를 저장 요청하는 함수
function refer_save_doc(){
    console.log("문서 참조 저장 요청");
    var r_empl_line = $('input[name = "r_empl_line"]').map(function(){
        return $(this).val();
    }).get(); //배열
    console.log("r_empl_line",r_empl_line);

    var doc_idx = $('.hidden_doc_idx').val();
    console.log("doc_idx",doc_idx);
    console.log("Object.keys(r_empl_line).length",Object.keys(r_empl_line).length);
    if(Object.keys(r_empl_line).length>0){
        $.ajax({
            type :'POST',
            url:'refer_save_doc.ajax',
            data: JSON.stringify({
                refer_line: r_empl_line,  // r_empl_line 값
                doc_idx: doc_idx        // doc_idx 값 배열
            }),
            contentType: 'application/json',
            dataType: 'JSON',
            success : function (data){
                console.log(data);
            },error : function (e){
                console.log(e);
            }
        });
    }
}
