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
                <!-- //프로젝트 팀 목록 -->

            </div>
        </div>
    </div>
</div>

        <c:import url="project_team_list_modal.jsp" />

</body>
<script src="resources/js/common.js"></script>
<script>
function updateInputNameAndParam() {
    const selectBox = document.getElementById("tst_search_select_category");
    const keywordInput = document.getElementById("searchKeyword") || document.getElementById("searchValueInput");

    // 선택된 카테고리 값에 따라 name 속성을 업데이트
    if (selectBox && keywordInput) {
        keywordInput.name = selectBox.value || ""; // 선택된 값으로 name 설정 또는 초기화
    } else {
        console.error("Select box or input field not found!");
    }
}

//검색 버튼 클릭 시 Ajax 요청
document.getElementById("searchBtn").addEventListener("click", function () {
    const form = document.getElementById("searchForm");
    const formData = new FormData(form);

    // Ajax 요청 데이터 생성
    const requestData = {};
    formData.forEach((value, key) => {
        if (value) {
            requestData[key] = value;
        }
    });

    // Ajax 요청
    $.ajax({
        url: './search_team_list.ajax',
        method: 'GET',
        data: requestData,
        success: function (response) {
            const tableBody = $('#teamListTable tbody');
            tableBody.empty();

            if (response.team_list && response.team_list.length > 0) {
                response.team_list.forEach(function (team) {
                    // 현재 날짜와 운영 종료 날짜 비교
                    const currentDate = new Date();
                    const deletionDate = new Date(team.deletion_date);

                    const status =
                        deletionDate < currentDate
                            ? '<span class="tst_badge_min btn_subtle">운영 종료</span>'
                            : '<span class="tst_badge_min btn_secondary">운영중</span>';

                    // 테이블 행 추가
                    tableBody.append(
                        '<tr>' +
                            '<td class="td_no_padding td_align_left">' + status + '</td>' +
                            '<th class="td_align_left tst_pointer" onclick="location.href=\'/project_team_detail.go?' + team.team_idx + '\'">' + team.team_name + '</th>' +
                            '<td class="td_align_left"><span onclick="tst_view_profile(\'' + team.team_head_idx + '\')" class="tst_pointer">' +
                            team.team_head_name + ' (' + (team.team_head_dept || "소속부서 없음") + '/' + (team.team_head_position || "직급 없음") + ')</span></td>' +
                            '<td>' + (team.head_cmp_phone || "없음") + '</td>' +
                            '<td>' + (team.head_cmp_email || "없음") + '</td>' +
                            '<td>' + (team.team_member_count || "0") + '명</td>' +
                            '<td class="td_align_left">' + (team.team_duty || "직무 없음") + '</td>' +
                        '</tr>'
                    );
                });
            } else {
                tableBody.append('<tr><td colspan="7">검색 결과가 없습니다.</td></tr>');
            }
        },
        error: function (err) {
            console.error("데이터를 가져오는 중 오류 발생:", err);
        },
    });
});

</script>

</html>