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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_employee_list'">
                        <h1>인사 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_employee_resign_list'">
                        <h1>퇴사자 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_employee_regist'">
                        <h1>직원 등록</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_employee_regist_multiple'">
                        <h1>직원 일괄 등록</h1>
                    </li>
                </ul>
                <!-- //제목 -->
                 
                <form>
                    <div class="tst_flex">
                   
                   <input type="hidden" name="empl_idx" value="${employee.empl_idx}" />
                        <div class="tst_col9">
                            <div class="tst_flex tst_flex_block">
                                <div class="tst_col12">
                                    <div class="tst_flex">
                                        <div class="tst_col4">
                                            <ul class="list_no_desc list_block">
                                            
                                                <li>
                                                    <label class="form_label">이름</label>
                                                    <input type="text" name="empl_name" maxlength="100" value="${employee.empl_name}" />
                                                </li>
                                                <li>
                                                    <label class="form_label">ID</label>
                                                    <input type="text" name="empl_id" maxlength="100" value="${employee.empl_id}" class="input_disable" readonly />
                                                </li>
                                                <li>
                                                    <label class="form_label">비밀번호</label>
                                                    <button onclick="tst_modal_call('tst_modal_password')" type="button" class="btn_subtle btn_full">임시 비밀번호 발급하기</button>
                                                </li>
                                                <li>
                                                    <label class="form_label">성별</label>
                                                    <div class="tst_flex">
                                                        <input type="hidden" name="empl_gender" value="${employee.empl_gender}" />
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
                                                    <input type="date" name="empl_birth" value="${employee.empl_birth}" placeholder="생년월일을 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">주민등록번호</label>
                                                    <input type="text" name="empl_ssn1" maxlength="100" value="${employee.empl_ssn1}" placeholder="주민등록번호를 입력하세요" />
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="tst_col8 padding_left">
                                            <ul class="list_no_desc list_block">
                                                <li>
                                                    <label class="form_label">사내 유선번호</label>
                                                    <input type="text" name="empl_cmp_phone" maxlength="100" value="${employee.empl_cmp_phone}" placeholder="사내 유선번호를 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">사내 이메일</label>
                                                    <input type="text" name="empl_cmp_email" maxlength="100" value="${employee.empl_cmp_email}" placeholder="사내 이메일을 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">
                                                        비상 연락처
                                                        <span class="font_caution">* 비상시 연락할 수 있는 전화번호를 입력하세요.</span>
                                                    </label>
                                                    <input type="text" name="empl_per_phone" maxlength="100" value="${employee.empl_per_phone}" placeholder="비상 연락처를 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">
                                                        개인 이메일
                                                        <span class="font_caution">* 비밀번호 분실시 새 비밀번호를 수령할 수 있는 메일 주소를 입력하세요.</span>
                                                    </label>
                                                    <input type="text" name="empl_per_email" maxlength="100" value="${employee.empl_per_email}" placeholder="개인 이메일을 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">입사일</label>
                                                    <input type="date" name="empl_join_date" maxlength="100" value="${employee.empl_join_date}" class="input_disable" readonly />
                                                </li>
                                                <li>
                                                    <label class="form_label">
                                                        급여 지급 계좌번호
                                                        <span class="font_caution">* 본인 명의 계좌인지 확인 후 입력하세요.</span>
                                                    </label>
                                                    <div class="tst_flex">
                                                        <div class="tst_col4">
                                                            <select name="">
                                                                <option value="{은행 번호}">{은행명}</option>
                                                                <option value="{은행 번호}">{은행명}</option>
                                                                <option value="{은행 번호}">{은행명}</option>
                                                            </select>
                                                        </div>
                                                        <div class="tst_col8">
                                                            <input type="text" name="" maxlength="100" value="{계좌번호}" placeholder="계좌번호를 입력하세요" />
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="tst_col12">
                                    <label class="form_label">주소</label>
                                    <input type="text" name="empl_addr" maxlength="100" value="${employee.empl_addr}" placeholder="주소를 입력하세요" />
                                    <hr class="separator" />
                                </div>
                                <div class="tst_col12">
                                    <ul class="tst_list list_no_desc list_inline">
                                        <li>
                                            <input type="submit" class="btn_primary" value="정보 수정하기" />
                                        </li>
                                        <li>
                                            <input type="button" onclick="location.href='/employee_detail.go?empl_idx=${employee.empl_idx}'" class="btn_secondary" value="이전으로 돌아가기" />
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        </form>
                        <div class="tst_col3">
                        
							<form id="emplStampForm" action="empl_file_upload.do?empl_idx=${employee.empl_idx}" method="POST" enctype="multipart/form-data">
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
                                <tbody>
                                <c:forEach var="fileItem" items="${file}" varStatus="status">
								<tr>
                                <td>${fileItem.new_filename} (${fileItem.file_size/1024})</td>
                                <td>
                                    <!-- 다운로드 경로를 입력하세요 --><button type="button" onclick="delFile('${fileItem.new_filename}','${employee.empl_idx}')" class="btn_min btn_primary">삭제하기</button>
                                </td>
                            	</tr>
								</c:forEach>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="2">
                                        <input type="file" id="fileInput" name="files" multiple />
                                         <ul id="attachmentFileList"></ul>
                                         <button type="submit" class="btn_primary">첨부파일 제출</button>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                            <!-- //첨부 파일 목록 -->
                            </form>

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
                                    <c:choose>
								           
								            <c:when test="${not empty employee.empl_stamp}">
                            <tr class="td_no_underline">
                            <td>${employee.empl_stamp}<p id="stampFileSize"></p> </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="tst_flex">
                                        <div class="tst_col12 align_center align_middle">
                                        	<!-- 파일 크기 표시용 -->
                                            <img src="/files/${employee.empl_stamp}" id="stampFile" class="companyinfo_stamp" />
                                       		
                                        </div>
                                    </div>
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
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="2">
                                    <form id="emplStampForm" action="empl_stamp_upload.do?empl_idx=${employee.empl_idx}" method="POST" enctype="multipart/form-data">
                                        <div class="tst_flex">
                                            <div class="tst_col12 align_center align_middle">
                                                <img id="newSealPreview" src="" class="companyinfo_stamp" style="display: none;"/>
                                            </div>
                                        </div>
                                        <input type="file" id="singleFile" alt="새로운 직인 미리보기" name="singleFile" multiple />
                                    	<button type="submit" class="btn_primary">직인 변경</button>
                                    </form>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                            <!-- //직인 > 파일이 있을 경우 -->

                         
							
                        </div>

                    </div>
                
            </div>
        </div>
    </div>
  </div>  
    <c:import url="manage_employee_update_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/manage_employee_update.js"></script>
<script>

//첨부파일 목록 표시
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

//직인파일 미리보기
document.getElementById('singleFile').addEventListener('change', function (event) {
    const file = event.target.files[0]; // 단일 파일
  
    const previewImage = document.getElementById('newSealPreview'); // 미리보기 이미지 태그

  //  displayList.innerHTML = ''; // 이름 초기화

    if (file) {
        // 파일이 있을 경우 미리보기 이미지 표시
        const reader = new FileReader();
        
        reader.onload = function(e) {
            previewImage.src = e.target.result; // Base64로 변환된 이미지 데이터 설정
            previewImage.style.display = 'block'; // 미리보기 이미지 보이기
        };

        // 이미지 파일 읽기
        reader.readAsDataURL(file);
    } else {
        // 파일이 선택되지 않으면 미리보기 이미지 숨기기
        previewImage.style.display = 'none';
    }
});
//삭제버튼 클릭시 삭제 
	function delFile(new_filename,empl_idx) {
      	
        const url = './empl_file_del.do/' + new_filename + '/' + empl_idx;
        window.location.href = url;  // 해당 URL로 이동하여 다운로드
        console.log(url);
    }
</script>
</html>