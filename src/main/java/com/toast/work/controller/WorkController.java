package com.toast.work.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.toast.work.service.WorkService;

@Controller
public class WorkController {
    
    Logger logger = LoggerFactory.getLogger(getClass());

    private final WorkService workService;

    public WorkController(WorkService workService) {
        this.workService = workService;
    }

    // work_record 페이지 이동
    @GetMapping(value = "/work_record.go")
    public String workRecord(@RequestParam(value = "startDate", required = false) String startDate, HttpSession session, Model model) {
        int empl_idx = (int) session.getAttribute("empl_idx");

        // startDate가 null일 경우 현재 주의 월요일 날짜를 기준으로 계산
        if (startDate == null) {
            LocalDate today = LocalDate.now();
            LocalDate monday = today.with(java.time.DayOfWeek.MONDAY);
            startDate = monday.toString();
        }

        Map<String, Object> getSumWork = workService.getSumWork(empl_idx, startDate); // 일주일치 기록을 합산하여 가져옴.

        if (getSumWork != null) { // total_hours, overtime_hours는 db에 저장된 타입이 decimal.
        	BigDecimal weeklyTotalWorkHours = (BigDecimal) getSumWork.get("weekly_total_work_hours"); // 일주일간 근무한 시간 총 52시간(초과 근무 포함)
        	BigDecimal requiredWorkHours = (BigDecimal) getSumWork.get("required_work_hours"); // 필수 40시간
        	BigDecimal totalOvertimeHours = (BigDecimal) getSumWork.get("total_overtime_hours"); // 초과 근무 최대 12시간

        	// DECIMAL을 시간을 나타내는 문자열로 변환
        	model.addAttribute("weeklyTotalWorkHours", formatWorkTime(weeklyTotalWorkHours)); // 
        	model.addAttribute("requiredWorkHours", formatWorkTime(requiredWorkHours));
        	model.addAttribute("totalOvertimeHours", formatWorkTime(totalOvertimeHours));
         }
        // 날짜 범위에 맞는 근무 기록 가져오기
        List<Map<String, Object>> workDays = workService.getWorkRecord(empl_idx, startDate);

        // 각 날짜에 대해 시간대별 근무 여부 계산
        List<Map<String, Object>> processedWorkDays = workDays.stream()
            .map(workDay -> {
            	java.sql.Time attendTimeSql = (java.sql.Time) workDay.get("attend_date");  // 출근 시간
                java.sql.Time leaveTimeSql = (java.sql.Time) workDay.get("leave_date");    // 퇴근 시간

                // sql.Time을 LocalTime으로 변환
                LocalTime attendTime = attendTimeSql.toLocalTime();
                LocalTime leaveTime = leaveTimeSql.toLocalTime();
                
                logger.info("attendTime" + attendTime);
                logger.info("leaveTime" + leaveTime);

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
                
                // 출퇴근 시각을 Map에 저장
                String attendTimeString = attendTime.format(formatter);  // 시:분 형식
                String leaveTimeString = leaveTime.format(formatter);    // 시:분 형식
                workDay.put("attend_date", attendTimeString);
                workDay.put("leave_date", leaveTimeString);

                // 총 근무시간 계산
                String totalWorkTime = "";
                if (leaveTime.equals(LocalTime.MIDNIGHT)) {
                    totalWorkTime = "근무중";
                } else {
                	// 근무시간 계산 (소수점 제거)
                	 Duration workDuration = Duration.between(attendTime, leaveTime);
                     long workedHours = workDuration.toHours();
                     long workedMinutes = workDuration.toMinutes() % 60;
                    // 점심시간 제외 (12시 ~ 13시)
                     if (attendTime.isBefore(LocalTime.of(13, 0)) && leaveTime.isAfter(LocalTime.of(12, 0))) {
                         workedHours -= 1;  // 점심시간 1시간을 빼줌
                     }

                    totalWorkTime = String.format("%d시간 %d분", workedHours, workedMinutes);
                }

                workDay.put("total_hours", totalWorkTime);

                // 날짜 및 요일 처리
                LocalDate workDate = LocalDate.parse(workDay.get("work_date").toString());
                String formattedDate = workDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd (E)"));
                workDay.put("formatted_date", formattedDate);

                // 6시부터 23시까지 각 시간대별 근무 여부 계산
                Map<String, String> workTimeSlots = new HashMap<>();
                for (int hour = 6; hour <= 23; hour++) {
                    for (int minute : new int[]{0, 30}) {
                        LocalTime timeSlot = LocalTime.of(hour, minute);
                                                
                        // 점심시간 처리
                        if (hour == 12 && (minute == 0 || minute == 30)) {
                            workTimeSlots.put("worked_hours_" + hour + "_" + minute, "bg_work_lunch");
                        }
                        // 일반 근무 처리
                        else if (!timeSlot.isBefore(attendTime) && timeSlot.isBefore(leaveTime)) {
                            workTimeSlots.put("worked_hours_" + hour + "_" + minute, "bg_work_ordinary");
                        }
                        // 출근 전, 퇴근 시간 이후 "일하지 않은 시간"으로 처리
                        else if (timeSlot.isBefore(attendTime) && timeSlot.isAfter(leaveTime)) {
                            workTimeSlots.put("worked_hours_" + hour + "_" + minute, "bg_work_no_over");
                        } else {
                            workTimeSlots.put("worked_hours_" + hour + "_" + minute, "bg_work_over");
                        }
                        logger.info("Hour: {}, Minute: {}, TimeSlot: {}, Status: {}", hour, minute, timeSlot, workTimeSlots.get("worked_hours_" + hour + "_" + minute));
                    }
                }

                workDay.putAll(workTimeSlots);
                return workDay;
            })
            .collect(Collectors.toList());

        model.addAttribute("processedWorkDays", processedWorkDays);
        logger.info("processedWorkDays? " + processedWorkDays);
        model.addAttribute("workDays", workDays);
        model.addAttribute("startDate", startDate);

        return "work_record";  
    }

    // 출근
    @ResponseBody
    @PostMapping(value = "/start_work.ajax")
    public String startWork(HttpSession session, Model model) {
        int empl_idx = (int) session.getAttribute("empl_idx");
        // 출근 시각을 기록
        LocalDate work_date = workService.startWork(empl_idx);
        // 출근 상태를 DB에 저장 (출근 상태를 true로 설정)
        workService.saveAttendanceStatus(empl_idx, true);
        session.setAttribute("work_date", work_date.toString()); // 세션에 출근날짜 저장.
        return "{\"status\": \"success\", \"message\": \"출근 완료\"}";
    }

    // 퇴근
    @ResponseBody
    @PostMapping(value = "/stop_work.ajax")
    public String stopWork(HttpSession session, Model model) {
        int empl_idx = (int) session.getAttribute("empl_idx");
        // 퇴근 시각을 기록하고 근무시간을 DB에 저장
        workService.stopWork(empl_idx);
        workService.saveAttendanceStatus(empl_idx, false); // 출근상태 업데이트
        return "{\"status\": \"success\", \"message\": \"퇴근 완료\"}";
    }
    
    // 출근 상태 조회
    @ResponseBody
    @GetMapping(value = "/get_attendance_state.ajax")
    public String getAttendanceState(HttpSession session) {
        int empl_idx = (int) session.getAttribute("empl_idx");
        // 출근 상태 조회
        Boolean isLoggedIn = workService.getAttendanceStatus(empl_idx);
        if (isLoggedIn == null) {
            return "{\"status\": \"error\", \"message\": \"세션에 임직원 정보가 없습니다.\"}";
        }
        // 출근 상태에 따라 응답을 반환
        return "{\"status\": \"success\", \"isLoggedIn\": " + isLoggedIn + "}";
    }
    
    // 매일 오후 11시에 모든 사원의 출근 기록을 자동 생성
    @Scheduled(cron = "0 0 23 * * ?")  // 매일 11시에 실행
    public void createWorkRecordForAllEmployees() {
        List<Integer> allEmployeeIdx = workService.getAllEmployeeIds(); // 모든 사원의 ID 목록을 가져옵니다
        LocalDate workDate = LocalDate.now(); // 오늘 날짜
        for (int empl_idx : allEmployeeIdx) {
            // 출근 퇴근 기록 삽입
            workService.insertWorkRecord(empl_idx, workDate);
        }
    }
    
    private String formatWorkTime(BigDecimal totalWorkTime) {
        if (totalWorkTime == null || totalWorkTime.compareTo(BigDecimal.ZERO) == 0) {
            return "0시간 0분";
        }

        // 시, 분 계산
        int hours = totalWorkTime.intValue();  // 시간 부분
        int minutes = totalWorkTime.subtract(BigDecimal.valueOf(hours)).multiply(BigDecimal.valueOf(60)).intValue(); // 분 부분

        return String.format("%d시간 %d분", hours, minutes);
    }
    
    private void calculateAndSaveWorkDuration(LocalTime attendTime, LocalTime leaveTime) {
        // 근무 시간 계산
        Duration duration = Duration.between(attendTime, leaveTime);
        long workedHours = duration.toHours();
        long workedMinutes = duration.toMinutes() % 60;

        // 점심시간(12시 ~ 13시)을 제외한 근무 시간 계산
        if (attendTime.isBefore(LocalTime.of(13, 0)) && leaveTime.isAfter(LocalTime.of(12, 0))) {
            workedHours -= 1; // 점심시간 1시간을 빼줌
        }

        // 근무 시간을 BigDecimal로 변환 (분을 60으로 나누어 소수점 처리)
        BigDecimal totalWorkTime = BigDecimal.valueOf(workedHours).add(BigDecimal.valueOf(workedMinutes).divide(BigDecimal.valueOf(60), 2, RoundingMode.HALF_UP));

        // totalWorkTime을 DB나 필요한 곳에 저장
    }
}
