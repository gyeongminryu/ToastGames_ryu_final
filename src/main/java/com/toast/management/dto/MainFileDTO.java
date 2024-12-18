package com.toast.management.dto;

public class MainFileDTO {
	private int file_idx;
	private String file_key;
	private int uploader_idx;
	private String ori_filename;
	private String new_filename;
	private String file_type;
	private String file_addr;
	
	public int getFile_idx() {
		return file_idx;
	}
	public void setFile_idx(int file_idx) {
		this.file_idx = file_idx;
	}
	public String getFile_key() {
		return file_key;
	}
	public void setFile_key(String file_key) {
		this.file_key = file_key;
	}
	public int getUploader_idx() {
		return uploader_idx;
	}
	public void setUploader_idx(int uploader_idx) {
		this.uploader_idx = uploader_idx;
	}
	public String getOri_filename() {
		return ori_filename;
	}
	public void setOri_filename(String ori_filename) {
		this.ori_filename = ori_filename;
	}
	public String getNew_filename() {
		return new_filename;
	}
	public void setNew_filename(String new_filename) {
		this.new_filename = new_filename;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public String getFile_addr() {
		return file_addr;
	}
	public void setFile_addr(String file_addr) {
		this.file_addr = file_addr;
	}
	
}
