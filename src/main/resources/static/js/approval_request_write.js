//rich text editor
var editor1 = new RichTextEditor("#div_editor_content", configDocument);
var editor2 = new RichTextEditor("#div_editor_content_sub", configNone);


let notification_data= {};

window.onload = function initialize(){

    //문서 가져오기
        approval_doc_get();



    // notification_data={
    //     "/approval_request.go":{
    //         noti_category : 1,
    //         noti_target_user : noti_receiver,
    //         noti_subject : '결재할 문서가 있습니다.',
    //         noti_content : doc_subject,
    //         noti_url : url
    //     }
    // }
}

//저장된 문서 가져오는 함수
function approval_doc_get(){
    console.log("문서 가져올 때 받은 doc_idx",doc_idx);
    $.ajax({
        type : 'get',
        url : 'approval_doc_get.ajax',
        data : {'doc_idx': doc_idx},
        dataType : 'JSON',
        success : function(data){
            console.log(data);

            console.log(data.doc_content);
            console.log(data.doc_idx);
            console.log(data.empl_name);
            console.log("data.duty_name",data.duty_name);
            console.log("data.files",data.files);
            if(data.files != undefined){
                console.log("files",data.files);
                for(var file of data.files){
                    console.log("file",file);
                }
            }
            //editor.setHTMLCode(data.form_content);//편집기 안의 HTML code 설정

            //document.getElementById('form_content').innerHTML =data.doc_content;
            //$('#form_content').html(data.doc_content);
            if(data.doc_content_sub!=null){
                editor2.setHTMLCode(data.doc_content_sub);
            }

            document.getElementById('div_editor_copy').innerHTML = data.doc_content;
            //setHtmlCode();

            //문서 정보란에 1차 정보 기입 (문서번호, 작성자, 부서명* -> 추가예정)
            $('.hidden_doc_idx').val(data.doc_idx);
            $('.hidden_empl_name').val(data.empl_name);

            //폼 양식 수정
            $('#document_idx_left').html(data.doc_idx);
            $('#sender_name_left').html(data.empl_name);
            $('#sender_dept_left').html(data.dept_name);

            $('#sender_name_right').html(data.empl_name);
            $('#sender_duty_right').html(data.duty_name);


            //가져온 정보를 html로 보여주는 코드
            //만약에 제목, 마감일시, 보고 내용이 있다면?
            $('#doc_end_date').val(data.doc_end_date);

            $('input[name="doc_subject"]').val(data.doc_subject);


            //결재선에 결재 요청자 정보 넣기
            $('#empl_line0').val(data.empl_idx);
            $('#dept_line0').val(data.dept_idx);
            $('#duty_line0').val(data.duty_idx);
            $('#position_line0').val(data.position_idx);

            //폼 양식 수정하면 copy에 있는 것 복붙
            setHtmlCode();


            //임시저장 setInterval 함수
            setInterval(approval_write_temporal_save, 10000);
            approval_content_edit();

            //저장된 결재선 가져오기
            approval_line_get();

            //저장된 참조선 가져오기
            refer_line_get();

            //저장된 파일 있으면 가져오기
            var doc_idx = $('.hidden_doc_idx').val();
            console.log("doc_idx",doc_idx);

           approval_get_file_infos(doc_idx);

        },
        error : function(e){
            console.log(e);
        }
    });
}

//저장된 파일 가져오는 함수
function approval_get_file_infos(doc_idx){
    console.log("doc_idx",doc_idx);
    $.ajax({
        type : 'POST',
        url : 'approval_get_file_infos.ajax',
        data : {'doc_idx':doc_idx},
        dataType : 'JSON',
        success: function(data){
            console.log(data);
            console.log("data.file",data.file);
            content = approval_file_draw(data.file);
            $('#file_preview').html(content);
        },error : function (e){
            console.log(data);
        }


    })

}


//저장된 결재선 가져오는 함수
function approval_line_get(){
    //doc_idx를 가진 line 정보 모두 가져오기
    //만약 map에서 꺼낸 step값이 1~3인 경우로 나눠서

    $.ajax({
        type : 'GET',
        url: 'approval_doc_line_get.ajax',
        data : {'doc_idx': doc_idx},
        dataType: 'JSON',
        success : function (data){
            approval_draw_appr_line(data.doc_lines);
            if(data.doc_alert != null){
                alert(data.doc_alert);
            }

        },error : function (e){
            console.log(e);
        }

    });
}

//가져온 결재선을 jsp에 보여주는 함수
function approval_draw_appr_line(data){
    console.log(data);
    var approval_line_id = '';
    var empl_line_id = '';
    var dept_line_id = '';
    var duty_line_id = '';
    var position_line_id = '';

    for(var key of Object.keys(data)){
        console.log(key);
        console.log(data[key]);
        var approval_line = data[key];

        console.log("순서 :",approval_line.line_order);
        console.log("직책 idx:",approval_line.duty_idx);
        console.log("직책 이름:",approval_line.duty_name);
        console.log("사원 idx:",approval_line.empl_idx);
        console.log("사원 이름:",approval_line.empl_name);
        console.log("직급 idx:",approval_line.position_idx);
        console.log("직급 이름:",approval_line.position_name);
        console.log("부서 idx:",approval_line.dept_idx);
        console.log("부서 이름:",approval_line.dept_name);


        content = approval_line.empl_name +'('+approval_line.dept_name+'/'+approval_line.position_name+')';
        
        //폼 양식 수정
        switch (approval_line.line_order){
            case 1 :
            //이름(직책/직급) html에 넣기
                approval_line_id ='#approval_line'+1;
                 $(approval_line_id).html(content);

                // input value에 넣기
                empl_line_id = '#empl_line'+1;
                dept_line_id = '#dept_line'+1;
                duty_line_id = '#duty_line'+1;
                position_line_id = '#position_line'+1;


                $(empl_line_id).val(approval_line.empl_idx);
                $(dept_line_id).val(approval_line.dept_idx);
                $(duty_line_id).val(approval_line.duty_idx);
                $(position_line_id).val(approval_line.position_idx);
                getHtmlCode();
                $('#approval_duty_1').html(approval_line.position_name);
                $('#approval_name_1').html(approval_line.empl_name);
                setHtmlCode();


                break;
            case 2 :
                //이름(직책/직급) html에 넣기
                approval_line_id ='#approval_line'+2;
                $(approval_line_id).html(content);

                // input value에 넣기
                empl_line_id = '#empl_line'+2;
                dept_line_id = '#dept_line'+2;
                duty_line_id = '#duty_line'+2;
                position_line_id = '#position_line'+2;

                $(empl_line_id).val(approval_line.empl_idx);
                $(dept_line_id).val(approval_line.dept_idx);
                $(duty_line_id).val(approval_line.duty_idx);
                $(position_line_id).val(approval_line.position_idx);
                getHtmlCode();

                $('#approval_duty_2').html(approval_line.position_name);
                $('#approval_name_2').html(approval_line.empl_name);

                setHtmlCode();
              /*  $('#approval_2 .empl_name').html(approval_line.empl_name);
                $('#approval_2 .position').html(approval_line.dept_name+'/'+approval_line.position_name);
               */
                break;

            case 3 :
                //이름(직책/직급) html에 넣기
                approval_line_id ='#approval_line'+3;

                $(approval_line_id).html(content);
                // input value에 넣기
                empl_line_id = '#empl_line'+3;
                dept_line_id = '#dept_line'+3;
                duty_line_id = '#duty_line'+3;
                position_line_id = '#position_line'+3;

                $(empl_line_id).val(approval_line.empl_idx);
                $(dept_line_id).val(approval_line.dept_idx);
                $(duty_line_id).val(approval_line.duty_idx);
                $(position_line_id).val(approval_line.position_idx);

                getHtmlCode();
                $('#approval_duty_3').html(approval_line.position_name);
                $('#approval_name_3').html(approval_line.empl_name);
                setHtmlCode();

                /*$('#approval_3 .empl_name').html(approval_line.empl_name);
                $('#approval_3 .position').html(approval_line.dept_name+'/'+approval_line.position_name);
                */
                break;

        }
    }



}



//가져온 참조선을 jsp에 보여주는 함수 (작성 중)
function refer_line_get(){
    $.ajax({
        type : 'GET',
        url: 'refer_doc_line_get.ajax',
        data : {'doc_idx': doc_idx},
        dataType: 'JSON',
        success : function (data){
            console.log("refer_line:",data.refer_line);
            approval_draw_refer_line(data.refer_line);

        },error : function (e){
            console.log(e);
        }

    });
}
function approval_draw_refer_line(datas){
    console.log(datas);
    content ='';
    for(var data of datas) {
        console.log(data);


        content = '<tr><th class="referrer_element">참조</th><td className="td_align_left referrer">'+ data.empl_name + '(' + data.dept_name + '/' + data.position_name + ')' +'</td><input type="hidden" name = "r_empl_line" id = "r_empl_line" value ="' + data.empl_idx + '"/><td><button type="button" onClick="delete_refer(this)" class="btn_primary btn_min">제외하기</button></td></tr>'
       /* //step이 0일 때는 참조에 추가
        content += '<div class ="referrer_element">참조<div class="referrer">' + data.empl_name + '(' + data.dept_name + '/' + data.position_name + ')' + '</div>';
        content += ' <input type="hidden" name = "r_empl_line" id = "r_empl_line" value ="' + data.empl_idx + '"/>'
        //삭제 버튼
        content += '<div class="delete_refer" onclick="delete_refer(this)">제외하기</div></div>'*/;
        console.log(content);

        $('#referrer_list').append(content);

    }


}





