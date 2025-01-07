document.getElementById("product_dispo_button").addEventListener("click", function () {
    if (getUpdateStatus()) {
        submitDispoForm();
    } else {
        alert("수정이 취소되었습니다. 다시 시도해주세요.");
    }
});


// 폼 제출 처리 (삭제되지 않은 파일만 전송)
function submitDispoForm() {


	console.log(use_date);
    var form = document.querySelector("form[action='productDispo.do']");
    var formData = new FormData(form);

    
    // FormData에 파일이 없는 경우 처리
    if (formData.getAll('attached_file').length === 0) {
        console.warn("첨부된 파일이 없습니다.");
    }

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/productDispo.do", true);

    // 응답 형식을 JSON으로 설정
    xhr.responseType = 'json';
    
	xhr.onload = function() {
	    if (xhr.status === 200) {
	        var response = xhr.response;
	        if (response.status === "success") {
	            // 리다이렉트 수행
	            window.location.href = response.redirectUrl;
	        } else {
	            console.error(response.message);
	        }
	    } else {
	        console.error('Error:', xhr.statusText);
	    }
	};

    // 폼 데이터를 서버로 전송
    xhr.send(formData);
}