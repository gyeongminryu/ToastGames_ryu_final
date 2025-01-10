package com.toast.work.controller;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
    public String workRecord(HttpSession session ,Model model) {
        // 출근 기록이 담긴 코드를 여기에 적어야 함.
        int empl_idx = (int) session.getAttribute("empl_idx");
        List<String> workDateString = (List<String>) workService.getWorkDate(empl_idx);
        // workDateString의 각 String을 LocalDate로 변환
        List<LocalDate> workDates = workDateString.stream()
                                                  .map(date -> LocalDate.parse(date))  // 각 String을 LocalDate로 변환
                                                  .collect(Collectors.toList());
        // 원하는 날짜 범위에 대한 작업 (예: 가장 최근 날짜 기준으로 작업하기 등)
        LocalDate latestWorkDate = workDates.get(workDates.size() - 1);  // 예시로 가장 최근 날짜 가져오기

        List<Map<String, Object>> workDays = workService.getWorkRecord(empl_idx, latestWorkDate);
        // 각 날짜에 대해 시간대별 근무 여부 계산
        List<Map<String, Object>> processedWorkDays = workDays.stream()
            .map(workDay -> {
                java.sql.Time attendTimeSql = (java.sql.Time) workDay.get("attend_date");  // 출근 시간 (sql.Time)
                java.sql.Time leaveTimeSql = (java.sql.Time) workDay.get("leave_date");    // 퇴근 시간 (sql.Time)

                // sql.Time을 LocalTime으로 변환
                LocalTime attendTime = attendTimeSql.toLocalTime().truncatedTo(ChronoUnit.MINUTES); // 초 제거
                LocalTime leaveTime = leaveTimeSql.toLocalTime().truncatedTo(ChronoUnit.MINUTES); // 초 제거
                
                // 시간 출력 형식 지정 (예: "10:45")
                String attendTimeString = attendTime.toString();  // "HH:mm" 형식
                String leaveTimeString = leaveTime.toString();   // "HH:mm" 형식

                // Map에 출퇴근 시각을 저장
                workDay.put("attend_date", attendTimeString);
                workDay.put("leave_date", leaveTimeString);
                
                // 총 근무 시간 계산 (소수점 제거)
                long workedHours = Duration.between(attendTime, leaveTime).toHours();
                long workedMinutes = Duration.between(attendTime, leaveTime).toMinutes() % 60;
                
                String totalWorkTime = workedHours + "시간 " + workedMinutes + "분";
                workDay.put("total_hours", totalWorkTime);
                
                // 날짜 및 요일 처리
                LocalDate workDate = LocalDate.parse(workDay.get("work_date").toString()); // workDay에서 날짜 가져오기
                String formattedDate = workDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd (E)")); // 예: "2025-01-10 (금)"

                // 날짜와 요일을 Map에 저장
                workDay.put("formatted_date", formattedDate);

                // 6시부터 23시까지 각 시간대별 근무 여부 계산 (30분 간격으로)
                Map<String, String> workTimeSlots = new HashMap<>();
                for (int hour = 6; hour <= 23; hour++) {
                    for (int minute : new int[]{0, 30}) { // 0분과 30분 처리
                        LocalTime timeSlot = LocalTime.of(hour, minute);  // 예: 6:00, 6:30, 7:00, 7:30 ...
                     // 12시와 12시 30분에 대해 점심시간 처리
                        if (hour == 12 && (minute == 0 || minute == 30)) {
                            workTimeSlots.put("worked_hours_" + hour + "_" + minute, "bg_work_lunch");
                        } else if (!timeSlot.isBefore(attendTime) && timeSlot.isBefore(leaveTime)) {
                            workTimeSlots.put("worked_hours_" + hour + "_" + minute, "bg_work_ordinary");
                        } else {
                            workTimeSlots.put("worked_hours_" + hour + "_" + minute, "bg_work_over");
                        }
                    }
                }

                // 기존 작업에 시간대별 근무 정보 추가
                workDay.putAll(workTimeSlots);
                //workTimeSlots.forEach((key, value) -> logger.info("Key: {}, Value: {}", key, value));
                return workDay;
            })
            .collect(Collectors.toList());

        model.addAttribute("workDays", processedWorkDays);
        return "work_record";
    }


    // 출근
    @ResponseBody
    @PostMapping(value = "/start_work.ajax")
    public String startWork(HttpSession session ,Model model) {
    	int empl_idx = (int) session.getAttribute("empl_idx");
        // 출근 시각을 기록
    	LocalDate work_date = workService.startWork(empl_idx);
        logger.info("isThisWork_date? : " + work_date);
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
        return "{\"status\": \"success\", \"message\": \"퇴근 완료\"}";
    }
    
}
