
function handleFileSelect(event) {
    var fileList = event.target.files; // 선택된 파일 목록
    var fileListBody = document.getElementById('fileListBody'); // 파일 리스트가 표시될 tbody   
    var filesArray = Array.from(fileList); // 선택된 파일들을 배열로 변환

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
