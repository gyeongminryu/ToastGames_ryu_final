package com.toast.schedule.controller;


import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.toast.schedule.dto.MeetingDTO;
import com.toast.schedule.dto.MeetingPhotoDTO;
import com.toast.schedule.service.MeetingService;

@RestController
@RequestMapping("/meeting")
public class MeetingController {
 
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
	
	private MeetingService meetingService;
	
	public MeetingController(MeetingService meetingService) {
		this.meetingService = meetingService;
	}
	
	//날짜 변환
	private LocalDateTime parseToLocalDateTime(String dateTimeStr) {
		try {
			return LocalDateTime.parse(dateTimeStr, FORMATTER);
		} catch (DateTimeParseException e) {
			logger.error("Invalid date format: {}", dateTimeStr, e);
			return null; // 실패 시 null 반환 (필요에 따라 예외를 던질 수도 있음)
		}
	}
	
	//회의실 예약 가기(회의실 이름+idx)
	@RequestMapping(value="/meeting.go")
	public ModelAndView meetingGo () {
		ModelAndView mv = new ModelAndView();
		List<Map<String, Object>> roomList = meetingService.meetingGo();
		mv.addObject("roomList", roomList);
		mv.setViewName("meeting");
		return mv;
	}
	
	//회의실 정보 등록 가기
	@RequestMapping(value="/meetingRoomAdd.go")
	public ModelAndView meetingAddGo () {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("meeting_room_add");
		return mv;
	}
	
	//회의실 정보 등록
	@PostMapping(value="/meetingRoom.add")
	public ModelAndView roomAdd(@RequestParam MultipartFile file,@RequestParam Map<String,String> param) {
		logger.info("Received params: " + param);
		logger.info("file count:"+file);
		meetingService.meetingRoomAdd(param,file);
		return new ModelAndView("redirect:/meeting/meeting.go");
	}
	

	//회의실 정보 상세보기(회의실 정보 전체)+사진 추가
	@RequestMapping(value="/meetingRoom.detail")
	public ModelAndView meetingDetail(@RequestParam("room_idx") int selectedRoomIdx) {
		ModelAndView mv = new ModelAndView();
		int room_idx = selectedRoomIdx;
		Map<String, Object> roomDetail= meetingService.meetingDetail(room_idx);
		String file_key = (String) roomDetail.get("file_key");
		MeetingPhotoDTO file = meetingService.meetingPhoto(file_key, room_idx);
		logger.info("roomDetail:{}",roomDetail);
		mv.addObject("roomDetail", roomDetail);
		mv.addObject("file", file);
		mv.setViewName("meeting_room");
		return mv;
	}
	

	//회의 일정 보기
	@PostMapping(value="/getMeeting.do")
	@ResponseBody
	public List<Map<String, Object>> getMeeting(@RequestBody Map<String, Object> params) {
	    List<Map<String, Object>> meetings = meetingService.getMeeting(params);
	    logger.info("일정 왜  events없어:"+meetings);
	    return meetings;
	}
	
	//회의 일정 추가
	@PostMapping("/meetingAdd.do")
	@ResponseBody
	public boolean addMeeting(@RequestBody Map<String, Object> params) {
	    MeetingDTO dto = new MeetingDTO();
	    
	    // 제목, 내용 받아오기
	    dto.setMeet_subject((String) params.get("title"));
	    dto.setMeet_content((String) params.get("content"));
	    
	    // 날짜 형식 변환
	    String start = (String) params.get("start");
	    String end = (String) params.get("end");
	    
        LocalDateTime startLocalDateTime = parseToLocalDateTime(start);
        LocalDateTime endLocalDateTime = parseToLocalDateTime(end);
	    
        if (startLocalDateTime != null && endLocalDateTime != null) {
            // DTO에 설정
            dto.setMeet_start_date(startLocalDateTime);
            dto.setMeet_end_date(endLocalDateTime);

            logger.info("Start Time (Local): " + startLocalDateTime);
            logger.info("End Time (Local): " + endLocalDateTime);

        } else {
            logger.error("Failed to parse start or end date");
        }
	    
	    // room, empl 값을 Integer로 변환
	    dto.setRoom_idx(Integer.parseInt((String) params.get("room")));
	    dto.setMeet_rent_empl_idx(Integer.parseInt((String) params.get("empl")));
	    
//	    logger.info("title: " + dto.getMeet_subject());
//	    logger.info("content: " + dto.getMeet_content());
//	    logger.info("start: " + dto.getMeet_start_date());
//	    logger.info("end: " + dto.getMeet_end_date());
//	    logger.info("room: " + dto.getRoom_idx());
//	    logger.info("empl: " + dto.getMeet_rent_empl_idx());
	    
	    boolean success = false;
	    if (meetingService.addMeeting(dto) > 0) {
	        success = true;
	    }
	    return success;
	}

	
	//회의 일정 수정(+++본인만=> 아직안함)
	@PostMapping("/meetingUpdate.do")
	@ResponseBody
	public boolean updateMeeting(@RequestBody Map<String, Object> params) {
	    MeetingDTO dto = new MeetingDTO();
	    
	    // 제목, 내용 받아오기
	    dto.setMeet_subject((String) params.get("title"));
	    dto.setMeet_content((String) params.get("content"));
	    
	    // 날짜 형식 변환
	    String start = (String) params.get("start");
	    String end = (String) params.get("end");
	    
        LocalDateTime startLocalDateTime = parseToLocalDateTime(start);
        LocalDateTime endLocalDateTime = parseToLocalDateTime(end);
	    
        if (startLocalDateTime != null && endLocalDateTime != null) {
            // DTO에 설정
            dto.setMeet_start_date(startLocalDateTime);
            dto.setMeet_end_date(endLocalDateTime);

//            logger.info("Start Time (Local): " + startLocalDateTime);
//            logger.info("End Time (Local): " + endLocalDateTime);

        } else {
            logger.error("Failed to parse start or end date");
        }
	    
	    // room, empl 값을 Integer로 변환
	    dto.setRoom_idx(Integer.parseInt((String) params.get("room")));
	    dto.setMeet_rent_empl_idx(Integer.parseInt((String) params.get("empl")));
	    dto.setMeet_rent_idx((int) params.get("rent_idx"));
	    
	    logger.info("title: " + dto.getMeet_subject());
	    logger.info("content: " + dto.getMeet_content());
	    logger.info("start: " + dto.getMeet_start_date());
	    logger.info("end: " + dto.getMeet_end_date());
	    logger.info("room: " + dto.getRoom_idx());
	    logger.info("empl: " + dto.getMeet_rent_empl_idx());
	    
	    boolean success = false;
	    if (meetingService.updateMeeting(dto) > 0) {
	        success = true;
	    }
	    return success;
	}
	
	//회의 시간 변경
	@PostMapping(value="/meetingDrop.do")
	@ResponseBody
	public boolean dropMeeting(
			@RequestParam("rent_idx") int rentIdx,
            @RequestParam("start") String start,
            @RequestParam("end") String end) {
		boolean success = false;
		MeetingDTO dto = new MeetingDTO();

	    
		// 날짜 형식 변환
        LocalDateTime startLocalDateTime = parseToLocalDateTime(start);
        LocalDateTime endLocalDateTime = parseToLocalDateTime(end);
	    
        if (startLocalDateTime != null && endLocalDateTime != null) {
            // DTO에 설정
            dto.setMeet_start_date(startLocalDateTime);
            dto.setMeet_end_date(endLocalDateTime);

            logger.info("Start Time (Local): " + startLocalDateTime);
            logger.info("End Time (Local): " + endLocalDateTime);

        } else {
            logger.error("Failed to parse start or end date");
        }
	    
	    dto.setMeet_rent_idx(rentIdx);
		int row = meetingService.dateUpdateMeeting(dto);
		if(row>0) {
			success=true;
		}
		return success; 
	}
	
	//회의 시간 변경
	@PostMapping(value="/meetingResize.do")
	@ResponseBody
	public boolean resizeMeeting(
			@RequestParam("rent_idx") int rentIdx,
			@RequestParam("start") String start,
			@RequestParam("end") String end) {
		boolean success = false;
		MeetingDTO dto = new MeetingDTO();
		
		
		// 날짜 형식 변환
		LocalDateTime startLocalDateTime = parseToLocalDateTime(start);
		LocalDateTime endLocalDateTime = parseToLocalDateTime(end);
		
		if (startLocalDateTime != null && endLocalDateTime != null) {
			// DTO에 설정
			dto.setMeet_start_date(startLocalDateTime);
			dto.setMeet_end_date(endLocalDateTime);
			
			logger.info("Start Time (Local): " + startLocalDateTime);
			logger.info("End Time (Local): " + endLocalDateTime);
			
		} else {
			logger.error("Failed to parse start or end date");
		}
		
		dto.setMeet_rent_idx(rentIdx);
		int row = meetingService.dateUpdateMeeting(dto);
		if(row>0) {
			success=true;
		}
		return success; 
	}
	
	
	//회의 일정 삭제
	@PostMapping(value="/meetingDelete.do")
	@ResponseBody
	public boolean deleteMeeting(@RequestBody int rent_idx) {
		int row = meetingService.deleteMeeting(rent_idx);
		boolean success = false;
		if(row > 0 ) {
			success = true;
		}
		return success;
	}

	//내가 포함된 일정만 보기
	
	
	//회의 일정 1시간 전 알림 발송
	
	
	//내가 포함된 회의 수정/ 삭제시 알림 발송
	
	
	//회의 참여자 추가/ 수정
	

}
