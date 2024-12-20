package com.toast.management.dto;

// organization_detail 부서 사원 리스트
public class DeptDetailMemberDTO {
	private String empl_name;
	private String duty_name;
	private String empl_job;
	private String position_name;
	private String movein_date;
	private String statement_name;
	private String empl_cmp_email;
	public String getEmpl_cmp_email() {
		return empl_cmp_email;
	}
	public void setEmpl_cmp_email(String empl_cmp_email) {
		this.empl_cmp_email = empl_cmp_email;
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
	public String getEmpl_job() {
		return empl_job;
	}
	public void setEmpl_job(String empl_job) {
		this.empl_job = empl_job;
	}
	public String getPosition_name() {
		return position_name;
	}
	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}
	public String getMovein_date() {
		return movein_date;
	}
	public void setMovein_date(String movein_date) {
		this.movein_date = movein_date;
	}
	public String getStatement_name() {
		return statement_name;
	}
	public void setStatement_name(String statement_name) {
		this.statement_name = statement_name;
	}
	
}
