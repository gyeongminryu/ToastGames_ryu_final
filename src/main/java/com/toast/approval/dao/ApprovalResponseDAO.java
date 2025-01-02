package com.toast.approval.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ApprovalResponseDAO {
    int update_appr_content(String doc_content, String doc_idx);
    int update_next_appr(String line_order, String doc_idx);
}
