<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>부서 정보 및 사원 목록</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
    <div class="container mt-4">
        <h2>부서장 변경 이력 정보</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>부서 ID</th>
                    <th>부서장 이름</th>
                    <th> 직책/직급</th>
                    <th>일시</th>
                </tr>
            </thead>
            <tbody>
                <!-- 서버에서 전달된 depthis 데이터로 부서 정보 동적으로 렌더링 -->
                <c:forEach var="dept" items="${depthis}">
                    <tr>
                        <td>${dept.dept_idx}</td>
                        <td>${dept.empl_name}</td>
                        <td>${dept.duty_name}/${dept.position_name}</td>
                        <td>${dept.dept_change_date}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
		<h2>부서 상세 정보</h2>
         <table>
         	<thead>
                <tr>
                    <th>부서 이름</th>
                    <th>부서장 이름/직책/직급</th>
                    <th>부서 직무</th>
                    <th>상위부서</th>
                    <th>부서 위치</th>
                    <th>조직원수</th>
                    <th>최초조직일시</th>
                </tr>
            </thead>
             <tbody>
             <tr>
             <td>${deptinfo.dept_name}</td>
             <td>${employee.empl_name}/${appoLast.duty_name}/${appoLast.position_name}</td>
             <td>${deptinfo.dept_duty}</td>
             <td>${highdeptinfo.dept_name}</td>
             <td>${deptinfo.dept_addr}</td>
             <td>조직원수</td>
             <td>${deptfirstdate.dept_change_date}</td>
             </tr>
             
             
              </tbody>
		 </table>
		
		 <form id="searchForm">
		 <input type="hidden" id="dept_idx" name="dept_idx" value="${dept.dept_idx}"/>
	        <label for="emplName">사원명:</label>
	        <input type="text" id="emplName" name="emplName" placeholder="사원명을 입력하세요">
	        
	        <label for="cmpEmail">회사 이메일:</label>
	        <input type="text" id="cmpEmail" name="cmpEmail" placeholder="이메일을 입력하세요">
	        
	        <button type="submit">검색</button>
	    </form>
		


        <h2>사원 목록</h2>
      <table class="employeeTable">
            <thead>
                <tr>
                    <th>부서원 이름</th>
                    <th>직책/직급</th>
                    <th>직무</th>
                    <th>회사이메일</th>
                    <th> 전입일시</th>
                    <th>근무상태</th>
                </tr>
            </thead>
            <tbody>
                <!-- 서버에서 전달된 depthis 데이터로 부서 정보 동적으로 렌더링 -->
                <c:forEach var="member" items="${deptmember}">
                    <tr>
                        <td>${member.empl_name}</td>
                        <td>${member.duty_name}/${member.position_name}</td>
                        <td>${member.empl_job}</td>
                        <td>${member.empl_cmp_email}</td>
                        <td>${member.movein_date}</td>
                        <td>${member.statement_name}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

      
    </div>

    <script>
    $(document).ready(function() {
        // 폼 제출 시 AJAX 요청
        $('#searchForm').on('submit', function(event) {
            event.preventDefault();  // 폼 기본 동작 방지

            var emplName = $('#emplName').val();
            var cmpEmail = $('#cmpEmail').val();
            var dept_idx = $('#dept_idx').val();

            // AJAX 요청
            $.ajax({
                url: '/searchDeptMember.ajax',  // 서버의 검색 엔드포인트
                method: 'GET',
                data: {
                    emplName: emplName,
                    cmpEmail: cmpEmail,
                    dept_idx: dept_idx
                },
                success: function(response) {
                	console.log(response.searchmember);
                    // 응답 받은 데이터를 테이블에 채우기
                    var tableBody = $('#employeeTable tbody');
                    tableBody.empty();  // 기존 내용 비우기

                    // 검색 결과가 있을 경우 테이블에 데이터 추가
                    if (response.length > 0) {
                        response.forEach(function(employee) {
                            tableBody.append('<tr>' +
                                '<td>' + employee.empl_name + '</td>' +
                                '<td>' + employee.duty_name + '</td>' +
                                '<td>' + employee.empl_job + '</td>' +
                                '<td>' + employee.empl_cmp_email + '</td>' +
                                '<td>' + employee.movein_date + '</td>' +
                                '<td>' + employee.statement_name + '</td>' +
                            '</tr>');
                        });
                    } else {
                        tableBody.append('<tr><td colspan="6">검색 결과가 없습니다.</td></tr>');
                    }
                },
                error: function(xhr, status, error) {
                    alert('검색 중 오류가 발생했습니다.');
                }
            });
        });
    });
    </script>
</body>
</html>