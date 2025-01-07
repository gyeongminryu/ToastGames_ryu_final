document.addEventListener("DOMContentLoaded", function () {
    const rentStateElement = document.getElementById("prod_rent_state");
	const rentCancelButton = document.getElementById("rentCancelButton"); // 버튼을 가져오기


    if (rentStateElement) {
        const rentStateValue = rentStateElement.getAttribute("data-value"); // data-value 속성 값 가져오기
        console.log("대여 상태 값 (data-value):", rentStateValue);

        // 값에 따라 조건 처리
        if (rentStateValue === "4") {
            if (rentCancelButton) {
            	rentCancelButton.style.display = "flex"; // 버튼 숨기기
        	}
		}else{
		    if (rentCancelButton) {
            	rentCancelButton.style.display = "none"; // 버튼 숨기기
        	}
		}
    } else {
        console.error("'prod_rent_state' 요소를 찾을 수 없습니다.");
    }
});

document.getElementById("product_cancel_request_button").addEventListener("click", function () {
    if (getRentStatus()) {
        submitRentCancelForm();
    } else {
        alert("대여 신청이 취소가 중단되었습니다. 다시 시도해주세요.");
    }
});




// 폼 제출 처리 (삭제되지 않은 파일만 전송)
function submitRentCancelForm() {

	const prod_idx = document.getElementById("prod_idx").textContent.trim();
    const prod_rent_idx = document.getElementById("prod_rent_idx").textContent.trim();
    
    $.ajax({
        type: 'GET',
        url: '/rentRequestCancel.ajax', 
        data:{
        	'prod_idx':prod_idx,
        	'prod_rent_idx':prod_rent_idx
        },
        dataType: 'json', 
        success: function(data) {
            // 서버에서 redirectURL 반환 시 페이지 이동
            if (data.redirectURL) {
                window.location.href = data.redirectURL;
            } else if (data.error) {
                // 에러 메시지가 반환되면 알림
                alert(data.error);
            }
        },
        error: function(e) {
            console.log("오류 발생", e);
        }       
    });

}

