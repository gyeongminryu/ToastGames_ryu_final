
    //login하고 leftnav 준비될 때 웹소켓도 켜기
    var notify_webSocket = null;


    $(document).ready(function() {
        $.ajax({
            url: 'layout_memberInfo',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                 $('#memberName').text(data.empl_name);  // Update name
       	 		 $('#memberDept').text(data.dept_name + '/' + data.duty_name);  // Update dept and duty
        		 $('#profileImage').attr('src', 'memberFiles/' + data.empl_profile);  // Update profile image src

                console.log(data);  // Log the response to see the data
                console.log(data.empl_idx);
                socketOn(data.empl_idx);
            },
            error: function(xhr, status, error) {
                console.error("Error fetching member info: " + error);
            }
        });
    });

    //웹소켓 서버는 80번 포트(HTTP의 기본 포트)에서 실행되지 않음
    function socketOn(empl_idx){
        //var url= "ws://localhost:8080/ToastGames_war/notify/"+empl_idx;
        var url= "ws://localhost/notify/"+empl_idx;
        //var url = "ws://localhost";
        notify_webSocket = new WebSocket(url);

        //1.웹소켓 연결
        notify_webSocket.onopen = function (evt){
            console.log('웹소켓 연결',evt);
        }

        //2. 웹소켓 끊겼을 때
        notify_webSocket.onclose = function(evt){
            console.log('웹소켓 종료',evt);
            console.log('웹소켓 종료 이유',evt.reason);
        }

        //3. 알림 수신 시
        notify_webSocket.onmessage = function(evt){
            console.log('알림 수신 : ',evt.data);

            let jsonData = JSON.parse(evt.data);
            let title = jsonData.title;
            let description = jsonData.description;
            let date = jsonData.date;
            console.log('jsonData',jsonData);
            console.log('title',title);
            console.log('description',description);
            console.log('date',date);


            add_alert(title,description,date);
        }
    }

    //알림 보낼 때
    function sendNoti(target_user,title,description,doc_date){
        notify_webSocket.send(title+'/'+description+'/'+doc_date+'/'+target_user);
    }
    