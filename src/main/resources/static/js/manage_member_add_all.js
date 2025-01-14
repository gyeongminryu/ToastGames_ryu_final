function manage_empl_exists(){
    let phone_number = [];

    var empl_per_phone = document.getElementsByName("empl_per_phone");
    console.log("empl_per_phones",empl_per_phone);
    for(var a = 0; a <empl_per_phone.length ; a++){
        console.log("empl_per_phone",empl_per_phone[a]);
        phone_number.push(empl_per_phone[a].value);
    }
    console.log('phone_number',phone_number);


    //phone number에 해당하는 값이 있는지
    $.ajax({
        url: '/manage_if_member_exists.ajax',
        type: 'POST', // HTTP 요청 방식
        contentType: 'application/json', // 전송 데이터 타입
        data: JSON.stringify({ phone_numbers: phone_number }), // 배열을 JSON 형식으로 전송
        success: function(data) {
            console.log("exists:", data.exists);
            var exist_members = data.exists;
            if(data.exists){
                alert('동일한 사원이 이미 존재합니다.');
                tst_modal_close('tst_modal_insert');
            }else{
                manage_set_empldata();
            }

        },
        error: function(xhr, status, error) {
            console.error("요청 실패:", error);
        }
    });

}

function manage_set_empldata(){
    //기존에 있는 사원인지 확인
        //핸드폰 번호 가져오기


    let i;
    let save = true;
    console.log("함수 실행");
    /*배열 형태로 name값으로 가져온 내용들을 [0]~ 이렇게 분리해서 순차적으로 넣는 방법*/
    console.log("row_length",row_length);

    // 모든 input 요소를 선택
    const inputs = document.querySelectorAll('.empl_info_input');

    // 각 input의 name 속성을 배열로 추출
    const names = Array.from(inputs).map(input => input.name)
      .filter(name => name)            // 빈 name을 제외
      .filter((value, index, self) => self.indexOf(value) === index); // 중복 제외;

    // 출력
    console.log(names);

        let data_list = [];
        for (i = 0; i<row_length-1; i++){
            let data = {};
            for(var name of names){ //이름들을 하나씩 넣음
                console.log(name);
                //var name_key = "input[name='"+name+"']";
                var nameElement = document.getElementsByName(name)[i];
                console.log(nameElement);
                if(nameElement.value === ''){
                    alert('입력되지 않은 정보가 있습니다.');
                    save = false;
                    break;
                }
                else{
                    data[name] = nameElement.value;
                }
                console.log("data",data);
            }
            data_list.push(data);
            console.log("data_list",data_list);
          }
        console.log("data_list",data_list);
        console.log("save",save);

        //이메일이 맞는지 확인
        var email = document.getElementsByName("empl_per_email");
        for(i = 0; i< email.length; i++){
            console.log(email[i].value);

            // 이메일 형식이 올바른지 확인하는 정규식
            var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            if (!emailRegex.test(email[i].value)) {
                alert("유효한 이메일 형식을 입력해 주세요.");
                save=false;
                break;
            }
        }

        //성별 기입이 올바른지 확인
        var gender = document.getElementsByName("empl_gender");
        for(i = 0; i< gender.length; i++){
            console.log(gender[i].value);
            if (gender[i].value !== '남' && gender[i].value !== '남자'&& gender[i].value !== '여'&& gender[i].value !== '여자') {
                alert("성별 란 입력이 올바르지 않습니다. 작성 가능한 문자는 '남','여','남자','여자'입니다.");
                save=false;
                break;
            }
        }


    console.log("save",save);


        //저장되는 함수
        if(save === true){
            console.log("일괄 등록 전송");
            management_save_empldata(data_list);
        }

        tst_modal_close('tst_modal_insert');
}




function management_save_empldata(data_list){

    const inputs = document.querySelectorAll('.empl_info_input');




    var param = {};
    param.list = data_list;
    console.log("param",param);
    $.ajax({
        type : 'POST',
        url : 'empl_add_all.ajax',
        data : JSON.stringify(param),
        contentType:'application/json; charset=UTF-8',
        dataType : 'JSON',
        success : function (data){
            console.log(data);
            alert('사원이 등록되었습니다.');
            location.href = '/employee_add_all.go';
        },error : function(e){
            console.log(e);
        }
    })
}
