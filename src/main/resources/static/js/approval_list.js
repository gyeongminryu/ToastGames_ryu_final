//자식창에서 부모창에서 보낸 param 값 받기
var url = new URLSearchParams(window.location.search);

var step = url.get('step');
console.log('부모창에 전달 받은 값',step);


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
            approval_draw_deptlist(data.dept);

        },error : function(e){
            console.log(e);
        }
    });

}

//팀 가져오는 함수
function approval_dept_open(dept_idx){
    console.log(dept_idx);
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


//가져온 부서/팀 이름 html에 띄우기
var content = '';
function approval_draw_deptlist(data){
    content = '';
    for (var dept of data){
        //console.log(dept);
        console.log("부서 이름:",dept.dept_name);
        console.log("부서 idx:",dept.dept_idx);
        console.log("부서 체계:",dept.dept_depth);

            if(dept.dept_depth == 2){
                content += '<div class="dept_wrapper"><div class = "dept_open" onclick = approval_dept_open('+dept.dept_idx+')>▼</div><div class="dept_subject" onclick="approval_dept_detail(' + dept.dept_idx + ')">'+dept.dept_name+'</div><div class="team_wrapper" dept_idx ="'+dept.dept_idx+'"></div></div>';
            }else if(dept.dept_depth == 3){
                content += '<div class="team_subject" onclick="approval_team_detail(' + dept.dept_idx + ')">'+dept.dept_name+'</div>';
            }

    }
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

//부서의 모든 팀원 가져오는 함수
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



//팀의 모든 팀원 가져오는 함수
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

function approval_draw_empllist(data,dept_idx){
    content = '';
    console.log("사원 리스트 보여주는 함수");
    console.log(data);
    for(var empl of data){
        console.log(empl);
        console.log(empl.empl_idx);
        content += '<div class="empl_individual" onclick="approval_selected_line('+dept_idx+','+empl.empl_idx+','+empl.duty_idx+',\''+empl.empl_name+'\',\''+empl.duty_name+'\',\''+empl.position_name+'\')">' + empl.empl_name + ' (' + empl.duty_name + '/' + empl.position_name + ') </div>';
    }
    $('#empl_wrapper').html(content);
}

var empl_i = 0;
var empl_n ='';
var position ='';
var duty = '';
var duty_i = 0;
var dept_i = 0;

function approval_selected_line(dept_idx,empl_idx,duty_idx,empl_name,duty_name,position_name){
        console.log(empl_idx);
        console.log(empl_name);

        console.log(duty_name);
        console.log(position_name);

        $('#send_val').val(empl_idx);
        empl_i= empl_idx;
        dept_i = dept_idx;
        duty_i = duty_idx;
        empl_n = empl_name;
        position = position_name;
        duty = duty_name;

}

function approval_send_line(){
   var send_val = $('#send_val').val();
   console.log('send_val:',send_val);

    opener.approval_get_lines(empl_i,dept_i,duty_i,empl_n,position,duty,step);
    window.close();

}
