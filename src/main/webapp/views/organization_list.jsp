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
    <link rel="stylesheet" type="text/css" href="resources/css/module_tree.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/organization.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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

                <!-- 차트 -->
                <table class="tst_table">
                    <thead>
                    <tr><th>조직도</th></tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <div class="chart_wrapper">
                                <!-- Chart Box -->
                                <div class="chart-box">
                                    <div id="chart_div"></div>
                                </div>
                                <!-- //Chart Box -->
                            </div>

                        </td>
                    </tr>
                    </tbody>
                </table>
                <hr class="separator" />
                <!-- //차트 -->

                <table class="tst_table table_no_padding table_no_underline">
                    <tr>
                        <td class="td_align_bottom">

                            <!-- 검색 -->
                            <form id="dept-search-form" onsubmit="return searchDept(event);">
                                <div class="tst_search_container">
                                    <div class="tst_search_select">
                                        <select id="tst_search_select_category" name="category">
                                            <option value="">검색 분류</option>
                                            <option value="dept_name">부서이름</option>
                                            <option value="head_name">부서장 이름/팀장 이름</option>
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
                            <!-- //검색 -->

                        </td>
                        <td class="td_align_right posit_relative">

                            <!-- 조직 추가 -->
                            <button onclick="tst_modal_call('tst_modal_write')" class="btn_primary">조직 추가하기</button>
                            <!-- //조직 추가 -->

                        </td>
                    </tr>
                </table>

                <!-- 표 -->
                <table class="tst_table tr_hover_subtle">
                    <colgroup>
                        <col style="width: 16px" />
                        <col style="width: 120px" />
                        <col style="width: 150px" />
                        <col style="width: 180px" />
                        <col style="width: 220px" />
                        <col style="width: 120px" />
                        <col style="width: auto" />
                        <col style="width: 180px" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th colspan="2">조직명</th>
                        <th>조직장</th>
                        <th>조직장 연락처</th>
                        <th>조직장 이메일</th>
                        <th>소속 인원</th>
                        <th>담당 직무</th>
                        <th>위치</th>
                    </tr>
                    </thead>
                    <tbody id="dept_list">

                    <!-- 부서 출력 -->
                    <tr class="td_bg_subtle">
                        <th><i class="bi bi-folder"></i></th>
                        <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">{부서명}</th>
                        <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{부서장} ({직급})</span></td>
                        <td>{부서장 연락처}</td>
                        <td>{부서장 이메일}</td>
                        <td>{소속 인원}명</td>
                        <td class="td_align_left">{부서 담당 직무}</td>
                        <td>{부서 위치}</td>
                    </tr>
                    <tr>
                        <td colspan="8" class="td_no_padding">

                            <!-- 소속 팀 출력 -->
                            <table class="tst_table tst_table_in_table">
                                <colgroup>
                                    <col style="width: 16px" />
                                    <col style="width: 120px" />
                                    <col style="width: 150px" />
                                    <col style="width: 180px" />
                                    <col style="width: 220px" />
                                    <col style="width: 120px" />
                                    <col style="width: auto" />
                                    <col style="width: 180px" />
                                </colgroup>
                                <tr>
                                    <th>├</th>
                                    <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">{팀명}</th>
                                    <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{팀장} ({직급})</span></td>
                                    <td>{팀장 연락처}</td>
                                    <td>{팀장 이메일}</td>
                                    <td>{소속 인원}명</td>
                                    <td class="td_align_left">{팀 담당 직무}</td>
                                    <td>{팀 위치}</td>
                                </tr>
                                <tr>
                                    <th>└</th><!-- '.tst_table_in_table tr:last-child'의 innerHTML을 '└'으로 바꾸시면 됩니다 -->
                                    <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">{팀명}</th>
                                    <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{팀장} ({직급})</span></td>
                                    <td>{팀장 연락처}</td>
                                    <td>{팀장 이메일}</td>
                                    <td>{소속 인원}명</td>
                                    <td class="td_align_left">{팀 담당 직무}</td>
                                    <td>{팀 위치}</td>
                                </tr>
                            </table>
                            <!-- //소속 팀 출력 -->
                        </td>
                    </tr>
                    <!-- //부서 출력 -->

                  
                    </tbody>
                </table>
                <!-- //표 -->

            </div>
        </div>
    </div>
</div>
<c:import url="organization_list_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/organization_list.js"></script>
<!-- FullCalendar Script -->
   <script>
    google.charts.load('current', { packages: ["orgchart"] });
    google.charts.setOnLoadCallback(initChart);

    var chart; // 차트 객체를 전역 변수로 선언
    var data; // 데이터 테이블 객체

    // 차트를 초기화하는 함수
    function initChart() {
        data = new google.visualization.DataTable();
        data.addColumn('string', 'Name'); // 이름
        data.addColumn('string', 'Manager'); // 상사
        data.addColumn('string', 'ToolTip'); // 툴팁 (HTML 형태로 렌더링)

        chart = new google.visualization.OrgChart(document.getElementById('chart_div'));

        var option = {
           allowHtml: true,
         //   size: 'small',
         //   color: '#ffcc00',
        //    highlightColor: '#ffff00',
         //   selectionColor: '#ff0000',
            allowCollapse: true,
        //    animationDuration: 400,
        //    nodeContent: 'title',
        //    maxDepth: 3,
        //    width: '100%',
        //    height: '400px'
        };

        // AJAX를 통해 서버 데이터 가져오기
        fetchDataAndRenderChart(option);
    }

    // 서버에서 데이터를 가져오고 차트를 렌더링
    function fetchDataAndRenderChart(option) {
        $.ajax({
            url: './dept_tree_list.ajax', // 경로설정
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log(response.deptlist);
                populateDropdowns(response);
                // 서버로부터 받은 데이터를 Google OrgChart 데이터 테이블에 반영
                response.deptlist.forEach(function(dept) {
 						var dept_duty = '';
 						if(dept.dept_depth == 2){
 							dept_duty = '부서장-'
 						}
 						else if(dept.dept_depth == 3){
 							dept_duty = '팀장-'
 						}
 						else if(dept.dept_depth == 1){
 							dept_duty = '대표-'
 						}
                	data.addRow([
                		  {v:dept.dept_idx, f:'<p>'+dept.dept_name+'</p>'+'<p class="font_subtle">'+dept_duty  +(dept.dept_head_name ? dept.dept_head_name : '공석')+'</p>'+'<p class="min font_subtle"><i class="bi bi-people-fill"></i>'+dept.total_dept_count+'</p>'}, // Name
                	    dept.dept_high, // Manager를 완전한 비어있는 div로 대체
                	    dept.dept_idx // ToolTip
                	]);
                });

                // 차트 렌더링
                chart.draw(data, option);

                // 클릭 이벤트 처리
                google.visualization.events.addListener(chart, 'select', function() {
                    var selectedItem = chart.getSelection()[0];
                    if (selectedItem) {
                        var name = data.getValue(selectedItem.row, 0);
                        var manager = data.getValue(selectedItem.row, 1);
                        var tooltip = data.getValue(selectedItem.row, 2);
                        console.log('Selected Name: ', name);
                        console.log('Manager: ', manager);
                        console.log('Tooltip: ', tooltip);
                        window.location.href = './organization_detail.go?dept_idx=' + tooltip;
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 실패: ', error);
            }
        });
    }
    
    $(document).ready(function () {
        // 부서 기본 정보 가져오기
        fetchDeptBasicList();

        function fetchDeptBasicList() {
            $.ajax({
                url: 'get_dept_basic_list.ajax', // 서버에서 데이터를 제공하는 엔드포인트
                type: 'GET', // GET 요청
                dataType: 'json', // JSON 형식의 응답
                success: function (response) {
                    console.log('부서 기본 정보:', response);
                    renderDeptTable(response); // 데이터를 테이블에 렌더링
                },
                error: function (xhr, status, error) {
                    console.error('부서 목록 가져오기 실패:', error);
                    alert('부서 목록을 가져오는 중 오류가 발생했습니다.');
                }
            });
        }

        // 테이블 데이터 렌더링
        function renderDeptTable(data) {
            var tbody = $('#dept_list'); // 테이블의 tbody 선택
            tbody.empty(); // 기존 데이터를 초기화

            if (!data || Object.keys(data).length === 0) {
                tbody.append('<tr><td colspan="8">부서 정보가 없습니다.</td></tr>');
                return;
            }

            // 상위 부서 반복
            for (var highDeptId in data) {
                if (data.hasOwnProperty(highDeptId)) {
                    var deptList = data[highDeptId];
                    var highDept = deptList[0]; // 상위 부서 정보
                    var subDepts = deptList.slice(1); // 하위 부서 목록

                    // 상위 부서 추가
                    var highDeptRow = '<tr class="td_bg_subtle">' +
                        '<th><i class="bi bi-folder"></i></th>' +
                        '<th class="td_align_left tst_pointer" onclick="location.href=\'/organization_detail.go?dept_idx=' + highDept.dept_idx + '\'">' + highDept.dept_name + '</th>' + // 경로설정
                        '<td class="td_align_left">' +
                        (highDept.dept_head_idx
                            ? '<span onclick="tst_view_profile(\'' + highDept.dept_head_idx + '\')" class="tst_pointer">' + highDept.empl_name + ' (' + highDept.position_name + ')</span>'
                            : '부서장 없음') +
                        '</td>' +
                        '<td>' + (highDept.empl_cmp_phone || '-') + '</td>' +
                        '<td>' + (highDept.empl_cmp_email || '-') + '</td>' +
                        '<td>' + (highDept.total_dept_count || '0') + '명</td>' +
                        '<td class="td_align_left">' + (highDept.dept_duty || '-') + '</td>' +
                        '<td>' + (highDept.dept_addr || '-') + '</td>' +
                        '</tr>';

                    tbody.append(highDeptRow);

                    // 하위 부서 출력
                    var subDeptTable = '<tr><td colspan="8" class="td_no_padding">' +
                        '<table class="tst_table tst_table_in_table">' +
                        '<colgroup>' +
                        '<col style="width: 16px" />' +
                        '<col style="width: 120px" />' +
                        '<col style="width: 150px" />' +
                        '<col style="width: 180px" />' +
                        '<col style="width: 220px" />' +
                        '<col style="width: 120px" />' +
                        '<col style="width: auto" />' +
                        '<col style="width: 180px" />' +
                        '</colgroup>' +
                        '<tbody>' +
                        renderSubDepts(subDepts) +
                        '</tbody>' +
                        '</table>' +
                        '</td></tr>';

                    tbody.append(subDeptTable);
                }
            }
        }

        // 하위 부서 데이터 렌더링
        function renderSubDepts(subDepts) {
        //    if (!subDepts || subDepts.length === 0) return '<tr><td colspan="8">소속 팀이 없습니다.</td></tr>';

            var subDeptRows = '';
            for (var i = 0; i < subDepts.length; i++) {
                var subDept = subDepts[i];
                var prefix = (i === subDepts.length - 1) ? '└' : '├';
                subDeptRows += '<tr>' +
                    '<th>' + prefix + '</th>' +
                    '<th class="td_align_left tst_pointer" onclick="location.href=\'/organization_detail.go?dept_idx=' + subDept.dept_idx + '\'">' + subDept.dept_name + '</th>' + // 경로설정
                    '<td class="td_align_left">' +
                    (subDept.dept_head_idx
                        ? '<span onclick="tst_view_profile(\'' + subDept.dept_head_idx + '\')" class="tst_pointer">' + subDept.empl_name + ' (' + subDept.position_name + ')</span>'
                        : '팀장 없음') +
                    '</td>' +
                    '<td>' + (subDept.empl_cmp_phone || '-') + '</td>' +
                    '<td>' + (subDept.empl_cmp_email || '-') + '</td>' +
                    '<td>' + (subDept.total_dept_count || '0')+ '명</td>' +
                    '<td class="td_align_left">' + (subDept.dept_duty || '-') + '</td>' +
                    '<td>' + (subDept.dept_addr || '-') + '</td>' +
                    '</tr>';
            }
            return subDeptRows;
        }
    });    
	
    
    
   // 검색 기능 검색 부서 가져오기 
function searchDept(event) {
    event.preventDefault(); // 폼 기본 동작 막기

    // 검색 카테고리와 키워드 가져오기
    var category = document.getElementById('tst_search_select_category').value;
    var keyword = document.querySelector('input[name="keyword"]').value.trim();

    if (!category) {
        alert('검색 분류를 선택하세요.');
        return false;
    }

    if (!keyword) {
        alert('검색어를 입력하세요.');
        return false;
    }

    // AJAX로 검색 요청
    $.ajax({
        url: './search_get_dept_list.ajax', // 검색을 처리할 서버 엔드포인트
        type: 'GET',
        data: { category: category, keyword: keyword },
        dataType: 'json',
        success: function (response) {
            console.log('검색 결과:', response);
            searchDeptTable(response); // 검색 결과를 테이블에 렌더링
        },
        error: function (xhr, status, error) {
            console.error('검색 실패:', error);
            alert('검색 중 오류가 발생했습니다.');
        }
    });
}
 
function searchDeptTable(data) {
    var tbody = $('#dept_list'); // 테이블의 tbody 선택
    tbody.empty(); // 기존 데이터를 초기화

    // 데이터가 없는 경우 처리
    if (!data || data.length === 0) {
        tbody.append('<tr><td colspan="8">부서 정보가 없습니다.</td></tr>');
        return;
    }

    // 부서 데이터 렌더링
    for (var i = 0; i < data.length; i++) {
        var subDept = data[i]; // 현재 부서 정보

        // 부서 정보 추가
        tbody.append(
            '<tr>' +
            '<th>' + '-' + '</th>' +
            '<th class="td_align_left tst_pointer" onclick="location.href=\'/organization_detail.go?dept_idx=' + subDept.dept_idx + '\'">' + subDept.dept_name + '</th>' +
            '<td class="td_align_left">' +
            (subDept.dept_head_idx
                ? '<span onclick="tst_view_profile(\'' + subDept.dept_head_idx + '\')" class="tst_pointer">' + subDept.empl_name + ' (' + subDept.position_name + ')</span>'
                : '팀장 없음') +
            '</td>' +
            '<td>' + (subDept.empl_cmp_phone || '-') + '</td>' +
            '<td>' + (subDept.empl_cmp_email || '-') + '</td>' +
            '<td>' + (subDept.total_dept_count || '0') + '명</td>' +
            '<td class="td_align_left">' + (subDept.dept_duty || '-') + '</td>' +
            '<td>' + (subDept.dept_addr || '-') + '</td>' +
            '</tr>'
        );
    }
}
    
    </script>
</html>