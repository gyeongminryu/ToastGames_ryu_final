


window.onload = function initialize(){
    //문서 가져오기

        approval_doc_get();

        //저장된 결재선 가져오기
        approval_line_get();
        //저장된 참조선 가져오기
        refer_line_get();

}

//저장된 문서 가져오는 함수
function approval_doc_get(){
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
            //editor.setHTMLCode(data.form_content);//편집기 안의 HTML code 설정

            //document.getElementById('form_content').innerHTML =data.doc_content;
            $('#form_content').html(data.doc_content);

            //문서 정보란에 1차 정보 기입 (문서번호, 작성자, 부서명* -> 추가예정)
            $('#doc_idx').html(data.doc_idx);
            $('.hidden_doc_idx').val(data.doc_idx);
            $('#doc_write_empl').html(data.empl_name);

            $('#doc_write_depart').html(data.dept_name);

            //가져온 정보를 html로 보여주는 코드
            //만약에 제목, 마감일시, 보고 내용이 있다면?
            $('#doc_end_date').val(data.doc_end_date);

            $('input[name="doc_subject"]').val(data.doc_subject);
            //$('#editor').html(data.doc_content_sub);
           // $('input[name="doc_content_sub"]').val(data.doc_content_sub);

            //퀼 에디터에 context 넣는 법
            quill.setContents([
                { insert: data.doc_content_sub },
            ]);

            //참조선도 있다면 가져오기


            //임시저장 setInterval 함수
            setInterval(approval_write_temporal_save, 10000);
            approval_content_edit();

        },
        error : function(e){
            console.log(e);
        }
    });
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

                $('#approval_1 .empl_name').html(approval_line.empl_name);
                $('#approval_1 .position').html(approval_line.dept_name+'/'+approval_line.position_name);


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
                $('#approval_2 .empl_name').html(approval_line.empl_name);
                $('#approval_2 .position').html(approval_line.dept_name+'/'+approval_line.position_name);

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
                $('#approval_3 .empl_name').html(approval_line.empl_name);
                $('#approval_3 .position').html(approval_line.dept_name+'/'+approval_line.position_name);

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
    for(var data of datas){
        console.log(data);

        //step이 0일 때는 참조에 추가
        content += '<div class ="referrer_element">참조<div class="referrer">'+data.empl_name+'('+data.dept_name+'/'+data.position_name+')'+'</div>';
        content += ' <input type="hidden" name = "r_empl_line" id = "r_empl_line" value ="'+data.empl_idx+'"/>'
        //삭제 버튼
        content+='<div class="delete_refer" onclick="delete_refer(this)">제외하기</div></div>';
        console.log(content);

        $('#referrer_list').append(content);

    }



}





