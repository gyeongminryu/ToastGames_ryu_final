package com.toast.schedule.dto;

import java.time.LocalDateTime;

public class ScheduleDTO {

	private int sche_idx;
	private String sche_title;
	private String sche_content;
	private int sche_type;
	private LocalDateTime sche_start_date;
	private LocalDateTime sche_end_date;
	private int sche_allday;
	private int sche_empl_idx;
	private LocalDateTime sche_write_date;
	private LocalDateTime sche_update_date;
	
	private int sche_parti_empl_idx;
	
	private int prod_rent_idx;
	private int prod_idx;
	private int prod_rent_empl_idx;
	private String prod_rent_reason;
	private LocalDateTime prod_rent_date;
	private LocalDateTime prod_exp_date;
	private LocalDateTime prod_return_date;
	
	
	public int getSche_parti_empl_idx() {
		return sche_parti_empl_idx;
	}
	public void setSche_parti_empl_idx(int sche_parti_empl_idx) {
		this.sche_parti_empl_idx = sche_parti_empl_idx;
	}
	
	
	public int getSche_idx() {
		return sche_idx;
	}
	public void setSche_idx(int sche_idx) {
		this.sche_idx = sche_idx;
	}
	public String getSche_title() {
		return sche_title;
	}
	public void setSche_title(String sche_title) {
		this.sche_title = sche_title;
	}
	public String getSche_content() {
		return sche_content;
	}
	public void setSche_content(String sche_content) {
		this.sche_content = sche_content;
	}
	public int getSche_type() {
		return sche_type;
	}
	public void setSche_type(int sche_type) {
		this.sche_type = sche_type;
	}
	public LocalDateTime getSche_start_date() {
		return sche_start_date;
	}
	public void setSche_start_date(LocalDateTime sche_start_date) {
		this.sche_start_date = sche_start_date;
	}
	public LocalDateTime getSche_end_date() {
		return sche_end_date;
	}
	public void setSche_end_date(LocalDateTime sche_end_date) {
		this.sche_end_date = sche_end_date;
	}
	public int getSche_allday() {
		return sche_allday;
	}
	public void setSche_allday(int sche_allday) {
		this.sche_allday = sche_allday;
	}
	public int getSche_empl_idx() {
		return sche_empl_idx;
	}
	public void setSche_empl_idx(int sche_empl_idx) {
		this.sche_empl_idx = sche_empl_idx;
	}
	public LocalDateTime getSche_write_date() {
		return sche_write_date;
	}
	public void setSche_write_date(LocalDateTime sche_write_date) {
		this.sche_write_date = sche_write_date;
	}
	public LocalDateTime getSche_update_date() {
		return sche_update_date;
	}
	public void setSche_update_date(LocalDateTime sche_update_date) {
		this.sche_update_date = sche_update_date;
	}
	
	
}
