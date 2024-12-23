//부모창 결재선
//결재선 선택 위해 결재도를 여는 js
var content = '';
function approval_line_window(step){
    console.log("결재 step",step);
    var win;

    //자식창에 결재 라인 step 전달
    //encodeURIComponent
    win = window.open('/approval_list.go?step='+ encodeURIComponent(step),'approval_list','height=300,left=100,top=100');

}

//자식창에서 받은 값을 토대로 이름 및 직급/직책 가져와서 보여주기
function approval_get_lines(empl_i,empl_n,dept_i,dept_n,duty_i,duty_n,position_i,position_n,step){
    console.log("empl_i 자식창에서 전달 받음",empl_i);
    console.log("dept_i 자식창에서 전달 받음",dept_i);
    console.log("duty_i 자식창에서 전달 받음",duty_i);
    console.log("position_i 자식창에서 전달 받음",position_i);

    console.log("empl_n 자식창에서 전달 받음",empl_n);
    console.log("dept_n 자식창에서 전달 받음",dept_n);
    console.log("position 자식창에서 전달 받음",position_n);
    console.log("duty 자식창에서 전달 받음",duty_n);
    console.log("step 자식창에서 전달 받음",step);

    content = empl_n +'('+dept_n +'/'+position_n+')';
    document.getElementById('approval_line'+step).innerHTML = content;
    document.getElementById('empl_line'+step).value = empl_i;
    document.getElementById('dept_line'+step).value = dept_i;
    document.getElementById('duty_line'+step).value = duty_i;
    document.getElementById('duty_line'+step).value = duty_i;

}


