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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_employee_list'">
                        <h1>인사 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_employee_resign_list'">
                        <h1>퇴사자 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_employee_regist'">
                        <h1>직원 등록</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_employee_regist_multiple'">
                        <h1>직원 일괄 등록</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">
                    <div class="tst_col2">

                        <!-- 부서/팀 검색 -->
                        <form>
                            <div class="tst_search_container width_full">
                                <div class="tst_search_input">
                                    <input type="text" name="keyword_category" maxlength="50" class="input_min input_underline" placeholder="부서 목록" readonly/>
                                </div>
                                <div class="tst_search_icon">
                                   <!--   <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button> -->
                                </div>
                            </div>
                        </form>
                        <!-- //부서/팀 검색 -->

                        <table class="tst_table table_align_left">
                            <colgroup>
                                <col style="width: 20px;" />
                                <col style="width: auto;" />
                            </colgroup>
                           
                            <tbody class="tst_pointer">
							 <!-- 전 직원 조회 (필터링 초기화) -->
                            <tr>
                                <td></td>
                                <th class="td_no_padding">
                                    <span onclick="location.href='./manage_employee_list.go'">전체 보기</span>
                                </th>
                            </tr>
                            <!-- //전 직원 조회 (필터링 초기화) -->

                            <!-- 가발령 상태인 직원 조회 -->
                            <tr>
                                <td></td>
                                <td class="td_no_padding">
                                    <span id="pre-assignment-list" >가발령</span>
                                </td>
                            </tr>
                            <!-- 가발령 상태인 직원 조회 -->
                            <!-- 부서 (필터링) -->
                            <tr id="dynamic-section-placeholder">
						       
						    </tr>
                            <tr>
                                <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this, '부서번호')"></i></td><!-- 한꺼번에 불러오실 경우 '부서 번호' 지우시면 됩니다.-->
                                <th class="td_no_padding">
                                    <span onclick="location.href='/manage_employee_list?'">{부서명}</span>
                                </th>
                            </tr>
                            <tr class="disp_hide">
                                <td colspan="2" class="td_no_padding">
                                    <table class="tst_table tst_table_in_table table_align_left">
                                        <colgroup>
                                            <col style="width: 23px;" />
                                            <col style="width: auto;" />
                                        </colgroup>

                                        <!-- 팀 목록 (필터링) -->
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">{팀명}</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">{팀명}</span></td>
                                        </tr>
                                        <!-- //팀 목록 (필터링) -->

                                    </table>
                                </td>
                            </tr>
                            <!-- //부서 (필터링) -->

                            <!-- 부서 > 선택한 항목 (필터링) -->
                            <tr class="td_bg_medium">
                                <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this, '부서번호')"></i></td><!-- 한꺼번에 불러오실 경우 '부서 번호' 지우시면 됩니다.-->
                                <th class="td_no_padding">
                                    <span onclick="location.href='/manage_employee_list?'">{분류명}</span>
                                </th>
                            </tr>

                            <tr class="disp_hide">
                                <td colspan="2" class="td_no_padding">
                                    <table class="tst_table tst_table_in_table table_align_left">
                                        <colgroup>
                                            <col style="width: 23px;" />
                                            <col style="width: auto;" />
                                        </colgroup>

                                        <!-- 팀 목록 (필터링) -->
                                        <!-- 팀 > 선택한 항목 (필터링) -->
                                        <tr class="td_bg_medium">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">{팀명}</span></td>
                                        </tr>
                                        <!-- //팀 > 선택한 항목 (필터링) -->

                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">{팀명}</span></td>
                                        </tr>
                                        <!-- //팀 목록 (필터링) -->

                                    </table>
                                </td>
                            </tr>
                            <!-- //부서 > 선택한 항목 (필터링) -->

                            <!-- 예시 -->
                            <tr>
                                <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this, '부서번호')"></i></td>
                                <th class="td_no_padding">
                                    <span onclick="location.href='/manage_employee_list?'">프로그래밍</span>
                                </th>
                            </tr>
                            <tr class="disp_hide">
                                <td colspan="2" class="td_no_padding">
                                    <table class="tst_table tst_table_in_table table_align_left">
                                        <colgroup>
                                            <col style="width: 23px;" />
                                            <col style="width: auto;" />
                                        </colgroup>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">게임엔진</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">게임플레이</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">플랫폼</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">DBA</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">웹개발</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this, '부서번호')"></i></td>
                                <th class="td_no_padding">
                                    <span onclick="location.href='/manage_employee_list?'">아트</span>
                                </th>
                            </tr>
                            <tr class="disp_hide">
                                <td colspan="2" class="td_no_padding">
                                    <table class="tst_table tst_table_in_table table_align_left">
                                        <colgroup>
                                            <col style="width: 23px;" />
                                            <col style="width: auto;" />
                                        </colgroup>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">이펙트</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">캐릭터모델링</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">애니메이션</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">BX</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">배경모델링</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">웹디자인</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">UI/UX그래픽</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- //예시 -->

                            </tbody>
                        </table>
                    </div>

                    <div class="tst_col10">

                        <!-- 직원 검색 -->
                        <form id="employee-search-form">
                            <div class="tst_search_container">
                                <div class="tst_search_select">
                                    <select id="tst_search_select_category" onchange="<!-- 분류 선택시 실행할 함수를 입력하세요 -->">
                                        <option value="">검색 분류</option>
                                        <option value="empl_name">이름</option>
                                    </select>
                                </div>
                                <div class="tst_search_input">
                                    <input type="text" name="keyword" maxlength="50" placeholder="검색어를 입력하세요" />
                                </div>
                                <div class="tst_search_icon">
                                    <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
                                </div>
                            </div>
                        </form>
                        <!-- //직원 검색 -->

                        <table class="tst_table tr_hover_subtle">
                            <colgroup>
                                <col style="width: 60px;" />
                                <col style="width: 200px;" />
                                <col style="width: 200px;" />
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
                            <tbody id="dept_member">

                            <!-- 검색되는 직원이 없을 경우 -->
                            <tr class="rent_list_no_data disp_hide"><!-- 데이터가 있을 경우 클래스 disp_hide를 추가하세요. -->
                                <td colspan="6" class="td_no_data">
                                    <p><i class="bi bi-person-exclamation"></i></p>
                                    <h3>검색 조건에 해당하는 직원이 없습니다.</h3>
                                </td>
                            </tr>
                            <!-- //검색되는 직원이 없을 경우 -->

                            <!-- 직원 목록 -->
                            <tr>
                                <td>{번호}</td>
                                <td class="td_align_left">
                                    <span onclick="location.href='/organization_detail?'" class="tst_pointer">{부서}</span>
                                </td>
                                <td class="td_align_left">
                                    <h3 onclick="location.href='/manage_employee_detail?'" class="tst_pointer">{직원명} ({ID})</h3>
                                </td>
                                <td class="td_align_left">{직급}/{직책}</td>
                                <td class="td_align_left">{직무}</td>
                                <td>{입사일|yyyy-MM-dd}</td>
                            </tr>
                            <!-- //직원 목록 -->

                            <!-- 예시 -->
                            <tr>
                                <td>126</td>
                                <td class="td_align_left">
                                    <span onclick="location.href='/organization_detail?'" class="tst_pointer">아트/UI/UX디자인</span>
                                </td>
                                <td class="td_align_left">
                                    <h3 onclick="location.href='/manage_employee_detail?'" class="tst_pointer">김이름 (kimname_art)</h3>
                                </td>
                                <td class="td_align_left">대리/사원</td>
                                <td class="td_align_left">게임 내 UI/UX 요소 디자인</td>
                                <td>2023-03-05</td>
                            </tr>
                            <tr>
                                <td>126</td>
                                <td class="td_align_left">
                                    <span onclick="location.href='/organization_detail?'" class="tst_pointer">오디오/오디오임플리먼테이션</span>
                                </td>
                                <td class="td_align_left">
                                    <h3 onclick="location.href='/manage_employee_detail?'" class="tst_pointer">김이름 (kimname_audio)</h3>
                                </td>
                                <td class="td_align_left">대리/사원</td>
                                <td class="td_align_left">오디오 미들웨어 설계, 오디오 데이터 관리</td>
                                <td>2023-03-05</td>
                            </tr>
                            <!-- //예시 -->

  

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
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/approval_send_modal.js"></script>
<script>
var allMembers = []; // 서버에서 가져온 전체 데이터를 저장
var filteredMembers = []; // 필터링된 데이터
var currentPage = 1; // 현재 페이지
var itemsPerPage = 15; // 한 페이지당 항목 수

document.addEventListener('DOMContentLoaded', function () {
	emplAllList(); // 전체 직원 데이터 로드
    fetchAndRenderDeptList(); // 부서 목록 로드
});
//초기 데이터 로드
// fetchAndRenderDeptList();
//부서 목록 가져오기
function fetchAndRenderDeptList() {
    $.ajax({
        url: './get_dept_list.ajax', // AJAX 요청 경로
        type: 'GET',
        dataType: 'json',
        success: function(data) {
        	console.log(data);
            renderDeptList(data); // 데이터 렌더링 함수 호출
        },
        error: function(xhr, status, error) {
            console.error('부서 목록 가져오기 실패:', error);
        }
    });
}

// emplAllList();
//인사관리 전체보기 리스트 출력 - 퇴사자 아닌 경우만 empl_all_list.ajax
function emplAllList() {
 $.ajax({
     url: './empl_all_list.ajax', // 요청 경로
     type: 'GET',
     dataType: 'json',
     success: function(data) {
        // renderDeptMembers(data); // 부서원 정보 렌더링
         allMembers = data; // 전체 데이터를 저장
         setupPagination(allMembers.length); // 페이지네이션 설정
         renderCurrentPage(); // 첫 페이지 렌더링
     },
     error: function(xhr, status, error) {
         console.error('부서원 정보 가져오기 실패:', error);
     }
 });
}

//기본 페이지네이션 설정
function setupPagination(totalItems) {
	$('#pagination').twbsPagination('destroy');
    var totalPages = Math.ceil(totalItems / itemsPerPage);
	
    
 // 데이터가 없는 경우 처리
    if (totalPages === 0) {
        $('#pagination').hide(); // 페이지네이션 숨기기
        var membersTable = $('#dept_member');
        membersTable.empty();
        membersTable.append(
            '<tr>' +
            '<td colspan="6" class="td_no_data">' +
            '<p><i class="bi bi-person-exclamation"></i></p>' +
            '<h3>결과가 없습니다.</h3>' +
            '</td>' +
            '</tr>'
        );
        return; // 함수 종료
    }
    $('#pagination').show(); // 데이터가 있는 경우 페이지네이션 표시
    $('#pagination').twbsPagination({
        totalPages: totalPages,
        visiblePages: 5,
        onPageClick: function (event, page) {
            currentPage = page;
            renderCurrentPage(); // 클릭한 페이지의 데이터 렌더링
        }
    });
}
// 검색 페이지네이션
function setupSearchPagination(totalItems) {
	$('#pagination').twbsPagination('destroy');
    var totalPages = Math.ceil(totalItems / itemsPerPage);

    $('#pagination').twbsPagination({
        totalPages: totalPages,
        visiblePages: 5,
        onPageClick: function (event, page) {
            currentPage = page;
            searchCurrentPage(); // 클릭한 페이지의 데이터 렌더링
        }
    });
}


// 현재 페이지 데이터 렌더링
function renderCurrentPage() {
    var startIndex = (currentPage - 1) * itemsPerPage;
    var endIndex = startIndex + itemsPerPage;
    var pageData = allMembers.slice(startIndex, endIndex);

    renderDeptMembers(pageData); // 현재 페이지 데이터 렌더링
}

// 검색 결과 출력
function searchCurrentPage() {
    var startIndex = (currentPage - 1) * itemsPerPage;
    var endIndex = startIndex + itemsPerPage;
    var pageData = filteredMembers.slice(startIndex, endIndex);

    renderDeptMembers(pageData); // 현재 페이지 데이터 렌더링
}

document.getElementById('pre-assignment-list').addEventListener('click', function () {
	 $.ajax({
	     url: './empl_pre_all_list.ajax', // 요청 경로
	     type: 'GET',
	     dataType: 'json',
	     success: function(data) {
	        // renderDeptMembers(data); // 부서원 정보 렌더링
	          allMembers = data; // 전체 데이터를 저장
         setupPagination(allMembers.length); // 페이지네이션 설정
         renderCurrentPage(); // 첫 페이지 렌더링
	     },
	     error: function(xhr, status, error) {
	         console.error('부서원 정보 가져오기 실패:', error);
	     }
	 });
	});



function renderDeptList(data) {
    var placeholder = document.getElementById('dynamic-section-placeholder');
    var tbody = placeholder.parentNode;

    // 기존 데이터 초기화
    while (tbody.lastChild && tbody.lastChild !== placeholder) {
        tbody.removeChild(tbody.lastChild);
    }

    // 데이터 렌더링
    $.each(data, function (key, deptList) {
        if (deptList.length === 0) return;

        var upperDept = deptList[0]; // 상위 부서
        var lowerDepts = deptList.slice(1); // 하위 부서

        // 상위 부서 추가
        var upperRow = document.createElement('tr');

        var upperTdIcon = document.createElement('td');
        var upperIcon = document.createElement('i');
        upperIcon.className = 'bi bi-caret-right-fill';
        
        
        if (lowerDepts.length > 0) {
            // 하위 부서가 있는 경우에만 클릭 이벤트 설정
            upperIcon.setAttribute('onclick', "show_team_list(this, 'lower-" + upperDept.dept_idx + "')");
        } else {
            // 하위 부서가 없으면 아이콘 스타일을 변경하거나 숨길 수 있음
            upperIcon.style.opacity = '0.5'; // 비활성화 상태 표시 (예: 흐리게)
           
        }
        
        upperTdIcon.appendChild(upperIcon);

        var upperTdName = document.createElement('td');
        upperTdName.className = 'tst_pointer';
        upperTdName.setAttribute('onclick', 'fetchDeptMembers(' + upperDept.dept_idx + ')');
        upperTdName.textContent = upperDept.dept_name;

        upperRow.appendChild(upperTdIcon);
        upperRow.appendChild(upperTdName);
        tbody.appendChild(upperRow);

        // 하위 부서 추가
        if (lowerDepts.length > 0) {
            var lowerRow = document.createElement('tr');
            lowerRow.id = 'lower-' + upperDept.dept_idx;
            lowerRow.className = 'disp_hide';

            var lowerTd = document.createElement('td');
            lowerTd.setAttribute('colspan', '2');

            var lowerTable = document.createElement('table');
            lowerTable.className = 'tst_table table_align_left table_no_padding';

            var lowerTbody = document.createElement('tbody');

            $.each(lowerDepts, function (index, lowerDept) {
                var lowerTr = document.createElement('tr');
                var lowerTdName = document.createElement('td');
                lowerTdName.className = 'tst_pointer';
                lowerTdName.setAttribute('onclick', 'fetchDeptMembers(' + lowerDept.dept_idx + ')');
                lowerTdName.textContent = lowerDept.dept_name;

                lowerTr.appendChild(lowerTdName);
                lowerTbody.appendChild(lowerTr);
            });

            lowerTable.appendChild(lowerTbody);
            lowerTd.appendChild(lowerTable);
            lowerRow.appendChild(lowerTd);
            tbody.appendChild(lowerRow);
        }
    });
}

// 부서원 정보 가져오기
function fetchDeptMembers(deptIdx) {
    $.ajax({
        url: './get_dept_members.ajax', // 요청 경로
        type: 'GET',
        data: { dept_idx: deptIdx }, // 서버로 전달할 데이터
        dataType: 'json',
        success: function(data) {
        	console.log(data);
        	// 데이터가 없는 경우 처리 
            if (data.length === 0) {
                // 페이지네이션 숨기기
                $('#pagination').hide();

                // 부서원 정보 테이블에 "결과 없음" 메시지 추가
                var membersTable = $('#dept_member');
                membersTable.empty();
                membersTable.append(
                    '<tr>' +
                    '<td colspan="6" class="td_no_data">' +
                    '<p><i class="bi bi-person-exclamation"></i></p>' +
                    '<h3>사원 정보가 없습니다.</h3>' +
                    '</td>' +
                    '</tr>'
                );
                return; // 함수 종료
            }
          //  renderDeptMembers(data); // 부서원 정보 렌더링
            allMembers = data; // 전체 데이터를 저장
         setupPagination(allMembers.length); // 페이지네이션 설정
         renderCurrentPage(); // 첫 페이지 렌더링
        },
        error: function(xhr, status, error) {
            console.error('부서원 정보 가져오기 실패:', error);
        }
    });
}

//부서원 정보 렌더링
function renderDeptMembers(members) {
    var membersTable = $('#dept_member'); // 부서원 정보 표시할 테이블
    membersTable.empty(); // 기존 데이터를 초기화
	
    // 부서원이 없을 경우 처리
    if (members.length === 0) {
        membersTable.append(
            '<tr>' +
            '<td colspan="6" class="td_no_data">' +
            '<p><i class="bi bi-person-exclamation"></i></p>' +
            '<h3>부서원 정보가 없습니다.</h3>' +
            '</td>' +
            '</tr>'
        );
        return; // 함수 종료
    }
    
    $.each(members, function(index, member) {
        var profileImage = member.empl_profile
            ? '/files/' + member.empl_profile
            : 'http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png';

        membersTable.append(
            '<tr>' +
            '<td>' + ((currentPage - 1) * itemsPerPage + index + 1) + '</td>' +
            '<td class="td_align_left">' +
            '<span onclick="location.href=\'/organization_detail.go?dept_idx=' + member.dept_idx + '\'" class="tst_pointer">' + (member.dept_name|| '없음') + '</span>' +
            '</td>' +
            '<td class="td_align_left">' +
            '<h3 onclick="location.href=\'/employee_detail.go?empl_idx=' + member.empl_idx + '\'" class="tst_pointer">' + member.empl_name + ' (' + member.empl_id + ')</h3>' +
            '</td>' +
            '<td class="td_align_left">' + (member.position_name || '없음') + '/' + (member.duty_name|| '없음') + '</td>' +
            '<td class="td_align_left">' + (member.empl_job || '없음') + '</td>' +
            '<td>' + formatDate(member.empl_join_date) + '</td>' +
            '</tr>'
        );
    });
}

//검색 기능
document.getElementById('employee-search-form').addEventListener('submit', function (e) {
    e.preventDefault(); // 폼 기본 동작 막기

    var category = document.getElementById('tst_search_select_category').value; // 검색 분류
    var keyword = this.querySelector('input[name="keyword"]').value.trim().toLowerCase(); // 검색 키워드
	
    console.log(category);
    console.log(keyword);
    
    if (!category) {
        alert('검색 분류를 선택하세요.');
        return;
    }

    if (!keyword) {
        alert('검색어를 입력하세요.');
        return;
    }

    // 검색 실행 전에 초기화
    filteredMembers = [...allMembers]; // 검색 전 초기화

    // 필터링
    filteredMembers = filteredMembers.filter(function (member) {
        return member[category] && member[category].toLowerCase().includes(keyword);
    });
	
    // 검색 결과 없을 경우 처리
    if (filteredMembers.length === 0) {
        // 페이지네이션 숨기기
        $('#pagination').hide();

        // "검색 결과 없음" 메시지 표시
        var membersTable = $('#dept_member');
        membersTable.empty(); // 기존 데이터 초기화
        membersTable.append(
            '<tr>' +
            '<td colspan="6" class="td_no_data">' +
            '<p><i class="bi bi-person-exclamation"></i></p>' +
            '<h3>검색 조건에 해당하는 사원이 없습니다.</h3>' +
            '</td>' +
            '</tr>'
        );
        return;
    }
    
    // 검색 결과 렌더링
    
    setupSearchPagination(filteredMembers.length); // 페이지네이션 재설정
    currentPage = 1; // 첫 페이지로 초기화
    searchCurrentPage(); // 검색 결과 렌더링
});


// 입사일 포맷 함수
function formatDate(dateString) {
    if (!dateString) return '-';
    var date = new Date(dateString);
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2);
    var day = ('0' + date.getDate()).slice(-2);
    return year + '-' + month + '-' + day;
}

</script>


</html>