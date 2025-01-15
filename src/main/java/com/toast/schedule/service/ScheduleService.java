package com.toast.schedule.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.toast.schedule.dao.ScheduleDAO;
import com.toast.schedule.dto.MeetingDTO;
import com.toast.schedule.dto.ScheduleDTO;


@Service
public class ScheduleService {

	
	Logger logger = LoggerFactory.getLogger(getClass());  
	
	private ScheduleDAO scheduleDao;
	
	public ScheduleService(ScheduleDAO scheduleDao) {
		this.scheduleDao = scheduleDao;
	}
	
	//내 정보 가져오기
	public ScheduleDTO myInfo(String myId) {	
		return scheduleDao.myInfo(myId);
	}
	
	
	//일정 추가
	public boolean scheduleAdd(ScheduleDTO scheduleDTO) {
		logger.info("dto:{}",scheduleDTO);
		//일정 추가
		ScheduleDTO schedule = new ScheduleDTO();
		schedule.setSche_title(scheduleDTO.getSche_title());
		schedule.setSche_content(scheduleDTO.getSche_content());
		schedule.setSche_type(scheduleDTO.getSche_type());
		schedule.setSche_start_date(scheduleDTO.getSche_start_date());
		schedule.setSche_end_date(scheduleDTO.getSche_end_date());
		schedule.setSche_allday(scheduleDTO.getSche_allday());
		schedule.setSche_empl_idx(scheduleDTO.getSche_empl_idx());

		int row = scheduleDao.scheduleAdd(schedule);
		boolean success = false;
		boolean parti_row=false;
		//성공하면 참여자 설정
		if(row>0) {
			success=true;
			ScheduleDTO schedule_parti = new ScheduleDTO();
			schedule_parti.setSche_idx(schedule.getSche_idx());
			schedule_parti.setSche_idx(schedule.getSche_idx());
			List<Integer> partiList = scheduleDTO.getSche_parti_empl_idxs();
			LocalDate startDate = scheduleDTO.getSche_start_date().toLocalDate();
			for (Integer parti : partiList) {
				schedule_parti.setSche_parti_empl_idx(parti);
				scheduleDao.scheduleParti(schedule_parti);
				ScheduleDTO noti = new ScheduleDTO();
				noti.setNoti_cate_idx(11);
				noti.setNoti_sender_empl_idx(scheduleDTO.getSche_empl_idx());
				noti.setNoti_receiver_empl_idx(parti);
				noti.setNoti_subject(startDate.toString()+"에 예정된 새로운 일정이 있습니다.");
				noti.setNoti_content(schedule.getSche_title()+':'+schedule.getSche_content());
				noti.setNoti_sent_date(LocalDateTime.now());
				noti.setNoti_deleted(0);
				noti.setNoti_link("/schedule.go");
				scheduleDao.scheAddNoti(noti);
			}
			parti_row=true;
		}
		return parti_row ? parti_row:success;
	}

	
	//일정 보기(내가 개설한 일정+내가 포함된 일정)
	public List<Map<String, Object>> getSchedules(ScheduleDTO dto) {
		logger.info("dto.empl"+dto.getSche_empl_idx());
		logger.info("dto.type"+dto.getSche_type());
		logger.info("dto.parti"+dto.getSche_parti_empl_idx());
		List<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
		List<Map<String, Object>> scheduleList = new ArrayList<Map<String,Object>>();
		if(dto.getSche_parti_empl_idx() != 0) {
			list = scheduleDao.getAllSchedule(dto);
		}else {
			list = scheduleDao.getSchedules(dto);
		}
		for (ScheduleDTO schedule : list) {
			List<ScheduleDTO> partiList = scheduleDao.getAllParti(schedule.getSche_idx());
			Map<String, Object> map = new HashMap<String, Object>();
			if(partiList != null) {
				map.put("parti",partiList);
			}
			logger.info("parti"+map.get("parti"));
			map.put("sche_idx", schedule.getSche_idx());
			map.put("sche_type", schedule.getSche_type());
			map.put("start", schedule.getSche_start_date());
			map.put("end", schedule.getSche_end_date());
			map.put("title", schedule.getSche_title());
			map.put("description", schedule.getSche_content());
			map.put("empl", schedule.getSche_empl_idx());
			map.put("allDay", schedule.getSche_allday());
			scheduleList.add(map);
		}
		return  scheduleList;
	}

	//일정 삭제
	@Transactional
	public int deleteSchedule(int sche_idx) {
		List<ScheduleDTO> dtoList = scheduleDao.getAllParti(sche_idx); //일정 참여자 정보
		ScheduleDTO sche = scheduleDao.getSchedetail(sche_idx); //일정정보
		for (ScheduleDTO dto : dtoList) {
			LocalDate startDate = sche.getSche_start_date().toLocalDate();
			ScheduleDTO noti = new ScheduleDTO();
			noti.setNoti_cate_idx(13);
			noti.setNoti_sender_empl_idx(sche.getSche_empl_idx());
			noti.setNoti_receiver_empl_idx(dto.getSche_parti_empl_idx());
			noti.setNoti_subject(startDate.toString()+"에 예정된 일정이 취소되었습니다");
			noti.setNoti_content(sche.getSche_title()+':'+sche.getSche_content());
			noti.setNoti_sent_date(LocalDateTime.now());
			noti.setNoti_deleted(0);
			scheduleDao.schedeleteNoti(noti);
		}
		int parti = scheduleDao.schedulePartiDelete(sche_idx);
		int row = scheduleDao.deleteSchedule(sche_idx);
		logger.info("row"+row);
		logger.info("parti"+parti);
		return parti;
	}



	

	//내가 파티원으로 포함된 일정 유무
	public boolean isParti(int sche_parti_empl_idx) {
		boolean meParti = false;
		if(scheduleDao.isParti(sche_parti_empl_idx)>0) {
			meParti=true;
		};
		return meParti;
	}


	//일정 수정
	@Transactional
	public boolean scheduleUpdate(ScheduleDTO dto) {
		logger.info("dto:{}",dto);

		// 현재 로컬 시간 가져오기
        LocalDateTime now = LocalDateTime.now(); // 로컬 시스템 시간
		dto.setSche_update_date(now);//update날짜 현재로 설정

		int row = scheduleDao.scheduleUpdate(dto);
		boolean success = false;
		boolean parti_row=false;
		//성공하면 참여자 설정
		if(row>0) {
			success=true;
			ScheduleDTO schedule_parti = new ScheduleDTO();
			schedule_parti.setSche_idx(dto.getSche_idx());
			List<Integer> partiList = dto.getSche_parti_empl_idxs();
			LocalDate startDate = dto.getSche_start_date().toLocalDate();
			scheduleDao.schedulePartiDelete(dto.getSche_idx());
			for (Integer parti : partiList) {
				schedule_parti.setSche_parti_empl_idx(parti);
				scheduleDao.scheduleParti(schedule_parti);
				ScheduleDTO noti = new ScheduleDTO();
				noti.setNoti_cate_idx(12);
				noti.setNoti_sender_empl_idx(dto.getSche_empl_idx());
				noti.setNoti_receiver_empl_idx(parti);
				noti.setNoti_subject(startDate.toString()+"에 예정된 일정에 변동이 있습니다.");
				noti.setNoti_content(dto.getSche_title()+':'+dto.getSche_content());
				noti.setNoti_sent_date(LocalDateTime.now());
				noti.setNoti_deleted(0);
				noti.setNoti_link("/schedule.go");
				scheduleDao.scheAddNoti(noti);
			}
			parti_row=true;
		}
		return parti_row ? parti_row:success;
	}


	//일정 시간 변경
	public int updateTimeSchedule(ScheduleDTO dto) {
		int row = scheduleDao.updateTimeSchedule(dto);
		return row;
	}

	
	//일정 작성자 확인
	public int checkSchedule(int sche_idx) {
		int empl_idx = scheduleDao.checkSchedule(sche_idx);
		return empl_idx;
	}


	// 부서정보
	public List<ScheduleDTO> getDeptList() {
		return scheduleDao.getDeptList();
	}

	// 팀 정보
	public List<ScheduleDTO> getTeamList() {
		return scheduleDao.getTeamList();
	}

	//부서별 사원
	public List<ScheduleDTO> getDeptEmpl(int deptIdx) {
		return scheduleDao.getDeptEmpl(deptIdx);
	}

	
	//팀별 사원
	public List<ScheduleDTO> getTeamEmpl(int teamIdx) {
		List<ScheduleDTO> teamEmpl = scheduleDao.getTeamEmpl(teamIdx);
		return teamEmpl;
	}

	//인수자 검색
	public List<ScheduleDTO> emplSearchMeeting(String option, String keyword) {
		List<ScheduleDTO> emplList = new ArrayList<ScheduleDTO>();
		if(option.equals("dept_name")) {
			emplList = scheduleDao.takeDeptEmpl(keyword);
		}else if(option.equals("position_name")) {
			emplList = scheduleDao.takePosiEmpl(keyword);
		}else {
			emplList = scheduleDao.takeEmpl(keyword);		
		}
		return emplList;
	}



}
