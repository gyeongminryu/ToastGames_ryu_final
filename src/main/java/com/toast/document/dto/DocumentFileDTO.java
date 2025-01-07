package com.toast.document.dto;

public class DocumentFileDTO {

    // file
    private int cnt_file;
    private int file_idx;
    private int uploader_idx;
    private String uploader_name;
    private String ori_filename;
    private String new_filename;
    private String file_type;
    private String file_addr;
    private int file_size;

    // Getter
    public int getCnt_file() {
        return cnt_file;
    }

    public int getFile_idx() {
        return file_idx;
    }

    public int getUploader_idx() {
        return uploader_idx;
    }

    public String getUploader_name() {
        return uploader_name;
    }

    public String getOri_filename() {
        return ori_filename;
    }

    public String getNew_filename() {
        return new_filename;
    }

    public String getFile_type() {
        return file_type;
    }

    public String getFile_addr() {
        return file_addr;
    }

    public int getFile_size() {
        return file_size;
    }

    // Setter
    public void setCnt_file(int cnt_file) {
        this.cnt_file = cnt_file;
    }

    public void setFile_idx(int file_idx) {
        this.file_idx = file_idx;
    }

    public void setUploader_idx(int uploader_idx) {
        this.uploader_idx = uploader_idx;
    }

    public void setUploader_name(String uploader_name) {
        this.uploader_name = uploader_name;
    }

    public void setOri_filename(String ori_filename) {
        this.ori_filename = ori_filename;
    }

    public void setNew_filename(String new_filename) {
        this.new_filename = new_filename;
    }

    public void setFile_type(String file_type) {
        this.file_type = file_type;
    }

    public void setFile_addr(String file_addr) {
        this.file_addr = file_addr;
    }

    public void setFile_size(int file_size) {
        this.file_size = file_size;
    }

}
