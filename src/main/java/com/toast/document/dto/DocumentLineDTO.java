package com.toast.document.dto;

import java.time.LocalDateTime;

public class DocumentLineDTO {

    // approval_line
    private int line_idx;
    private int doc_idx;
    private int line_order;
    private int dept_idx;
    private String dept_name;
    private int duty_idx;
    private String duty_name;
    private int empl_idx;
    private String empl_name;
    private int position_idx;
    private String position_name;
    private String empl_profile;
    private LocalDateTime appr_date;

    // Getter
    public int getLine_idx() {
        return line_idx;
    }

    public int getDoc_idx() {
        return doc_idx;
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

    public String getEmpl_name() {
        return empl_name;
    }

    public int getPosition_idx() {
        return position_idx;
    }

    public String getPosition_name() {
        return position_name;
    }

    public String getEmpl_profile() {
        return empl_profile;
    }

    public LocalDateTime getAppr_date() {
        return appr_date;
    }

    // Setter
    public void setLine_idx(int line_idx) {
        this.line_idx = line_idx;
    }

    public void setDoc_idx(int doc_idx) {
        this.doc_idx = doc_idx;
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

    public void setEmpl_name(String empl_name) {
        this.empl_name = empl_name;
    }

    public void setPosition_idx(int position_idx) {
        this.position_idx = position_idx;
    }

    public void setPosition_name(String position_name) {
        this.position_name = position_name;
    }

    public void setEmpl_profile(String empl_profile) {
        this.empl_profile = empl_profile;
    }

    public void setAppr_date(LocalDateTime appr_date) {
        this.appr_date = appr_date;
    }

}
