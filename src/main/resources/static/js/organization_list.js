google.charts.load('current', {packages:["orgchart"]});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Name');
    data.addColumn('string', 'Manager');

    data.addRows([
        [{'v':'이사실', 'f':'<p>대표이사</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>김대표 (이사)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, ''],
        [{'v':'부서A', 'f':'<p>부서명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>부서장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '이사실'],
        [{'v':'부서B', 'f':'<p>부서명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>부서장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '이사실'],
        [{'v':'부서C', 'f':'<p>부서명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>부서장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '이사실'],
        [{'v':'부서D', 'f':'<p>부서명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>부서장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '이사실'],
        [{'v':'부서E', 'f':'<p>부서명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>부서장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '이사실'],
        [{'v':'팀A', 'f':'<p>팀명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>팀장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '부서A'],
        [{'v':'팀B', 'f':'<p>팀명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>팀장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '부서A'],
        [{'v':'팀C', 'f':'<p>팀명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>팀장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '부서B'],
        [{'v':'팀D', 'f':'<p>팀명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>팀장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '부서B'],
        [{'v':'팀E', 'f':'<p>팀명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>팀장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '부서C'],
        [{'v':'팀F', 'f':'<p>팀명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>팀장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, `부서C`],
        [{'v':'팀G', 'f':'<p>팀명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>팀장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '부서C'],
        [{'v':'팀H', 'f':'<p>팀명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>팀장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '부서D'],
        [{'v':'팀I', 'f':'<p>팀명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>팀장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '부서E'],
        [{'v':'팀J', 'f':'<p>팀명</p><p class="font_subtle"><i class="bi bi-bookmark-fill"></i>팀장 (직급)</p><p class="min font_subtle"><i class="bi bi-people-fill"></i>5</p>'}, '부서E']
    ]);

    var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
    var option = {
        'allowHtml': true,
        'size': 'large',
        'nodeClass': 'tst_tree_node',
        'selectedNodeClass': 'tst_tree_node_selected'
    };

    chart.draw(data, option);
}