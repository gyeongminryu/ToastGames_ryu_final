package com.toast.management.dto;

public class AppointmentDTO {
	private int appo_idx;
	private int appo_empl_idx;
	private int dept_idx;
	private int position_idx;
	private int duty_idx;
	private String empl_job;
	private String movein_date;
	private String transfer_date;
	private int appo_handler_idx;
	private String update_date;
	private String position_name;
	private String duty_name;
	private String dept_name;
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
	public int getAppo_idx() {
		return appo_idx;
	}
	public void setAppo_idx(int appo_idx) {
		this.appo_idx = appo_idx;
	}
	public int getAppo_empl_idx() {
		return appo_empl_idx;
	}
	public void setAppo_empl_idx(int appo_empl_idx) {
		this.appo_empl_idx = appo_empl_idx;
	}
	public int getDept_idx() {
		return dept_idx;
	}
	public void setDept_idx(int dept_idx) {
		this.dept_idx = dept_idx;
	}
	public int getPosition_idx() {
		return position_idx;
	}
	public void setPosition_idx(int position_idx) {
		this.position_idx = position_idx;
	}
	public int getDuty_idx() {
		return duty_idx;
	}
	public void setDuty_idx(int duty_idx) {
		this.duty_idx = duty_idx;
	}
	public String getEmpl_job() {
		return empl_job;
	}
	public void setEmpl_job(String empl_job) {
		this.empl_job = empl_job;
	}
	public String getMovein_date() {
		return movein_date;
	}
	public void setMovein_date(String movein_date) {
		this.movein_date = movein_date;
	}
	public String getTransfer_date() {
		return transfer_date;
	}
	public void setTransfer_date(String transfer_date) {
		this.transfer_date = transfer_date;
	}
	public int getAppo_handler_idx() {
		return appo_handler_idx;
	}
	public void setAppo_handler_idx(int appo_handler_idx) {
		this.appo_handler_idx = appo_handler_idx;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	
	
}
