// 이름 정정 신청하기
function mypage_change_name(no) {
    // no: 사원번호
}

// 이름 정정 신청하기 > 파일 첨부시 시행되는 함수
// 사용하지 않으셔도 됩니다.
function tst_file_name(elem) {
    // elem: 파일 입력창
}



// 증명 서류 제출하기
function mypage_summit_file(key) {
    // key: 파일 키
}

// 증명 서류 제출하기 > 파일 첨부시 시행되는 함수
// 개당 2mb 미만, 최대 5개의 파일만 첨부할 수 있습니다. pdf, jpg, png 파일만 첨부할 수 있습니다.
// 위 규칙을 벗어나면 alert을 띄우세요.
function tst_file_summit(elem) {
    // elem: 파일 입력창
}



// 직인 파일 첨부하기
function mypage_summit_stamp(no) {
    // no: 사원번호
}

// 직인 파일 첨부하기 > 파일 첨부시 시행되는 함수
// 2mb 미만의 gif, png 파일만 첨부할 수 있습니다.
// 위 규칙을 벗어나면 alert을 띄우세요.
function tst_file_summit(elem) {
    // elem: 파일 입력창

    // 파일 미리보기는 '#image_preview'에 아래와 같이 입력하시면 됩니다.
    //
    // <div id="img_preview" className="tst_col12 align_center align_middle"></div>
    //
    //  ▼ 위의 div에 아래와 같이 이미지를 삽입하세요.
    //
    // <div id="img_preview" className="tst_col12 align_center align_middle">
    //     <img src="{이미지 바이너리 코드}" className="companyinfo_stamp"/>
    // </div>

}