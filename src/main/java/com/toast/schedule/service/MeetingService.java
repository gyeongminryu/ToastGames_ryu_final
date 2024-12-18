package com.toast.schedule.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.toast.schedule.dao.MeetingDAO;
import com.toast.schedule.dto.MeetingDTO;
import com.toast.schedule.dto.MeetingPhotoDTO;

@Service
public class MeetingService {

	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	private MeetingDAO meetingDao;
	
	public MeetingService(MeetingDAO meetingDao) {
		this.meetingDao = meetingDao;
	}
	
	//회의실 가기(회의실 이름+idx)
	public List<Map<String, Object>> meetingGo() {
		return meetingDao.meetingGo();		
	}

	//회의실 정보 상세보기
	public Map<String, Object> meetingDetail(int room_idx) {
		logger.info("room_idx:"+room_idx);
		return meetingDao.meetingDetail(room_idx);
	}
	
	//회의실 정보 상세(사진)
	public MeetingPhotoDTO meetingPhoto(String file_key, int room_idx) {
		return meetingDao.meetingPhoto(file_key);
	}

	//회의실 (정보) 추가
	public void meetingRoomAdd(Map<String, String> param, MultipartFile file) {
		//회의실 정보 dto
		MeetingDTO dto = new MeetingDTO();
		dto.setRoom_name(param.get("room_name"));
		dto.setRoom_addr(param.get("room_addr"));
		dto.setRoom_empl_idx(Integer.parseInt(param.get("room_empl_idx")));
		dto.setRoom_info(param.get("room_info"));
		dto.setRoom_min(Integer.parseInt(param.get("room_min")));
		dto.setRoom_max(Integer.parseInt(param.get("room_max")));
		
		meetingDao.roomAdd(dto);
		int room_idx = dto.getRoom_idx();
		
		if(room_idx > 0) {
			roomFileAdd(file, room_idx);
		}
		
	}
	
	//회의실 (정보) 추가 사진
	private void roomFileAdd(MultipartFile file, int room_idx) {
		
		
		//1.파일명 추출
		String oriFilename = file.getOriginalFilename();
		//2.기존 파일의 확장자만 분리
		String ext = oriFilename.substring(oriFilename.lastIndexOf("."));
		
		//3.새파일명 생성
		String newFilename = UUID.randomUUID().toString()+ext; //바로 해도됨 +문자는 문자열로 인식
		
		//4. 첨부파일 키 생성
		String fileKey = UUID.randomUUID().toString();
		
		//5. 파일 저장
		try {
			byte[] arr = file.getBytes();
			Path path = Paths.get("C:/upload/"+newFilename);
			Files.write(path, arr);
			//6.저장 내용 files 테이블에 insert
			MeetingPhotoDTO photo_dto = new MeetingPhotoDTO();
			photo_dto.setNew_filename(newFilename);
			photo_dto.setOri_filename(oriFilename);
			photo_dto.setFile_addr(path.toString());
			photo_dto.setFile_type(ext);
			photo_dto.setFile_key(fileKey);
			photo_dto.setUploader_idx(room_idx);
			meetingDao.roomFileAdd(photo_dto);
			meetingDao.roomKeyAdd(fileKey, room_idx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	//회의 일정 보기
	public List<Map<String, Object>> getMeeting(Map<String, Object> params) {
		Integer room_idx = Integer.parseInt((String) params.get("room"));
		List<MeetingDTO> list = meetingDao.getMeeting(room_idx);
		List<Map<String, Object>> meeting_list = new ArrayList<Map<String,Object>>();
		for (MeetingDTO dto : list) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("meet_rent_idx", dto.getMeet_rent_idx());
			map.put("room", dto.getRoom_idx());
			map.put("start", dto.getMeet_start_date());
			map.put("end", dto.getMeet_end_date());
			map.put("title", dto.getMeet_subject());
			map.put("description", dto.getMeet_content());
			map.put("empl", dto.getMeet_rent_empl_idx());
			
			meeting_list.add(map);
		}
		return  meeting_list;
	}
	
	//회의 일정 추가
	public int addMeeting(MeetingDTO dto) {
		logger.info("dto:{}",dto);
		int row = meetingDao.addMeeting(dto);
		return row;
	}


	//회의 일정 수정
	public int updateMeeting(MeetingDTO dto) {
		logger.info("dto:{}",dto);
		int row = meetingDao.updateMeeting(dto);
		logger.info("success:"+row);
		return row;
	}

	//회의 일정 삭제
	public int deleteMeeting(int rent_idx) {
		return meetingDao.deleteMeeting(rent_idx);
		
	}

	//회의 일정 시간 변경
	public int dateUpdateMeeting(MeetingDTO dto) {
		return meetingDao.dateUpdateMeeting(dto);
	}
	

	
	
	//내가 포함된 일정만 보기
	
	
	//회의 일정 1시간 전 알림 발송
	
	
	//내가 포함된 회의 수정/ 삭제시 알림 발송
	
	
	//회의 참여자 추가/ 수정
}
