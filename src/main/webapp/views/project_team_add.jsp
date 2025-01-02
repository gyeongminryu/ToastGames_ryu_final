<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<head>
    <title>프로젝트 팀 형성하기</title>
    <script>
 	// 직원 정보를 클릭하여 선택
    function selectTeamLeader(row) {
        var emplIdx = row.getAttribute('data-empl-idx'); // 직원 ID
        var emplName = row.getAttribute('data-empl-name'); // 직원 이름
        var dutyName = row.getAttribute('data-duty-name'); // 직급
        var positionName = row.getAttribute('data-position-name'); // 직책
        var deptName = row.getAttribute('data-dept-name'); // 부서

        // 선택한 정보를 input 필드에 반영
        document.getElementById("team_head_name").value =
            emplName + " (" + dutyName + "/" + positionName + ") - " + deptName;
        document.getElementById("team_head_idx").value =
        	emplIdx;
        closeModal();
    }
    
        // 모달창 열기
        function openTeamLeaderModal() {
            var modal = document.getElementById("teamLeaderModal");
            modal.style.display = "block";
        }

        // 모달창 닫기
        function closeModal() {
            var modal = document.getElementById("teamLeaderModal");
            modal.style.display = "none";
        }

        
        
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
                        var row = '<tr class="staff-row" ' +
                                  'data-empl-idx="' + employee.empl_idx + '" ' +
                                  'data-empl-name="' + (employee.empl_name || "없음") + '" ' +
                                  'data-duty-name="' + (employee.duty_name || "없음") + '" ' +
                                  'data-position-name="' + (employee.position_name || "없음") + '" ' +
                                  'data-dept-name="' + (employee.dept_name || "없음") + '" ' +
                                  'onclick="selectTeamLeader(this)">' +
                                  '<td>' + (i + 1) + '</td>' +
                                  '<td>' + (employee.empl_name || "없음") + '</td>' +
                                  '<td>' + (employee.duty_name || "없음") + '/' + (employee.position_name || "없음") + '</td>' +
                                  '<td>' + (employee.dept_name || "없음") + '</td>' +
                                  '<td>' + (employee.empl_job || "없음") + '</td>' +
                                  '</tr>';
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
            document.getElementById("dept_idx").addEventListener("change", fetchStaffList); // 부서 변경 시 호출
            document.getElementById("searchBtn").addEventListener("click", fetchStaffList); // 검색 버튼 클릭 시 호출
        });
    </script>
</head>
<body>
    <h1>프로젝트 팀 형성하기</h1>
    <form action="project_team_add.do" method="post"> 
        <!-- 프로젝트 팀명 -->
        <div>
            <label for="team_name">프로젝트 팀명</label><br>
            <input type="text" id="team_name" name="team_name" value="[캐주얼게임] 토스트 타이쿤" required>
        </div>
        <br>

        <!-- 조직장 -->
        <div>
            <label for="team_head_idx">조직장</label><br>
            <input type="hidden" id="team_head_idx" name="team_head_idx" >
            <input type="text" id="team_head_name" name="team_head_name" >
            <button type="button" onclick="openTeamLeaderModal()">조직장 선택</button>
        </div>
        <br>

        <!-- 운영 기간 -->
        <div>
            <label for="startDate">운영 기간</label><br>
            <input type="date" id="callup_date" name="calup_date" value="2025-01-02T09:00" required>
            ~
            <input type="date" id="deletion_date" name="deletion_date" value="2025-10-17T18:00" required>
        </div>
        <br>

        <!-- 직무 -->
        <div>
            <label for="team_duty">직무</label><br>
            <textarea id="team_duty" name="team_duty" rows="4" cols="50" maxlength="1000" required>
토스트 회사 스위티 토스트를 운영하는 타이쿤 게임 제작
            </textarea>
        </div>
        <br>

        <!-- 버튼 -->
        <div>
            <button type="submit">프로젝트 팀 형성하기</button>
            <button type="button" onclick="history.back()">돌아가기</button>
        </div>
    </form>

    <!-- 조직장 선택 모달 -->
    <div id="teamLeaderModal" style="display:none; position:fixed; top:10%; left:10%; width:80%; height:80%; background-color:white; border:1px solid #000; overflow:auto;">
        <h2>프로젝트 팀장 등록</h2>
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
        <table border="1" width="100%" id="leaderTable">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>이름</th>
                    <th>직급/직책</th>
                    <th>소속</th>
                    <th>직무</th>
                </tr>
            </thead>
            <tbody id="staffList">
               
                <!-- 추가 데이터 -->
            </tbody>
        </table>
        <br>
        <button onclick="closeModal()">닫기</button>
    </div>
</body>
</html>
