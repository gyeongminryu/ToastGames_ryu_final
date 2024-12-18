package com.toast.approval.dto;

import java.util.Date;

public class ApprovalDTO {
    private int doc_idx;
    private int doc_empl_idx;
    private String doc_subject;
    private String doc_content;
    private String doc_content_sub;
    private int form_idx;
    private int doc_state;
    private Date doc_write_date;
    private Date doc_update_date;
    private Date doc_end_date;

    public int getDoc_idx() {
        return doc_idx;
    }

    public void setDoc_idx(int doc_idx) {
        this.doc_idx = doc_idx;
    }

    public int getDoc_empl_idx() {
        return doc_empl_idx;
    }

    public void setDoc_empl_idx(int doc_empl_idx) {
        this.doc_empl_idx = doc_empl_idx;
    }

    public String getDoc_subject() {
        return doc_subject;
    }

    public void setDoc_subject(String doc_subject) {
        this.doc_subject = doc_subject;
    }

    public String getDoc_content() {
        return doc_content;
    }

    public void setDoc_content(String doc_content) {
        this.doc_content = doc_content;
    }

    public String getDoc_content_sub() {
        return doc_content_sub;
    }

    public void setDoc_content_sub(String doc_content_sub) {
        this.doc_content_sub = doc_content_sub;
    }

    public Date getDoc_write_date() {
        return doc_write_date;
    }

    public void setDoc_write_date(Date doc_write_date) {
        this.doc_write_date = doc_write_date;
    }

    public int getDoc_state() {
        return doc_state;
    }

    public void setDoc_state(int doc_state) {
        this.doc_state = doc_state;
    }

    public int getForm_idx() {
        return form_idx;
    }

    public void setForm_idx(int form_idx) {
        this.form_idx = form_idx;
    }

    public Date getDoc_update_date() {
        return doc_update_date;
    }

    public void setDoc_update_date(Date doc_update_date) {
        this.doc_update_date = doc_update_date;
    }

    public Date getDoc_end_date() {
        return doc_end_date;
    }

    public void setDoc_end_date(Date doc_end_date) {
        this.doc_end_date = doc_end_date;
    }
}
