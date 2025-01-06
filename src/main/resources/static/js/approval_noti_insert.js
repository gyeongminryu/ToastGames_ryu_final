function approval_insert_notify(url,target_users,sender_idx,doc_subject,doc_content,notify_category){
    //send_date
    let today = new Date(); //오늘 날짜에 대한 전체 정보

    let year = today.getFullYear();//년도 구하기
    let month = today.getMonth(); //달 구하기
    let date = today.getDate(); // 일 구하기

    let hours = today.getHours();
    let minutes = today.getMinutes();
    let seconds = today.getSeconds();

    //format
    var doc_date= year+'-'+month+'-'+date+ ' ' + hours+':'+minutes+':'+seconds;

    console.log("작성 일자:",doc_date);

    //ajax로 전달할 param
    var receiver_list = [];
    if(Array.isArray(target_users)){ //target_users가 여러명일 때
        for(var target_user_key of Object.keys(target_users)){
            receiver_list.push(target_users.target_user_key);
        }
    }else{ //한명일 때
        receiver_list.push(target_users);
    }

    if(doc_subject===''){
        doc_subject = '제목 없음';
    }
    console.log("doc_subject:",doc_subject);

    if(doc_content === ''){
        doc_content = '내용 없음';
    }


    console.log("receiver_list:",receiver_list);
    var param = {};
    param.url = url;
    param.receiver_list = receiver_list;
    param.sender_idx = sender_idx;
    param.doc_subject = doc_subject;
    param.doc_content = doc_content;
    param.doc_date = doc_date;
    param.notify_category = 1;
    console.log("param:{}",param);
    var success = false;
    $.ajax({
        type : 'POST',
        url : 'approval_noti_insert.ajax',
        data: JSON.stringify(param),
        dataType: 'JSON',
        contentType:'application/json; charset=UTF-8',
        success : function(data){
            console.log(data);
            success = true;
        },
        error : function (e){
            console.log(e);
        }
    })

    return success;
}