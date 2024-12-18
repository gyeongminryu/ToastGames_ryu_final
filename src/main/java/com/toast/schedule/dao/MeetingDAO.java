package com.toast.schedule.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.toast.schedule.dto.MeetingDTO;
import com.toast.schedule.dto.MeetingPhotoDTO;

@Mapper
public interface MeetingDAO {
	
	//회의실 가기(회의실 이름+idx)
	List<Map<String, Object>> meetingGo();

	//회의실 (정보) 추가
	int roomAdd(MeetingDTO dto);
	
	//회의실 사진 추가
	int roomFileAdd(MeetingPhotoDTO photo_dto);
	
	//회의실 사진 file_key추가
	int roomKeyAdd(String photo_key, int room_idx);
	
	//회의실 정보보기
	Map<String, Object> meetingDetail(int room_idx);

	//회의실 사진보기
	MeetingPhotoDTO meetingPhoto(String file_key);
	
	//회의 일정 추가
	int addMeeting(MeetingDTO dto);

	//회의 일정 보기
	List<MeetingDTO> getMeeting(int room_idx);

	//회의 일정 수정
	int updateMeeting(MeetingDTO dto);

	//회의 일정 삭제
	int deleteMeeting(int rent_idx);

	//회의 일정 시간변경
	int dateUpdateMeeting(MeetingDTO dto);



	


}
