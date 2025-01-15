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
    <link rel="stylesheet" type="text/css" href="resources/css/module_pagenation.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/approval.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/approval_send_modal.css" />>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="resources/js/jquery.twbsPagination.js"></script>
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_staff_list'">
                        <h1>구성원 관리</h1>
                    </li>
                </ul>
                <!-- //제목 -->



                <!-- 직원 검색 -->
               
                    <div class="tst_search_container">
                    <input type="hidden" name="dept_idx" id="dept_idx" value="${empl_info.dept_idx}" />
                        <div class="tst_search_select">
                            <select id="searchKey" onchange="<!-- 분류 선택시 실행할 함수를 입력하세요 -->">
                                <option value="">검색 분류</option>
                                <option value="empl_name">이름</option>
                				<option value="empl_cmp_email">ID</option>
                            </select>
                        </div>
                        <div class="tst_search_input">
                            <input type="text" id="searchValue" name="keyword" maxlength="50" placeholder="검색어를 입력하세요" />
                        </div>
                        <div class="tst_search_icon">
                            <button id="searchBtn" class="btn_icon"><i class="bi bi-search"></i></button>
                        </div>
                    </div>
                
                <!-- //직원 검색 -->

                <table class="tst_table tr_hover_subtle">
                    <colgroup>
                        <col style="width: 60px;" />
                        <col style="width: 200px;" />
                        <col style="width: 250px;" />
                        <col style="width: 120px;" />
                        <col style="width: auto;" />
                        <col style="width: 150px;" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>부서/팀</th>
                        <th>직원명 (ID)</th>
                        <th>직급/직책</th>
                        <th>직무</th>
                        <th>입사일</th>
                    </tr>
                    </thead>
                    <tbody id="staffList">

				<!-- 검색되는 직원이 없을 경우 -->
				    <c:if test="${empty dept_info}">
				        <tr class="rent_list_no_data">
				            <td colspan="6" class="td_no_data">
				                <p><i class="bi bi-person-exclamation"></i></p>
				                <h3>검색 조건에 해당하는 직원이 없습니다.</h3>
				            </td>
				        </tr>
				    </c:if>
				    <!-- //검색되는 직원이 없을 경우 -->
				
				    <!-- 직원 목록 -->
				    <c:if test="${not empty dept_info}">
				        <c:forEach var="employee" items="${dept_info}" varStatus="status">
				            <tr>
				                <td>${status.index + 1}</td>
				                <td class="td_align_left">
				                    <span onclick="location.href='/organization_detail.go?dept_idx=${employee.dept_idx}'" class="tst_pointer">
				                        ${employee.dept_name}
				                    </span>
				                </td>
				                <td class="td_align_left">
				                    <h3 onclick="location.href='/staff_detail.go?empl_idx=${employee.empl_idx}'" class="tst_pointer">
				                        ${employee.empl_name} (${employee.empl_id})
				                    </h3>
				                </td>
				                <td class="td_align_left">${employee.position_name}/${employee.duty_name}</td>
				                <td class="td_align_left">${employee.empl_job}</td>
				                <td>${employee.empl_join_date}</td>
				            </tr>
				        </c:forEach>
				    </c:if>
				    <!-- //직원 목록 -->
                    <!-- //예시 -->

                    <!-- pagination -->
                    <tfoot>
                    <tr>
                        <td colspan="7">
                            <ul id="pagination" class="pagination-sm pagination">
                                <li class="page-item first disabled">
                                    <a href="#" class="page-link"><i class="bi bi-chevron-double-left"></i></a>
                                </li>
                                <li class="page-item prev disabled">
                                    <a href="#" class="page-link"><i class="bi bi-chevron-left"></i></a>
                                </li>
                                <li class="page-item active">
                                    <a href="#" class="page-link">1</a>
                                </li>
                                <li class="page-item">
                                    <a href="#" class="page-link">2</a>
                                </li>
                                <li class="page-item">
                                    <a href="#" class="page-link">3</a>
                                </li>
                                <li class="page-item">
                                    <a href="#" class="page-link">4</a>
                                </li>
                                <li class="page-item">
                                    <a href="#" class="page-link">5</a>
                                </li>
                                <li class="page-item">
                                    <a href="#" class="page-link">6</a>
                                </li>
                                <li class="page-item">
                                    <a href="#" class="page-link">7</a>
                                </li>
                                <li class="page-item">
                                    <a href="#" class="page-link">8</a>
                                </li>
                                <li class="page-item">
                                    <a href="#" class="page-link">9</a>
                                </li>
                                <li class="page-item">
                                    <a href="#" class="page-link">10</a>
                                </li>
                                <li class="page-item next">
                                    <a href="#" class="page-link"><i class="bi bi-chevron-right"></i></a>
                                </li>
                                <li class="page-item last">
                                    <a href="#" class="page-link"><i class="bi bi-chevron-double-right"></i></a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    </tfoot>
                    <!-- //pagination -->
                </table>
            </div>
        </div>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/approval_send_modal.js"></script>
<script>
// 직원 목록 가져오기
function fetchStaffList() {
    var deptIdx = document.getElementById("dept_idx").value;
    var searchKey = document.getElementById("searchKey").value;
    var searchValue = document.getElementById("searchValue").value;

    $.ajax({
        url: "./staff_list.ajax", // AJAX 요청 URL 경로설정
        type: "GET",
        data: {
            dept_idx: deptIdx,
            searchKey: searchKey,
            searchValue: searchValue
        },
        success: function(data) {
        	console.log(data);
            var tbody = document.getElementById("staffList");
            tbody.innerHTML = ""; // 기존 데이터 비우기
			
            if (data.length === 0) {
                // 검색 결과가 없을 경우
                var noDataRow = 
                    "<tr class='rent_list_no_data'>" +
                        "<td colspan='6' class='td_no_data'>" +
                            "<p><i class='bi bi-person-exclamation'></i></p>" +
                            "<h3>검색 조건에 해당하는 직원이 없습니다.</h3>" +
                        "</td>" +
                    "</tr>";
                tbody.innerHTML = noDataRow;
            } 
            else{
            
            for (var i = 0; i < data.length; i++) {
                var employee = data[i];
                var row = "<tr>";
                row += "<td>" + (i + 1) + "</td>";
                row += "<td class='td_align_left'>"; 
                row += "<span onclick=\"location.href='/organization_detail.go?dept_idx='\" class='tst_pointer'>" 
                		+ (employee.dept_name || "N/A")+"</td>";
               
                
                row += "<td class='td_align_left'>";
                row += "<h3 onclick=\"location.href='/manage_staff_detail?'\" class='tst_pointer'>" 
                       + (employee.empl_name || "N/A") 
                       + " (" + (employee.empl_id || "N/A") + ")</h3>";
                row += "</td>";
                
                row += "<td class='td_align_left'>" 
                       +(employee.position_name || "N/A")+'/'+ (employee.duty_name || "N/A") + "</td>";
                
                row += "<td class='td_align_left'>" 
                       + (employee.empl_job || "N/A") + "</td>";
                
                row += "<td>" 
                       + (employee.empl_join_date || "N/A") + "</td>";
                
                row += "</tr>";

                tbody.innerHTML += row; // 기존 행에 추가
            }
        }
        },
        error: function(err) {
            console.error("데이터를 가져오는 중 오류 발생:", err);
        }
    });
}

// 이벤트 핸들링
document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("dept_idx").addEventListener("change", fetchStaffList); // 부서 변경 시 호출
    document.getElementById("searchBtn").addEventListener("click", fetchStaffList); // 검색 버튼 클릭 시 호출
});
</script>

</html>