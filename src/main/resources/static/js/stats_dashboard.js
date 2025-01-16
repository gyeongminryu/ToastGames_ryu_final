function tst_modal_call_param(cls, idx) {
    document.getElementsByClassName(cls)[0].style.display = 'flex';
    getData(idx, 2);
}

function tst_modal_close(cls) {
    document.getElementsByClassName(cls)[0].style.display = 'none';
}

// 스피너
function waitingAnimator() {
    let waiting = document.getElementsByClassName('waiting')[0];
    if (waiting.innerHTML == '<i class="bi bi-reception-0"></i>') {
        waiting.innerHTML = '<i class="bi bi-reception-1"></i>';
    } else if (waiting.innerHTML == '<i class="bi bi-reception-1"></i>') {
        waiting.innerHTML = '<i class="bi bi-reception-2"></i>';
    } else if (waiting.innerHTML == '<i class="bi bi-reception-2"></i>') {
        waiting.innerHTML = '<i class="bi bi-reception-3"></i>';
    } else if (waiting.innerHTML == '<i class="bi bi-reception-3"></i>') {
        waiting.innerHTML = '<i class="bi bi-reception-4"></i>';
    } else if (waiting.innerHTML == '<i class="bi bi-reception-4"></i>') {
        waiting.innerHTML = '<i class="bi bi-reception-0"></i>';
    }
}

// 탭 메뉴
function setTab(game_idx, game_market) {
    document.getElementsByClassName('item_google')[0].onclick = function () {
        getData(game_idx, 1);
    }
    document.getElementsByClassName('item_appmarket')[0].onclick = function () {
        getData(game_idx, 2);
    }

    switch (game_market) {
        case 1:
            document.getElementsByClassName('item_google')[0].classList.add('list_tab_item_active');
            document.getElementsByClassName('item_appmarket')[0].classList.remove('list_tab_item_active');
            break;
        case 2:
            document.getElementsByClassName('item_google')[0].classList.remove('list_tab_item_active');
            document.getElementsByClassName('item_appmarket')[0].classList.add('list_tab_item_active');
            break;
    }
}

// 댓글 출력
function getData(game_idx, game_market) {
    //console.log(game_idx);
    setTab(game_idx, game_market);

    for (var j = 0; j < 5; j++) {
        document.getElementsByClassName('progress_bar_fill')[j].style.width = '0';
    }
    document.getElementsByClassName('comment_area')[0].innerHTML = '';
    document.getElementsByClassName('waiting')[0].classList.remove('disp_hide');
    let waitingInterval = setInterval(waitingAnimator, 150);

    $.ajax({
        type: 'post',
        url: 'stats_comment.ajax',
        data: {
            'game_idx': game_idx,
            'game_market': game_market
        },
        dataType: 'json',
        success: function(data) {
            // 스피너 정지
            clearInterval(waitingInterval);
            document.getElementsByClassName('waiting')[0].classList.add('disp_hide');

            // 데이터 출력
            document.getElementsByClassName('totalScore')[0].innerHTML = data.score;
            percentagePrint(data.percentage);
            listPrint(data.list);
            //console.log(data.list);
        },
        error: function(e) {
            //console.log(e);
        }
    });
}

function percentagePrint(per) {
    //console.log(per);
    for (var i = 0; i < per.length; i++) {
        console.log(per[i]);
        //console.log(document.getElementsByClassName('print_percentage_graph')[i].getElementsByClassName('progress_bar_fill')[0]);
        document.getElementsByClassName('print_percentage_graph')[i].getElementsByClassName('progress_bar_fill')[0].style.width = per[i];
    }
}

function listPrint(list) {
    //console.log(list);
    let tags = '';

    for (var i = 0; i < list.length; i += 3) {
        // console.log(list[i]);
        // console.log(list[i+1]);
        // console.log(list[i+2]);
        tags += '<li><div class="comment_container">';
        tags += '<div class="comment_information">';
        tags += '<h3>'+ list[i] +'</h3>';
        tags += '<p class="min font_subtle">' + list[i+1] + '</p>';
        tags += '</div>';
        tags += '<div class="comment_content">';
        tags += '<p>' + list[i+2] + '</p>';
        tags += '</div></div></li>';
    }

    document.getElementsByClassName('comment_area')[0].innerHTML = tags;
}