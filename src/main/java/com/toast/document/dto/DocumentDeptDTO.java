package com.toast.document.dto;

import java.time.LocalDateTime;

public class DocumentDeptDTO {

    // department
    private int dept_idx;
    private String dept_name;
    private int dept_high;
    private int dept_state;
    private int dept_depth;

    // Getter
    public int getDept_idx() {
        return dept_idx;
    }

    public String getDept_name() {
        return dept_name;
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

    // Setter
    public void setDept_idx(int dept_idx) {
        this.dept_idx = dept_idx;
    }

    public void setDept_name(String dept_name) {
        this.dept_name = dept_name;
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
