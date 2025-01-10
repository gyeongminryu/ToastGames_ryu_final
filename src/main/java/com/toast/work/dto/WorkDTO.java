package com.toast.work.dto;

import java.time.LocalTime;
import java.time.LocalDate;

public class WorkDTO {

	private LocalTime attend_date; // 출근 시각
	private LocalTime leave_date; // 퇴근 시각
	private LocalDate work_date; //근무일
    private int total_hours = 0; // 총 근무시간 (분 단위)
    private int overtime_hours = 0; // 초과 근무시간 (분 단위)
    
	public int getTotal_hours() {
		return total_hours;
	}
	public void setTotal_hours(int total_hours) {
		this.total_hours = total_hours;
	}
	public int getOvertime_hours() {
		return overtime_hours;
	}
	public void setOvertime_hours(int overtime_hours) {
		this.overtime_hours = overtime_hours;
	}
	public LocalTime getAttend_date() {
		return attend_date;
	}
	public void setAttend_date(LocalTime attend_date) {
		this.attend_date = attend_date;
	}
	public LocalTime getLeave_date() {
		return leave_date;
	}
	public void setLeave_date(LocalTime leave_date) {
		this.leave_date = leave_date;
	}
	public LocalDate getWork_date() {
		return work_date;
	}
	public void setWork_date(LocalDate work_date) {
		this.work_date = work_date;
	}
    
    
    
}
