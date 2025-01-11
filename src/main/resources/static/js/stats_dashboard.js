// 게임 개수 구하기
getLength();

function getLength() {
    $.ajax({
        type: 'post',
        url: 'stats_dashboard_get_length.ajax',
        data: {},
        dataType: 'json',
        success: function(data) {
            // 데이터 저장
            let length = data.length;
            //console.log(data.length);

            // 크롤링
            for (let i = 1; i < length; i++) {
                crawlingData(i);
            }
        },
        error: function(e) {
            //console.log(e);
        }
    });
}

function crawlingData(idx) {
    //console.log(idx);
    //console.log(document.getElementsByClassName('list_module_' + idx)[0]);

    $.ajax({
        type: 'post',
        url: 'stats_dashboard_crawling.ajax',
        data: {
            'idx': idx
        },
        dataType: 'json',
        success: function(data) {
            // 목록 출력
            //listPrint(data.list);
            console.log(data.list);
        },
        error: function(e) {
            //console.log(e);
        }
    });
}