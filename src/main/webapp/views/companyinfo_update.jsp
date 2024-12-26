<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<html>
<head>
<meta charset="UTF-8">
<title>회사 정보 수정 폼</title>
</head>
<body>
    <h2>회사 정보 수정 폼</h2>
    <!-- 상대경로 -->
    <form action="./companyinfo_update.do" method="POST">
        <table>
            <tr>
                <td><label for="companyName">회사명:</label></td>
                <td><input type="text" id="comp_name" name="comp_name"  value="${comp_info.comp_name }" required /></td>
            </tr>
            <tr>
                <td><label for="ceoName">대표 :</label></td>
                  <td><input type="text" id="ceo_idx" name="ceo_idx" value="${ceo_info.empl_name}/${ceo_info.position_name}/${ceo_info.duty_name}" required /></td>
            </tr>
            <tr>
                <td><label for="ceoName">회사 번호:</label></td>
                <td><input type="text" id="comp_phone" name="comp_phone" value="${comp_info.comp_phone }" required /></td>
            </tr>
            <tr>
                <td><label for="businessNumber">사업자등록번호:</label></td>
             <td><input type="text" id="comp_biz_no" name="comp_biz_no" value="${comp_info.comp_biz_no }" required /></td>
            </tr>
            <tr>
                <td><label for="corporateNumber">법인등록번호:</label></td>
                <td><input type="text" id="comp_corp_no" name="comp_corp_no" value="${comp_info.comp_corp_no }" required /></td>
            </tr>
            <tr>
                <td><label for="address">주소:</label></td>
 				<td><input type="text" id="comp_addr" name="comp_addr" value="${comp_info.comp_addr }" required /></td>
            </tr>
            <tr>
                <td><label for="establishmentDate">설립일:</label></td>
                                <td><input type="date" id="comp_est_date" name="comp_est_date" value="${comp_info.comp_est_date }" required /></td>
            </tr>
           
            
        </table>
        <br />
        <input type="submit" value="제출" />
    </form>
    
    
    <form id="compFileForm" action="comp_file_upload" method="POST" enctype="multipart/form-data">


<div>
    <label for="fileInput">첨부 파일 선택:</label>
    <input type="file" id="fileInput" name="files" multiple />
    <ul id="attachmentFileList"></ul> <!-- 첨부파일 목록 -->
</div>
<button type="submit">첨부파일 제출</button>
</form>

 <div>
        <h4>기존 직인 파일:</h4>
        <img id="existingSealPreview" src="/files/${comp_info.comp_stamp}" alt="기존 직인 미리보기" 
            style="display: ${comp_info.comp_stamp != null ? 'block' : 'none'}; max-width: 200px; max-height: 200px;" />
    </div>

<form id="companyStampForm" action="company_stamp.do" method="POST" enctype="multipart/form-data">
<!-- 새로 선택한 직인 파일 -->
    <div>
    
        <label for="empl_stamp">새로운 직인 파일 선택:</label>
        <input type="file" id="singleFile" name="singleFile" />
        <!-- 새로 선택한 직인 파일 미리보기 -->  
        <div>
        <h4>새로운 직인 파일 미리보기:</h4>
        <img id="newSealPreview" src="#" alt="새로운 직인 미리보기" style="display: none; max-width: 200px; max-height: 200px;" />
    </div>
    </div>

    <button type="submit">직인 제출</button>
</form>
</body>

<script>

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

</script>

</html>