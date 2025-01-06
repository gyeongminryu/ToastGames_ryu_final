var ws = null;
    //사원번호
var url = "";
var noti_receiver ="";




    function connectWebSocket(user_id){
        console.log("웹소켓 연결 함수 실행");

        ws = new WebSocket("ws://localhost:80/notify/"+user_id);


        ws.onopen = function (evt){
            console.log("웹소켓 연결됨");
        }

        ws.onclose = function(evt){
            console.log("웹소켓 연결 종료됨");
        }

        //다른 사람이 보낸 알림 확인
        ws.onmessage = function(evt){
            var data = JSON.parse(evt.data);
            console.log("받은 알람:", data);
            //화면에 띄우는 부분 확인
        }
    }




//내가 알림 보내기
function approval_send_message(doc_idx, target_user_id,url,doc_subject,noti_content,doc_date,sender_idx){
    console.log("approval_send_message함수 실행");

        console.log("target_user_id",target_user_id);
    console.log("sender_idx",sender_idx);

    //location.pathname 구하기

    //path name에 해당하는 notification[location.pathname] 얻기

    var message = notification_data[url];

    //DB에 넣기
    //approval_notify_db();


    if(ws&&ws.readyState === WebSocket.open){
        // 서버로 알림 메시지를 보냄
        ws.send(JSON.stringify(message));
    }else{
        connectWebSocket(sender_idx);
    }

}