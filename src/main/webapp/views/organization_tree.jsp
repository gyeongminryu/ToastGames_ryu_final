<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
    <!-- Form for input -->
    <form action="go" method="get">
        <input type="text" id="test_id" name="test_id"/>
        <input type="text" id="test_name" name="test_name"/>
        <button type="submit">저장</button>
    </form>

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
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Name');  // 이름
        data.addColumn('string', 'Manager');  // 상사
        data.addColumn('string', 'ToolTip');  // 툴팁 (툴팁을 HTML로 처리)

        // 데이터 추가: HTML을 이용하여 이름과 직급을 함께 표시
        data.addRows([ // 이름이 같으면 하나만 나옴
        	 ['<div>보스<div><div>ceo<div><div>1<div>', '', 'CEO'], // John은 HTML 스타일 적용
             ['<div>사업부<div><div>부장<div><div>1<div>', '<div>보스<div><div>ceo<div><div>1<div>', 'VP of Marketing'], // Manager에는 텍스트만
             ['<div>영업부<div><div>부장<div><div>1<div>', '<div>보스<div><div>ceo<div><div>1<div>', 'VP of Sales'],
             ['<div>기술부<div><div>부장<div><div>1<div>', '<div>보스<div><div>ceo<div><div>1<div>', 'Marketing Manager'],
             ['<div>해외부<div><div>부장<div><div>1<div>', '<div>보스<div><div>ceo<div><div>1<div>', 'Sales Manager'],
             ['<div>바부<div><div>부장<div><div>1<div>', '<div>보스<div><div>ceo<div><div>1<div>', 'SEO Specialist'],
             ['<div>밥부<div><div>부장<div><div>1<div>', '<div>보스<div><div>ceo<div><div>1<div>', 'Sales Specialist']
        ]);
		
        var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));

        // 차트 옵션 설정
        var option = {
        		 allowHtml: true,
        		  size: 'small',
        		  color: '#ffcc00',
        		  highlightColor: '#ffff00',
        		  selectionColor: '#ff0000',
        		//  layout: 'vertical',
        		  allowCollapse: true,
        		  animationDuration: 400,
        		  nodeContent: 'title',
        		  maxDepth: 3,
        		  width: '10%',
        		  height: '60px'
		};
        chart.draw(data, option);  // 데이터와 옵션을 사용해 차트를 그리기
        
        // 클릭 이벤트 처리
        google.visualization.events.addListener(chart, 'select', function() {
            var selectedItem = chart.getSelection()[0];
            if (selectedItem) {
                var name = data.getValue(selectedItem.row, 0);
                var manager = data.getValue(selectedItem.row, 1);
                var idx = data.getValue(selectedItem.row, 2);
               console.log(idx);
            }
        });
        
    }
    
    
   
    </script>



</html>