   // 에디터 설정하기
	var config = {}
	    config.toolbar = "basic";  // 기본 툴바 설정
	    config.editorResizeMode = "none";  // 에디터 크기 조정 안함
	
	document.querySelector("#div_editor").style.height = "550px";
			
	//파일 업로드 시 설정
	config.file_upload_handler = function(file,pathReplace){//파일객체, 경로변경 함수
		console.log(file);	
		if(file.size > (2*1024*1024)){
			alert('2MB 이상의 파일은 올릴수 없습니다.');
			return false;
		}
	}
	
	var editor = new RichTextEditor("#div_editor", config);
	
function handleFileSelect(event) {
    var fileList = event.target.files; // 선택된 파일 목록
    var fileListBody = document.getElementById('fileListBody'); // 파일 리스트가 표시될 tbody   
    var filesArray = Array.from(fileList); // 선택된 파일들을 배열로 변환

	// 파일 유효성 검사
    var maxFileSize = 2 * 1024 * 1024; // 2MB
    var allowedTypes = ['application/pdf', 'image/jpeg', 'image/png', 'image/gif'];

    console.log('선택된 파일들:', filesArray); // 파일 목록 확인  

    // 파일이 선택되지 않았을 경우 처리
    if (filesArray.length === 0) {
        alert('파일을 선택해주세요.');
        return;  // 종료
    }

    // 파일 수 체크
    if (filesArray.length > 5) {
        alert('최대 5개의 파일만 첨부할 수 있습니다.');
        event.target.value = ''; // 파일 입력 리셋       
        return;  // 종료
    }

    // 파일 검증 (크기 및 형식)
    for (let i = 0; i < filesArray.length; i++) {
        let file = filesArray[i];
        console.log('검증 중인 파일:', file); // 현재 검증 중인 파일
        
        // 파일 크기 체크
        if (file.size > maxFileSize) {
            alert('파일 크기는 2MB 이하만 허용됩니다.');
            event.target.value = ''; // 파일 입력 리셋          
            return;  // 종료
        }

        // 파일 형식 체크
        if (!allowedTypes.includes(file.type)) {
            alert('pdf, jpg, png, gif 파일만 첨부할 수 있습니다.');
            event.target.value = ''; // 파일 입력 리셋      
            return;  // 종료
        }
    }

    // 기존의 첨부 파일 메시지 제거
    var noFileMessage = document.getElementById('noFileMessage');
    if (noFileMessage) {
        noFileMessage.remove();
    }

    // 기존에 있던 파일 목록을 지우고 새로 갱신
    fileListBody.innerHTML = '';

    // 파일 목록 갱신
    filesArray.forEach(function(file, index) {
        // 새로운 파일 목록 행 생성
        var row = document.createElement('tr');

        // 파일명과 용량을 표시하는 셀 생성
        var fileNameCell = document.createElement('td');
        var fileSizeCell = document.createElement('td');
        var fileSize = Math.round(file.size / 1024); // 파일 용량을 KB로 변환

        fileNameCell.textContent = `${file.name} (${fileSize} KB)`;

        // 삭제 버튼 추가
        var deleteButton = document.createElement('button');
        deleteButton.type = 'button';
        deleteButton.className = 'btn_primary btn_min';
        deleteButton.textContent = '삭제하기';
        deleteButton.onclick = function () {
            // 해당 파일 행 삭제
            row.remove();
            // 배열에서 해당 파일 삭제
            filesArray = filesArray.filter(function(f) { return f !== file; });

			// 새로운 DataTransfer 객체 생성 후 파일 목록 갱신
            var newFileList = new DataTransfer();  // 새로운 DataTransfer 객체 생성
            filesArray.forEach(function(file) {
                newFileList.items.add(file);  // 파일을 새로운 DataTransfer 객체에 추가
            });
            document.getElementById('fileInput').files = newFileList.files;  // input의 files 갱신

            // 삭제 후 첨부파일이 없으면 메시지 다시 표시
            if (filesArray.length === 0) {
                var messageRow = document.createElement('tr');
                messageRow.id = 'noFileMessage';
                var messageCell = document.createElement('td');
                messageCell.colSpan = 2;
                messageCell.className = 'td_align_center';
                messageCell.innerHTML = '<span class="font_subtle">첨부 파일이 없습니다.</span>';
                messageRow.appendChild(messageCell);
                fileListBody.appendChild(messageRow);
            }
        };

        // 삭제 버튼 셀에 추가
        var deleteButtonCell = document.createElement('td');
        deleteButtonCell.appendChild(deleteButton);

        // 행에 셀을 추가하고 tbody에 추가
        row.appendChild(fileNameCell);
        row.appendChild(deleteButtonCell);
        fileListBody.appendChild(row);
    });

    // 파일이 하나도 없을 경우 메시지 표시
    if (filesArray.length === 0 && !document.getElementById('noFileMessage')) {
        var messageRow = document.createElement('tr');
        messageRow.id = 'noFileMessage';
        var messageCell = document.createElement('td');
        messageCell.colSpan = 2;
        messageCell.className = 'td_align_center';
        messageCell.innerHTML = '<span class="font_subtle">첨부 파일이 없습니다.</span>';
        messageRow.appendChild(messageCell);
        fileListBody.appendChild(messageRow);
    }
}