<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>직원 상세정보</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid black;
            padding: 8px;
        }

        h2 {
            margin-top: 20px;
        }
        #appoModal {
    display: none;
    position: fixed;
    top: 20%;
    left: 30%;
    width: 40%;
    padding: 20px;
    background-color: white;
    border: 1px solid #333;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    
    <h1>직원 상세정보</h1>
    
    <h2>직원 기본 정보</h2>
    <table>
        <tr>
            <th>직원 ID</th>
            <td id="empl_id">${employee.empl_id}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td id="empl_name">${employee.empl_name}</td>
        </tr>
        <tr>
            <th>성별</th>
            <td id="empl_gender">${employee.empl_gender ? '여성' : '남성'}</td>
        </tr>
        <tr>
            <th>생년월일</th>
            <td id="empl_birth">${employee.empl_birth}</td>
        </tr>
        <tr>
            <th>주민등록번호</th>
            <td id="empl_ssn">${employee.empl_ssn1}-${employee.empl_ssn2}</td>
        </tr>
        <tr>
            <th>입사일</th>
            <td id="empl_join">${employee.empl_join_date}</td>
        </tr>
        <tr>
            <th>퇴사일</th>
            <td id="empl_resig">${employee.empl_resig_date}</td>
        </tr>
        <tr>
            <th>직급</th>
            <td id="empl_position_name">${appoLast.position_name}</td>
        </tr>
        <tr>
            <th>직책</th>
            <td id="empl_duty_name">${appoLast.duty_name}</td>
        </tr>
        <tr>
            <th>부서</th>
            <td id="empl_dept_name">${appoLast.dept_name}</td>
        </tr>
        <tr>
            <th>파일 키</th>
            <td id="file_key">${employee.file_key}</td>
        </tr>
    </table>

    <h2>최근 발령 정보</h2>
    <table>
        <tr>
            <th>발령 인덱스</th>
            <td id="appoLast_idx">${appoLast.appo_idx}</td>
        </tr>
        <tr>
            <th>발령 대상 직원 ID</th>
            <td id="appoLast_empl_id">${appoLast.appo_empl_idx}</td>
        </tr>
        <tr>
            <th>부서 이름</th>
            <td id="appoLast_dept_idx">${appoLast.dept_name}</td>
        </tr>
        <tr>
            <th>직책 이름</th>
            <td id="appoLast_position_idx">${appoLast.position_name}</td>
        </tr>
        <tr>
            <th>업무 인덱스</th>
            <td id="appoLast_duty_idx">${appoLast.duty_idx}</td>
        </tr>
        <tr>
            <th>직원 업무</th>
            <td id="appoLast_empl_job">${appoLast.empl_job}</td>
        </tr>
        <tr>
            <th>이동일</th>
            <td id="appoLast_movein">${appoLast.movein_date}</td>
        </tr>
        <tr>
            <th>이전 근무일</th>
            <td id="appoLast_transfer">${appoLast.transfer_date}</td>
        </tr>
        <tr>
            <th>담당자 인덱스</th>
            <td id="appoLast_handler">${appoLast.appo_handler_idx}</td>
        </tr>
        <tr>
            <th>수정일</th>
            <td id="appoLast_update">${appoLast.update_date}</td>
        </tr>
    </table>
	 <table border="1">
        <tr>
            <th>부서</th>
            <th>직급</th>
            <th>직책</th>
            <th>직무</th>
            <th>시작</th>
            <th>종료</th>
        </tr>
        <c:forEach var="appo" items="${appoList}">
        <tr>
            <td id="appoList_dept_idx">${appo.dept_name}</td>        
            <td id="appoList_position_idx">${appo.position_name}</td>
            <td id="appoList_duty_idx">${appo.duty_name}</td>
             <td id="appoList_empl_job">${appo.empl_job}</td>
              <td id="appoList_movein_date">${appo.movein_date}</td>
              <td id="appoList_transfer_date">${appo.transfer_date}</td>
            </tr>
        </c:forEach>
    </table>
	
    <h2>첨부파일 목록</h2>
    <table>
        <tr>
            <th>파일 인덱스</th>
            <th>파일 키</th>
            <th>업로더 인덱스</th>
            <th>원본 파일명</th>
            <th>새 파일명</th>
            <th>파일 타입</th>
            <th>파일 경로</th>
        </tr>
        <tr th:each="fileItem : ${fileList}" class="file-list">
            <td class="file_idx">${fileItem.file_idx}</td>
            <td class="file_key">${fileItem.file_key}</td>
            <td class="uploader_idx">${fileItem.uploader_idx}</td>
            <td class="ori_filename">${fileItem.ori_filename}</td>
            <td class="new_filename">${fileItem.new_filename}</td>
            <td class="file_type">${fileItem.file_type}</td>
            <td class="file_addr">${fileItem.file_addr}</td>
        </tr>
    </table>


<!-- 인사발령 버튼 -->
<button id="openAppoModal">인사발령</button>

<!-- 모달창 -->
<div id="appoModal" style="display: none; position: fixed; top: 20%; left: 30%; width: 40%; padding: 20px; background-color: #fff; border: 1px solid #000;">
    <h3>인사 발령</h3>
    
   <!-- 폼 영역 -->
    <form id="appoForm" action="employeeAppo.do" method="POST">
        <div>
            <label for="department">부서:</label>
            <select id="department" name="dept_idx">
                <option value="">선택</option>
            </select>
        </div>
        <div>
            <label for="position">직급:</label>
            <select id="position" name="position_idx">
                <option value="">선택</option>
            </select>
        </div>
        <div>
            <label for="duty">직책:</label>
            <select id="duty" name="duty_idx">
                <option value="">선택</option>
            </select>
        </div>
         <div>
            <label for="effectiveDate">선택 날짜:</label>
            <input type="date" id="movein_date" name="movein_date">
        </div>
        <!-- 히든 필드 (선택값 동기화) -->
        <input type="hidden" id="empl_idx" name="empl_idx" value="${employee.empl_idx}">
       
       <!-- <input type="hidden" id="hiddenDuty" name="hiddenDuty"> 처리자 empl_idx 넣기 세션아이디로 --> 
        
        <div style="margin-top: 10px;">
            <button type="submit" id="submitAppo">확인</button>
            <button type="button" id="closeAppoModal">취소</button>
        </div>
    </form>
</div>

<!-- 근무변경 버튼 -->
<button id="openChangeModal">근무변경</button>
<!-- 근무변경 모달창 -->
<div id="changeModal" style="display: none; position: fixed; top: 20%; left: 30%; width: 40%; padding: 20px; background-color: #fff; border: 1px solid #000;">
    <h3>근무 변경</h3>
    
    <form id="changeForm" action="employeeChange.do" method="POST">
        <div>
            <label for="statement">근무상태:</label>
            <select id="statement" name="statement_idx">
                <option value="1">근무중</option>
                <option value="2">휴직</option>
                <option value="3">퇴직</option>
            </select>
        </div>
         <input type="hidden" id="empl_idx" name="empl_idx" value="${employee.empl_idx}">
        <div style="margin-top: 10px;">
            <button type="submit" id="submitChange">확인</button>
            <button type="button" id="closeChangeModal">취소</button>
        </div>
    </form>
</div>
    <script>
    $(document).ready(function () {
        // 인사발령 모달 열기
        $("#openAppoModal").click(function () {
            fetchAppoData();
            $("#appoModal").show();
        });
	
        // 모달 닫기
        $("#closeAppoModal").click(function () {
            $("#appoModal").hide();
        });
		
     	// 근무변경 모달 열기
        $("#openChangeModal").click(function () {
          //  fetchChangeData();
            $("#changeModal").show();
        });
     
        // 근무변경 모달 닫기
        $("#closeChangeModal").click(function () {
            $("#changeModal").hide();
        });
        
        // AJAX 호출: 직급, 직책, 부서 데이터를 불러옴
        function fetchAppoData() {
            $.ajax({
                url: "./apponamelist.ajax", // 경로설정
                type: "GET",
                success: function(response) {
                    console.log('Response:', response);
                    populateDropdowns(response);
                },
                error: function() {
                    alert('데이터를 불러오는 중 문제가 발생했습니다.');
                }
            });
        }

        // 드롭다운 리스트 채우기
        function populateDropdowns(data) {
            const deptSelect = $("#department");
            const posiSelect = $("#position");
            const dudySelect = $("#duty");

            deptSelect.empty();
            posiSelect.empty();
            dudySelect.empty();

            data.dept.forEach(item => {
            	   deptSelect.append('<option value="' + item.dept_idx + '">' + item.dept_name + '</option>');
            });

            data.posi.forEach(item => {
            	   posiSelect.append('<option value="' + item.position_idx + '">' + item.position_name + '</option>');
            });

            data.dudy.forEach(item => {
            	 dudySelect.append('<option value="' + item.duty_idx + '">' + item.duty_name + '</option>');
            });
        }
   	 
        // 확인 버튼 클릭 이벤트
        $("#submitAppo").click(function () {
            const selectedDept = $("#department").val();
            const selectedPosi = $("#position").val();
            const selectedDuty = $("#duty").val();

            alert('부서: ' + selectedDept + '\n직급: ' + selectedPosi + '\n직책: ' + selectedDuty);
            
            // 여기에 서버로 데이터를 보내는 AJAX 로직도 추가 가능
            // 예: $.post("/submitAppoData", { dept: selectedDept, posi: selectedPosi, duty: selectedDuty });
            
            $("#appoModal").hide();
        });
    });
        
    </script>

</body>
</html>
