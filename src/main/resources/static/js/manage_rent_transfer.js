function select_type(type){
    switch (type) {
        case 'sign':
            document.getElementsByClassName('sign_area')[0].style.display = 'block';
            document.getElementsByClassName('stamp_area')[0].style.display = 'none';
            document.getElementsByClassName('item_sign')[0].classList.add('tst_tablist_item_active');
            document.getElementsByClassName('item_stamp')[0].classList.remove('tst_tablist_item_active');
            break;
        case 'stamp':
            document.getElementsByClassName('sign_area')[0].style.display = 'none';
            document.getElementsByClassName('stamp_area')[0].style.display = 'flex';
            document.getElementsByClassName('item_sign')[0].classList.remove('tst_tablist_item_active');
            document.getElementsByClassName('item_stamp')[0].classList.add('tst_tablist_item_active');
            break;
    }
}

function show_team_list(elem, no){
    // no: 부서 번호
    let number = "'"+no+"'";
    elem.parentElement.parentElement.nextElementSibling.classList.remove('disp_hide');
    elem.parentElement.innerHTML = '<i class="bi bi-caret-down-fill" onclick="hide_team_list(this, '+number+')"></i>';
}

function hide_team_list(elem, no){
    // no: 부서 번호
    let number = "'"+no+"'";
    elem.parentElement.parentElement.nextElementSibling.classList.add('disp_hide');
    elem.parentElement.innerHTML = '<i class="bi bi-caret-right-fill" onclick="show_team_list(this, '+number+')"></i>';
}



// 선택한 파일을 저장할 배열
let selectedFiles = [];

document.getElementById('fileInput').addEventListener('change', function(event) {
	const previewContainer = document.getElementById('preview_row');

	// 새로 선택한 파일 추가
	const newFiles = Array.from(event.target.files);

	// 총 파일 개수 확인
	if (selectedFiles.length + newFiles.length > 5) {
		alert("최대 5개의 파일만 업로드할 수 있습니다.");
		event.target.value = ''; // 입력 초기화
		return;
	}

	// 새 파일 추가
	selectedFiles = selectedFiles.concat(newFiles);

	// 중복 제거 (같은 파일을 여러 번 추가 방지)
	const fileMap = new Map();
	selectedFiles.forEach(file => fileMap.set(file.name, file));
	selectedFiles = Array.from(fileMap.values());

	// 미리보기 초기화
	previewContainer.innerHTML = '';

	// 모든 선택된 파일을 미리보기로 추가
	selectedFiles.forEach(file => {
		if (file.type.startsWith('image/')) {
			const reader = new FileReader();

			reader.onload = function(e) {
				const img = document.createElement('img');
				img.src = e.target.result;
				previewContainer.appendChild(img);
			};

			reader.readAsDataURL(file);
		}
	});

	// 파일 입력 초기화 (같은 파일 다시 선택 가능하게 함)
	event.target.value = '';
});



//인계하기 버튼 클릭시
document.getElementById("product_transfer_button").addEventListener("click", function () {
    if (getDisposeStatus()) {
        submitDispoForm();
    } else {
        alert("수정이 취소되었습니다. 다시 시도해주세요.");
    }
});


// 폼 제출 처리 (삭제되지 않은 파일만 전송)
function submitDispoForm() {
    var prodIdx = document.querySelector("#prod_idx").textContent.trim(); // #prod_idx에서 텍스트 가져오기
    var form = document.querySelector("form[action='productTransfer.do']");
    var formData = new FormData(form);
    
    // 가져온 물품 번호를 FormData에 추가
    formData.append("prod_idx", prodIdx);

    // 파일 존재 여부 확인 후 유효한 파일만 추가
	var files = selectedFiles;  
	if (files.length > 0) {
	    // 파일이 있는 경우만 formData에 추가
	    for (var i = 0; i < files.length; i++) {
	        formData.append("file", files[i]);
	    }
	} else {
	    console.log("업로드할 파일이 없습니다.");
	}

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/productTransfer.do", true);

    // 응답 형식을 JSON으로 설정
    xhr.responseType = 'json';
    
    xhr.onload = function() {
        if (xhr.status === 200) {
            var response = xhr.response;
            if (response.status === "success") {
                // 리다이렉트 수행
                window.location.href = response.redirectUrl;
            } else {
                console.error('서버 오류:', response.message);
            }
        } else {
            console.error('서버 응답 실패:', xhr.statusText);
        }
    };

    xhr.onerror = function() {
        console.error('네트워크 오류 또는 요청 실패');
    };

    // 폼 데이터를 서버로 전송
    xhr.send(formData);
}






