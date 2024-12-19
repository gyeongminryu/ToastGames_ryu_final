package com.toast.management.dto;

public class DeptHistoryDTO {
	
	private String dept_history_idx;
	private String	dept_idx;
	private String	dept_name;
	private String dept_head_idx;
	private String dept_duty; 
	private String dept_addr; 
	private String dept_change_date; 
	private String dept_high;
	private String dept_state;
	
	private String empl_name; // 부서장 이름
	private String duty_name; // 직책
	private String position_name; // 직급
	
	public String getDept_history_idx() {
		return dept_history_idx;
	}
	public void setDept_history_idx(String dept_history_idx) {
		this.dept_history_idx = dept_history_idx;
	}
	public String getDept_idx() {
		return dept_idx;
	}
	public void setDept_idx(String dept_idx) {
		this.dept_idx = dept_idx;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getDept_head_idx() {
		return dept_head_idx;
	}
	public void setDept_head_idx(String dept_head_idx) {
		this.dept_head_idx = dept_head_idx;
	}
	public String getDept_duty() {
		return dept_duty;
	}
	public void setDept_duty(String dept_duty) {
		this.dept_duty = dept_duty;
	}
	public String getDept_addr() {
		return dept_addr;
	}
	public void setDept_addr(String dept_addr) {
		this.dept_addr = dept_addr;
	}
	public String getDept_change_date() {
		return dept_change_date;
	}
	public void setDept_change_date(String dept_change_date) {
		this.dept_change_date = dept_change_date;
	}
	public String getDept_high() {
		return dept_high;
	}
	public void setDept_high(String dept_high) {
		this.dept_high = dept_high;
	}
	public String getDept_state() {
		return dept_state;
	}
	public void setDept_state(String dept_state) {
		this.dept_state = dept_state;
	}
	public String getEmpl_name() {
		return empl_name;
	}
	public void setEmpl_name(String empl_name) {
		this.empl_name = empl_name;
	}
	public String getDuty_name() {
		return duty_name;
	}
	public void setDuty_name(String duty_name) {
		this.duty_name = duty_name;
	}
	public String getPosition_name() {
		return position_name;
	}
	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}
	
	
	
	
}
