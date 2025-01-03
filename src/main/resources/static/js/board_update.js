// 기존 파일 목록을 로딩하는 함수
function loadExistingFiles(board_idx) {
    $.ajax({
        url: 'updateFileList.ajax',  // 서버에서 파일 목록을 가져올 URL
        type: 'GET',  // GET 요청
        data: { 'board_idx': board_idx },  // board_idx를 전달
        dataType: 'json',
        success: function(fileList) {
            // 파일 목록을 화면에 출력
            displayFileList(fileList);
        },
        error: function(xhr, status, error) {
            console.error("파일 목록을 가져오는 데 실패했습니다.", error);
        }
    });
}

// 파일 목록을 화면에 출력하는 함수
function displayFileList(fileList) {
    var fileListBody = $('#fileListBody');
    fileListBody.empty();  // 기존 파일 목록 초기화, tbody만 비움

    // 파일이 있으면 목록을 표시
    if (fileList && fileList.length > 0) {
        fileList.forEach(function(file) {
            var row = $('<tr></tr>');
            
            // 파일 이름과 파일 크기를 하나의 셀에 표시
            var fileInfoCell = $('<td></td>').text(file.ori_filename + ' (' + Math.round(file.file_size / 1024) + ' KB)');
            
            // 삭제 버튼 추가
            var deleteButton = $('<button type="button" class="btn_primary btn_min">삭제하기</button>');
            deleteButton.on('click', function() {
                deleteFile(file.file_idx);  // 파일 삭제 함수 호출
            });

            var deleteButtonCell = $('<td></td>').append(deleteButton);

            // 행에 셀을 추가하고 tbody에 추가
            row.append(fileInfoCell).append(deleteButtonCell);
            fileListBody.append(row);
        });
    } else {
        // 파일이 없으면 "첨부 파일 없음" 메시지 표시
        var messageRow = $('<tr id="noFileMessage"></tr>');
        var messageCell = $('<td colspan="2" class="td_align_center"></td>')
            .html('<span class="font_subtle">첨부 파일이 없습니다.</span>');
        messageRow.append(messageCell);
        fileListBody.append(messageRow);
    }
}


// 파일을 삭제하는 함수
function deleteFile(file_idx) {
    $.ajax({
        url: 'deleteFile.ajax',  // 파일 삭제 처리 URL
        type: 'POST',  // POST 요청
        data: { 'file_idx': file_idx },  // 삭제할 파일의 idx와 게시글 idx
        dataType: 'json',
        success: function(fileList) {
            // 삭제 후 파일 목록 갱신
            displayFileList(fileList);
        },
        error: function(xhr, status, error) {
            console.error("파일 삭제에 실패했습니다.", error);
        }
    });
}

// 파일 업로드 처리
function uploadFile() {
    var formData = new FormData();
    var files = $('#fileInput')[0].files;  // input에서 파일들 가져오기
    for (var i = 0; i < files.length; i++) {
        formData.append('file', files[i]);  // FormData에 파일 추가
    }

    $.ajax({
        url: 'boardFileUpload.ajax',  // 파일 업로드 처리 URL
        type: 'POST',  // POST 요청
        data: formData,  // 
        contentType: false,  // contentType은 자동으로 처리
        processData: false,  // jQuery가 데이터 처리하지 않도록 설정
        dataType: 'json',
        success: function(fileList) {
            // 업로드 후 파일 목록 갱신
            displayFileList(fileList);
        },
        error: function(xhr, status, error) {
            console.error("파일 업로드에 실패했습니다.", error);
        }
    });
}

// 페이지가 로드되면 기존 파일 목록을 가져와서 출력
$(document).ready(function() {
    var board_idx = $('#board_idx').val();  // 게시글 idx를 가져옴
    loadExistingFiles(board_idx);  // 기존 파일 목록 로딩

    // 파일 선택 시 업로드 처리
    $('#fileInput').on('change', function(event) {
        uploadFile();  // 파일 업로드 처리
    });
});

// '파일 선택' 버튼 클릭 시 파일 input을 클릭하도록 설정
    $('#customFileButton').on('click', function() {
        $('#fileInput').click();  // 숨겨진 input[type="file"] 클릭
    });

    // 파일이 선택되면 파일명 표시
    $('#fileInput').on('change', function() {
        var fileName = $(this).val().split('\\').pop();  // 파일명만 추출
        console.log(fileName);  // 선택된 파일명 콘솔에 표시 (필요시 다른 작업 수행)
    });
