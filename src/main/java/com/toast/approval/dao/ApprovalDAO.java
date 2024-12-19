package com.toast.approval.dao;

import com.toast.approval.dto.ApprovalDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ApprovalDAO {
    List<Map<String, Object>> form_list();

    Map<String, Object> form(int idx);

    int doc_write_initial(ApprovalDTO app_dto);

    Map<String, Object> doc_get(int doc_idx);

    String doc_empl_name(int empl_idx);

    int doc_write(String doc_idx, String doc_end_date, String doc_subject, String doc_content_sub, String doc_content, String doc_write_date);

    int approval_doc_file_write(String doc_idx, String ori_filename, String new_filename, String file_key, int empl_idx, String file_type, String file_addr);

    int doc_dept_idx(int empl_idx);
}
