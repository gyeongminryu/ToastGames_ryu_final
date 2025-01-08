package com.toast.document.dto;

public class DocumentRefDTO {

    // reference
    private int ref_idx;
    private int ref_doc_idx;
    private int ref_empl_idx;
    private String empl_name;

    // reference_department
    private int ref_dept_idx;
    private String ref_dept_name;

    // Getter
    public int getRef_idx() {
        return ref_idx;
    }

    public int getRef_doc_idx() {
        return ref_doc_idx;
    }

    public int getRef_empl_idx() {
        return ref_empl_idx;
    }

    public String getEmpl_name() {
        return empl_name;
    }

    public int getRef_dept_idx() {
        return ref_dept_idx;
    }

    public String getRef_dept_name() {
        return ref_dept_name;
    }

    // Setter
    public void setRef_idx(int ref_idx) {
        this.ref_idx = ref_idx;
    }

    public void setRef_doc_idx(int ref_doc_idx) {
        this.ref_doc_idx = ref_doc_idx;
    }

    public void setRef_empl_idx(int ref_empl_idx) {
        this.ref_empl_idx = ref_empl_idx;
    }

    public void setEmpl_name(String empl_name) {
        this.empl_name = empl_name;
    }

    public void setRef_dept_idx(int ref_dept_idx) {
        this.ref_dept_idx = ref_dept_idx;
    }

    public void setRef_dept_name(String ref_dept_name) {
        this.ref_dept_name = ref_dept_name;
    }

}
