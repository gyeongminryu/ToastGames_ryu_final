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
    <link rel="stylesheet" type="text/css" href="resources/css/mypage.css" />
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
                    <li class="tst_title_item" onclick="location.href='/manage_employee_list'">
                        <h1>인사 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_employee_resign_list'">
                        <h1>퇴사자 관리</h1>
                    </li>
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_employee_regist'">
                        <h1>직원 등록</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_employee_regist_multiple'">
                        <h1>직원 일괄 등록</h1>
                    </li>
                </ul>
                <!-- //제목 -->
                <form action="./employee_add.do" method="POST" enctype="multipart/form-data">
                    <div class="tst_flex">
                        <div class="tst_col9">
                            <div class="tst_flex tst_flex_block">
                                <div class="tst_col12">
                                    <div class="tst_flex">
                                        <div class="tst_col4">
                                            <ul class="list_no_desc list_block">
                                                <li>
                                                    <label class="form_label">이름</label>
                                                    <input type="text" name="empl_name" maxlength="100" required placeholder="이름을 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">ID</label>
                                                    <input type="text" name="empl_id" maxlength="100" required placeholder="ID를 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">비밀번호</label>
                                                    <input type="text" name="empl_pw" maxlength="100" required placeholder="ID를 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">성별</label>
                                                    <div class="tst_flex">
                                                        <input type="hidden" name="gender" value="" />
                                                        <div class="tst_col6">
                                                            <button type="button" onclick="select_gender('0')" class="btn_full btn_empty gender_0">남</button>
                                                        </div>
                                                        <div class="tst_col6">
                                                            <button type="button" onclick="select_gender('1')" class="btn_full btn_empty gender_1">여</button>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li>
                                                    <label class="form_label">생년월일</label>
                                                    <input type="date" name="empl_birth" required placeholder="생년월일을 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">주민등록번호</label>
                                                    <div class="tst_flex">
                                                    <div class="tst_col6">
                                                    <input type="text" name="empl_ssn1" maxlength="6" required placeholder="앞자리를 입력하세요" />
                                                    </div>
                                                    <div class="tst_col6">
                                                    <input type="text" name="empl_ssn2" maxlength="7" required placeholder="뒷자리를 입력하세요" />
                                                	</div>
                                                	</div>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="tst_col8 padding_left">
                                            <ul class="list_no_desc list_block">
                                                <li>
                                                    <label class="form_label">사내 유선번호</label>
                                                    <input type="text" name="empl_cmp_phone" maxlength="100" placeholder="사내 유선번호를 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">사내 이메일</label>
                                                    <input type="text" name="empl_cmp_email" maxlength="100" placeholder="사내 이메일을 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">
                                                        비상 연락처
                                                        <span class="font_caution">* 비상시 연락할 수 있는 전화번호를 입력하세요.</span>
                                                    </label>
                                                    <input type="text" name="empl_per_phone" maxlength="100" placeholder="비상 연락처를 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">
                                                        개인 이메일
                                                        <span class="font_caution">* 비밀번호 분실시 새 비밀번호를 수령할 수 있는 메일 주소를 입력하세요.</span>
                                                    </label>
                                                    <input type="email" name="empl_per_email" maxlength="100" required placeholder="개인 이메일을 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">입사일</label>
                                                    <input type="date" name="empl_join_date" maxlength="100" />
                                                </li>
                                                <li>
                                                    <label class="form_label">
                                                        급여 지급 계좌번호
                                                        <span class="font_caution">* 본인 명의 계좌인지 확인 후 입력하세요.</span>
                                                    </label>
                                                    <div class="tst_flex">
                                                        <div class="tst_col4">
                                                            <select name="bank_idx">
															    <option value="1">농협</option>
															    <option value="2">수협</option>
															    <option value="3">국민</option>
															    <option value="4">우리</option>
															    <option value="5">신한</option>
															    <option value="6">KEB하나</option>
															    <option value="7">기업</option>
															  </select>
                                                        </div>
                                                        <div class="tst_col8">
                                                            <input type="text" name="empl_account" maxlength="100" placeholder="계좌번호를 입력하세요" />
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="tst_col12">
                                    <label class="form_label">주소</label>
                                    <input type="text" name="" maxlength="100" placeholder="주소를 입력하세요" />
                                    <hr class="separator" />
                                </div>
                                <div class="tst_col12">
                                    <ul class="tst_list list_no_desc list_inline">
                                        <li>
                                            <input type="submit" class="btn_primary" value="직원 등록하기" />
                                        </li>
                                        <li>
                                            <input type="button" onclick="location.href='/manage_employee_list'" class="btn_secondary" value="목록으로 돌아가기" />
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        
                        <div class="tst_col3">

                            <!-- 첨부 파일 목록 -->
                            <table class="tst_table table_align_left table_no_padding">
                                <colgroup>
                                    <col style="width: auto" />
                                    <col style="width: 60px" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th colspan="2">첨부 파일</th>
                                </tr>
                                </thead>
                                <tbody id="attachmentFileList">
                                <tr>
                                    <td>{파일명 (파일 용량kb)}</td>
                                    <td>
                                        <button onclick="tst_modal_call_param('tst_modal_delete', '{파일idx}')" type="button" class="btn_min btn_primary">파일 삭제</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>{파일명 (파일 용량kb)}</td>
                                    <td>
                                        <button onclick="tst_modal_call_param('tst_modal_delete', '{파일idx}')" type="button" class="btn_min btn_primary">파일 삭제</button>
                                    </td>
                                </tr>

                                <!-- 첨부 파일이 없는 경우 아래와 같이 입력하세요 -->
                                <tr>
                                    <td colspan="2" class="td_align_center">
                                        <span class="font_subtle">첨부 파일이 없습니다.</span>
                                    </td>
                                </tr>
                                <!-- //첨부 파일이 없는 경우 아래와 같이 입력하세요 -->

                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="2">
                                        <input type="file" id="fileInput" name="files" multiple />
                                    </td>
                                </tr>
                                
                                </tfoot>
                            </table>
                            <!-- //첨부 파일 목록 -->

                            <hr class="separator" />

                            <!-- 직인 > 파일이 있을 경우 -->
                            <table class="tst_table table_align_left table_no_padding">
                                <colgroup>
                                    <col style="width: auto" />
                                    <col style="width: 60px" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th colspan="2">직인</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="td_no_underline">
                                    <td id="fileInfo"><p class="font_subtle align_center">직인이 없습니다.</p></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div class="tst_flex">
                                            <div class="tst_col12 align_center align_middle">
                                                <img id="newSealPreview" src="#" alt="새로운 직인 미리보기" style="display: none; max-width: 200px; max-height: 200px;" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="2">
                                        <input type="file" id="singleFile" name="singleFile" onchange="getFileInfo(this)" multiple />
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                            <!-- //직인 > 파일이 있을 경우 -->

                        </div>
                    </div>
                    
                </form>
            </div>
        </div>
    </div>
    </div>

        <script src="resources/js/common.js"></script>
<script>
//성별 버튼 스타일 설정
function scan_gender() {
    const genderValue = document.querySelector('[name="gender"]').value;
    const gender0 = document.querySelector('.gender_0');
    const gender1 = document.querySelector('.gender_1');

    if (genderValue === '0') {
        gender0.classList.remove('btn_empty');
        gender0.classList.add('btn_subtle');
        gender1.classList.remove('btn_subtle');
        gender1.classList.add('btn_empty');
    } else if (genderValue === '1') {
        gender0.classList.remove('btn_subtle');
        gender0.classList.add('btn_empty');
        gender1.classList.remove('btn_empty');
        gender1.classList.add('btn_subtle');
    }
}

// 성별 선택 함수
function select_gender(gender) {
    document.querySelector('[name="gender"]').value = gender;
    scan_gender();
}

// DOMContentLoaded 이후에 초기화
document.addEventListener('DOMContentLoaded', function () {
    scan_gender(); // 초기 성별 버튼 스타일 설정
});


//새 직인 파일 미리보기
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

//파일 정보 가져오기
function getFileInfo(input) {
    const fileInfoElement = document.getElementById('fileInfo');
    const preview = document.getElementById('newSealPreview');
    
    // 파일이 선택되었는지 확인
    if (input.files && input.files.length > 0) {
        const file = input.files[0]; // 첫 번째 파일 가져오기
        const fileName = file.name; // 파일 이름
        const fileSize = (file.size / 1024).toFixed(2); // 파일 크기 (KB로 변환)

        // 파일 정보 표시
       fileInfoElement.textContent = fileName + " (" + fileSize + " KB)";

        // 이미지 파일인 경우 미리보기
        if (file.type.startsWith('image/')) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        } else {
            preview.style.display = 'none'; // 이미지가 아니면 미리보기 숨김
        }
    } else {
        // 파일이 선택되지 않은 경우
        fileInfoElement.textContent = '파일을 선택해주세요.';
        preview.style.display = 'none';
    }
}


//첨부파일 목록 표시
document.getElementById('fileInput').addEventListener('change', function (event) {
    const fileList = event.target.files; // 선택된 첨부파일
    const displayList = document.getElementById('attachmentFileList'); // 첨부파일 목록 표시 영역

    // 화면 초기화
    displayList.innerHTML = '';

    // 각 첨부파일 이름과 삭제 버튼을 행으로 추가
    for (let i = 0; i < fileList.length; i++) {
        const row = document.createElement('tr');

        // 파일명 및 크기 셀
        const fileCell = document.createElement('td');
        const fileSize = (fileList[i].size / 1024).toFixed(2); // KB로 변환
        fileCell.textContent = fileList[i].name + ' (' + fileSize + ' KB)';
        row.appendChild(fileCell);

        // 삭제 버튼 셀
        const buttonCell = document.createElement('td');
        const deleteButton = document.createElement('button');
        deleteButton.textContent = '파일 삭제';
        deleteButton.type = 'button';
        deleteButton.className = 'btn_min btn_primary';
        deleteButton.onclick = function () {
            tst_modal_call_param('tst_modal_delete', i); // 파일 인덱스 전달
        };
        buttonCell.appendChild(deleteButton);

        row.appendChild(buttonCell);
        displayList.appendChild(row);
    }
});

// 직인 파일 입력 시 이미지 미리보기
function img_preview(elem) {
    // 이미지 미리보기 로직 구현 (필요 시)
}
</script>
    <c:import url="manage_employee_update_modal.jsp" />
</body>

</html>