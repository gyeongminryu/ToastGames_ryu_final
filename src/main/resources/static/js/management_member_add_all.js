

function management_set_empldata(){
    console.log("함수 실행");
    /*배열 형태로 name값으로 가져온 내용들을 [0]~ 이렇게 분리해서 순차적으로 넣는 방법*/
    console.log("row_length",row_length);

    // 모든 input 요소를 선택
    const inputs = document.querySelectorAll('input');

    // 각 input의 name 속성을 배열로 추출
    const names = Array.from(inputs).map(input => input.name)
      .filter(name => name)            // 빈 name을 제외
      .filter((value, index, self) => self.indexOf(value) === index); // 중복 제외;

    // 출력
    console.log(names);

        let data_list = [];
        for (var i = 0;i<row_length-1;i++){
            let data = {};
            for(var name of names){ //이름들을 하나씩 넣음
                console.log(name);
                var name_key = "'"+name+"'";
                var nameElement = document.getElementsByName(name)[i];
                console.log(nameElement);
                data[name] = nameElement.value;
                console.log("data",data);

            }
            data_list.push(data);
            console.log("data_list",data_list);

          }
        console.log("data_list",data_list);

        management_save_empldata(data_list);
}

/*function management_save_empldata(data_list){

    $.ajax({
        type : 'POST',
        url : 'empl_add_all.ajax',
        data : data_list,
        dataType : 'JSON',
        success : function (data){
            console.log(data);
        },error : function(e){
            console.log(e);
        }
    })
}*/


function management_save_empldata(data_list){
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
        },error : function(e){
            console.log(e);
        }
    })
}
