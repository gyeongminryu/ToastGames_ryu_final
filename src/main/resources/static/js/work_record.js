// 현재 날짜를 기준으로 해당 주의 시작일(월요일)과 종료일(일요일)을 계산하는 함수
function getWeekRange(date) {
    let startOfWeek = new Date(date);
    let dayOfWeek = startOfWeek.getDay();
    let diffToMonday = dayOfWeek === 0 ? -6 : 1 - dayOfWeek; // Sunday가 0이므로, 월요일까지 차이 계산
    startOfWeek.setDate(startOfWeek.getDate() + diffToMonday); // 월요일로 이동

    let endOfWeek = new Date(startOfWeek);
    endOfWeek.setDate(startOfWeek.getDate() + 6); // 일요일로 이동

    // YYYY-MM-DD 형식으로 날짜 반환
    return {
        startDate: formatDate(startOfWeek),
        endDate: formatDate(endOfWeek)
    };
}

// Date 객체를 YYYY-MM-DD 형식으로 변환하는 함수
function formatDate(date) {
    let year = date.getFullYear();
    let month = ('0' + (date.getMonth() + 1)).slice(-2); // 월 앞에 0을 추가
    let day = ('0' + date.getDate()).slice(-2); // 일 앞에 0을 추가
    return `${year}-${month}-${day}`;
}

// 주간 날짜 범위를 업데이트하는 함수
function updateWeekRange(startDate) {
    const startDateElement = document.getElementById('startDate');
    const weekRangeText = document.getElementById('weekRangeText');

    // startDate를 기준으로 7일 범위를 계산하여 업데이트
    const startDateObj = new Date(startDate);
    startDateObj.setDate(startDateObj.getDate() + 6); // startDate에서 6일 더해서 종료일 계산

    const endDate = formatDate(startDateObj);  // 종료일 계산

    // 주간 범위 업데이트
    weekRangeText.textContent = `${startDate} ~ ${endDate}`;

    // startDate 값을 hidden input에 설정
    startDateElement.value = startDate;
}

// 이전 주 또는 차주로 이동하는 함수
function moveWeek(direction) {
    const currentWeekRange = document.getElementById('weekRange').textContent.split(" ~ ");
    const startDate = new Date(currentWeekRange[0].trim());

    // 주간 날짜 범위 이동 (7일 단위로 이동)
    if (direction === 'prev') {
        startDate.setDate(startDate.getDate() - 7); // 1주일 전으로 이동
    } else if (direction === 'next') {
        startDate.setDate(startDate.getDate() + 7); // 1주일 후로 이동
    }

    // 새로운 날짜 범위 계산
    const newStartDate = formatDate(startDate);
    const newEndDate = formatDate(new Date(startDate.getFullYear(), startDate.getMonth(), startDate.getDate() + 6)); // 종료일은 시작일에 6일 추가
       
    // 새로운 주간 범위 업데이트
    updateWeekRange(newStartDate);
    
    // 폼을 제출하여 서버로 데이터를 전송
    const form = document.getElementById('weekRangeForm');
    if (form) {
        form.submit(); // 폼 제출
    }
}

const requiredWorkMinutes = 8 * 60; // 480분

// 출근 상태 여부를 추적하는 변수 (최초 선언)
let isLoggedIn = false;  // 초기 상태는 출근 전 (false)

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

    // 출근 상태를 토글
    isLoggedIn = !isLoggedIn;
}

// 페이지 로드 시, 콘솔을 추가하여 시작일과 종료일이 제대로 설정되는지 확인합니다.
window.addEventListener("DOMContentLoaded", function() {

    const startDateElement = document.getElementById('startDate');

    // startDate와 endDate가 null일 경우 기본값 계산
    if (!startDateElement.value) {
        const today = new Date();
        // 주간 날짜 범위를 계산하는 함수 (현재 날짜 기준으로 월요일~일요일 범위 계산)
        const { startDate: calculatedStartDate } = getWeekRange(today);

        // startDate 값을 hidden input에 설정
        startDateElement.value = calculatedStartDate;

        // 주간 범위 업데이트
        updateWeekRange(calculatedStartDate);
    } else {
        // 기존 startDate 값이 있으면 그대로 사용하여 주간 범위 업데이트
        updateWeekRange(startDateElement.value);
    }
});

document.addEventListener("DOMContentLoaded", function() {
    // 서버에서 출근 상태를 가져옵니다.
    $.ajax({
        url: 'get_attendance_state.ajax',  // 출근 상태 가져오는 URL (서버 처리)
        type: 'GET',
        success: function(response) {
            const result = JSON.parse(response);  // JSON 응답 파싱
            if (result.status === 'success') {
                isLoggedIn = result.isLoggedIn;  // 서버에서 받은 출근 상태

                // 출근 상태에 맞는 버튼 텍스트 설정
                const button = document.getElementById('attendanceButton');
                button.innerText = isLoggedIn ? '퇴근하기' : '출근하기';
            } else {
                console.log("출근 상태를 가져오는 데 실패했습니다.");
            }
        },
        error: function(xhr, status, error) {
            console.error("출근 상태 불러오기 중 오류 발생: " + error);
        }
    });
});

// 페이지 로드 시 sessionStorage에서 출근 상태 불러오기
document.addEventListener("DOMContentLoaded", function() {
    const savedStatus = sessionStorage.getItem('isLoggedIn');
    
    if (savedStatus !== null) {
        isLoggedIn = (savedStatus === 'true');
        const button = document.getElementById('attendanceButton');
        button.innerText = isLoggedIn ? '퇴근하기' : '출근하기';
    }
});

// 페이지 로드 시 근무 시간 상태 복원
document.addEventListener("DOMContentLoaded", function() {
	const progressBar = document.getElementById("progressRequiredFill");
 	progressBar.style.width = "0%";  // 진행 상태 초기화
 	const overtimeBar = document.getElementById("overtimeProgressBar");
    overtimeBar.style.width = "0%";
 	    
    if (savedStartTime) {
        const currentTime = Date.now();
        const elapsedTime = currentTime - savedStartTime;  // 경과 시간 계산
        const currentWorkMinutes = Math.floor(elapsedTime / 60000);  // 경과 시간 (분 단위)

        const totalWorkMinutes = 8 * 60;  // 필수 근무 시간 (480분)
        const progressBar = document.getElementById("progressRequiredFill");
        const workTimeDisplay = document.getElementById("workTimeDisplay");
        const overtimeBar = document.getElementById("overtimeProgressBar");
        
        // UI 업데이트: "현재 시간 / 총 시간" 표시
        const hours = Math.floor(currentWorkMinutes / 60);
        const minutes = currentWorkMinutes % 60;
        workTimeDisplay.innerHTML = `${hours}시간 ${minutes}분 <span> / 12시간</span>`;
	    overtimeBar.style.width = "0%";
	
        // 진행도 계산: (현재 근무 시간 / 필수 근무 시간) * 100
        const progressRatio = (currentWorkMinutes / totalWorkMinutes) * 100;
        progressBar.style.width = progressRatio + "%";  // 진행 상태를 비율로 설정
    }
});

function startWork() {
    $.ajax({
        url: 'start_work.ajax',  // 출근 처리 URL
        type: 'POST',
        success: function(response) {
            const result = JSON.parse(response);  // JSON 응답 파싱
            if (result.status === 'success') {
                console.log(result.message);  // "출근 완료"
                startWorkTimeProgress();
            }
        },
        error: function(xhr, status, error) {
            alert(result.message);  // 실패 시 경고창
            console.error("출근 처리 중 오류 발생: " + error);
        }
    });
}

// 출근 처리 후 근무 시간 진행 애니메이션 시작
function startWorkTimeProgress() {
    const totalWorkMinutes = 8 * 60;  // 필수 근무 시간: 40시간 (2400분)
    let currentWorkMinutes = 0;        // 현재 근무한 시간 (분 단위)
    let overtimeMinutes = 0;           // 초과 근무 시간 (분 단위)
    
    // 저장된 출근 시각이 있을 경우, 그 시간부터 계산 시작
    const savedStartTime = sessionStorage.getItem('startWorkTime');
    let startTime = savedStartTime ? parseInt(savedStartTime) : Date.now();  // 저장된 시간 사용 (없으면 현재 시간 사용)

	 // 출근 시간 저장
    sessionStorage.setItem('startWorkTime', startTime);  // 출근 시간 저장

    const progressBar = document.getElementById("progressRequiredFill");
    const workTimeDisplay = document.getElementById("workTimeDisplay");
    const overtimeBar = document.getElementById("overtimeProgressBar"); // 초과 근무 progress bar
    const overtimeDisplay = document.getElementById("overtimeDisplay"); // 초과 근무 시간 표시
    
    // 출근 시 초과 근무 상태 초기화
    overtimeBar.style.width = "0%"; // 초과 근무 진행 바 초기화
    
    const intervalTime = 1000; // 1초마다 진행

    const interval = setInterval(() => {
        const elapsedTime = Date.now() - startTime;  // 경과 시간 (밀리초 단위)
        currentWorkMinutes = Math.floor(elapsedTime / 60000);  // 경과 시간 (분 단위)
		
		// 필수 근무 시간이 8시간(480분)을 초과한 경우 초과 근무로 처리
        if (currentWorkMinutes > requiredWorkMinutes) {
            overtimeMinutes = currentWorkMinutes - requiredWorkMinutes;  // 초과 근무 시간
            overtimeBar.style.width = (overtimeMinutes / requiredWorkMinutes) * 100 + "%";  // 초과 근무 진행도 표시
            overtimeDisplay.innerHTML = `초과 근무: ${Math.floor(overtimeMinutes / 60)}시간 ${overtimeMinutes % 60}분`;
        }

        const hours = Math.floor(currentWorkMinutes / 60);
        const minutes = currentWorkMinutes % 60;
        // UI 업데이트: "현재 시간 / 총 시간" 표시
        workTimeDisplay.innerHTML = `${hours}시간 ${minutes}분 <span> / 12시간</span>`;
        

        // 진행도 계산: (현재 근무 시간 / 필수 근무 시간) * 100
        const progressRatio = (currentWorkMinutes / requiredWorkMinutes) * 100;
        progressBar.style.width = progressRatio + "%";  // 진행 상태를 비율로 설정

        // 만약 근무 시간이 8시간을 넘으면 애니메이션 종료
        if (currentWorkMinutes >= requiredWorkMinutes) {
            clearInterval(interval); // 8시간에 도달하면 애니메이션 종료
            console.log("8시간 근무 완료");
        }
    }, intervalTime);  // 1초마다 갱신
}

let savedStartTime = sessionStorage.getItem('startWorkTime');

// 퇴근 메서드
function stopWork() {
    $.ajax({
        url: 'stop_work.ajax',  // 퇴근 처리 URL
        type: 'POST',
        success: function(response) {
            const result = JSON.parse(response);  // JSON 응답 파싱
            if (result.status === 'success') {
                console.log(result.message);  // "퇴근 완료"
                const requiredWorkMinutes = 8 * 60;  // 필수 근무 시간
                const currentWorkMinutes = Math.floor((Date.now() - savedStartTime) / 60000);  // 경과 시간 (분 단위)
                const overtimeMinutes = Math.max(0, currentWorkMinutes - requiredWorkMinutes); // 초과 근무 시간 계산

                // 초과 근무 시간에 대한 처리가 필요하다면 서버에 저장하거나 추가적인 처리를 할 수 있습니다.

                // 근무 시간 애니메이션 멈추기
                stopWorkTimeProgress();  // 근무 시간 애니메이션 멈추기              
                location.reload();  // 페이지 새로고침
            }
        },
        error: function(xhr, status, error) {
            console.error("퇴근 처리 중 오류 발생: " + error);
        }
    });
}

// 퇴근 시 근무 시간 애니메이션을 멈추고 상태를 초기화하는 함수
function stopWorkTimeProgress() {
    // 애니메이션을 멈추기 위해서는 저장된 시간 리셋 및 UI 초기화 필요
    sessionStorage.removeItem('startWorkTime');  // 저장된 출근 시간 삭제

    // 진행 상태와 표시를 초기화
    // 진행 상태와 표시를 초기화
    const progressBar = document.getElementById("progressRequiredFill");
    const workTimeDisplay = document.getElementById("workTimeDisplay");
    const overtimeBar = document.getElementById("overtimeProgressBar");
    const overtimeDisplay = document.getElementById("overtimeDisplay");
    
    progressBar.style.width = "0%";  // 진행 상태 초기화
    overtimeBar.style.width = "0%";  // 초과 근무 초기화
}