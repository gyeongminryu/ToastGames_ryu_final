//자식창 결재선
//결재선을 선택하여 부모창에 보내는 js

//자식창에서 부모창에서 보낸 param 값(결재 순서) 받기
var url = new URLSearchParams(window.location.search);

var step = url.get('step');
console.log('부모창에 전달 받은 값',step);

//부서(상위부서) 보여주기
window.onload = function initialize(){
    approval_get_high_dept();
};
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
function approval_dept_open(dept_idx){
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

            if(dept.dept_depth == 2){
                content += '<div class="dept_wrapper"><div class = "dept_open" onclick = approval_dept_open('+dept.dept_idx+')>▼</div><div class="dept_subject" onclick="approval_dept_detail(' + dept.dept_idx + ')">'+dept.dept_name+'</div><div class="team_wrapper" dept_idx ="'+dept.dept_idx+'"></div></div>';
            }else if(dept.dept_depth == 3){
                content += '<div class="team_subject" onclick="approval_team_detail(' + dept.dept_idx + ')">'+dept.dept_name+'</div>';
            }
    }
    
    //html 넣어주기
  if(dept.dept_depth == 2){
      $('#all_dept_wrapper').html(content);
  }else if(dept.dept_depth == 3){
      console.log('team html 추가');

      $('.team_wrapper[dept_idx="' + dept.dept_high + '"]').html(content);

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
            approval_draw_empllist(data.empl);

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

        content += '<div class="empl_individual" onclick="approval_selected_line('+empl.dept_idx+','+empl.empl_idx+',\''+empl.dept_name+'\','+empl.duty_idx+',\''+empl.empl_name+'\',\''+empl.duty_name+'\',\''+empl.position_name+'\','+ empl.position_idx+')">' + empl.empl_name + ' (' + empl.duty_name + '/' + empl.position_name + ') </div>';
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

//결재선 보내는 함수
function approval_send_line(){
    //var send_val = $('#send_val').val(); //삭제해야함
   //console.log('send_val:',send_val);

    opener.approval_get_lines(empl_i,empl_n,dept_i2,dept_n,duty_i,duty_n,position_i,position_n,step);
    window.close();

}
