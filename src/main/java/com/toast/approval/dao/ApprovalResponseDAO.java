package com.toast.approval.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ApprovalResponseDAO {
    int update_appr_content(String doc_content, String doc_idx);

    int count_update_next_appr(String line_order, String doc_idx);

    int update_next_appr(String line_order, String doc_idx);

    int update_my_approval_state(int empl_idx, String doc_idx, String formatted_date);

    int appr_reject_state(String doc_idx, int empl_idx, String reject_reason);

    int count_top_line_order(String doc_idx, String line_order);

    int update_top_line_order(String doc_idx, String line_order);
}
