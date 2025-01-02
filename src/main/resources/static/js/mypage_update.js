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
    // 파일 입력 요소 가져오기
    var fileInput = document.getElementById('fileInput');
    var files = fileInput.files;
    
    var maxFileSize = 2 * 1024 * 1024; // 2MB
    var allowedTypes = ['application/pdf', 'image/jpeg', 'image/png', 'image/gif'];

    console.log('선택된 파일들:', files); // 파일 목록 확인  

    // 파일이 선택되지 않았을 경우 처리
    if (files.length === 0) {
        alert('파일을 선택해주세요.');
        return;  // 종료
    }

    // 파일 수 체크
    if (files.length > 5) {
        alert('최대 5개의 파일만 첨부할 수 있습니다.');
        return;  // 종료
    }

    // 파일 검증 (크기 및 형식)
    for (let file of files) {
        console.log('검증 중인 파일:', file); // 현재 검증 중인 파일
        
        // 파일 크기 체크
        if (file.size > maxFileSize) {
            alert('파일 크기는 2MB 이하만 허용됩니다.');
            return;  // 종료
        }

        // 파일 형식 체크
        if (!allowedTypes.includes(file.type)) {
            alert('pdf, jpg, png, gif 파일만 첨부할 수 있습니다.');
            return;  // 종료
        }
    }

    console.log('파일 검증 완료, 파일 준비 완료');

     var formData = new FormData($('#fileUploadForm')[0]);  // FormData로 폼 데이터 가져오기
	    $.ajax({
	        url: 'fileUpload.ajax',        // 파일 업로드 URL
	        type: 'POST',
	        data: formData,              // FormData로 전송
	        processData: false,          // 자동 처리 안함
	        contentType: false,          // contentType 자동 설정 안 함
	        success: function(response) {
	            updateFileList(response);  // 응답으로 받은 파일 리스트로 테이블 갱신
	            console.log('파일 업로드 성공', response);  // 서버 응답 출력
	        },
	        error: function(xhr, status, error) {
	            console.log('파일 업로드 실패', error);  // 오류 출력
	        }
	    });
	}

// 증명 서류 제출하기 > 파일 첨부시 시행되는 함수
// 개당 2mb 미만, 최대 5개의 파일만 첨부할 수 있습니다. pdf, jpg, png 파일만 첨부할 수 있습니다.
// 위 규칙을 벗어나면 alert을 띄우세요.



function tst_file_summit(elem) {
    // elem: 파일 입력창
}

	// 파일 업로드 후 파일 리스트를 갱신하는 함수
	function updateFileList(fileList) {
	    var tableBody = $('#fileListTableBody');
	    tableBody.empty();  // 기존 파일 리스트 지우기
	
		 if (fileList.length === 0) {
        // 첨부 파일이 없을 경우 메시지 추가
        tableBody.append('<tr><td colspan="2" class="td_align_center"><span class="font_subtle">첨부 파일이 없습니다.</span></td></tr>');
		} else {
        // 첨부 파일이 있을 경우 파일 목록을 표에 추가
	    fileList.forEach(function(file) {
	        var row = $('<tr></tr>'); // 새로운 테이블 행 생성
	        var fileNameCell = $('<td></td>').text(file.ori_filename); // 파일 이름 셀
	        row.append(fileNameCell);
	        tableBody.append(row);  // 테이블에 행 추가
	    });
	}
}
// 페이지 로드 시, 초기 파일 목록을 서버에서 가져와서 표시
	$(document).ready(function() {
	    $.ajax({
	        url: 'getFileList.ajax',   // 서버에서 파일 목록을 가져오는 URL
	        type: 'GET',
	        success: function(response) {
	            updateFileList(response);  // 파일 목록을 화면에 표시
	        },
	        error: function(xhr, status, error) {
	            console.log('파일 목록 불러오기 실패', error);  // 오류 출력
	        }
	    });
	});
	
	
// 기존 비밀번호 입력창에서 벗어날 때 호출되는 함수
document.getElementById("currentPassword").addEventListener("blur", function() {
    checkCurrentPassword();  // 기존 비밀번호 확인
});

// 기존 비밀번호 확인 함수
function checkCurrentPassword() {
    var currentPassword = document.getElementById("currentPassword").value;

    // AJAX로 서버에 기존 비밀번호를 확인
    $.ajax({
        url: 'checkCurrentPw.ajax',
        type: 'POST',
        data: { currentPassword: currentPassword },
        success: function(response) {
            if (response.status === 'error') {
                // 기존 비밀번호 오류 메시지 표시
                document.getElementById("currentPasswordError").classList.remove('disp_hide');
                document.getElementById("newPasswordPrompt").classList.add('disp_hide');
            } else {
                // 기존 비밀번호가 맞다면, 새 비밀번호 입력 안내 표시
                document.getElementById("newPasswordPrompt").classList.remove('disp_hide');
                document.getElementById("currentPasswordError").classList.add('disp_hide');
            }
        },
        error: function() {
            console.log("비밀번호 확인 요청 실패");
        }
    });
}

// 비밀번호 변경 처리 함수
function submitPasswordChange() {
    var currentPassword = document.getElementById("currentPassword").value;
    var newPassword = document.getElementById("newPassword").value;
    var confirmPassword = document.getElementById("confirmPassword").value;

    // 비밀번호와 확인 비밀번호가 일치하는지 확인
    if (newPassword !== confirmPassword) {
        document.getElementById("passwordMismatchError").classList.remove('disp_hide');
        return;
    } else {
        document.getElementById("passwordMismatchError").classList.add('disp_hide');
    }

    // 비밀번호 변경 요청
    $.ajax({
        type: 'POST',
        url: 'changePw.ajax',  // 비밀번호 변경 요청 URL
        data: {
            currentPassword: currentPassword,
            newPassword: newPassword,
            confirmPassword: confirmPassword
        },
        dataType: 'json',
        success: function(response) {
            if (response.status === "error") {
                // 에러 메시지 출력
                document.querySelector('.min.font_caution').classList.remove('disp_hide');
           } else if (response.status === "success") {
                // 비밀번호 변경 성공 후 모달 닫고 입력값 및 메시지 초기화
                tst_modal_close('tst_modal_password');  // 모달 닫기
            }
        },
        error: function() {
            $('#resultMessage').text("비밀번호 변경에 실패했습니다.");
        }
    });
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