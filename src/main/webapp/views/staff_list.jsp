<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>구성원 관리</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <!-- Header Section -->
    <header>
        <h1>TOAST GAMES</h1>
    </header>

    <!-- Main Content Section -->
    <main>
        <h2>구성원 관리</h2>

        <!-- 검색 필터 -->
        <div>
            <label for="dept_idx">부서:</label>
            <select id="dept_idx">
                <option value="">전체</option>
                <option value="101">부서 101</option>
                <option value="102">부서 102</option>
                <option value="103">부서 103</option>
                <option value="105">부서 105</option>
            </select>

            <label for="searchKey">검색 기준:</label>
            <select id="searchKey">
                <option value="">선택</option>
                <option value="empl_name">이름</option>
                <option value="empl_cmp_email">이메일</option>
            </select>

            <input type="text" id="searchValue" placeholder="검색어 입력" />
            <button id="searchBtn">검색</button>
        </div>

        <!-- 직원 목록 테이블 -->
        <table border="1">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>부서</th>
                    <th>성명</th>
                    <th>직급/직책</th>
                    <th>ID</th>
                    <th>유선 연락처</th>
                    <th>이메일</th>
                    <th>입사일시</th>
                    <th>퇴사일시</th>
                    <th>근무상태</th>
                </tr>
            </thead>
            <tbody id="staffList">
                <!-- 데이터가 여기에 동적으로 추가됩니다 -->
            </tbody>
        </table>
    </main>

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

                    for (var i = 0; i < data.length; i++) {
                        var employee = data[i];
                        var row = "<tr>";
                        row += "<td>" + (i + 1) + "</td>";
                        row += "<td>" + (employee.dept_name || "N/A") + "</td>";
                        row += "<td>" + (employee.empl_name || "N/A") + "</td>";
                        row += "<td>" + (employee.duty_name || "N/A") + "</td>";
                        row += "<td>" + (employee.empl_id || "N/A") + "</td>";
                        row += "<td>" + (employee.empl_cmp_phone || "N/A") + "</td>";
                        row += "<td>" + (employee.empl_cmp_email || "N/A") + "</td>";
                        row += "<td>" + (employee.empl_join_date || "N/A") + "</td>";
                        row += "<td>" + (employee.empl_resig_date || "N/A") + "</td>";
                        row += "<td>" + (employee.statement_name || "N/A") + "</td>";
                        row += "</tr>";

                        tbody.innerHTML += row;
                    }
                },
                error: function(err) {
                    console.error("데이터를 가져오는 중 오류 발생:", err);
                }
            });
        }

        // 이벤트 핸들링
        document.addEventListener("DOMContentLoaded", function() {
         //   document.getElementById("dept_idx").addEventListener("change", fetchStaffList); // 부서 변경 시 호출
            document.getElementById("searchBtn").addEventListener("click", fetchStaffList); // 검색 버튼 클릭 시 호출
        });
    </script>
</body>
</html>
