package com.toast.notify.dao;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface NotiDAO {

    int approval_noti_insert(Map<String, Object> parameter);
    List<Map<String, Object>> get_all_noti(int empl_idx);

    int delete_noti_one(String noti_idx);

    int delete_noti_all(String empl_idx);

    //여기서부터 작업
    Map<String,Object> get_empl_dept_info(int empl_idx);

    String get_dept_name(Object dept_idx);

    String approval_get_empl_team_name(int empl_idx);
}
