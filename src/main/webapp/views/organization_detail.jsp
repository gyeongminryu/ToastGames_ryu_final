<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/manage_rent.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_table.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/organization_list'">
                        <h1>부서 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/project_team_list'">
                        <h1>프로젝트 팀 관리</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">

                    <!-- 조직 정보 -->
                    <div class="tst_col3">
                        <table class="tst_table table_align_left table_no_padding">
                            <colgroup>
                                <col style="width: 100px" />
                                <col style="width: auto" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="2">부서 정보</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th>부서명</th>
                                    <td>${deptinfo.dept_name}</td>
                                </tr>
                                <tr>
                                    <th>부서 구분</th>
                                    <td>부서</td>
                                </tr>
                                <tr>
                                    <th>부서장</th>
                                    <td>
                                        <span onclick="tst_view_profile('${employee.empl_idx}')" class="tst_pointer">
                                            ${employee.empl_name} (${appoLast.duty_name}/${appoLast.position_name})
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>직무</th>
                                    <td>${deptinfo.dept_duty}</td>
                                </tr>
                                <tr>
                                    <th>상위 부서</th>
                                    <td>${highdeptinfo.dept_name}</td>
                                </tr>
                                <tr>
                                    <th>부서원 수</th>
                                    <td>${deptcnt}명</td>
                                </tr>
                                <tr>
                                    <th>위치</th>
                                    <td>${deptinfo.dept_addr}</td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="2">
                                        <button onclick="tst_modal_call('tst_modal_update')" class="btn_primary btn_full">
                                            부서 정보 수정하기
                                        </button>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                        <hr class="separator" />

                        <!-- 부서장 변경 이력 -->
                        <table class="tst_table">
                            <colgroup>
                                <col style="width: 60px;" />
                                <col style="width: auto;" />
                                <col style="width: 110px;" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>부서장</th>
                                    <th>발령일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="dept" items="${depthis}" varStatus="status">
                                    <tr>
                                          <td>${status.index + 1}</td>
                                        <td class="td_align_left">
                                            <span onclick="tst_view_profile('${dept.dept_head_idx}')" class="tst_pointer">
                                                ${dept.empl_name} (${dept.duty_name}/${dept.position_name})
                                            </span>
                                        </td>
                                        <td>${dept.dept_change_date}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- 조직원 검색 및 목록 -->
                    <div class="tst_col9">

                      <!-- 조직원 검색 -->
                        <form id="searchForm">
                            <div class="tst_search_container">
                                <div class="tst_search_select">
                                    <select id="tst_search_select_category" name="searchKey">
                                        <option value="">검색 분류</option>
                                         <option value="empl_name">이름</option>
                							<option value="empl_cmp_email">이메일</option>
                                    </select>
                                </div>
                                <div class="tst_search_input">
                                    <input type="text" id="searchValue" name="searchValue" maxlength="50" class="input_min input_underline" placeholder="검색어를 입력하세요" />
                                </div>
                                <div class="tst_search_icon">
                                    <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
                                </div>
                            </div>
                        </form>
                        <!-- //조직원 검색 -->

                        <!-- 조직원 목록 -->
                        <h2>사원 목록</h2>
                        <table id="employeeTable" class="tst_table">
                            <thead>
                                <tr>
                                    <th>부서원 이름</th>
                                    <th>직책/직급</th>
                                    <th>직무</th>
                                    <th>회사 이메일</th>
                                    <th>전입 일시</th>
                                    <th>근무 상태</th>
                                </tr>
                            </thead>
                            <tbody>
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
                </div>
            </div>
        </div>
    </div>
</div>
<script>
$(document).ready(function() {
    const emplNameContainer = $('#emplNameContainer');
    const cmpEmailContainer = $('#cmpEmailContainer');
    const searchOptions = $('input[name="searchOption"]');

    // 라디오 버튼 변경 시 입력 필드 토글
    searchOptions.on('change', function() {
        if ($(this).val() === 'emplName') {
            emplNameContainer.show();
            cmpEmailContainer.hide();
            $('#cmpEmail').val('');
        } else if ($(this).val() === 'cmpEmail') {
            emplNameContainer.hide();
            cmpEmailContainer.show();
            $('#emplName').val('');
        }
    });

    // 폼 제출 시 AJAX 요청
    $('#searchForm').on('submit', function(event) {
        event.preventDefault();

        var emplName = $('#emplName').val();
        var cmpEmail = $('#cmpEmail').val();
        var dept_idx = $('#dept_idx').val();

        $.ajax({
            url: './search_dept_member.ajax',
            method: 'GET',
            data: {
                emplName: emplName,
                cmpEmail: cmpEmail,
                dept_idx: dept_idx
            },
            success: function(response) {
                var tableBody = $('#employeeTable tbody');
                tableBody.empty();

                if (response.length > 0) {
                    response.forEach(function(employee) {
                        tableBody.append('<tr>' +
                            '<td>' + employee.empl_name + '</td>' +
                            '<td>' + employee.duty_name + '/' + employee.position_name + '</td>' +
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
            error: function() {
                alert('검색 중 오류가 발생했습니다.');
            }
        });
    });
});
</script>
</body>
</html>
