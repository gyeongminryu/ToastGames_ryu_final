    
    //회의실 등록 부서 확인
    /*const empl_depart_idx = "${my_dept_idx}";
    const room_depart_idx = "108";
    
    document.addEventListener("DOMContentLoaded", function() {
    	const editButton = document.getElementById("editButton");
    	const confirmButton = document.getElementById("confirmButton");
    	const deleteButton = document.getElementById("deleteButton");

    	// 현재 사용자와 관리사원의 empl_idx가 다를 경우 버튼 숨김
    	if (empl_depart_idx !== room_depart_idx) {
        	editButton.style.display = "none";
        	confirmButton.style.display = "none";
        	deleteButton.style.display = "none";
    	}
	});*/
    

    
    var editButton = document.getElementById("editButton");
    var confirmButton = document.getElementById("confirmButton");
    var deleteButton = document.getElementById("deleteButton");
    var table = document.getElementById("meeting_room_detail");
    var editableCells = table.querySelectorAll(".editable");

    var isEditing = false;

    // 수정 버튼 클릭 시
    editButton.addEventListener("click", function() {
        if (!isEditing) {
            editableCells.forEach(function(cell) {
                var currentValue = cell.textContent;
                cell.innerHTML = '<input type="text" value="' + currentValue + '" />';
            });
            isEditing = true;
            editButton.style.display = "none";
            confirmButton.style.display = "inline-block";
        }
    });

    // 확인 버튼 클릭 시
    confirmButton.addEventListener("click", function() {
        if (isEditing) {
            editableCells.forEach(function(cell) {
                var input = cell.querySelector("input");
                var newValue = input.value;
                cell.textContent = newValue;
            });
            isEditing = false;
            editButton.style.display = "inline-block";
            confirmButton.style.display = "none";

            // 수정된 데이터를 FormData로 준비
            var formData = new FormData();
            
            editableCells.forEach(function(cell) {
                var key = cell.dataset.key;
                var value = cell.textContent;
                formData.append(key, value);
            });


            // room_idx를 FormData에 추가
            var roomIdx = document.getElementById("room_idx").value;
            formData.append("room_idx", roomIdx);

            // 서버로 FormData 전송
            fetch("/meeting/updateMeetingRoomDetail.do", {
                method: "POST",
                body: formData
            })
            .then(function(response) {
                return response.json();
            })
            .then(function(result) {
                console.log("서버 응답:", result);
                alert("회의실 정보가 수정되었습니다");
            })
            .catch(function(error) {
                console.error("에러 발생:", error);
                alert("회의실 정보수정에 실패하였습니다");
            });
        }
    });

    // 삭제 버튼 클릭 시
    deleteButton.addEventListener("click", function() {
        if (confirm("정말로 이 회의실 정보를 삭제하시겠습니까?")) {
            // 삭제 요청
            var room_idx = document.getElementById("room_idx").value; // room_idx를 가져옵니다.
            var image_src = document.getElementById("meeting-room-photo").src;  // 이미지의 src를 가져옵니다.
        	var new_filename = image_src.split("/").pop();  // src에서 파일명만 추출
        	
            console.log("삭제할 ID:", room_idx);
            console.log("삭제할 파일명:", new_filename);

            fetch("/meeting/deleteMeetingRoom.do", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"  // JSON 형식으로 전송
                },
                body: JSON.stringify({
                    room_idx: room_idx,  // 삭제할 room_idx를 JSON 형식으로 전송
                    image_filename: image_filename  // 삭제할 이미지 파일명
                })
            })
            .then(function(response) {
                return response.json();
            })
            .then(function(result) {
                console.log("서버 응답:", result);
                alert("회의실 정보가 삭제되었습니다");
                window.location.href = "meeting.go";
            })
            .catch(function(error) {
                console.error("에러 발생:", error);
                alert("회의실 정보삭제에 실패하였습니다");
            });
        }
    });