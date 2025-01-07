package com.toast.document.dto;

import java.time.LocalDateTime;

public class DocumentDTO {

    // document
    private int doc_idx;
    private int doc_empl_idx;
    private String empl_name;
    private String doc_subject;
    private String doc_content;
    private String doc_content_sub;
    private int form_idx;
    private int doc_state;
    private LocalDateTime doc_write_date;
    private LocalDateTime doc_update_date;
    private LocalDateTime doc_end_date;
    private String file_key;

    // approval_line
    private int line_idx;
    private int line_order;
    private int dept_idx;
    private String dept_name;
    private int duty_idx;
    private String duty_name;
    private int empl_idx;
    private int position_idx;
    private String position_name;

    // reference
    private int ref_idx;
    private int ref_doc_idx;
    private int ref_empl_idx;

    // reference_department
    private int ref_dept_idx;

    // form
    private String form_subject;

    // Getter
    public int getDoc_idx() {
        return doc_idx;
    }

    public int getDoc_empl_idx() {
        return doc_empl_idx;
    }

    public String getEmpl_name() {
        return empl_name;
    }

    public String getDoc_subject() {
        return doc_subject;
    }

    public String getDoc_content() {
        return doc_content;
    }

    public String getDoc_content_sub() {
        return doc_content_sub;
    }

    public int getForm_idx() {
        return form_idx;
    }

    public int getDoc_state() {
        return doc_state;
    }

    public LocalDateTime getDoc_write_date() {
        return doc_write_date;
    }

    public LocalDateTime getDoc_update_date() {
        return doc_update_date;
    }

    public LocalDateTime getDoc_end_date() {
        return doc_end_date;
    }

    public String getFile_key() {
        return file_key;
    }

    public int getLine_idx() {
        return line_idx;
    }

    public int getLine_order() {
        return line_order;
    }

    public int getDept_idx() {
        return dept_idx;
    }

    public String getDept_name() {
        return dept_name;
    }

    public int getDuty_idx() {
        return duty_idx;
    }

    public String getDuty_name() {
        return duty_name;
    }

    public int getEmpl_idx() {
        return empl_idx;
    }

    public int getPosition_idx() {
        return position_idx;
    }

    public String getPosition_name() {
        return position_name;
    }

    public int getRef_idx() {
        return ref_idx;
    }

    public int getRef_doc_idx() {
        return ref_doc_idx;
    }

    public int getRef_empl_idx() {
        return ref_empl_idx;
    }

    public int getRef_dept_idx() {
        return ref_dept_idx;
    }

    public String getForm_subject() {
        return form_subject;
    }

    // Setter
    public void setDoc_idx(int doc_idx) {
        this.doc_idx = doc_idx;
    }

    public void setDoc_empl_idx(int doc_empl_idx) {
        this.doc_empl_idx = doc_empl_idx;
    }

    public void setEmpl_name(String empl_name) {
        this.empl_name = empl_name;
    }

    public void setDoc_subject(String doc_subject) {
        this.doc_subject = doc_subject;
    }

    public void setDoc_content(String doc_content) {
        this.doc_content = doc_content;
    }

    public void setDoc_content_sub(String doc_content_sub) {
        this.doc_content_sub = doc_content_sub;
    }

    public void setForm_idx(int form_idx) {
        this.form_idx = form_idx;
    }

    public void setDoc_state(int doc_state) {
        this.doc_state = doc_state;
    }

    public void setDoc_write_date(LocalDateTime doc_write_date) {
        this.doc_write_date = doc_write_date;
    }

    public void setDoc_update_date(LocalDateTime doc_update_date) {
        this.doc_update_date = doc_update_date;
    }

    public void setDoc_end_date(LocalDateTime doc_end_date) {
        this.doc_end_date = doc_end_date;
    }

    public void setFile_key(String file_key) {
        this.file_key = file_key;
    }

    public void setLine_idx(int line_idx) {
        this.line_idx = line_idx;
    }

    public void setLine_order(int line_order) {
        this.line_order = line_order;
    }

    public void setDept_idx(int dept_idx) {
        this.dept_idx = dept_idx;
    }

    public void setDept_name(String dept_name) {
        this.dept_name = dept_name;
    }

    public void setDuty_idx(int duty_idx) {
        this.duty_idx = duty_idx;
    }

    public void setDuty_name(String duty_name) {
        this.duty_name = duty_name;
    }

    public void setEmpl_idx(int empl_idx) {
        this.empl_idx = empl_idx;
    }

    public void setPosition_idx(int position_idx) {
        this.position_idx = position_idx;
    }

    public void setPosition_name(String position_name) {
        this.position_name = position_name;
    }

    public void setRef_idx(int ref_idx) {
        this.ref_idx = ref_idx;
    }

    public void setRef_doc_idx(int ref_doc_idx) {
        this.ref_doc_idx = ref_doc_idx;
    }

    public void setRef_empl_idx(int ref_empl_idx) {
        this.ref_empl_idx = ref_empl_idx;
    }

    public void setRef_dept_idx(int ref_dept_idx) {
        this.ref_dept_idx = ref_dept_idx;
    }

    public void setForm_subject(String form_subject) {
        this.form_subject = form_subject;
    }

}
