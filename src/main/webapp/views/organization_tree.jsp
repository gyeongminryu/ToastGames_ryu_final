<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

 
    <!-- Google Charts CSS -->
    <style>
        #chart_div .google-visualization-orgchart-table {
            width: 500px;
            height: 250px;
        }
        .google-visualization-orgchart-table td {
            font-family: NotoSans;
        }
        .orgchart-node {
            text-align: center;
        }
        .orgchart-node .name {
            font-weight: bold;
            font-size: 16px;
        }
        .orgchart-node .position {
            font-size: 14px;
            color: #888;
        }
        #calendar {
		    width: 100%;
		    height: 600px; /* 캘린더 높이를 설정 */
		}
    </style>

    <!-- Google Charts Loader -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>

<body>
   

    <!-- Chart Box -->
    <div class="chart-box">
        <div id="chart_div"></div>
    </div>

    <!-- Calendar -->
    <div id="calendar"></div>

    

   
</body>

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
            color: '#ffcc00',
            highlightColor: '#ffff00',
            selectionColor: '#ff0000',
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
                		  {v:dept.dept_name, f:dept.dept_name+'<div>'+dept.dept_name +'장-' +(dept.dept_head_name ? dept.dept_head_name : '공석')+'</div>'+'<div>'+dept.total_dept_count+'</div>'}, // Name
                	    dept.high_dept_name, // Manager를 완전한 비어있는 div로 대체
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