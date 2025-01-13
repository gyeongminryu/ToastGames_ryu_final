package com.toast.schedule.dto;

import java.time.LocalDateTime;
import java.util.List;

public class MeetingDTO {

	private int team_idx;
	private String team_name;
	private int dept_idx;
	private String dept_name;
	private String position_name;
	private String duty_name;
	private String empl_profile;
	private int empl_idx;
	private String empl_name;
	private int room_idx;
	private String room_name;
	private String room_addr;
	private int room_empl_idx;
	private String room_info;
	private String file_key;
	private int room_min;
	private int room_max;
	
	private int meet_rent_idx;
	//private int room_idx;
	private int meet_rent_empl_idx;
	private String meet_subject;
	private String meet_content;
	private LocalDateTime meet_start_date;
	private LocalDateTime meet_end_date;
	
	private int meet_parti_idx;
	//private int meet_rent_idx;
	private int meet_parti_empl_idx;
	private List<Integer> meet_parti_empl_idxs;
	

	public int getNoti_cate_idx() {
		return noti_cate_idx;
	}
	public void setNoti_cate_idx(int noti_cate_idx) {
		this.noti_cate_idx = noti_cate_idx;
	}
	public int getNoti_sender_empl_idx() {
		return noti_sender_empl_idx;
	}
	public void setNoti_sender_empl_idx(int noti_sender_empl_idx) {
		this.noti_sender_empl_idx = noti_sender_empl_idx;
	}
	public int getNoti_receiver_empl_idx() {
		return noti_receiver_empl_idx;
	}
	public void setNoti_receiver_empl_idx(int noti_receiver_empl_idx) {
		this.noti_receiver_empl_idx = noti_receiver_empl_idx;
	}
	public String getNoti_subject() {
		return noti_subject;
	}
	public void setNoti_subject(String noti_subject) {
		this.noti_subject = noti_subject;
	}
	public String getNoti_content() {
		return noti_content;
	}
	public void setNoti_content(String noti_content) {
		this.noti_content = noti_content;
	}
	public LocalDateTime getNoti_sent_date() {
		return noti_sent_date;
	}
	public void setNoti_sent_date(LocalDateTime noti_sent_date) {
		this.noti_sent_date = noti_sent_date;
	}
	public LocalDateTime getNoti_read_date() {
		return noti_read_date;
	}
	public void setNoti_read_date(LocalDateTime noti_read_date) {
		this.noti_read_date = noti_read_date;
	}
	public int getNoti_deleted() {
		return noti_deleted;
	}
	public void setNoti_deleted(int noti_deleted) {
		this.noti_deleted = noti_deleted;
	}
	public String getNoti_link() {
		return noti_link;
	}
	public void setNoti_link(String noti_link) {
		this.noti_link = noti_link;
	}
	//알림
	private int noti_cate_idx;
	private int noti_sender_empl_idx;
	private int noti_receiver_empl_idx;
	private String noti_subject;
	private String noti_content;
	private LocalDateTime noti_sent_date;
	private LocalDateTime noti_read_date;
	private int noti_deleted;
	private String noti_link;
	
	
	public int getTeam_idx() {
		return team_idx;
	}
	public void setTeam_idx(int team_idx) {
		this.team_idx = team_idx;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public int getDept_idx() {
		return dept_idx;
	}
	public void setDept_idx(int dept_idx) {
		this.dept_idx = dept_idx;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getPosition_name() {
		return position_name;
	}
	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}
	public String getDuty_name() {
		return duty_name;
	}
	public void setDuty_name(String duty_name) {
		this.duty_name = duty_name;
	}
	public String getEmpl_profile() {
		return empl_profile;
	}
	public void setEmpl_profile(String empl_profile) {
		this.empl_profile = empl_profile;
	}

	
	public int getEmpl_idx() {
		return empl_idx;
	}
	public void setEmpl_idx(int empl_idx) {
		this.empl_idx = empl_idx;
	}
	public String getEmpl_name() {
		return empl_name;
	}
	public void setEmpl_name(String empl_name) {
		this.empl_name = empl_name;
	}

	
	
	public List<Integer> getMeet_parti_empl_idxs() {
		return meet_parti_empl_idxs;
	}
	public void setMeet_parti_empl_idxs(List<Integer> meet_parti_empl_idxs) {
		this.meet_parti_empl_idxs = meet_parti_empl_idxs;
	}
	public int getRoom_idx() {
		return room_idx;
	}
	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public String getRoom_addr() {
		return room_addr;
	}
	public void setRoom_addr(String room_addr) {
		this.room_addr = room_addr;
	}
	public int getRoom_empl_idx() {
		return room_empl_idx;
	}
	public void setRoom_empl_idx(int room_empl_idx) {
		this.room_empl_idx = room_empl_idx;
	}
	public String getRoom_info() {
		return room_info;
	}
	public void setRoom_info(String room_info) {
		this.room_info = room_info;
	}
	public String getFile_key() {
		return file_key;
	}
	public void setFile_key(String file_key) {
		this.file_key = file_key;
	}
	public int getRoom_min() {
		return room_min;
	}
	public void setRoom_min(int room_min) {
		this.room_min = room_min;
	}
	public int getRoom_max() {
		return room_max;
	}
	public void setRoom_max(int room_max) {
		this.room_max = room_max;
	}
	public int getMeet_rent_idx() {
		return meet_rent_idx;
	}
	public void setMeet_rent_idx(int meet_rent_idx) {
		this.meet_rent_idx = meet_rent_idx;
	}
	public int getMeet_rent_empl_idx() {
		return meet_rent_empl_idx;
	}
	public void setMeet_rent_empl_idx(int meet_rent_empl_idx) {
		this.meet_rent_empl_idx = meet_rent_empl_idx;
	}
	public String getMeet_subject() {
		return meet_subject;
	}
	public void setMeet_subject(String meet_subject) {
		this.meet_subject = meet_subject;
	}
	public String getMeet_content() {
		return meet_content;
	}
	public void setMeet_content(String meet_content) {
		this.meet_content = meet_content;
	}
	public LocalDateTime getMeet_start_date() {
		return meet_start_date;
	}
	public void setMeet_start_date(LocalDateTime startDateTime) {
		this.meet_start_date = startDateTime;
	}
	public LocalDateTime getMeet_end_date() {
		return meet_end_date;
	}
	public void setMeet_end_date(LocalDateTime meet_end_date) {
		this.meet_end_date = meet_end_date;
	}
	public int getMeet_parti_idx() {
		return meet_parti_idx;
	}
	public void setMeet_parti_idx(int meet_parti_idx) {
		this.meet_parti_idx = meet_parti_idx;
	}
	public int getMeet_parti_empl_idx() {
		return meet_parti_empl_idx;
	}
	public void setMeet_parti_empl_idx(int meet_parti_empl_idx) {
		this.meet_parti_empl_idx = meet_parti_empl_idx;
	}
	
	
}
