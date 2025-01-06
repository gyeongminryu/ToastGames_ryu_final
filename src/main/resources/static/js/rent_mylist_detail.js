document.addEventListener("DOMContentLoaded", function () {
    const rentStateElement = document.getElementById("prod_rent_state");
	const rentCancelButton = document.getElementById("rentCancelButton"); // 버튼을 가져오기


    if (rentStateElement) {
        const rentStateValue = rentStateElement.getAttribute("data-value"); // data-value 속성 값 가져오기
        console.log("대여 상태 값 (data-value):", rentStateValue);

        // 값에 따라 조건 처리
        if (rentStateValue === "4") {
            if (rentCancelButton) {
            	rentCancelButton.style.display = "none"; // 버튼 숨기기
        	}
		}else{
		    if (rentCancelButton) {
            	rentCancelButton.style.display = "flex"; // 버튼 숨기기
        	}
		}
    } else {
        console.error("'prod_rent_state' 요소를 찾을 수 없습니다.");
    }
});

