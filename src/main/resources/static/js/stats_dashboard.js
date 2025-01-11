// 게임 통계 목록 출력
printGameList();

function printGameList() {
    $.ajax({
        type: 'post',
        url: 'stats_dashboard_list.ajax',
        data: {},
        dataType: 'json',
        success: function(data) {
            // 목록 출력
            console.log(data.list);
        },
        error: function(e) {
            //console.log(e);
        }
    });
}