//자식창 결재선
//결재선을 선택하여 부모창에 보내는 js

/*//자식창에서 부모창에서 보낸 param 값(결재 순서) 받기
var url = new URLSearchParams(window.location.search);

var step = url.get('step');*/

var step =0;



//부서(상위부서) 보여주기

    function appr_show_modal(param){
        document.getElementsByClassName('tst_modal_select')[0].style.display = 'flex';
        console.log('부모창에 전달 받은 값',param);
        step= param;
        approval_get_all_empl();
        approval_get_high_dept();
    }

    //회사 내 모든 직원 가져오기
function approval_get_all_empl(){
    console.log("approval_get_all_empl 함수 실행");
        $.ajax({
        type : 'GET',
        url : 'approval_company_get_allempl.ajax',
        data : {},
        dataType : 'JSON',
        success : function(data){

            console.log("approval_get_all_empl의 데이터",data);
            content='';
            for(var empl of data.company_empl){

                console.log(empl);
                console.log(empl.empl_idx);
                console.log(empl.dept_name);

                //content += '<div class="empl_individual" onclick="approval_selected_line('+empl.dept_idx+','+empl.empl_idx+',\''+empl.dept_name+'\','+empl.duty_idx+',\''+empl.empl_name+'\',\''+empl.duty_name+'\',\''+empl.position_name+'\','+ empl.position_idx+')">' + empl.empl_name + ' (' + empl.duty_name + '/' + empl.position_name + ') </div>';
                content+='<tr onclick="approval_selected_line('+empl.dept_idx+','+empl.empl_idx+',\''+empl.dept_name+'\','+empl.duty_idx+',\''+empl.empl_name+'\',\''+empl.duty_name+'\',\''+empl.position_name+'\','+ empl.position_idx+')"><td class="td_align_top td_no_padding"><img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" /></td><td><p>' + empl.empl_name + ' (' + empl.dept_name + '/' + empl.position_name + ')</p><p class="min font_subtle">'+empl.duty_name+'</p></td></tr>';

            }
            $('#empl_wrapper').html(content);

        },error : function(e){
            console.log(e);
        }
    });
}
function approval_get_high_dept(){
    //상위 부서만 가져오기
    $.ajax({
        type : 'GET',
        url : 'approval_highdept.ajax',
        data : {},
        dataType: 'JSON',
        success : function(data){
            console.log(data);
            console.log(data.dept);

            //가져온 부서 값, jsp 단에 보여주기
            approval_draw_deptlist(data.dept);


        },error : function(e){
            console.log(e);
        }
    });

}

//팀(하위부서) 가져오는 함수
function approval_dept_open(e,dept_idx){
    console.log("e:",e);
    console.log("e.parent:",e.parentElement.parentElement.nextElementSibling);

    var dept_idx_string = "'"+dept_idx+"'";
    console.log("팀 가져오기 위한 idx:",dept_idx);
    $.ajax({
        type : 'GET',
        url : 'approval_show_team.ajax',
        data : {'dept_idx':dept_idx},
        dataType : 'JSON',
        success : function (data){
            console.log(data);
            console.log('data.length',data.dept.length);

            if(data.dept.length >0){
                approval_draw_deptlist(data.dept);

                //이때 팀 리스트를 보이기 설정
                show_team_list(e,dept_idx_string);

            }


        },error : function (e){
            console.log(e);
        }
    });
}


//가져온 부서/팀 이름 jsp에 보여주는 함수
var content = '';
function approval_draw_deptlist(data){
    console.log(data);
    content = '';
    for (var dept of data){
        console.log(dept);
        console.log("부서 이름:",dept.dept_name);
        console.log("부서 idx:",dept.dept_idx);
        console.log("부서 체계:",dept.dept_depth);

        /*부서이면*/
            if(dept.dept_depth === 2){
                //content += '<div class="dept_wrapper"><div class = "dept_open" onclick = approval_dept_open('+dept.dept_idx+')>▼</div><div class="dept_subject" onclick="approval_dept_detail(' + dept.dept_idx + ')">'+dept.dept_name+'</div><div class="team_wrapper" dept_idx ="'+dept.dept_idx+'"></div></div>';
                content+='<tr><td><i class="bi bi-caret-right-fill" onclick="approval_dept_open(this,'+dept.dept_idx+')"></i></td><td onclick="approval_dept_detail('+dept.dept_idx+')" class="tst_pointer">'+dept.dept_name+'</td></tr><tr class="disp_hide"><td></td><td><table class="tst_table tst_table_in_table table_align_left table_no_padding" dept_idx ="'+dept.dept_idx+'"></table></td></tr>';
        /*팀이면*/
            }else if(dept.dept_depth === 3){
                //content += '<div class="team_subject" onclick="approval_team_detail(' + dept.dept_idx + ')">'+dept.dept_name+'</div>';
                content+='<tbody><tr><td onclick="approval_team_detail('+dept.dept_idx+')">'+dept.dept_name+'</td></tr>'
            }
    }

    //html 넣어주기
  if(dept.dept_depth === 2){
      console.log('부서 html 추가');
      $('#all_dept_wrapper').html(content);
  }else if(dept.dept_depth === 3){
      console.log('team html 추가');
      console.log('team content:',content);

      $('table[dept_idx="' + dept.dept_high + '"]').html(content);

      console.log("상위부서 번호:",dept.dept_high);
      console.log("팀추가");
        //클릭한 상위부서 idx 기반으로 넣어줘야할 듯


  }
}

//부서 클릭 -> 부서 내 모든 팀원 가져오는 함수
function approval_dept_detail(dept_idx){
    console.log(dept_idx);

    //부서원들 전부 데려오기
    $.ajax({
        type : 'GET',
        url : 'approval_dept_allempl.ajax',
        data : {'dept_idx':dept_idx},
        dataType: 'JSON',
        success : function(data){
            console.log(data.empl);
            approval_draw_empllist(data.empl,dept_idx);

        },error : function (e){
            console.log(e);
        }
    });

}



//팀 클릭 -> 팀의 모든 팀원 가져오는 함수
function approval_team_detail(dept_idx){
    $.ajax({
        type : 'GET',
        url : 'approval_team_allempl.ajax',
        data : {"team_idx": dept_idx},
        dataType : 'JSON',
        success : function(data){
            console.log(data);
            console.log("팀원 정보",data.empl);
            approval_draw_empllist(data.empl,dept_idx);
        }, error : function(e){
            console.log(e);
        }
    });
}

//가져온 사원 목록 보여주는 함수
function approval_draw_empllist(data,dept_idx){
    content = '';
    console.log("사원 리스트 보여주는 함수");
    console.log(data);
    for(var empl of data){
        console.log(empl);
        console.log(empl.empl_idx);
        console.log(empl.dept_name);

        //content += '<div class="empl_individual" onclick="approval_selected_line('+empl.dept_idx+','+empl.empl_idx+',\''+empl.dept_name+'\','+empl.duty_idx+',\''+empl.empl_name+'\',\''+empl.duty_name+'\',\''+empl.position_name+'\','+ empl.position_idx+')">' + empl.empl_name + ' (' + empl.duty_name + '/' + empl.position_name + ') </div>';
        content+='<tr onclick="approval_selected_line('+empl.dept_idx+','+empl.empl_idx+',\''+empl.dept_name+'\','+empl.duty_idx+',\''+empl.empl_name+'\',\''+empl.duty_name+'\',\''+empl.position_name+'\','+ empl.position_idx+')"><td class="td_align_top td_no_padding"><img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" /></td><td><p>' + empl.empl_name + ' (' + empl.dept_name + '/' + empl.position_name + ')</p><p class="min font_subtle">'+empl.duty_name+'</p></td></tr>';

    }
    $('#empl_wrapper').html(content);
}

var empl_i = 0;
var empl_n ='';
var position_i =0;
var position_n ='';

var duty_i = 0;
var duty_n = '';

var dept_i = 0;
var dept_n = '';

//결재선 선택하고 > 결재선 보내기 위해 값을 세팅하는 함수
function approval_selected_line(dept_i1,empl_idx,dept_name,duty_idx,empl_name,duty_name,position_name,position_idx){
    console.log('부서 idx',dept_i1);
    console.log('부서 이름',dept_name);


    console.log('사원 idx',empl_idx);
    console.log('사원 이름',empl_name);

    console.log('직책 idx',duty_idx);
    console.log('직책 이름',duty_name);

    console.log('직급 idx',position_idx);
    console.log('직급 이름',position_name);

        //$('#send_val').val(empl_idx);//삭제해야함
        empl_i= empl_idx;
        empl_n = empl_name;
        dept_i2 = dept_i1;
        dept_n = dept_name;
        duty_i = duty_idx;
        duty_n = duty_name;
        position_i = position_idx;
        position_n = position_name;
}

//결재선 선택했는지 안 선택했는지 구별하는 플래그
var selected = 0;

//결재선 보내는 함수
function approval_send_line(){
    //var send_val = $('#send_val').val(); //삭제해야함
   //console.log('send_val:',send_val);

    tst_modal_close('tst_modal_select');
    selected = 1; //선택
    approval_get_lines(empl_i,empl_n,dept_i2,dept_n,duty_i,duty_n,position_i,position_n,step,selected);


    //window.close();
}


//결재선 선택하지 않음
function approval_line_none(){


    tst_modal_close('tst_modal_select');
    if(step !== 1){
        selected = 0;
        approval_get_lines(0,'',0,'',0,'',0,'',step,selected);
        window.close();
    }else{
        alert('1차 결재선은 반드시 지정해야합니다.');
    }

}

function approval_step_change_alert(approval_step_change_alert){
    console.log('approval_step_change_alert 실행');
    alert(approval_step_change_alert);
}