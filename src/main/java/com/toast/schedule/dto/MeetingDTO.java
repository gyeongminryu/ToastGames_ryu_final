package com.toast.schedule.dto;

import java.time.LocalDateTime;
import java.util.List;

public class MeetingDTO {

	private int room_idx;
	private String room_name;
	private String room_addr;
	private int room_empl_idx;
	private String room_info;
	private String file_key; //실제 프로젝트에서 변경 바람
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
