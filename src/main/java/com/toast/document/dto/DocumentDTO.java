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
    private int dept_idx_0;
    private String dept_name_0;
    private int duty_idx_0;
    private String duty_name_0;
    private int empl_idx_0;
    private String empl_name_0;
    private int position_idx_0;
    private String position_name_0;
    private LocalDateTime appr_date_0;
    private int dept_idx_1;
    private String dept_name_1;
    private int duty_idx_1;
    private String duty_name_1;
    private int empl_idx_1;
    private String empl_name_1;
    private int position_idx_1;
    private String position_name_1;
    private LocalDateTime appr_date_1;
    private int dept_idx_2;
    private String dept_name_2;
    private int duty_idx_2;
    private String duty_name_2;
    private int empl_idx_2;
    private String empl_name_2;
    private int position_idx_2;
    private LocalDateTime appr_date_2;
    private String position_name_2;
    private int dept_idx_3;
    private String dept_name_3;
    private int duty_idx_3;
    private String duty_name_3;
    private int empl_idx_3;
    private String empl_name_3;
    private int position_idx_3;
    private String position_name_3;
    private LocalDateTime appr_date_3;

    // form
    private String form_subject;

    // others
    private int cnt_file;
    private boolean authority;

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

    public int getDept_idx_0() {
        return dept_idx_0;
    }

    public String getDept_name_0() {
        return dept_name_0;
    }

    public int getDuty_idx_0() {
        return duty_idx_0;
    }

    public String getDuty_name_0() {
        return duty_name_0;
    }

    public int getEmpl_idx_0() {
        return empl_idx_0;
    }

    public String getEmpl_name_0() {
        return empl_name_0;
    }

    public int getPosition_idx_0() {
        return position_idx_0;
    }

    public String getPosition_name_0() {
        return position_name_0;
    }

    public LocalDateTime getAppr_date_0() {
        return appr_date_0;
    }

    public int getDept_idx_1() {
        return dept_idx_1;
    }

    public String getDept_name_1() {
        return dept_name_1;
    }

    public int getDuty_idx_1() {
        return duty_idx_1;
    }

    public String getDuty_name_1() {
        return duty_name_1;
    }

    public int getEmpl_idx_1() {
        return empl_idx_1;
    }

    public String getEmpl_name_1() {
        return empl_name_1;
    }

    public int getPosition_idx_1() {
        return position_idx_1;
    }

    public String getPosition_name_1() {
        return position_name_1;
    }

    public LocalDateTime getAppr_date_1() {
        return appr_date_1;
    }

    public int getDept_idx_2() {
        return dept_idx_2;
    }

    public String getDept_name_2() {
        return dept_name_2;
    }

    public int getDuty_idx_2() {
        return duty_idx_2;
    }

    public String getDuty_name_2() {
        return duty_name_2;
    }

    public int getEmpl_idx_2() {
        return empl_idx_2;
    }

    public String getEmpl_name_2() {
        return empl_name_2;
    }

    public int getPosition_idx_2() {
        return position_idx_2;
    }

    public String getPosition_name_2() {
        return position_name_2;
    }

    public LocalDateTime getAppr_date_2() {
        return appr_date_2;
    }

    public int getDept_idx_3() {
        return dept_idx_3;
    }

    public String getDept_name_3() {
        return dept_name_3;
    }

    public int getDuty_idx_3() {
        return duty_idx_3;
    }

    public String getDuty_name_3() {
        return duty_name_3;
    }

    public int getEmpl_idx_3() {
        return empl_idx_3;
    }

    public String getEmpl_name_3() {
        return empl_name_3;
    }

    public int getPosition_idx_3() {
        return position_idx_3;
    }

    public String getPosition_name_3() {
        return position_name_3;
    }

    public LocalDateTime getAppr_date_3() {
        return appr_date_3;
    }

    public String getForm_subject() {
        return form_subject;
    }

    public int getCnt_file() {
        return cnt_file;
    }

    public boolean isAuthority() {
        return authority;
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

    public void setDept_idx_0(int dept_idx_0) {
        this.dept_idx_0 = dept_idx_0;
    }

    public void setDept_name_0(String dept_name_0) {
        this.dept_name_0 = dept_name_0;
    }

    public void setDuty_idx_0(int duty_idx_0) {
        this.duty_idx_0 = duty_idx_0;
    }

    public void setDuty_name_0(String duty_name_0) {
        this.duty_name_0 = duty_name_0;
    }

    public void setEmpl_idx_0(int empl_idx_0) {
        this.empl_idx_0 = empl_idx_0;
    }

    public void setEmpl_name_0(String empl_name_0) {
        this.empl_name_0 = empl_name_0;
    }

    public void setPosition_idx_0(int position_idx_0) {
        this.position_idx_0 = position_idx_0;
    }

    public void setPosition_name_0(String position_name_0) {
        this.position_name_0 = position_name_0;
    }

    public void setAppr_date_0(LocalDateTime appr_date_0) {
        this.appr_date_0 = appr_date_0;
    }

    public void setDept_idx_1(int dept_idx_1) {
        this.dept_idx_1 = dept_idx_1;
    }

    public void setDept_name_1(String dept_name_1) {
        this.dept_name_1 = dept_name_1;
    }

    public void setDuty_idx_1(int duty_idx_1) {
        this.duty_idx_1 = duty_idx_1;
    }

    public void setDuty_name_1(String duty_name_1) {
        this.duty_name_1 = duty_name_1;
    }

    public void setEmpl_idx_1(int empl_idx_1) {
        this.empl_idx_1 = empl_idx_1;
    }

    public void setEmpl_name_1(String empl_name_1) {
        this.empl_name_1 = empl_name_1;
    }

    public void setPosition_idx_1(int position_idx_1) {
        this.position_idx_1 = position_idx_1;
    }

    public void setPosition_name_1(String position_name_1) {
        this.position_name_1 = position_name_1;
    }

    public void setAppr_date_1(LocalDateTime appr_date_1) {
        this.appr_date_1 = appr_date_1;
    }

    public void setDept_idx_2(int dept_idx_2) {
        this.dept_idx_2 = dept_idx_2;
    }

    public void setDept_name_2(String dept_name_2) {
        this.dept_name_2 = dept_name_2;
    }

    public void setDuty_idx_2(int duty_idx_2) {
        this.duty_idx_2 = duty_idx_2;
    }

    public void setDuty_name_2(String duty_name_2) {
        this.duty_name_2 = duty_name_2;
    }

    public void setEmpl_idx_2(int empl_idx_2) {
        this.empl_idx_2 = empl_idx_2;
    }

    public void setEmpl_name_2(String empl_name_2) {
        this.empl_name_2 = empl_name_2;
    }

    public void setPosition_idx_2(int position_idx_2) {
        this.position_idx_2 = position_idx_2;
    }

    public void setPosition_name_2(String position_name_2) {
        this.position_name_2 = position_name_2;
    }

    public void setAppr_date_2(LocalDateTime appr_date_2) {
        this.appr_date_2 = appr_date_2;
    }

    public void setDept_idx_3(int dept_idx_3) {
        this.dept_idx_3 = dept_idx_3;
    }

    public void setDept_name_3(String dept_name_3) {
        this.dept_name_3 = dept_name_3;
    }

    public void setDuty_idx_3(int duty_idx_3) {
        this.duty_idx_3 = duty_idx_3;
    }

    public void setDuty_name_3(String duty_name_3) {
        this.duty_name_3 = duty_name_3;
    }

    public void setEmpl_idx_3(int empl_idx_3) {
        this.empl_idx_3 = empl_idx_3;
    }

    public void setEmpl_name_3(String empl_name_3) {
        this.empl_name_3 = empl_name_3;
    }

    public void setPosition_idx_3(int position_idx_3) {
        this.position_idx_3 = position_idx_3;
    }

    public void setPosition_name_3(String position_name_3) {
        this.position_name_3 = position_name_3;
    }

    public void setAppr_date_3(LocalDateTime appr_date_3) {
        this.appr_date_3 = appr_date_3;
    }

    public void setForm_subject(String form_subject) {
        this.form_subject = form_subject;
    }

    public void setCnt_file(int cnt_file) {
        this.cnt_file = cnt_file;
    }

    public void setAuthority(boolean authority) {
        this.authority = authority;
    }

}
