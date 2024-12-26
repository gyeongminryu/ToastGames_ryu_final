package com.toast.approval.dao;

import com.toast.approval.dto.ApprovalDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ApprovalDAO {
    /*문서 조회 -> 옮기기*/
    List<Map<String, Object>> form_list();

    Map<String, Object> form(int idx);



    List<Map<String, Object>> highdept();

    List<Map<String, Object>> dept_allempl(int dept_idx);

    List<Map<String, Object>> form_list_searched(String search_val);

    List<Map<String, Object>> show_team(int dept_idx);

    List<Map<String, Object>> team_allempl(int team_idx);

    int request_empl_count(int empl_idx);

    List<Map<String, Object>> get_sent_list(int empl_idx);
}
