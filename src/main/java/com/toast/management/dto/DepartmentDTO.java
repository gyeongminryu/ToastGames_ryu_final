package com.toast.management.dto;

public class DepartmentDTO {
	private int dept_idx;
	private String dept_name;
	private int dept_head_idx;
	private String dept_duty;
	private String dept_addr;
	private int dept_high;
	private boolean dept_state;
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
	public int getDept_head_idx() {
		return dept_head_idx;
	}
	public void setDept_head_idx(int dept_head_idx) {
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
	public int getDept_high() {
		return dept_high;
	}
	public void setDept_high(int dept_high) {
		this.dept_high = dept_high;
	}
	public boolean isDept_state() {
		return dept_state;
	}
	public void setDept_state(boolean dept_state) {
		this.dept_state = dept_state;
	}
}
