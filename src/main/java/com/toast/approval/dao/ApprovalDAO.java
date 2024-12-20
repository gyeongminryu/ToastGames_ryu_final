package com.toast.approval.dao;

import com.toast.approval.dto.ApprovalDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ApprovalDAO {


    List<Map<String, Object>> highdept();

    List<Map<String, Object>> dept_allempl(int dept_idx);

    List<Map<String, Object>> form_list_searched(String search_val);
}
