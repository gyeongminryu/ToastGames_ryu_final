/*const filter = document.getElementById('meeting_only_mine');

show_filtering_state();

function show_filtering_state() {
    if (filter.checked) {
    	console.log(filter.checked);
        document.getElementsByClassName('tst_filtering_off')[0].classList.add('disp_hide');
        document.getElementsByClassName('tst_filtering_on')[0].classList.remove('disp_hide');
    } else {
    	console.log(filter.checked);
        document.getElementsByClassName('tst_filtering_off')[0].classList.remove('disp_hide');
        document.getElementsByClassName('tst_filtering_on')[0].classList.add('disp_hide');
    }
}

function filtering_on() {
    filter.checked = true;
    show_filtering_state();
}

function filtering_off() {
    filter.checked = false;
    show_filtering_state();
}*/


// 필터링 상태 업데이트 함수
function show_filtering_state() {
    // FullCalendar 이벤트 갱신
    if (calendar) {
        calendar.refetchEvents();
    } else {
        console.error('FullCalendar 인스턴스가 초기화되지 않았습니다.');
        return;
    }

    // UI 업데이트
    if (filter.checked) {
        console.log("내가 포함된 회의만 보기 활성화");
        document.getElementsByClassName('tst_filtering_off')[0].classList.add('disp_hide');
        document.getElementsByClassName('tst_filtering_on')[0].classList.remove('disp_hide');
    } else {
        console.log("전체 회의 보기");
        document.getElementsByClassName('tst_filtering_off')[0].classList.remove('disp_hide');
        document.getElementsByClassName('tst_filtering_on')[0].classList.add('disp_hide');
    }
}

// 필터링 UI 요소 클릭 시
document.querySelector('.tst_filtering_off').addEventListener('click', function() {
    filter.checked = true;  // 체크박스 상태 활성화
    show_filtering_state(); // 필터링 상태 갱신
});

document.querySelector('.tst_filtering_on').addEventListener('click', function() {
    filter.checked = false; // 체크박스 상태 비활성화
    show_filtering_state(); // 필터링 상태 갱신
});

// 초기 상태 업데이트
const filter = document.getElementById('meeting_only_mine');
show_filtering_state();




