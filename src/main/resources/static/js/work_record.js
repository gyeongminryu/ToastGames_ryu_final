// 현재 주의 시작일과 종료일 계산
function getWeekRange(date) {
    const startDate = new Date(date);
    const day = startDate.getDay(); // 현재 날짜의 요일 (0: 일요일, 1: 월요일, ..., 6: 토요일)

    // 월요일로 이동
    const diffToMonday = day === 0 ? -6 : 1 - day; // 일요일(0)은 -6, 월요일(1)은 1 - 요일
    const monday = new Date(startDate.setDate(startDate.getDate() + diffToMonday));
    
    // 일요일로 이동
    const sunday = new Date(monday);
    sunday.setDate(monday.getDate() + 6);

    // 월요일과 일요일 날짜를 문자열 형식으로 반환 (YYYY-MM-DD)
    return {
        startDate: monday.toISOString().split('T')[0], // "2025-01-06"
        endDate: sunday.toISOString().split('T')[0] // "2025-01-12"
    };
}

// 전 주 또는 차주로 이동하는 함수
function moveWeek(direction) {
    const selectedDate = document.getElementById('selectedDate').value || new Date().toISOString().split('T')[0]; // 현재 선택된 날짜 (기본은 오늘 날짜)
    const currentWeek = getWeekRange(new Date(selectedDate)); // 현재 주의 날짜 범위

    let newStartDate;
    let newEndDate;

    if (direction === 'prev') {
        // 전 주 (현재 주에서 7일 빼기)
        newStartDate = new Date(currentWeek.startDate);
        newStartDate.setDate(newStartDate.getDate() - 7);
        newEndDate = new Date(currentWeek.endDate);
        newEndDate.setDate(newEndDate.getDate() - 7);
    } else if (direction === 'next') {
        // 차주 (현재 주에서 7일 더하기)
        newStartDate = new Date(currentWeek.startDate);
        newStartDate.setDate(newStartDate.getDate() + 7);
        newEndDate = new Date(currentWeek.endDate);
        newEndDate.setDate(newEndDate.getDate() + 7);
    }

    // 새로운 날짜 범위를 출력
    const newWeekRange = getWeekRange(newStartDate);

    // 주간 날짜 범위 업데이트
    const weekDisplay = document.getElementById('weekRange');
    weekDisplay.textContent = `${newWeekRange.startDate} - ${newWeekRange.endDate}`;

    // 해당 날짜 범위로 서버에서 데이터를 가져오기
    fetch(`/work_record.go?startDate=${newWeekRange.startDate}&endDate=${newWeekRange.endDate}`)
        .then(response => response.json())
        .then(data => {
            // 데이터 갱신
            updateWorkRecords(data);
        });
}

// 서버에서 받아온 근무 기록으로 테이블 갱신
function updateWorkRecords(data) {
    const workTableBody = document.getElementById('work-schedule-body');
    workTableBody.innerHTML = ''; // 기존 내용 지우기

    data.forEach(workDay => {
        const row = document.createElement('tr');
        // 각 날짜별 근무 기록을 테이블에 추가
        row.innerHTML = `
            <td>${workDay.work_date}</td>
            <td>${workDay.attend_date} ~ ${workDay.leave_date}</td>
            <td>${workDay.total_hours}</td>
        `;
        workTableBody.appendChild(row);
    });
}


// 출근 상태 여부를 추적하는 변수 (최초 선언)
let isLoggedIn = false;  // 초기 상태는 출근 전 (false)

// 출근과 퇴근을 토글하는 함수
function toggleAttendance() {
    const button = document.getElementById('attendanceButton');

    if (isLoggedIn) {
        // 퇴근하기 버튼 클릭 시 처리
        stopWork();  // 퇴근 메서드 실행
        button.innerText = '출근하기';  // 버튼 텍스트를 '출근하기'로 변경
    } else {
        // 출근하기 버튼 클릭 시 처리
        startWork();  // 출근 메서드 실행
        button.innerText = '퇴근하기';  // 버튼 텍스트를 '퇴근하기'로 변경
    }
	
	// sessionStroage에 출근 상태 저장?
	sessionStorage.setItem('isLoggedIn', !isLoggedIn);
	
    // 출근 상태를 토글
    isLoggedIn = !isLoggedIn;
}

function startWork() {
    $.ajax({
        url: 'start_work.ajax',  // 출근 처리 URL
        type: 'POST',
        success: function(response) {
            const result = JSON.parse(response);  // JSON 응답 파싱
            if (result.status === 'success') {
                console.log(result.message);  // "출근 완료"
                // 추가적으로 처리할 로직(예: UI 업데이트)
                startWorkTimeProgress();
            }
        },
        error: function(xhr, status, error) {
            console.error("출근 처리 중 오류 발생: " + error);
        }
    });
}

// 페이지 로드 시 sessionStorage에서 출근 상태 불러오기. 새로고침이나 페이지 이동시 출근하기가 초기화 되는걸 막음.
document.addEventListener("DOMContentLoaded", function() {
    const savedStatus = sessionStorage.getItem('isLoggedIn');
    
    if (savedStatus !== null) {
        isLoggedIn = (savedStatus === 'true');
        const button = document.getElementById('attendanceButton');
        button.innerText = isLoggedIn ? '퇴근하기' : '출근하기';
    }
});

// 출근 처리 후 근무 시간 진행 애니메이션 시작
function startWorkTimeProgress() {
    const totalWorkMinutes = 40 * 60;  // 필수 근무 시간: 40시간 (2400분)
    let currentWorkMinutes = 0;        // 현재 근무한 시간 (분 단위)

    const progressBar = document.getElementById("progressRequiredFill");
    const workTimeDisplay = document.getElementById("workTimeDisplay");

    // 출근 시간을 기준으로 시작 (현재 시간부터 시작)
    const startTime = Date.now();  // 출근 시각 (밀리초 기준)

    // 애니메이션 간격 설정 (1초마다 진행)
    const intervalTime = 1000; // 1초마다 진행

    // 시간 갱신 애니메이션
    const interval = setInterval(() => {
        const elapsedTime = Date.now() - startTime;  // 경과 시간 (밀리초 단위)
        currentWorkMinutes = Math.floor(elapsedTime / 60000);  // 경과 시간 (분 단위)

        // 시간과 분 계산
        const hours = Math.floor(currentWorkMinutes / 60);
        const minutes = currentWorkMinutes % 60;

        // UI 업데이트: "현재 시간 / 총 시간" 표시
        workTimeDisplay.innerHTML = `${hours}시간 ${minutes}분 <span> / 40시간</span>`;

        // 진행도 계산: (현재 근무 시간 / 필수 근무 시간) * 100
        const progressRatio = (currentWorkMinutes / totalWorkMinutes) * 100;
        progressBar.style.width = progressRatio + "%";  // 진행 상태를 비율로 설정

        // 만약 근무 시간이 40시간을 넘으면 애니메이션 종료
        if (currentWorkMinutes >= totalWorkMinutes) {
            clearInterval(interval); // 40시간에 도달하면 애니메이션 종료
            console.log("40시간 근무 완료");
        }
    }, intervalTime);  // 1초마다 갱신
}

// 퇴근 메서드
function stopWork() {
    $.ajax({
        url: 'stop_work.ajax',  // 퇴근 처리 URL
        type: 'POST',
        success: function(response) {
            const result = JSON.parse(response);  // JSON 응답 파싱
            if (result.status === 'success') {
                console.log(result.message);  // "퇴근 완료"
                // 퇴근이 완료되면 페이지를 새로고침
                location.reload();  // 페이지 새로고침
            }
        },
        error: function(xhr, status, error) {
            console.error("퇴근 처리 중 오류 발생: " + error);
        }
    });
}


