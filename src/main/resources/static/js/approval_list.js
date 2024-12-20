

window.onload = function initialize(){
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



};


//클릭하면 부서 idx 아래 팀 목록 가져오는 함수


//가져온 부서/팀 이름 뿌리기
var content = '';
function approval_draw_deptlist(data){
    content = '';
    for (var dept of data){
        //console.log(dept);
        console.log(dept.dept_name);
        console.log(dept.dept_idx);
        console.log(dept.dept_depth);
        if(dept.dept_depth == 2){
            content += '<div class="dept_wrapper"><div class = "dept_open" onclick = function dept_open('+dept.dept_idx+')>▼</div><div class="dept_subject" onclick="dept_detail(' + dept.dept_idx + ')">'+dept.dept_name+'</div><div class="team_wrapper" dept_idx ='+dept.dept_idx+'></div></div>';
        }else if(dept.dept_depth == 1){
            content += '<div class="team_subject" onclick="team_detail(' + dept.dept_idx + ')">'+dept.dept_name+'</div>';
        }
    }
  if(dept.dept_depth == 2){
      $('#all_dept_wrapper').html(content);
  }else if(dept.dept_depth == 1){
      //$('#team_wrapper[dept_idx]').html(content);
        //클릭한 상위부서 idx 기반으로 넣어줘야할 듯
  }
}


function dept_detail(dept_idx){
    console.log(dept_idx);
    
    //부서원들 전부 데려오기
    $.ajax({
        type : 'GET',
        url : 'approval_dept_allempl.ajax',
        data : {'dept_idx':dept_idx},
        dataType: 'JSON',
        success : function(data){
            console.log(data);

        },error : function (e){
            console.log(e);
        }
    });

}
