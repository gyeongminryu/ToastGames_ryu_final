package com.toast.schedule.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.toast.schedule.dto.ScheduleDTO;

@Mapper
public interface ScheduleDAO {

	//달력가기 참여자 가져오기
	List<Map<String, Object>> getScheduleParti();
	
	//일정 추가
	int scheduleAdd(ScheduleDTO scheduleDTO);

	//참여자 추가
	int scheduleParti(ScheduleDTO schedule_parti);
	
	//일정보기(내가 생성한 일정)
	List<ScheduleDTO> getSchedules(ScheduleDTO dto);

	//내가 파티원으로 포함된일정이 있는지 유무
	int isParti(int sche_parti_empl_idx);
	
	//내가 피티원인 일정 포함
	List<ScheduleDTO> getAllSchedule(ScheduleDTO dto);

	//일정 삭제
	int deleteSchedule(int sche_idx);
	
	//일정 참여자 삭제
	int schedulePartiDelete(int sche_idx);
	
	//모든일정에 관한 참여자 가져오기
	List<Integer> getAllParti(int sche_idx);

	//일정 수정
	int scheduleUpdate(ScheduleDTO schedule);

	//일정 drop, resize수정
	int updateTimeSchedule(ScheduleDTO dto);










	
	
	
	

	
}
