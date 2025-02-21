var empl_idx =0;

function open_alert_list(){
    //notify 테이블의 내용을 가져오기

       $.ajax({
            type : 'POST',
            url : 'get_noti_list.ajax',
            data : {},
            dataType :'JSON',
            success : function(data){
                console.log(data);
                console.log(data.all_noti);
                noti_draw(data.all_noti);
                tst_view_alertlist();
            },
            error : function (e){
                console.log(e);
            }
        })
}


    function noti_draw (all_noti){
            var content ='';
            for(var noti of all_noti){
               console.log(noti);
               console.log(noti.noti_cate_idx);
               var category = noti.noti_cate_idx;
               empl_idx = noti.noti_receiver_empl_idx;
               //만약 category = 1
                var dateStr = noti.noti_sent_date;
                // 날짜와 시간 분리
                let [datePart, timePart] = dateStr.split("T");

                // 시간 부분에서 밀리초 및 시간대 제거
                let timeOnly = timePart.split('.')[0];

                console.log("날짜 부분:", datePart);  // "2024-12-07"
                console.log("시간 부분:", timeOnly); // "08:19:51"
                //2024-12-07T05:22:12.000+00:00

                var date = datePart +' '+ timeOnly;
               //날짜 format 바꾸기

               switch (category){
                   case 1:
                       console.log("결재 요청한 알람");
                       content += '<li><div class="alert_item"><div class="alert_item_header tst_flex"><div class="tst_col6"><p><i class="bi bi-megaphone margin_right"></i>결재 요청</p></div><div class="tst_col6 align_right"><p class="min font_subtle"><span>'+date+'</span><span><i onclick="noti_delete(this,'+noti.noti_idx+')" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span></p></div></div><div onclick="location.href=\'' + noti.noti_link + '\'"  class="alert_item_body tst_pointer"><p>'+noti.noti_subject+'</p></div></div></li>';
                       break;
                   case 2:
                       console.log("결재 승인한 알람");
                       content += '<li><div class="alert_item"><div class="alert_item_header tst_flex"><div class="tst_col6"><p><i class="bi bi-file-earmark-check margin_right"></i>' + noti.noti_cate_name + '</p></div><div class="tst_col6 align_right"><p class="min font_subtle"><span>' + date + '</span><span><i onclick="noti_delete(this,' + noti.noti_idx + ')" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span></p></div></div><div onclick="location.href=\'' + noti.noti_link + '\'" class="alert_item_body tst_pointer"><p><b>문서' + noti.noti_subject + '</b> 이/가 결재되었습니다. (결재자:' + noti.empl_name + ')</p></div></div></li>';
                       console.log("content:",content);
                       break;
                   case 3 :
                       console.log("결재 반려한 알람");
                       content += '<li><div class="alert_item"><div class="alert_item_header tst_flex"><div class="tst_col6"><p><i class="bi bi-file-earmark-check margin_right"></i>'+noti.noti_cate_name+'</p></div><div class="tst_col6 align_right"><p class="min font_subtle"><span>'+date+'</span><span><i onclick="noti_delete(this,'+noti.noti_idx+')" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span></p></div></div><div onclick="location.href=\'' + noti.noti_link + '\'"  class="alert_item_body tst_pointer"><p><b>문서'+noti.noti_subject+'</b> 이/가 결재 반려되었습니다. (결재자:'+ noti.empl_name+')</p></div></div></li>';
                       break;

                   //회의실 및 일정
                   case 11 :
                   case 12 :
                   case 14 :
                   case 15 :
                   case 17 :
                   case 18 :
                       console.log("회의실 및 일정");
                       content += '<li><div class="alert_item"><div class="alert_item_header tst_flex"><div class="tst_col6"><p><i class="bi bi-person-video3 margin_right"></i>'+noti.noti_cate_name+'</p></div><div class="tst_col6 align_right"><p class="min font_subtle"><span>'+date+'</span><span><i onclick="noti_delete(this,'+noti.noti_idx+')" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span></p></div></div><div onclick="location.href=\'' + noti.noti_link + '\'"  class="alert_item_body tst_pointer"><h3>'+noti.noti_subject+'</h3><p class="font_subtle">'+noti.noti_content+'</p></div></div></li>';
                       break;
                    //회의실 및 일정 취소
                   case 13 :
                   case 16 :
                       console.log("회의실 및 일정 취소");
                       content += '<li><div class="alert_item"><div class="alert_item_header tst_flex"><div class="tst_col6"><p><i class="bi bi-person-video3 margin_right"></i>'+noti.noti_cate_name+'</p></div><div class="tst_col6 align_right"><p class="min font_subtle"><span>'+date+'</span><span><i onclick="noti_delete(this,'+noti.noti_idx+')" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span></p></div></div><div class="alert_item_body tst_pointer"><h3>'+noti.noti_subject+'</h3><p class="font_subtle">'+noti.noti_content+'</p></div></div></li>';
                       break;
                   case 19 :
                       console.log("일정 및 공용 물품");
                        content += '<li><div class="alert_item"><div class="alert_item_header tst_flex"><div class="tst_col6"><p><i class="bi bi-person-video3 margin_right"></i>'+noti.noti_cate_name+'</p></div><div class="tst_col6 align_right"><p class="min font_subtle"><span>'+date+'</span><span><i onclick="noti_delete(this,'+noti.noti_idx+')" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span></p></div></div><div onclick="location.href=\'' + noti.noti_link + '\'"  class="alert_item_body tst_pointer"><h3>'+noti.noti_subject+'</h3><p class="font_subtle">'+noti.noti_content+'</p></div></div></li>';
                       break;

                   case 21 :
                       console.log("공지사항");
                       content += '<li><div class="alert_item"><div class="alert_item_header tst_flex"><div class="tst_col6"><p><i class="bi bi-megaphone margin_right"></i>'+noti.noti_cate_name+'</p></div><div class="tst_col6 align_right"><p class="min font_subtle"><span>'+date+'</span><span><i onclick="noti_delete(this,'+noti.noti_idx+')" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span></p></div></div><div onclick="location.href=\'' + noti.noti_link + '\'"  class="alert_item_body tst_pointer"><h3>'+noti.noti_subject+'</h3><p class="single_line_paragraph">'+noti.noti_content+'</p></div></div></li>';
                       break;

                   case 22 :
                   case 23 :
                       console.log("부서 공지사항");
                       content += '<li><div class="alert_item"><div class="alert_item_header tst_flex"><div class="tst_col6"><p><i class="bi bi-megaphone margin_right"></i>'+noti.dept_name+' 공지사항</p></div><div class="tst_col6 align_right"><p class="min font_subtle"><span>'+date+'</span><span><i onclick="noti_delete(this,'+noti.noti_idx+')" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span></p></div></div><div onclick="location.href=\'' + noti.noti_link + '\'"  class="alert_item_body tst_pointer"><h3>'+noti.noti_subject+'</h3><p class="single_line_paragraph">'+noti.noti_content+'</p></div></div></li>';
                       break;
               }

               console.log("content 최종:",content);

               $('#noti_box').html(content);


           }
    }

    //개별 알림 삭제 함수
    function noti_delete(evt,noti_idx){
        //css에서 제거되도록 구현
        console.log(evt);
        $(evt).closest('.alert_item').remove();
        console.log($(evt).closest('.alert_item')[0]);

        console.log(noti_idx);

        $.ajax({
            type : 'POST',
            url : 'delete_noti_one.ajax',
            data : {'noti_idx':noti_idx},
            dataType: 'JSON',
            success : function (data){
                console.log(data);
            }, error : function (e){
                console.log(e);
            }


        });

    }

    //전체 알림 삭제 함수
    function noti_delete_all(){
        console.log("empl_idx:",empl_idx);
        tst_modal_close('tst_modal_delete_all');
        $.ajax({
            type : 'POST',
            url : 'delete_noti_all.ajax',
            data : {'empl_idx':empl_idx},
            dataType: 'JSON',
            success : function (data){
                console.log(data);
            }, error : function (e){
                console.log(e);
            }
        })

        $('#noti_box').html('');
    }

