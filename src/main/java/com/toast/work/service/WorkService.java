package com.toast.work.service;

import com.toast.work.dao.WorkDAO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;

@Service
public class WorkService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final WorkDAO workDAO;
	
	public WorkService(WorkDAO workDAO) {
		this.workDAO = workDAO;
	}
	
    private final int requiredWorkTime = 2400; // 필수 근무시간 (40시간 = 2400분)
    private int total_hours = 0; // 총 근무시간 (분 단위)
    private int overtime_hours = 0; // 초과 근무시간 (분 단위)
    private LocalTime attend_date; // 출근 시각
    private LocalTime leave_date; // 퇴근 시각
    private LocalDate work_date; //근무일
 
    // 연도-월-일 형태로 날짜 포맷팅
   //private String formatWorkDate(LocalDate date) {
    //    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
      //  return date.format(formatter);  // "2025-01-09"
   // }
    
    // 요일 정보 가져오기
    //private String getDayOfWeek(LocalDate date) {
    //    return date.getDayOfWeek().toString().substring(0, 1);  // "MON" -> "M"
    //}
    
    // 출근 시각을 기록하고 근무시간 계산 및 DB에 저장
    public LocalDate startWork(int empl_idx) {
        LocalDate work_date = LocalDate.now();
        Date sqlDate = Date.valueOf(work_date);  // LocalDate -> java.sql.Date
        //LocalDate formattedWorkDate = formatWorkDate(work_date);  // 연도-월-일 형태로 포맷팅
        attend_date  = LocalTime.now(); // 출근시간

        // WorkDay DB에 저장. 사원, 출근시간, 출근한 날짜
        workDAO.saveStartTime(empl_idx, attend_date, sqlDate);
        return work_date; // 출근한 날짜를 가져온다.
    }

    // 퇴근 시각을 기록하고 근무시간 계산 및 DB에 저장
    public void stopWork(int empl_idx) {
    	// 퇴근 시각 기록    	
    	leave_date = LocalTime.now();
        // 출근 시각을 DB에서 가져옴.
    	attend_date  = workDAO.getStartTimeForEmployee(empl_idx);
        
        // 총 근무시간 계산 (출근 시각과 퇴근 시각의 차이)
        total_hours = (int) ChronoUnit.MINUTES.between(attend_date, leave_date);  // 근무시간 계산

        // 오후 6시 기준 초과 근무 시간 계산
        overtime_hours = calculateOvertime(leave_date); // 초과 근무시간 계산
        
        // 근무시간을 WorkDay DB에 저장
        workDAO.updateWorkDay(empl_idx, attend_date, leave_date, total_hours, overtime_hours);

        // 총 근무시간 업데이트
        //total_hours += workTime;
        //if (total_hours > requiredWorkTime) {
        //	overtime_hours = total_hours - requiredWorkTime;
        //}
    }
    
    // 오후 6시 이후의 근무 시간을 초과 근무 시간으로 계산
    private int calculateOvertime(LocalTime leave_date) {
        // 기준 퇴근 시간 오후 6시
        LocalTime thresholdTime = LocalTime.of(18, 0);  // 18:00:00

        // 퇴근 시간이 18시 이후라면 초과 근무 시간이 발생
        if (leave_date.isAfter(thresholdTime)) {
            // 초과 근무 시간 계산
            return (int) ChronoUnit.MINUTES.between(thresholdTime, leave_date);
        } else {
            return 0;  // 오후 6시 이전이라면 초과 근무가 없음
        }
    }
    
    // 저장된 db의 리스트를 가져온다.
	public List<Map<String, Object>> getWorkRecord(int empl_idx, LocalDate workDate) {
		return workDAO.getWorkRecord(empl_idx, workDate);
	}

	public List<String> getWorkDate(int empl_idx) {
		return workDAO.getWorkDate(empl_idx);
	}
	
    // 주간 근무시간 조회
    public int getTotalWorkTime(int empl_idx) {
        return workDAO.getWeeklyWorkTime(empl_idx);
    }

    // 일일 근무시간 조회
    public int getDailyWorkTimes(int empl_idx) {
        return workDAO.getDailyWorkTimes(empl_idx);
    }
    
}
