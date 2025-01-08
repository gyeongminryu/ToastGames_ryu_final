package com.toast.rent.dto;

import java.time.LocalDateTime;

public class ResourceManageDTO {

	//공용물품 관리
	private int prod_idx;
	private String prod_name;
	private int prod_cate_idx;
	private String prod_model;
	private String prod_info;
	private int prod_rent;
	private String prod_place;
	private int prod_empl_idx;
	private LocalDateTime prod_purch_date;
	private LocalDateTime prod_dispo_date;
	private int prod_state;
	
	private String prod_rent_str;
	
	public String getProd_rent_str() {
		return prod_rent_str;
	}
	public void setProd_rent_str(String prod_rent_str) {
		this.prod_rent_str = prod_rent_str;
	}
	
	//공용물품  카테고리
	//private int prod_cate_idx;
	private String prod_cate_name;
	private int prod_life;
	
	//공용물품 대여
	private int prod_rent_idx;
	//private int prod_idx;
	private int prod_rent_empl_idx;
	private String prod_rent_reason;
	private LocalDateTime prod_rent_date;
	private LocalDateTime prod_exp_date;
	private LocalDateTime prod_return_date;
	private int prod_return_state;
	
	
	public int getProd_return_state() {
		return prod_return_state;
	}
	public void setProd_return_state(int prod_return_state) {
		this.prod_return_state = prod_return_state;
	}

	//관리사원 정보
	private int empl_idx;
	private String empl_name;
	private int appo_last_idx;
	private String empl_id;
	private int appo_idx;
	private int dept_idx;
	private String position_name; //직급
	private String duty_name; //직책
	private String dept_name; //부서명
	
	
	//공용물품 폐기처리
	private int disp_prod_idx;
	//private int prod_idx;
	private int disp_state;
	private String disp_reason;
	private int take_empl_idx;
	private int disp_empl_idx;
	private LocalDateTime disp_date;
	private int team_idx;
	private String team_name;
	
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
	public int getDisp_prod_idx() {
		return disp_prod_idx;
	}
	public void setDisp_prod_idx(int disp_prod_idx) {
		this.disp_prod_idx = disp_prod_idx;
	}
	public int getDisp_state() {
		return disp_state;
	}
	public void setDisp_state(int disp_state) {
		this.disp_state = disp_state;
	}
	public String getDisp_reason() {
		return disp_reason;
	}
	public void setDisp_reason(String disp_reason) {
		this.disp_reason = disp_reason;
	}
	public int getTake_empl_idx() {
		return take_empl_idx;
	}
	public void setTake_empl_idx(int take_empl_idx) {
		this.take_empl_idx = take_empl_idx;
	}
	public int getDisp_empl_idx() {
		return disp_empl_idx;
	}
	public void setDisp_empl_idx(int disp_empl_idx) {
		this.disp_empl_idx = disp_empl_idx;
	}
	public LocalDateTime getDisp_date() {
		return disp_date;
	}
	public void setDisp_date(LocalDateTime disp_date) {
		this.disp_date = disp_date;
	}
	public String getEmpl_name() {
		return empl_name;
	}
	public void setEmpl_name(String empl_name) {
		this.empl_name = empl_name;
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
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public int getEmpl_idx() {
		return empl_idx;
	}
	public void setEmpl_idx(int empl_idx) {
		this.empl_idx = empl_idx;
	}
	public int getAppo_last_idx() {
		return appo_last_idx;
	}
	public void setAppo_last_idx(int appo_last_idx) {
		this.appo_last_idx = appo_last_idx;
	}
	public String getEmpl_id() {
		return empl_id;
	}
	public void setEmpl_id(String empl_id) {
		this.empl_id = empl_id;
	}
	public int getAppo_idx() {
		return appo_idx;
	}
	public void setAppo_idx(int appo_idx) {
		this.appo_idx = appo_idx;
	}
	public int getDept_idx() {
		return dept_idx;
	}
	public void setDept_idx(int dept_idx) {
		this.dept_idx = dept_idx;
	}
	public int getProd_idx() {
		return prod_idx;
	}
	public void setProd_idx(int prod_idx) {
		this.prod_idx = prod_idx;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public int getProd_cate_idx() {
		return prod_cate_idx;
	}
	public void setProd_cate_idx(int prod_cate_idx) {
		this.prod_cate_idx = prod_cate_idx;
	}
	public String getProd_model() {
		return prod_model;
	}
	public void setProd_model(String prod_model) {
		this.prod_model = prod_model;
	}
	public String getProd_info() {
		return prod_info;
	}
	public void setProd_info(String prod_info) {
		this.prod_info = prod_info;
	}
	public int getProd_rent() {
		return prod_rent;
	}
	public void setProd_rent(int prod_rent) {
		this.prod_rent = prod_rent;
	}
	public String getProd_place() {
		return prod_place;
	}
	public void setProd_place(String prod_place) {
		this.prod_place = prod_place;
	}
	public int getProd_empl_idx() {
		return prod_empl_idx;
	}
	public void setProd_empl_idx(int prod_empl_idx) {
		this.prod_empl_idx = prod_empl_idx;
	}
	public LocalDateTime getProd_purch_date() {
		return prod_purch_date;
	}
	public void setProd_purch_date(LocalDateTime prod_purch_date) {
		this.prod_purch_date = prod_purch_date;
	}
	public LocalDateTime getProd_dispo_date() {
		return prod_dispo_date;
	}
	public void setProd_dispo_date(LocalDateTime prod_dispo_date) {
		this.prod_dispo_date = prod_dispo_date;
	}
	public int getProd_state() {
		return prod_state;
	}
	public void setProd_state(int prod_state) {
		this.prod_state = prod_state;
	}
	public String getProd_cate_name() {
		return prod_cate_name;
	}
	public void setProd_cate_name(String prod_cate_name) {
		this.prod_cate_name = prod_cate_name;
	}
	public int getProd_life() {
		return prod_life;
	}
	public void setProd_life(int prod_life) {
		this.prod_life = prod_life;
	}
	public int getProd_rent_idx() {
		return prod_rent_idx;
	}
	public void setProd_rent_idx(int prod_rent_idx) {
		this.prod_rent_idx = prod_rent_idx;
	}
	public int getProd_rent_empl_idx() {
		return prod_rent_empl_idx;
	}
	public void setProd_rent_empl_idx(int prod_rent_empl_idx) {
		this.prod_rent_empl_idx = prod_rent_empl_idx;
	}
	public String getProd_rent_reason() {
		return prod_rent_reason;
	}
	public void setProd_rent_reason(String prod_rent_reason) {
		this.prod_rent_reason = prod_rent_reason;
	}
	public LocalDateTime getProd_rent_date() {
		return prod_rent_date;
	}
	public void setProd_rent_date(LocalDateTime prod_rent_date) {
		this.prod_rent_date = prod_rent_date;
	}
	public LocalDateTime getProd_exp_date() {
		return prod_exp_date;
	}
	public void setProd_exp_date(LocalDateTime prod_exp_date) {
		this.prod_exp_date = prod_exp_date;
	}
	public LocalDateTime getProd_return_date() {
		return prod_return_date;
	}
	public void setProd_return_date(LocalDateTime prod_return_date) {
		this.prod_return_date = prod_return_date;
	}
	
}
