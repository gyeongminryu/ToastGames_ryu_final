var doc_idx = $('#doc_idx').val();
var doc_subject = $('#doc_subject').val();
var doc_content_sub = $('#doc_content_sub').val();

var empl_idx = $('#empl_idx').val();
var doc_write_empl_idx = $('#doc_write_empl_idx').val();

var my_appr_order=$('#my_appr_order').val();
var my_appr_name=$('#my_appr_name').val();


console.log("doc_idx",doc_idx);
console.log("empl_idx",empl_idx);
console.log("my_appr_order",my_appr_order);

//직인 작성
const canvas = document.getElementById("canvas");
const context = canvas.getContext("2d");

let drawing = false;
canvas.addEventListener("mousedown", () => {
    drawing = true;
    context.beginPath(); //beginPath() : 새로운 경로를 만듦
});

canvas.addEventListener("mousemove", (event) => {
    if (!drawing) return;

    const x = event.clientX - canvas.getBoundingClientRect().left;
    const y = event.clientY - canvas.getBoundingClientRect().top;
    context.lineTo(x, y);//현재 위치에서 (x,y) 좌표로 직선을 그릴 경로 추가
    context.stroke();//실제 화면에 그리게 하는 메서드
});


canvas.addEventListener("mouseup", () => {
    drawing = false;
    context.closePath();
});

function approval_sign_close(){
    tst_modal_close('tst_modal_send');
    context.clearRect(0, 0, canvas.width, canvas.height);
}

function approval_sign_save(){
    //본인의 결재선에 사인 저장
    var line_url = "approval_name_"+my_appr_order;
        //"signatureImage"+my_appr_order;
    console.log("line_url",line_url);
    const signatureImage = document.getElementById(line_url);
    console.log("signatureImage",signatureImage);
    //만약 사인된 게 있으면,

    //사인된 게 있는지 확인하는 법
    var isValid = context.getImageData(0, 0, canvas.width, canvas.height).data.some(channel => channel !== 0);

    console.log(isValid);

    var src = '';

    //도장 이미지
    const sign_preview = document.getElementById('sign_preview');

    //직인이 있거나, 도장이 있는 경우 처리
    if(isValid || sign_preview.getAttribute("src")!=null){
        if(isValid){
            alert('서명으로 결재가 진행됩니다.');
            src = canvas.toDataURL();
        }else{
            alert('등록된 도장으로 결재가 진행됩니다.');
            //만약 사인된게 없으면 도장 사용
            console.log("sign_preview.src:",sign_preview.getAttribute("src"));
            src = sign_preview.getAttribute("src");
        }
        console.log("src",src);
        var line_sign_preview = document.getElementById(line_url);
        console.log("line_sign_preview",line_sign_preview);
        //line_sign_preview.innerHTML = '<img src='+src+' alt="image" width="70px" height="70px">';


        var img = document.createElement('img');

        //src 속성 설정
        img.src = src;
        img.alt = 'image';
        img.style.display = 'block';
        img.style.width = '40px';
        img.style.placeSelf = 'center';

        //부모 요소에 이미지 추기
        line_sign_preview.appendChild(img);

        //결재된 시간 넣기
        var appr_date = time_format();

        var date = appr_date.split(' ')[0]; // 공백을 기준으로 나누고 첫 번째 요소는 날짜

        var approval_date ="#approval_date_"+my_appr_order;
        $(approval_date).html(date);

        //div_copy 내용을 다시 붙여넣기
        

        setHtmlCode();
        //signatureImage.src = src;
        //사인된거 혹은 도장이 있을 경우에는
        //signatureImage.style.display = "block";
        //signatureImage.width = 50; // 원하는 너비로 설정
        //signatureImage.height = 50; // 원하는 높이로 설정


        /*signatureImage.style.backgroundImage = "url('" +src+"')";
        signatureImage.style.backgroundSize = "contain";*/

        console.log("signatureImage",signatureImage);
        //html을 업데이트 해주기 (확인)

        //var doc_content = $('.doc_content').html();
        var doc_content = editor1.getHTMLCode();

        console.log("doc_content",doc_content);
        // 켜기
        save_approved_doc_content(doc_content,appr_date);
    }else{
        //직인이 있거나, 도장이 없는 경우 처리 -> alert 띄움
        //아예 서명도 도장도 안된 경우
        alert('서명 혹은 도장을 등록해주세요!');
    }



}

function save_approved_doc_content(doc_content,appr_date){
    var line_order = Number(my_appr_order)+1;
    console.log("결재 후 line_order 값",line_order);


    $.ajax({
        type : 'POST',
        url : 'save_approved_doc_content.ajax',
        data : {"doc_content":doc_content,"doc_idx":doc_idx,"line_order": line_order,"appr_date":appr_date},
        dataType : 'JSON',
        success : function (data){
            console.log(data);
            console.log(location.pathname+location.search); //hostname(도메인)을 제외한 나머지 주소

                //최종 결재면 안 진행
                //결재 다음 사람에게 요청
                console.log("타겟 유저",data.target_user);
                //가져올 필요 없음
                //결재 요청자 가져오기
                doc_appr_subject ='';
                doc_appr_subject += $('#doc_write_empl_name').val();
                doc_appr_subject += '가 결재를 요청한 문서가 있습니다. (결재 마감일시 = ';
                doc_appr_subject+= $('#doc_end_date').val();
                doc_appr_subject+=')';


                //웹소켓
                //1.결재 요청 알람 -- 다음 결재자
                approval_insert_notify_promise(location.pathname+location.search,data.target_user,empl_idx,doc_appr_subject,doc_content_sub,1).then(function (){
                console.log("첫 번째 알림 완료");
                //2.결재 승인 알람 -- 결재 요청자
                //sent 주소로 넣기
                //approval_set_notify(data.target,location.pathname);
                    doc_content_sub = my_appr_name;
                    url = '/approval_sent_detail.go?doc_idx='+doc_idx+'&type=sent';
                    console.log(parseInt(doc_write_empl_idx));

                    doc_appr_subject =$('#doc_subject').val();
                    doc_content_sub = $('#my_appr_name').val();

                return approval_insert_notify_promise(url,parseInt(doc_write_empl_idx),empl_idx,doc_subject,doc_content_sub,2);
                }).then(function (){
                    console.log("두 번째 알림 완료");
                    location.href = "/approval_received_list.go";
                }).catch(function(e){
                console.log(e);
               })



        },error : function(e){
            console.log(e);
        }
    })

}

//프로미스로 감싸야 함
function approval_insert_notify_promise(url, target_user, empl_idx, doc_subject, doc_content_sub, type) {
    return new Promise(function(resolve, reject) {
        approval_insert_notify(url, target_user, empl_idx, doc_subject, doc_content_sub, type);
        resolve();  // 비동기 작업이 완료되었음을 알림
    });
}

function time_format(){
    let today = new Date(); //오늘 날짜에 대한 전체 정보

    let year = today.getFullYear();//년도 구하기
    let month = today.getMonth()+1;
    month = month.toString().padStart(2, '0'); //달 구하기 -> 1월 = 0,12월 = 11
    let date = today.getDate().toString().padStart(2, '0'); // 일 구하기

    let hours = today.getHours().toString().padStart(2, '0');
    let minutes = today.getMinutes().toString().padStart(2, '0');
    let seconds = today.getSeconds().toString().padStart(2, '0');

    //format
    var doc_date= year+'-'+month+'-'+date+ ' ' + hours+':'+minutes+':'+seconds;
    console.log("작성 일자:",doc_date);
    return doc_date;
}
