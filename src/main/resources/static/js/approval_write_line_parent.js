//부모창 결재선
//결재선 선택 위해 결재도를 여는 js
var content = '';
var win;

//console.log("참조 count 준비? :",refer_count);


function approval_line_window(step){
    console.log("결재 step",step);


    //자식창에 결재 라인 step 전달
    //encodeURIComponent
    win = window.open('/approval_list.go?step='+ encodeURIComponent(step),'approval_list','height=300,left=100,top=100');

}

//자식창에서 받은 값을 토대로 이름 및 직급/직책 가져와서 보여주기
function approval_get_lines(empl_i,empl_n,dept_i,dept_n,duty_i,duty_n,position_i,position_n,step,selected){
    console.log("empl_i 자식창에서 전달 받음",empl_i);
    console.log("dept_i 자식창에서 전달 받음",dept_i);
    console.log("duty_i 자식창에서 전달 받음",duty_i);
    console.log("position_i 자식창에서 전달 받음",position_i);

    console.log("empl_n 자식창에서 전달 받음",empl_n);
    console.log("dept_n 자식창에서 전달 받음",dept_n);
    console.log("position 자식창에서 전달 받음",position_n);
    console.log("duty 자식창에서 전달 받음",duty_n);
    console.log("step 자식창에서 전달 받음",step);

    var step_num = parseInt(step)+1;
    //empl_i == null && empl_n == null
    //만약 전달 받은 값이 null
    console.log(selected);
    
    //step이 0이 아닐 때는 approval에 추가
    if(step !=0){
        if(selected === 1){
            content = empl_n +'('+dept_n +'/'+position_n+')';

            document.getElementById('approval_line'+step).innerHTML = content;
            document.getElementById('empl_line'+step).value = empl_i;
            document.getElementById('dept_line'+step).value = dept_i;
            document.getElementById('duty_line'+step).value = duty_i;
            document.getElementById('position_line'+step).value = position_i;

        }else if(selected ===0){

            //마지막 3차 결재선은 innerHTML을 먼저 조회하면 null때문에 에러가 생기므로, step_num의 요소부터 있는지 확인하기
            if(document.getElementById('approval_line'+step_num)){


                //다음에 있는 값을 삭제된 결재선으로 넣기
                if(document.getElementById('approval_line'+step_num).innerHTML!==''){
                    console.log(document.getElementById('approval_line'+step_num).innerHTML);
                    var approval_step_change_alert = step+'차 결재선을 지정하지 않아,'+ step_num+'차 결재선에 있던 결재자로 대체됩니다.';
                    win.approval_step_change_alert(approval_step_change_alert);
                    //만약 다음에 있는 값의 html이 비지 않았다면 옮기기
                    document.getElementById('approval_line'+step).innerHTML = document.getElementById('approval_line'+step_num).innerHTML;
                    document.getElementById('empl_line'+step).value =document.getElementById('empl_line'+step_num).value;
                    document.getElementById('dept_line'+step).value =  document.getElementById('dept_line'+step_num).value;
                    document.getElementById('duty_line'+step).value = document.getElementById('duty_line'+step_num).value;
                    document.getElementById('position_line'+step).value = document.getElementById('position_line'+step_num).value;

                    //step+1에 있는 값은 지우기
                    document.getElementById('approval_line'+step_num).innerHTML = '';
                    document.getElementById('empl_line'+step_num).removeAttribute('value');
                    document.getElementById('dept_line'+step_num).removeAttribute('value');
                    document.getElementById('duty_line'+step_num).removeAttribute('value');
                    document.getElementById('position_line'+step_num).removeAttribute('value');

                }else{
                    //이전에 있던 값 지우기
                    document.getElementById('approval_line'+step).innerHTML = '';
                    document.getElementById('empl_line'+step).removeAttribute('value');
                    document.getElementById('dept_line'+step).removeAttribute('value');
                    document.getElementById('duty_line'+step).removeAttribute('value');
                    document.getElementById('position_line'+step).removeAttribute('value');

                }

            }
        }
    }else{
        //refer_count 없애기
        content ='';
        //step이 0일 때는 참조에 추가
        content += '<div class ="referrer_element">참조<div class="referrer">'+empl_n+'('+dept_n+'/'+position_n+')'+'</div>';
        content += ' <input type="hidden" name = "r_empl_line" id = "r_empl_line" value ="'+empl_i+'"/>'
        //삭제 버튼
        content+='<div class="delete_refer" onclick="delete_refer(this)">제외하기</div></div>';
        console.log(content);

        $('#referrer_list').append(content);

        //refer_count++;

    }
}

function delete_refer(evt){
    //var referrer_element = '#referrer_element'+ count;
    $(evt).closest('.referrer_element').remove();
}

