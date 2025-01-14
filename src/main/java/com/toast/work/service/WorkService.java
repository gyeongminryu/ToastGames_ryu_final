package com.toast.work.service;

import com.toast.work.dao.WorkDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class WorkService {

    Logger logger = LoggerFactory.getLogger(getClass());

    private final WorkDAO workDAO;

    public WorkService(WorkDAO workDAO) {
        this.workDAO = workDAO;
    }

    // 출근 시각을 기록하고 출근 날짜를 반환
    public LocalDate startWork(int empl_idx) {
        LocalDate work_date = LocalDate.now(); // 출근한 날짜!!!
        LocalTime attend_date = LocalTime.now(); // 출근시간
        workDAO.saveStartTime(empl_idx, attend_date, java.sql.Date.valueOf(work_date));
        return work_date;
    }

 // 퇴근 시각을 기록하고 근무시간을 DB에 저장
    public void stopWork(int empl_idx) {
    	LocalTime attend_date = workDAO.getStartTimeForEmployee(empl_idx); // 가장 최신 출근일자를 가져온다.
        LocalTime leave_date = LocalTime.now(); // 퇴근 버튼을 누르면.
        // 출근 시간과 퇴근시간 사이의 차이를 분단위로 계산.
        int total_minutes = (int) java.time.temporal.ChronoUnit.MINUTES.between(attend_date, leave_date);

        // 점심시간 제외
        LocalTime lunchStart = LocalTime.of(12, 0);
        LocalTime lunchEnd = LocalTime.of(13, 0);
        
        // 출근 시간이 점심시간(12:00 ~ 13:00)에 포함될 경우, 점심시간을 빼야 한다.
        // 12시 이전에 출근하면, 12시 이후에 퇴근하면 작동.
        if (attend_date.isBefore(lunchStart) && leave_date.isAfter(lunchStart)) {
            // 출근은 12:00 이전, 퇴근이 점심시간 이후인 경우 점심시간에서 겹치는 만큼 차감
        	// 13시 이전에 퇴근을 하면 작동.
            if (leave_date.isBefore(lunchEnd)) {
                total_minutes -= java.time.temporal.ChronoUnit.MINUTES.between(lunchStart, leave_date);
            } else {
                total_minutes -= 60; // 퇴근 시간이 13:00 이후면 점심시간 전체 60분 차감
            }
        } 
        // 퇴근 시간이 12:00 ~ 13:00 사이에 포함된 경우만 그 시간만큼 차감
        // 12시 이후에 퇴근하면, 13시 이전에 퇴근하면.
        else if (leave_date.isAfter(lunchStart) && leave_date.isBefore(lunchEnd)) {
            total_minutes -= java.time.temporal.ChronoUnit.MINUTES.between(lunchStart, leave_date);
        }

        // 시와 분을 소수점 형태로 계산 (시간 = 분 / 60)
        double total_hours = total_minutes / 60.0;  // 60.0으로 나누어 소수점 계산
        // 오버타임 계산 (필요시)
        double overtime_hours = calculateOvertime(attend_date, leave_date);
        workDAO.updateWorkDay(empl_idx, attend_date, leave_date, total_hours, overtime_hours);
    }

    // 초과 근무 시간 계산 (소수점까지 반환)
    private double calculateOvertime(LocalTime attend_date, LocalTime leave_date) {
        int standardWorkMinutes = 8 * 60;  // 표준 근무시간 (8시간)
        long totalWorkMinutes = java.time.temporal.ChronoUnit.MINUTES.between(attend_date, leave_date);
        
        // 총 근무 시간이 표준 근무시간을 초과하는 경우
        if (totalWorkMinutes > standardWorkMinutes) {
            long overtimeMinutes = totalWorkMinutes - standardWorkMinutes;
            return overtimeMinutes / 60.0; // 소수점까지 오버타임 시간 계산 (시간 단위)
        }
        
        return 0.0; // 오버타임이 없는 경우
    }
    
    // 주어진 날짜 범위의 근무 기록을 가져옵니다
    public List<Map<String, Object>> getWorkRecord(int empl_idx, String startDate) {
        return workDAO.getWorkRecord(empl_idx, startDate);
    }

    // 임직원의 근무일 목록을 가져옵니다
    public List<String> getWorkDate(int empl_idx) {
        return workDAO.getWorkDate(empl_idx);
    }

    // 주어진 기간에 대한 총 근무 시간 및 초과 근무 시간 가져오기
    public Map<String, Object> getSumWork(int empl_idx, String startDate) {
        return workDAO.getSumWork(empl_idx, startDate);
    }

    // 모든 사원의 ID 목록을 가져옵니다
    public List<Integer> getAllEmployeeIds() {
        return workDAO.getAllEmployeeIds(); // MyBatis Mapper 호출
    }

    // 출근 기록을 DB에 삽입
    public void insertWorkRecord(int empl_idx, LocalDate workDate) {
        boolean exists = workDAO.checkWorkRecordExists(empl_idx, workDate);
        
        if (!exists) { // 해당 날짜에 출근기록이 없다면 insert
            Map<String, Object> params = new HashMap<>();
            params.put("empl_idx", empl_idx);
            params.put("workDate", workDate);

            workDAO.insertWorkRecord(params);
        }
    }

    // 출근 상태 저장
    public void saveAttendanceStatus(int empl_idx, boolean isLoggedIn) {
        workDAO.saveAttendanceStatus(empl_idx, isLoggedIn);
    }

    // 출근 상태 조회
    public Boolean getAttendanceStatus(int empl_idx) {
        return workDAO.getAttendanceStatus(empl_idx);
    }
}
