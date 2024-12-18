package com.toast.approval.dao;

import com.toast.approval.dto.ApprovalDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ApprovalDAO {
    List<Map<String, Object>> form_list();

    Map<String, Object> form(int idx);

    int doc_write(ApprovalDTO app_dto);

    Map<String, Object> doc_get(int docIdx);
}
