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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/companyinfo_detail'">
                        <h1>회사 정보</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">

                    <!-- 회사 정보 상세보기 -->
                    <div class="tst_col9">
                        <table class="tst_table table_align_left table_no_padding">
                            <colgroup>
                                <col style="width: 150px" />
                                <col style="width: auto" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">회사 정보</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>회사명</th>
                                <td><input type="text" id="comp_name" name="comp_name" value="${comp_info.comp_name}" readonly /></td>
                            </tr>
                            <tr>
                                <th>대표</th>
                                <td>
                                    <input type="text" id="ceo_idx" name="ceo_idx" value="${ceo_info.empl_name}/${ceo_info.position_name}/${ceo_info.duty_name}" readonly />
                                </td>
                            </tr>
                            <tr>
                                <th>설립일</th>
                                <td><input type="date" id="comp_est_date" name="comp_est_date" value="${comp_info.comp_est_date}" readonly /></td>
                            </tr>
                            <tr>
                                <th>사업자 등록번호</th>
                                <td><input type="text" id="comp_biz_no" name="comp_biz_no" value="${comp_info.comp_biz_no}" readonly /></td>
                            </tr>
                            <tr>
                                <th>법인 등록 번호</th>
                                <td><input type="text" id="comp_corp_no" name="comp_corp_no" value="${comp_info.comp_corp_no}" readonly /></td>
                            </tr>
                            <tr>
                                <th>대표 전화번호</th>
                                <td><input type="text" id="comp_phone" name="comp_phone" value="${comp_info.comp_phone}" readonly /></td>
                            </tr>
                            <tr>
                                <th>주소</th>
                                <td><input type="text" id="comp_addr" name="comp_addr" value="${comp_info.comp_addr}" readonly /></td>
                            </tr>
                            </tbody>
                              <tfoot>
                            <tr>
                                <td colspan="2">
                                    <button class="btn_primary" onclick="location.href='./companyinfo_update.go'">정보 수정하기</button>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                    <!-- // 회사 정보 상세보기 -->

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
                            <tbody>
                            <c:forEach var="fileItem" items="${file}">
						      	  <tr>
                                <td>${fileItem.new_filename}(${fileItem.file_size/1024}kb)</td>
                                <td>
                                    <button onclick="downloadFile('${fileItem.new_filename}')" class="btn_min btn_primary">다운로드</button>
                                </td>
                            </tr>
						        </c:forEach> 
        
                            </tbody>
                        </table>
                        <!-- //첨부 파일 목록 -->

                        <hr class="separator" />

                        <!-- 직인 > 파일이 있을 경우 -->
                        <table class="tst_table table_align_left table_no_padding">
                            <thead>
                            <tr>
                                <th>직인</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
								           
								            <c:when test="${not empty comp_info.comp_stamp}">
                            <tr class="td_no_underline">
                            <td>${comp_info.comp_stamp}<p id="stampFileSize"></p> </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="tst_flex">
                                        <div class="tst_col12 align_center align_middle">
                                        	<!-- 파일 크기 표시용 -->
                                            <img src="/files/${comp_info.comp_stamp}" id="stampFile" class="companyinfo_stamp" />
                                       		
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
                            </tbody>
                        </table>
                        <!-- //직인 > 파일이 있을 경우 -->

                    </div>

                </div>
            </div>
        </div>
    </div>
   
</body>

 <script src="resources/js/common.js"></script> 
 <script>
//파일 크기 가져오기 함수
 function getFileSize(filePath, elementId) {
    fetch(filePath, { method: 'HEAD' })
        .then(function(response) {
            var fileSize = response.headers.get('content-length'); // 파일 크기(바이트) 가져오기
            if (fileSize) {
                var sizeInKB = (fileSize / 1024).toFixed(2); // KB 단위로 변환
                var element = document.getElementById(elementId);
                element.innerText = '파일 크기: ' + sizeInKB + ' KB';
            } else {
                document.getElementById(elementId).innerText = '크기 알 수 없음';
            }
        })
        .catch(function(error) {
            console.error('파일 크기 가져오기 실패:', error);
            document.getElementById(elementId).innerText = '크기 가져오기 실패';
        });
}

 document.addEventListener('DOMContentLoaded', function() {
	    var filePath = document.getElementById('stampFile').getAttribute('src'); // 이미지의 경로 가져오기
	    getFileSize(filePath, 'stampFileSize'); // 크기 표시용 요소에 업데이트
	});
//다운로드 버튼 클릭 시 해당 파일 다운로드
 function downloadFile(filename) {
     const url = './memberDownload/' + filename;  // 다운로드 URL
     window.location.href = url;  // 해당 URL로 이동하여 다운로드
 }
</script>
</html>
