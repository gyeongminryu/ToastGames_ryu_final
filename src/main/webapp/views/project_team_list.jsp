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
    <link rel="stylesheet" type="text/css" href="resources/css/organization.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/approval.css" />
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
                    <li class="tst_title_item" onclick="location.href='/organization_list'">
                        <h1>부서 관리</h1>
                    </li>
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/project_team_list'">
                        <h1>프로젝트 팀 관리</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <table class="tst_table table_no_padding table_no_underline">
                    <tr>
                        <td class="td_align_bottom">

                            <!-- 검색 -->
                            <form id="searchForm">
                                <div class="tst_search_container">
                                    <div class="tst_search_select">
                                        <select id="tst_search_select_category" name="category" onchange="updateInputNameAndParam()">
                                            <option value="" disabled selected>검색 분류</option>
                                            <option value="teamName">팀 이름</option>
                                            <option value="teamHead">팀장 이름</option>
                                        </select>
                                    </div>
                                    <div class="tst_search_input">
                                        <input type="text" id="searchKeyword" name="keyword" maxlength="50" placeholder="검색어를 입력하세요" />
                                    </div>
                                    <div class="tst_search_icon">
                                        <button type="button" id="searchBtn"class="btn_icon"><i class="bi bi-search"></i></button>
                                    </div>
                                </div>
                            </form>
                            <!-- //검색 -->

                        </td>
                        <td class="td_align_right posit_relative">

                            <!-- 프로젝트 팀 추가 -->
                            <button onclick="tst_modal_call('tst_modal_write')" class="btn_primary">프로젝트 팀 추가하기</button>
                           <!-- //프로젝트 팀 추가 -->

                        </td>
                    </tr>
                </table>

                <!-- 프로젝트 팀 목록 -->
                <table class="tst_table tr_hover_subtle" id="teamListTable">
                    <colgroup>
                        <col style="width: 80px" />
                        <col style="width: 180px" />
                        <col style="width: 180px" />
                        <col style="width: 160px" />
                        <col style="width: 200px" />
                        <col style="width: 100px" />
                        <col style="width: auto" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th></th>
                        <th>팀명</th>
                        <th>팀장</th>
                        <th>팀장 연락처</th>
                        <th>팀장 이메일</th>
                        <th>소속 인원</th>
                        <th>담당 직무</th>
                    </tr>
                    </thead>
                    <tbody>

                    <!-- 프로젝트 팀 > 운영중 -->
                    <tr>
                        <td class="td_no_padding td_align_left"><span class="tst_badge_min btn_secondary">운영중</span></td>
                        <th class="td_align_left tst_pointer" onclick="location.href='/project_team_detail?'">{팀명}</th>
                        <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{팀장} ({소속부서|팀}/{직급})</span></td>
                        <td>{팀장 연락처}</td>
                        <td>{팀장 이메일}</td>
                        <td>{소속 인원}명</td>
                        <td class="td_align_left">{팀 담당 직무}</td>
                    </tr>
                    <!-- //프로젝트 팀 > 운영중 -->

                    <!-- 프로젝트 팀 > 운영 종료 -->
                    <tr>
                        <td class="td_no_padding td_align_left"><span class="tst_badge_min btn_subtle">운영 종료</span></td>
                        <th class="td_align_left tst_pointer" onclick="location.href='/project_team_detail?'">{팀명}</th>
                        <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{팀장} ({소속부서|팀}/{직급})</span></td>
                        <td>{팀장 연락처}</td>
                        <td>{팀장 이메일}</td>
                        <td>{소속 인원}명</td>
                        <td class="td_align_left">{팀 담당 직무}</td>
                    </tr>
                    <!-- //프로젝트 팀 > 운영 종료 -->

                   
                    </tbody>

                    <!-- pagination -->
                    <tfoot>
                    <tr>
                        <td colspan="7">
                        <nav aria-label="Page navigation">
                            <ul id="pagination" class="pagination">
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
                            </nav>
                        </td>
                    </tr>
                    </tfoot>
                    <!-- //pagination -->

                </table>
                <!-- //프로젝트 팀 목록 -->

            </div>
        </div>
    </div>
</div>

        <c:import url="project_team_list_modal.jsp" />

</body>
<script src="resources/js/common.js"></script>
<script>


let allMembers = []; // 전체 데이터 배열
let currentPage = 1; // 현재 페이지 번호
const rowsPerPage = 10; // 한 페이지에 표시할 데이터 수

// 검색 선택 항목 업데이트
function updateInputNameAndParam() {
    var selectBox = document.getElementById("tst_search_select_category");
    var keywordInput = document.getElementById("searchKeyword");

    if (selectBox && keywordInput) {
        keywordInput.name = selectBox.value || ""; // 선택된 값으로 name 설정 또는 초기화
    } else {
        console.error("Select box or input field not found!");
    }
}

// 페이징 UI 설정 함수
function setupPagination(totalItems) {
    var totalPages = Math.ceil(totalItems / rowsPerPage); // 총 페이지 수
    var pagination = document.getElementById("pagination");

    pagination.innerHTML = ""; // 기존 페이지 버튼 초기화

    // 이전 버튼
    var prevButton = document.createElement("li");
    prevButton.className = "page-item prev" + (currentPage === 1 ? " disabled" : "");
    prevButton.innerHTML = '<a href="#" class="page-link"><i class="bi bi-chevron-left"></i></a>';
    prevButton.onclick = function () {
        if (currentPage > 1) {
            currentPage--;
            renderCurrentPage();
        }
    };
    pagination.appendChild(prevButton);

    // 페이지 번호 버튼 생성
    for (var i = 1; i <= totalPages; i++) {
        var pageButton = document.createElement("li");
        pageButton.className = "page-item" + (i === currentPage ? " active" : "");
        pageButton.innerHTML = '<a href="#" class="page-link">' + i + '</a>';
        pageButton.onclick = (function (page) {
            return function () {
                currentPage = page;
                renderCurrentPage();
            };
        })(i);
        pagination.appendChild(pageButton);
    }

    // 다음 버튼
    var nextButton = document.createElement("li");
    nextButton.className = "page-item next" + (currentPage === totalPages ? " disabled" : "");
    nextButton.innerHTML = '<a href="#" class="page-link"><i class="bi bi-chevron-right"></i></a>';
    nextButton.onclick = function () {
        if (currentPage < totalPages) {
            currentPage++;
            renderCurrentPage();
        }
    };
    pagination.appendChild(nextButton);
}

// 현재 페이지 렌더링
function renderCurrentPage() {
    var tableBody = document.getElementById("teamListTable").querySelector("tbody");
    tableBody.innerHTML = ""; // 테이블 초기화

    var startIndex = (currentPage - 1) * rowsPerPage;
    var endIndex = startIndex + rowsPerPage;

    var pageData = allMembers.slice(startIndex, endIndex); // 현재 페이지 데이터

    if (pageData.length > 0) {
        pageData.forEach(function (team) {
            var currentDate = new Date();
            var deletionDate = new Date(team.deletion_date);

            var status =
                deletionDate < currentDate
                    ? '<span class="tst_badge_min btn_subtle">운영 종료</span>'
                    : '<span class="tst_badge_min btn_secondary">운영중</span>';

            // 테이블 행 추가
            var row = "<tr>";
            row += '<td class="td_no_padding td_align_left">' + status + "</td>";
            row += '<th class="td_align_left tst_pointer" onclick="location.href=\'/project_team_detail.go?team_idx=' + team.team_idx + '\'">' + team.team_name + "</th>";
            row += '<td class="td_align_left"><span onclick="tst_view_profile(\'' + team.team_head_idx + '\')" class="tst_pointer">' + team.team_head_name + " (" + (team.team_head_dept || "소속부서 없음") + "/" + (team.position_name || "직급 없음") + ")</span></td>";
            row += "<td>" + (team.head_cmp_phone || "없음") + "</td>";
            row += "<td>" + (team.head_cmp_email || "없음") + "</td>";
            row += "<td>" + (team.team_member_count || "0") + "명</td>";
            row += '<td class="td_align_left">' + (team.team_duty || "직무 없음") + "</td>";
            row += "</tr>";
            tableBody.innerHTML += row;
        });
    } else {
        tableBody.innerHTML = '<tr><td colspan="7">검색 결과가 없습니다.</td></tr>';
    }
}

// 팀 전체 목록 로드
function teamAllList() {
    $.ajax({
        url: './search_team_all_list.ajax', // 요청 경로
        type: 'GET',
        dataType: 'json',
        success: function (data) {
        	console.log(data);
            allMembers = data.team_list || []; // 전체 데이터를 저장
            setupPagination(allMembers.length); // 페이지네이션 설정
            renderCurrentPage(); // 첫 페이지 렌더링
        },
        error: function (xhr, status, error) {
            console.error('데이터를 가져오는 중 오류 발생:', error);
        }
    });
}

// 검색 버튼 클릭 시
document.getElementById("searchBtn").addEventListener("click", function () {
    var form = document.getElementById("searchForm");
    var formData = new FormData(form);

    var requestData = {};
    formData.forEach(function (value, key) {
        if (value) {
            requestData[key] = value;
        }
    });

    $.ajax({
        url: './search_team_list.ajax',
        method: 'GET',
        data: requestData,
        success: function (response) {
            console.log(response);
            allMembers = response.team_list || []; // 검색된 데이터 저장
            setupPagination(allMembers.length); // 페이지네이션 설정
            renderCurrentPage(); // 첫 페이지 렌더링
        },
        error: function (err) {
            console.error("데이터를 가져오는 중 오류 발생:", err);
        }
    });
});

//페이지 로드 시 초기 데이터 표시
document.addEventListener("DOMContentLoaded", function () {
    teamAllList(); // 초기 데이터 로드
});

</script>

</html>