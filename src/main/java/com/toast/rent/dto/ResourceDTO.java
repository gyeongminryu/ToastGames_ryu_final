package com.toast.rent.dto;

import java.time.LocalDateTime;

public class ResourceDTO {

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
