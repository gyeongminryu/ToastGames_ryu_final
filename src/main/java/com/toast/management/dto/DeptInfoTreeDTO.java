package com.toast.management.dto;

public class DeptInfoTreeDTO {
	
	private String dept_idx;
	private String dept_name;
	private String dept_duty;
	private String dept_head_name;
	private String high_dept_name;
	private String high_dept_head_name;
	private String high_dept_head_duty;
	private String total_dept_count;
	private String total_high_dept_count;
	
	public String getTotal_high_dept_count() {
		return total_high_dept_count;
	}
	public void setTotal_high_dept_count(String total_high_dept_count) {
		this.total_high_dept_count = total_high_dept_count;
	}
	public String getTotal_dept_count() {
		return total_dept_count;
	}
	public void setTotal_dept_count(String total_dept_count) {
		this.total_dept_count = total_dept_count;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	
	public String getDept_head_name() {
		return dept_head_name;
	}
	public void setDept_head_name(String dept_head_name) {
		this.dept_head_name = dept_head_name;
	}
	public String getDept_duty() {
		return dept_duty;
	}
	public void setDept_duty(String dept_duty) {
		this.dept_duty = dept_duty;
	}
	public String getHigh_dept_name() {
		return high_dept_name;
	}
	public void setHigh_dept_name(String high_dept_name) {
		this.high_dept_name = high_dept_name;
	}
	
	public String getHigh_dept_head_name() {
		return high_dept_head_name;
	}
	public void setHigh_dept_head_name(String high_dept_head_name) {
		this.high_dept_head_name = high_dept_head_name;
	}
	public String getHigh_dept_head_duty() {
		return high_dept_head_duty;
	}
	public void setHigh_dept_head_duty(String high_dept_head_duty) {
		this.high_dept_head_duty = high_dept_head_duty;
	}
	public String getDept_idx() {
		return dept_idx;
	}
	public void setDept_idx(String dept_idx) {
		this.dept_idx = dept_idx;
	}
	
}
