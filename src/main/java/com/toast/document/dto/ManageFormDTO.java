package com.toast.document.dto;

import org.apache.ibatis.type.Alias;

import java.time.LocalDateTime;

public class ManageFormDTO {

    // table form
    private int form_idx;
    private String form_subject;
    private String form_content;
    private int form_handler_idx;
    private String form_handler_name;
    private int form_writer_idx;
    private String form_writer_name;
    private int form_writer_dept;
    private String form_writer_dept_name;
    private int form_writer_position;
    private String form_writer_position_name;
    private LocalDateTime form_write_date;
    private int form_updater_idx;
    private String form_updater_name;
    private int form_updater_dept;
    private String form_updater_dept_name;
    private int form_updater_position;
    private String form_updater_position_name;
    private LocalDateTime form_updater_date;
    private int form_state;

    // table g_approval_line
    private int line_detail_idx;
    private int gline_order;
    private int dept_idx_1;
    private String dept_name_1;
    private int duty_idx_1;
    private String duty_name_1;
    private int dept_idx_2;
    private String dept_name_2;
    private int duty_idx_2;
    private String duty_name_2;
    private int dept_idx_3;
    private String dept_name_3;
    private int duty_idx_3;
    private String duty_name_3;

    // table department
    private int dept_high;
    private int dept_state;
    private int dept_depth;

    // Getters
    public int getForm_idx() {
        return form_idx;
    }

    public String getForm_subject() {
        return form_subject;
    }

    public String getForm_content() {
        return form_content;
    }

    public int getForm_handler_idx() {
        return form_handler_idx;
    }

    public String getForm_handler_name() {
        return form_handler_name;
    }

    public int getForm_writer_idx() {
        return form_writer_idx;
    }

    public String getForm_writer_name() {
        return form_writer_name;
    }

    public int getForm_writer_dept() {
        return form_writer_dept;
    }

    public String getForm_writer_dept_name() {
        return form_writer_dept_name;
    }

    public int getForm_writer_position() {
        return form_writer_position;
    }

    public String getForm_writer_position_name() {
        return form_writer_position_name;
    }

    public LocalDateTime getForm_write_date() {
        return form_write_date;
    }

    public int getForm_updater_idx() {
        return form_updater_idx;
    }

    public String getForm_updater_name() {
        return form_updater_name;
    }

    public int getForm_updater_dept() {
        return form_updater_dept;
    }

    public String getForm_updater_dept_name() {
        return form_updater_dept_name;
    }

    public int getForm_updater_position() {
        return form_updater_position;
    }

    public String getForm_updater_position_name() {
        return form_updater_position_name;
    }

    public LocalDateTime getForm_updater_date() {
        return form_updater_date;
    }

    public int getForm_state() {
        return form_state;
    }

    public int getLine_detail_idx() {
        return line_detail_idx;
    }

    public int getGline_order() {
        return gline_order;
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

    public int getDept_high() {
        return dept_high;
    }

    public int getDept_state() {
        return dept_state;
    }

    public int getDept_depth() {
        return dept_depth;
    }

    // Setters
    public void setForm_idx(int form_idx) {
        this.form_idx = form_idx;
    }

    public void setForm_subject(String form_subject) {
        this.form_subject = form_subject;
    }

    public void setForm_content(String form_content) {
        this.form_content = form_content;
    }

    public void setForm_handler_idx(int form_handler_idx) {
        this.form_handler_idx = form_handler_idx;
    }

    public void setForm_handler_name(String form_handler_name) {
        this.form_handler_name = form_handler_name;
    }

    public void setForm_writer_idx(int form_writer_idx) {
        this.form_writer_idx = form_writer_idx;
    }

    public void setForm_writer_name(String form_writer_name) {
        this.form_writer_name = form_writer_name;
    }

    public void setForm_writer_dept(int form_writer_dept) {
        this.form_writer_dept = form_writer_dept;
    }

    public void setForm_writer_dept_name(String form_writer_dept_name) {
        this.form_writer_dept_name = form_writer_dept_name;
    }

    public void setForm_writer_position(int form_writer_position) {
        this.form_writer_position = form_writer_position;
    }

    public void setForm_writer_position_name(String form_writer_position_name) {
        this.form_writer_position_name = form_writer_position_name;
    }

    public void setForm_write_date(LocalDateTime form_write_date) {
        this.form_write_date = form_write_date;
    }

    public void setForm_updater_idx(int form_updater_idx) {
        this.form_updater_idx = form_updater_idx;
    }

    public void setForm_updater_name(String form_updater_name) {
        this.form_updater_name = form_updater_name;
    }

    public void setForm_updater_dept(int form_updater_dept) {
        this.form_updater_dept = form_updater_dept;
    }

    public void setForm_updater_dept_name(String form_updater_dept_name) {
        this.form_updater_dept_name = form_updater_dept_name;
    }

    public void setForm_updater_position(int form_updater_position) {
        this.form_updater_position = form_updater_position;
    }

    public void setForm_updater_position_name(String form_updater_position_name) {
        this.form_updater_position_name = form_updater_position_name;
    }

    public void setForm_updater_date(LocalDateTime form_updater_date) {
        this.form_updater_date = form_updater_date;
    }

    public void setForm_state(int form_state) {
        this.form_state = form_state;
    }

    public void setLine_detail_idx(int line_detail_idx) {
        this.line_detail_idx = line_detail_idx;
    }

    public void setGline_order(int gline_order) {
        this.gline_order = gline_order;
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

    public void setDept_high(int dept_high) {
        this.dept_high = dept_high;
    }

    public void setDept_state(int dept_state) {
        this.dept_state = dept_state;
    }

    public void setDept_depth(int dept_depth) {
        this.dept_depth = dept_depth;
    }

}
