var notification_que =[];

//알림 추가 함수
function add_alert(title,description,time) {
    notification_que.push({title: title,description:description,time:time});

    //큐가 비어있지 않으면 순차적으로 표시
    if(notification_que.length ===1){
        show_next_notification();
    }
}

//알림 띄우기
function show_next_notification(){

    if(notification_que.length ===0) return;
    var current_noti = notification_que[0];

    var title = current_noti.title;
    console.log(title);
    var description = current_noti.description;
    console.log(description);
    var time = current_noti.time;


    $('.notify_entity_title').html(title);
    $('.notify_entity_description').html(description);
    $('.notify_entity_time').html(time);

    $('.notify_entity').fadeIn("slow");

    setInterval(function(){
        $('.notify_entity').fadeOut("slow");
        notification_que.shift();
        show_next_notification();
    },10000);





}