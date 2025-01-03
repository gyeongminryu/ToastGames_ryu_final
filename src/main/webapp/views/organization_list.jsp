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
                            <form>
                                <div class="tst_search_container">
                                    <div class="tst_search_select">
                                        <select id="tst_search_select_category" name="category">
                                            <option value="{검색 분류}">검색 분류</option>
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
                    <tbody>

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

                    <!-- 예시 -->
                    <tr class="td_bg_subtle">
                        <th><i class="bi bi-folder"></i></th>
                        <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">프로그래밍</th>
                        <td class="td_align_left"><span onclick="tst_view_profile('10052')" class="tst_pointer">서연진 (차장)</span></td>
                        <td>02-2345-6789</td>
                        <td>member@toastgames.com</td>
                        <td>8명</td>
                        <td class="td_align_left">엔진 개발, 게임 콘텐츠 개발, 유지 보수시 이슈 처리, 프로그래밍</td>
                        <td>5층 503-5호</td>
                    </tr>
                    <tr>
                        <td colspan="8" class="td_no_padding">
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
                                    <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">게임엔진</th>
                                    <td class="td_align_left"><span onclick="tst_view_profile('10060')" class="tst_pointer">김인하 (과장)</span></td>
                                    <td>02-2345-6789</td>
                                    <td>member@toastgames.com</td>
                                    <td>3명</td>
                                    <td class="td_align_left">게임엔진 개발</td>
                                    <td>5층 503호</td>
                                </tr>
                                <tr>
                                    <th>├</th>
                                    <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">게임플레이</th>
                                    <td class="td_align_left"><span onclick="tst_view_profile('10059')" class="tst_pointer">박사금 (과장)</span></td>
                                    <td>02-2345-6789</td>
                                    <td>member@toastgames.com</td>
                                    <td>3명</td>
                                    <td class="td_align_left">QA 및 테스트</td>
                                    <td>5층 503호</td>
                                </tr>
                                <tr>
                                    <th>└</th>
                                    <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">DBA</th>
                                    <td class="td_align_left"><span onclick="tst_view_profile('10064')" class="tst_pointer">주차장 (과장)</span></td>
                                    <td>02-2345-6789</td>
                                    <td>member@toastgames.com</td>
                                    <td>2명</td>
                                    <td class="td_align_left">데이터베이스 관리</td>
                                    <td>5층 504호</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <!-- //예시 -->

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
            size: 'small',
         //   color: '#ffcc00',
        //    highlightColor: '#ffff00',
         //   selectionColor: '#ff0000',
            allowCollapse: true,
            animationDuration: 400,
            nodeContent: 'title',
            maxDepth: 3,
            width: '100%',
            height: '400px'
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
         
                // 서버로부터 받은 데이터를 Google OrgChart 데이터 테이블에 반영
                response.deptlist.forEach(function(dept) {
 
                	data.addRow([
                		  {v:dept.dept_idx, f:dept.dept_name+'<div>'+dept.dept_name +'장-' +(dept.dept_head_name ? dept.dept_head_name : '공석')+'</div>'+'<div>'+dept.total_dept_count+'</div>'}, // Name
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
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 실패: ', error);
            }
        });
    }
    </script>
</html>