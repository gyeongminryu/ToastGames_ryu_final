<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_table.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/companyinfo.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
    <c:import url="layout_topnav.jsp" />
    <div class="tst_container">
        <c:import url="layout_leftnav.jsp" />
        <div class="tst_container_right">
            <div class="tst_contents">
                <div class="tst_contents_inner">

                    <!-- 제목 -->
                    <ul class="tst_title list_no_desc list_inline">
                        <li class="tst_title_item tst_title_item_active" onclick="location.href='/companyinfo_update'">
                            <h1>회사 정보 수정하기</h1>
                        </li>
                    </ul>
                    <!-- //제목 -->

                   
                        <div class="tst_flex">

                            <!-- 문서 작성하기 -->
                            <div class="tst_col9">
                             <form action="./companyinfo_update.do" method="POST">
                                <table class="tst_table table_align_left table_no_underline table_no_padding">
                                    <colgroup>
                                        <col style="width: 120px;" />
                                        <col style="width: auto;" />
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th colspan="2">문서 작성</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th>회사명</th>
                                            <td>
                                                <input type="text" id="comp_name" name="comp_name" value="${comp_info.comp_name}" maxlength="100" placeholder="회사명을 입력하세요" required />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>대표</th>
                                            <td>
                                                <div class="tst_flex">
                                                    <div class="tst_col10">
                                                        <input type="hidden" id="ceo_idx" name="ceo_idx" value="${comp_info.ceo_idx}" />
                                                        <input type="text" id="ceo" name="ceo" value="${ceo_info.empl_name}/${ceo_info.position_name}/${ceo_info.duty_name}" readonly required />
                                                    </div>
                                                    <div class="tst_col2">
                                                        <button type="button" id="changeCeoButton" class="btn_secondary btn_full">대표 변경하기</button>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>설립일</th>
                                            <td>
                                                <input type="date" id="comp_est_date" name="comp_est_date" value="${comp_info.comp_est_date}" required />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>사업자 등록 번호</th>
                                            <td>
                                                <input type="text" id="comp_biz_no" name="comp_biz_no" value="${comp_info.comp_biz_no}" maxlength="100" placeholder="사업자 등록번호를 입력하세요" required />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>법인 등록 번호</th>
                                            <td>
                                                <input type="text" id="comp_corp_no" name="comp_corp_no" value="${comp_info.comp_corp_no}" maxlength="100" placeholder="법인 등록번호를 입력하세요" required />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>대표 전화번호</th>
                                            <td>
                                                <input type="text" id="comp_phone" name="comp_phone" value="${comp_info.comp_phone}" maxlength="100" placeholder="회사 대표 전화번호를 입력하세요" required />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>주소</th>
                                            <td>
                                                <input type="text" id="comp_addr" name="comp_addr" value="${comp_info.comp_addr}" maxlength="1000" placeholder="회사 주소를 입력하세요" required />
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="2">
                                                <button type="submit" class="btn_primary">회사 정보 수정하기</button>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                                </form>
                            </div>
                            <!-- //문서 작성하기 -->

                            <div class="tst_col3">
                                <!-- 첨부 파일 편집 -->
                                   <form id="compStampForm" action="comp_file_upload.do" method="POST" enctype="multipart/form-data">
                                <table class="tst_table table_align_left table_no_padding">
                                    <colgroup>
                                        <col style="width: auto;" />
                                        <col style="width: 60px;" />
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th colspan="2">첨부 파일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="fileItem" items="${file}">
                                            <tr>
                                                <td>${fileItem.new_filename} (${fileItem.file_size / 1024} KB)</td>
                                                <td>
                                                    <button type="button" onclick="delcompFile('${fileItem.new_filename}')" class="btn_primary btn_min">삭제</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                    
                                        <tr>
                                            <td colspan="2">
                                         
                                                <label for="fileInput">첨부 파일 선택:</label>
                                                <input type="file" id="fileInput" name="files" multiple />
                                                <ul id="attachmentFileList"></ul>
                                                <button type="submit" class="btn_primary">첨부파일 제출</button>
                                           
                                            </td>
                                        </tr>
                                         
                                    </tfoot>
                                </table>
                                 </form>
                                <!-- //첨부 파일 편집 -->

                                <hr class="separator" />

                                <!-- 직인 -->
                                <table class="tst_table table_align_left table_no_padding">
                                    <thead>
                                        <tr>
                                            <th>직인</th>
                                        </tr>
                                    </thead>
                                    <tbody>
										<c:choose>
								           
								            <c:when test="${not empty comp_info.comp_stamp}">
								                <tr>
								                    <td>
								                        ${comp_info.comp_stamp} <p id="stampFileSize"></p>
								                        <img id="existingSealPreview" src="/files/${comp_info.comp_stamp}" 
								                             alt="기존 직인 미리보기" 
								                             style="max-width: 200px; max-height: 200px;" />
								                    </td>
								                </tr>
								                <tr>
		                                        	<td>
		                                        	<button type="button" onclick="delcompStamp('${comp_info.comp_stamp}')" class="btn_primary btn_min">삭제</button>
		                                        	</td>
		                                        </tr>
										                
								            </c:when>
								            
								            <c:otherwise>
								                <tr>
								                    <td>
								                        <p class="font_subtle align_center">직인이 없습니다.</p>
								                    </td>
								                </tr>
								            </c:otherwise>
								        </c:choose>
                                        <tr>
                                            <td>
                                              <form id="companyStampForm" action="company_stamp.do" method="POST" enctype="multipart/form-data">
												    <label for="singleFile">새로운 직인 선택:</label>
												    <input type="file" id="singleFile" name="singleFile" />
												    <div>
												        <h4>새로운 직인 파일 미리보기:</h4>
												        <img id="newSealPreview" src="#" alt="새로운 직인 미리보기" style="display: none; max-width: 200px; max-height: 200px;" />
												    </div>
												    <button type="submit" class="btn_primary">직인 변경</button>
												</form>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <!-- //직인 -->
                            </div>
                        </div>

                </div>
            </div>
        </div>
    </div>

<!-- 모달 창 -->
<div id="employeeModal" class="modal disp_hide">
    <div class="modal-content">
        <!-- 닫기 버튼 -->
        <span class="close tst_pointer">&times;</span>
        <!-- 모달 제목 -->
        <h3>직원 리스트</h3>
        <!-- 직원 리스트 테이블 -->
        <table id="employeeTable" class="tst_table table_align_left">
            <thead>
                <tr>
                    <th>직원 번호</th>
                    <th>직원 이름</th>
                    <th>직책/직급</th>
                    <th>선택</th>
                </tr>
            </thead>
            <tbody>
                <!-- 직원 리스트 데이터는 AJAX로 추가 -->
            </tbody>
        </table>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    var modal = document.getElementById('employeeModal'); // 모달
    var closeModal = document.querySelector('.close'); // 닫기 버튼
    var employeeTableBody = document.querySelector('#employeeTable tbody'); // 직원 리스트 테이블
    var changeCeoButton = document.getElementById('changeCeoButton'); // 대표 변경 버튼

    // 첨부파일 목록 표시
    document.getElementById('fileInput').addEventListener('change', function (event) {
        var fileList = event.target.files; // 선택된 첨부파일
        var displayList = document.getElementById('attachmentFileList'); // 첨부파일 목록 표시 영역

        // 화면 초기화
        displayList.innerHTML = '';

        // 각 첨부파일 이름을 리스트에 추가
        for (var i = 0; i < fileList.length; i++) {
            var listItem = document.createElement('li');
            listItem.textContent = fileList[i].name; // 첨부파일 이름
            displayList.appendChild(listItem);
        }
    });

    // 파일 크기 가져오기 함수
    function getFileSize(filePath, elementId) {
        fetch(filePath, { method: 'HEAD' })
            .then(function (response) {
                var fileSize = response.headers.get('content-length'); // 파일 크기(바이트) 가져오기
                if (fileSize) {
                    var sizeInKB = (fileSize / 1024).toFixed(2); // KB 단위로 변환
                    var element = document.getElementById(elementId);
                    element.innerText = '파일 크기: ' + sizeInKB + ' KB';
                } else {
                    document.getElementById(elementId).innerText = '크기 알 수 없음';
                }
            })
            .catch(function (error) {
                console.error('파일 크기 가져오기 실패:', error);
                document.getElementById(elementId).innerText = '크기 가져오기 실패';
            });
    }

    // 파일 크기 초기화
    var filePath = document.getElementById('existingSealPreview').getAttribute('src'); // 이미지의 경로 가져오기
    getFileSize(filePath, 'stampFileSize'); // 크기 표시용 요소에 업데이트

    // 대표 변경하기 버튼 클릭 시 모달 열기
    changeCeoButton.addEventListener('click', function () {
        modal.style.display = 'block';

        // AJAX로 직원 리스트 가져오기
        $.ajax({
            url: './employee_list.ajax',
            type: 'GET',
            dataType: 'json',
            success: function (response) {
                employeeTableBody.innerHTML = ''; // 기존 데이터 초기화

                response.forEach(function (employee) {
                    var row = document.createElement('tr');
                    row.innerHTML =
                        '<td>' + employee.empl_idx + '</td>' +
                        '<td>' + employee.empl_name + '</td>' +
                        '<td>' + ((employee.position_name || '없음') + '/' + (employee.duty_name || '없음')) + '</td>' +
                        '<td><button type="button" class="selectCeoButton" data-id="' +
                        employee.empl_idx +
                        '" data-name="' +
                        employee.empl_name +
                        '" data-position="' +
                        (employee.position_name || '') +
                        '" data-duty="' +
                        (employee.duty_name || '') +
                        '">선택</button></td>';
                    employeeTableBody.appendChild(row);
                });

                // 직원 선택 버튼 이벤트 추가
                var selectCeoButtons = document.querySelectorAll('.selectCeoButton');
                selectCeoButtons.forEach(function (button) {
                    button.addEventListener('click', function () {
                        var emplName = this.getAttribute('data-name');
                        var positionName = this.getAttribute('data-position') || '없음';
                        var emplIdx = this.getAttribute('data-id');
                        var dutyName = this.getAttribute('data-duty') || '없음';

                        document.getElementById('ceo').value = emplName + '/' + positionName + '/' + dutyName;
                        document.getElementById('ceo_idx').value = emplIdx;
                        modal.style.display = 'none'; // 모달 닫기
                    });
                });
            },
            error: function (xhr, status, error) {
                console.error('직원 리스트를 가져오는 중 오류 발생:', error);
            }
        });
    });

    // 닫기 버튼 클릭 이벤트
    closeModal.addEventListener('click', function () {
        modal.style.display = 'none';
    });

    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function (event) {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });

    // 새 직인 파일 미리보기
    document.getElementById('singleFile').addEventListener('change', function (event) {
        var file = event.target.files[0]; // 선택된 파일 가져오기
        var previewImage = document.getElementById('newSealPreview'); // 미리보기 이미지 요소 가져오기

        if (file) {
            var reader = new FileReader(); // FileReader 객체 생성
            reader.onload = function (e) {
                previewImage.src = e.target.result; // FileReader가 생성한 URL로 이미지 src 설정
                previewImage.style.display = 'block'; // 이미지 표시
            };
            reader.readAsDataURL(file); // 선택한 파일을 Data URL로 읽기
        } else {
            previewImage.style.display = 'none'; // 파일이 없으면 이미지 숨기기
        }
    });

    // 첨부 파일 삭제
    window.delcompFile = function (new_filename) {
        var url = './comp_file_del.do/' + new_filename;
        console.log('파일 삭제 요청 URL:', url);
        window.location.href = url; // 삭제 요청 처리
    };
 // 첨부 파일 삭제
    window.delcompStamp = function (new_filename) {
        var url = './comp_stamp_del.do/' + new_filename;
        console.log('파일 삭제 요청 URL:', url);
        window.location.href = url; // 삭제 요청 처리
    };
});

</script>
<script src="resources/js/common.js"></script>

</body>
</html>

