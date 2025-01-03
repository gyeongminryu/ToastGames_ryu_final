var doc_idx = $('#doc_idx').val();
var empl_idx = $('#empl_idx').val();

var my_appr_order=$('#my_appr_order').val();

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
    var line_url = "signatureImage"+my_appr_order;
    console.log(line_url);
    const signatureImage = document.getElementById(line_url);
    //만약 사인된 게 있으면,

    //사인된 게 있는지 확인하는 법
    var isValid = context.getImageData(0, 0, canvas.width, canvas.height).data.some(channel => channel !== 0);

    console.log(isValid);

    var src = '';
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

        signatureImage.src = src;
        //사인된거 혹은 도장이 있을 경우에는
        signatureImage.style.display = "block";
        signatureImage.width = 50; // 원하는 너비로 설정
        signatureImage.height = 50; // 원하는 높이로 설정
        //html을 업데이트 해주기
        var doc_content = $('.doc_content').html();
        //console.log("doc_content",doc_content);


        // 켜기
        save_approved_doc_content(doc_content);
    }else{
        //직인이 있거나, 도장이 없는 경우 처리 -> alert 띄움
        //아예 서명도 도장도 안된 경우
        alert('서명 혹은 도장을 등록해주세요!');
    }



}

function save_approved_doc_content(doc_content){
    var line_order = Number(my_appr_order)+1;

    $.ajax({
        type : 'POST',
        url : 'save_approved_doc_content.ajax',
        data : {"doc_content":doc_content,"doc_idx":doc_idx,"line_order": line_order},
        dataType : 'JSON',
        success : function (data){
            console.log(data);
            console.log(location.pathname); //hostname(도메인)을 제외한 나머지 주소

                    location.href = "/approval_received_list.go";


        },error : function(e){
            console.log(e);
        }
    })

}