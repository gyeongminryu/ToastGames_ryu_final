package com.toast.schedule.controller;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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
@RequestMapping
public class MeetingController {
 
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
	
	private MeetingService meetingService;
	
    private HttpSession session;

    public MeetingController(MeetingService meetingService, HttpSession session) {
        this.meetingService = meetingService;
        this.session = session;
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
	
	
//--------------------------------------------로그인 체크 및 부서 체크---------------------------------------------------------------------
	
	
	//회의실 예약 가기(회의실 + 사원)
	@RequestMapping(value="/meeting.go")
	public ModelAndView meetingGo () {
		ModelAndView mv = new ModelAndView();
		//회의실
		List<Map<String, Object>> roomList = meetingService.meetingGo();
		mv.addObject("roomList", roomList);
		//내 정보
		//String myId= "peterrabbit165";
		//String myId= (String) session.getAttribute("loginId");
		//MeetingDTO my_info = meetingService.myInfo(myId);
		//int my_empl_idx = my_info.getEmpl_idx();
		//session.setAttribute("my_idx", my_empl_idx);
		//mv.addObject("my_empl_idx", my_empl_idx);
		List<MeetingDTO> deptList = meetingService.getDeptList();
		List<MeetingDTO> teamList= meetingService.getTeamList();
		mv.addObject("deptList", deptList);
		mv.addObject("teamList", teamList);
		mv.setViewName("meeting_room_calendar");
		return mv;
	}
	
	//회의실 정보 등록 가기(
	@RequestMapping(value="/meetingRoomAdd.go")
	public ModelAndView meetingAddGo () {
		ModelAndView mv = new ModelAndView();
		//String myId= "peterrabbit165";
		//String myId= (String) session.getAttribute("loginId");
		//logger.info(myId);
		//부서번호 가져오기
		//int my_dept_idx = meetingService.myDept(myId);
		//logger.info("my_dept_idx"+my_dept_idx);
		//mv.addObject("my_dept_idx", my_dept_idx);
		mv.setViewName("meeting_room_add");
		return mv;
	}
	
	//회의실 정보 등록
	@PostMapping(value="/meetingRoomAdd.do")
	public ModelAndView roomAdd(@RequestParam MultipartFile file,@RequestParam Map<String,String> param) {
		logger.info("Received params: " + param);
		logger.info("file count:"+file);
		meetingService.meetingRoomAdd(param,file);
		return new ModelAndView("redirect:/meeting.go");
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
	
	//회의실 정보 수정(관리자, 사진제외)
	@PostMapping("/updateMeetingRoomDetail.do")
	public ResponseEntity<?> updateRoomDetail(
			@ModelAttribute MeetingDTO meetingDto) {  // room_idx 추가
	        
	    logger.info("회의실 ID (room_idx): {}", meetingDto.getRoom_idx());
	    int row = meetingService.updateMeetingRoom(meetingDto);
	    
	    // 응답에 담을 데이터 준비
	    Map<String, String> response = new HashMap<>();
	    if(row >0) {
	    	response.put("message", "수정 성공");
	    }else {
	    	response.put("message", "수정 실패");
	    }
	    
	    // 수정 처리 후 응답
	    return ResponseEntity.ok(response);
	}

	//회의실 정보 삭제 (사진 삭제 추가)
	@PostMapping("/deleteMeetingRoom.do")
	public ResponseEntity<?> deleteMeetingRoom(
			@RequestBody Map<String, String> params) {  // room_idx 추가
	        
	    logger.info("회의실 ID (room_idx): {}", params.get("room_idx"));
	    logger.info("새 파일 이름 (new_filename): {}", params.get("image_filename"));
	    
	    int row = meetingService.checkMeetingRoom(Integer.parseInt(params.get("room_idx")));

	    // 응답에 담을 데이터 준비
	    Map<String, String> response = new HashMap<>();

	    if(row >0) {
	    	response.put("message", "삭제 실패");
	    }else {
	    	meetingService.deleteMeetingRoom(params);
	    	response.put("message", "삭제 성공");
	    }
	    
	    // 수정 처리 후 응답
	    return ResponseEntity.ok(response);
	}
	

	//회의 일정 보기(회의실별+ 내가 포함된 회의)
	@PostMapping(value="/getMeeting.do")
	@ResponseBody
	public List<Map<String, Object>> getMeeting(@RequestBody Map<String, Object> params) {
		
	    String room = (String) params.get("room");
	    logger.info("room:"+room);
	    String myMeeting = null;
	    if(params.get("my_meeting") != null) {
	    	myMeeting = (String) session.getAttribute("empl_idx");
	    }
	    Map<String, Object> param = new HashMap<String, Object>();
	    param.put("room", room);
	    param.put("my_meeting", myMeeting);
	    
	    List<Map<String, Object>> meetings = new ArrayList<Map<String,Object>>();
		if (myMeeting != null) {
			meetings = meetingService.getMyMeeting(param);
		} else {
			meetings = meetingService.getMeeting(param);
			logger.info("일정 왜  events없어:"+meetings);
		}
		logger.info("meetings의길이:"+meetings.size());
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

        } else {
            logger.error("Failed to parse start or end date");
        }
	    //int empl_idx=(int) session.getAttribute("empl_idx");
        int empl_idx= 10003;
	    // room, empl 값을 Integer로 변환
	    dto.setRoom_idx(Integer.parseInt((String) params.get("room")));
	    dto.setMeet_rent_empl_idx(empl_idx);
	    
	    List<Integer> meeting_parti = new ArrayList<>();
	    
	    //Object로 넘어오는 타입이 뭔지 몰라 경고 발생으로 데이터가 리스트인지 먼저 확인
	    Object participantsObj = params.get("meeting_parti");
	    logger.info("meeting_parti: " + participantsObj);

	    if (participantsObj instanceof List<?>) {
	        List<?> partiList = (List<?>) participantsObj;
	        logger.info("partiList size: " + partiList.size());
	        logger.info("partiList contents: " + partiList);

	        for (Object parti : partiList) {
	            logger.info("parti: " + parti + ", Type: " + (parti != null ? parti.getClass().getName() : "null"));

	            if (parti instanceof Integer) {
	                // 이미 Integer라면 바로 추가
	                meeting_parti.add((Integer) parti);
	            } else if (parti instanceof String) {
	                // String인 경우 Integer로 변환 후 추가
	                meeting_parti.add(Integer.parseInt((String) parti));
	            } else {
	                logger.warn("Unexpected type for parti: " + parti);
	            }
	        }

	    }

	    // DTO에 리스트 추가 (빈 리스트라도 설정)
	    dto.setMeet_parti_empl_idxs(meeting_parti);
	    logger.info("Final DTO meeting_parti: " + dto.getMeet_parti_empl_idxs());


	    
	    boolean success = false;
	    if (meetingService.addMeeting(dto)) {
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
	    int empl_idx=(int) session.getAttribute("empl_idx");
        //int empl_idx= 10003;
	    // room, empl, rent_idx 값을 Integer로 변환
	    dto.setRoom_idx(Integer.parseInt((String) params.get("room")));
	    dto.setMeet_rent_empl_idx(empl_idx);
	    dto.setMeet_rent_idx((int) params.get("rent_idx"));
	    
	    logger.info("title: " + dto.getMeet_subject());

	    List<Integer> meeting_parti = new ArrayList<>();
	    
	    Object participantsObj = params.get("meeting_parti");
	    logger.info("meeting_parti: " + participantsObj);
	    if (participantsObj instanceof List<?>) {
	        List<?> partiList = (List<?>) participantsObj;
	        logger.info("partiList size: " + partiList.size());
	        logger.info("partiList contents: " + partiList);

	        for (Object parti : partiList) {
	            logger.info("parti: " + parti + ", Type: " + (parti != null ? parti.getClass().getName() : "null"));

	            if (parti instanceof Integer) {
	                // 이미 Integer라면 바로 추가
	                meeting_parti.add((Integer) parti);
	            } else if (parti instanceof String) {
	                // String인 경우 Integer로 변환 후 추가
	                meeting_parti.add(Integer.parseInt((String) parti));
	            } else {
	                logger.warn("Unexpected type for parti: " + parti);
	            }
	        }

	    }
	    dto.setMeet_parti_empl_idxs(meeting_parti);
	    
	    boolean success = false;
	    if (meetingService.updateMeeting(dto)) {
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
	@PostMapping(value="/resizeMeeting.do")
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

	//부서별 직원 가져오기
	@GetMapping(value="/getDeptEmplMeeting.ajax")
	@ResponseBody
	public Map<String, Object> getDeptEmpl(@RequestParam("dept_idx") String dept_idx) {
		
		int deptIdx = Integer.parseInt(dept_idx);
		List<MeetingDTO> emplList = meetingService.getDeptEmpl(deptIdx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emplList", emplList);
		return map;
	}
	

	
	//팀별 직원 가져오기
	@GetMapping(value="/getTeamEmplMeeting.ajax")
	@ResponseBody
	public Map<String, Object> getTeamEmpl(@RequestParam("team_idx") String team_idx) {
		
		int teamIdx = Integer.parseInt(team_idx);
		List<MeetingDTO> emplList = meetingService.getTeamEmpl(teamIdx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emplList", emplList);
		return map;
	}
	
	
	//사원 검색
	@PostMapping(value="/emplSearchMeeting.ajax")
	@ResponseBody
	public Map<String, Object> emplSearchMeeting(
			@RequestParam("option") String option, 
			@RequestParam("keyword") String keyword) {
		
		List<MeetingDTO> emplList = meetingService.emplSearchMeeting(option, keyword);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emplList", emplList);
		return map;
		
	}
	
	
	
	
	

}
