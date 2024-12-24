<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>부서 정보 수정</h1>
   <form action="./organizationUpdate.do" method="POST">
    <table>
    	 <input type="hidden" id="dept_idx" name="dept_idx" value="${dept.dept_idx}" />
        <!-- 조직명 -->
        <tr>
            <td><label for="organizationName">조직명:</label></td>
            <td>
                <input type="text" id="dept_name" name="dept_name" value="${dept.dept_name}" required />
            </td>
        </tr>
         <!-- 부서장 -->
        <tr>
            <td><label for="organizationName">부서장:</label></td>
            <td>
                <input type="text" id="dept_head_idx" name="dept_head_idx" value="${dept.dept_head_idx}" required />
            </td>
        </tr>
        
        <!-- 직무 -->
        <tr>
            <td><label for="jobRole">직무:</label></td>
            <td>
                <input type="text" id="dept_duty" name="dept_duty" value="${dept.dept_duty}" required />
            </td>
        </tr>
        <!-- 현재 상위 =-->
        <tr>
            <td><label for="jobRole">현재 상위 조직</label></td>
            <td>
                <input type="text" value="${dept.dept_high}" required />
            </td>
        </tr>
        <!-- 상위 조직 드롭다운 (AJAX를 통해 채움) -->
        <tr>
            <td><label for="parentOrganization">변경 할 상위 조직:</label></td>
            <td>
                <select id="dept_high" name="dept_high">
                    <option value="">선택</option>
                </select>
            </td>
        </tr>
        
        <!-- 위치 -->
        <tr>
            <td><label for="location">위치:</label></td>
            <td>
                <input type="text" id="dept_addr" name="dept_addr" value="${dept.dept_addr}" required />
            </td>
        </tr>
             
    </table>
    <br />
    <input type="submit" value="제출" />
</form>
</body>

<script>

$(document).ready(function () {
    fetchAppoData();
});


function fetchAppoData() {
    $.ajax({
        url: "./dept_high_list.ajax", // 경로설정
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

function populateDropdowns(data) {
    const deptSelect = $("#dept_high");
    var deptIdx = document.getElementById('dept_idx').value;
    deptSelect.empty();

    data.dept.forEach(item => {
    	if(item.dept_idx.toString() !== deptIdx){  
    		deptSelect.append('<option value="' + item.dept_idx + '">' + item.dept_name + '</option>');
    	}
    	 
    });

}

</script>

</html>