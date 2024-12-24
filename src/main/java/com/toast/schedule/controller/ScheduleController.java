package com.toast.schedule.controller;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.toast.schedule.dto.ScheduleDTO;
import com.toast.schedule.service.ScheduleService;

@RestController
@RequestMapping("/schedule")
public class ScheduleController {

	private ScheduleService scheduleService;
	
	public ScheduleController(ScheduleService scheduleService) {
		this.scheduleService = scheduleService;
	}
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
	
	//날짜 변환
	private LocalDateTime parseToLocalDateTime(String dateTimeStr) {
		try {
			return LocalDateTime.parse(dateTimeStr, FORMATTER);
		} catch (DateTimeParseException e) {
			logger.error("Invalid date format: {}", dateTimeStr, e);
			return null; // 실패 시 null 반환 (필요에 따라 예외를 던질 수도 있음)
		}
	}

	
	
//------------------------여기부터 로그인 아이디 신경써야함(일단 생략 진행+기능 완성 후 추가)---------------------
	
	//달력 가기
	@RequestMapping(value="/schedule.go")
	public ModelAndView main() {
		ModelAndView mv = new ModelAndView();
		List<Map<String, Object>> partiList = scheduleService.getScheduleParti();
		mv.addObject("partiList", partiList);
		mv.setViewName("calendar_month");
		return mv;
	}
	

	//일정 추가(참여자 추가 포함)
	@PostMapping("/scheduleAdd.do")
	@ResponseBody
	public boolean scheduleAdd(@RequestBody Map<String, Object> params) {
	    ScheduleDTO dto = new ScheduleDTO();

	    logger.info("allday:"+params.get("allday"));
	    dto.setSche_title((String)params.get("title"));
	    dto.setSche_content((String)params.get("content"));
	    dto.setSche_type(Integer.parseInt((String)params.get("sche_type")));
	    if((boolean)params.get("allday")) {
	    	dto.setSche_allday(1);
	    }else {
	    	dto.setSche_allday(0);
	    }
	    // 날짜 형식 변환
	    String start = (String) params.get("start");
	    String end = (String) params.get("end");
	    
        LocalDateTime startLocalDateTime = parseToLocalDateTime(start);
        LocalDateTime endLocalDateTime = parseToLocalDateTime(end);
	    
        if (startLocalDateTime != null && endLocalDateTime != null) {
            // DTO에 설정
            dto.setSche_start_date(startLocalDateTime);
            dto.setSche_end_date(endLocalDateTime);

            logger.info("Start Time (Local): " + startLocalDateTime);

        } else {
            logger.error("Failed to parse start or end date");
        }
	    dto.setSche_empl_idx(Integer.parseInt((String)params.get("empl_idx")));
		logger.info("sche_empl_idx:"+dto.getSche_empl_idx());
		
		List<Integer> scheduleParti = new ArrayList<>();
		    
		//Object로 넘어오는 타입이 뭔지 몰라 경고 발생으로 데이터가 리스트인지 먼저 확인
		Object participantsObj = params.get("sche_parti");
		if (participantsObj instanceof List<?>) {
			List<?> partiList = (List<?>) participantsObj;
			for (Object parti : partiList) {
				if (parti instanceof String) {
					scheduleParti.add(Integer.parseInt((String) parti));
				}
			}
		}
		dto.setSche_parti_empl_idxs(scheduleParti);
		boolean success = false;
		if(scheduleService.scheduleAdd(dto)) {
			success=true;
		}
		return success;
	}
	
	
	//일정 보기(참여자, 내가 만든일정 분리)
	@PostMapping("/getSchedules.do")
	@ResponseBody
	public List<Map<String, Object>> getSchedule(@RequestBody Map<String, Object> param){
		ScheduleDTO dto = new ScheduleDTO();
		dto.setSche_empl_idx(10003);  //현재 로그인한 사원 번호로 설정해야함
		logger.info("param"+(String)param.get("schedule_type_name"));
		dto.setSche_type(Integer.parseInt((String)param.get("schedule_type_name"))); //선택한 라디오박스의 값
		List<Map<String, Object>> schedules = new ArrayList<Map<String,Object>>();
		if(scheduleService.isParti(10003)) {
			dto.setSche_parti_empl_idx(10003);
			schedules = scheduleService.getSchedules(dto); 
		}else {
			schedules = scheduleService.getSchedules(dto);
		}
	    logger.info("schedules"+schedules);
	    return schedules;
	}
	
	
	//일정 수정
	@PostMapping("/scheduleUpdate.do")
	@ResponseBody
	public boolean scheduleUpdate(@RequestBody Map<String, Object> params) {
		ScheduleDTO dto = new ScheduleDTO();
	    logger.info("allday:"+params.get("allday"));
	    dto.setSche_idx((Integer)params.get("sche_idx"));
	    dto.setSche_title((String)params.get("title"));
	    dto.setSche_content((String)params.get("content"));
	    dto.setSche_type(Integer.parseInt((String)params.get("sche_type")));
	    if((boolean)params.get("allday")) {
	    	dto.setSche_allday(1);
	    }else {
	    	dto.setSche_allday(0);
	    }
	    // 날짜 형식 변환
	    String start = (String) params.get("start");
	    String end = (String) params.get("end");
	    
        LocalDateTime startLocalDateTime = parseToLocalDateTime(start);
        LocalDateTime endLocalDateTime = parseToLocalDateTime(end);
	    
        if (startLocalDateTime != null && endLocalDateTime != null) {
            // DTO에 설정
            dto.setSche_start_date(startLocalDateTime);
            dto.setSche_end_date(endLocalDateTime);

            logger.info("Start Time (Local): " + startLocalDateTime);

        } else {
            logger.error("Failed to parse start or end date");
        }
	    dto.setSche_empl_idx(Integer.parseInt((String)params.get("empl_idx")));
		logger.info("sche_empl_idx:"+dto.getSche_empl_idx());
		
		List<Integer> scheduleParti = new ArrayList<>();
		    
		//Object로 넘어오는 타입이 뭔지 몰라 경고 발생으로 데이터가 리스트인지 먼저 확인
		Object participantsObj = params.get("sche_parti");
		if (participantsObj instanceof List<?>) {
		    List<?> partiList = (List<?>) participantsObj;
		    for (Object parti : partiList) {
		        if (parti instanceof String) {
		            scheduleParti.add(Integer.parseInt((String) parti));
		        } else if (parti instanceof Integer) {
		            scheduleParti.add((Integer) parti);
		        }
		    }
		}

		dto.setSche_parti_empl_idxs(scheduleParti);
		boolean success = false;
		if(scheduleService.scheduleUpdate(dto)) {
			success=true;
		}
		return success;
	}

	//일정 drop 수정
	@PostMapping("/scheduleDrop.do")
	@ResponseBody
	public String dropSchedule(@RequestBody Map<String, Object> params) {
		ScheduleDTO dto = new ScheduleDTO();
	    int sche_idx = (Integer) params.get("sche_idx");
	    dto.setSche_idx(sche_idx);
	    if((boolean)params.get("allday")) {
	    	dto.setSche_allday(1);
	    }else {
	    	dto.setSche_allday(0);
	    }
	    // 날짜 형식 변환
	    String start = (String) params.get("start");
	    String end = (String) params.get("end");
	    
        LocalDateTime startLocalDateTime = parseToLocalDateTime(start);
        LocalDateTime endLocalDateTime = parseToLocalDateTime(end);
        
        dto.setSche_start_date(startLocalDateTime);
        dto.setSche_end_date(endLocalDateTime);
        
        LocalDateTime now = LocalDateTime.now(); // 로컬 시스템 시간
		dto.setSche_update_date(now);
	    int result = scheduleService.updateTimeSchedule(dto);
	    return result > 0 ? "success" : "fail";
	}
	
	//일정 resize 수정
	@PostMapping("/scheduleResize.do")
	@ResponseBody
	public String resizeSchedule(@RequestBody Map<String, Object> params) {
		ScheduleDTO dto = new ScheduleDTO();
	    int sche_idx = (Integer) params.get("sche_idx");
	    dto.setSche_idx(sche_idx);
	    if((boolean)params.get("allday")) {
	    	dto.setSche_allday(1);
	    }else {
	    	dto.setSche_allday(0);
	    }
	    // 날짜 형식 변환
	    String start = (String) params.get("start");
	    String end = (String) params.get("end");
	    
        LocalDateTime startLocalDateTime = parseToLocalDateTime(start);
        LocalDateTime endLocalDateTime = parseToLocalDateTime(end);
        
        dto.setSche_start_date(startLocalDateTime);
        dto.setSche_end_date(endLocalDateTime);
        
        LocalDateTime now = LocalDateTime.now(); // 로컬 시스템 시간
		dto.setSche_update_date(now);
	    int result = scheduleService.updateTimeSchedule(dto);
	    return result > 0 ? "success" : "fail";
	}
	

	//일정 삭제
	@PostMapping("/scheduleDelete.do")
	@ResponseBody
	public String deleteSchedule(@RequestBody Map<String, Object> param) {	
	    int result = scheduleService.deleteSchedule((Integer)param.get("sche_idx"));
	    return result > 0 ? "success" : "fail";
	}
	
	
	//일정 추가 알림
	
	
	
	//일정 수정알림
	
	
	//일정 공용물품 반납일정추가
	
	
	
	//공용물품 반납 1일전 알림
}
