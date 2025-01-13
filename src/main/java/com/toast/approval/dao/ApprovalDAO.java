package com.toast.approval.dao;

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

    List<Map<String, Object>> approval_company_get_allempl();


    int empl_count(int empl_idx, int doc_state);
    int receiver_empl_count(int empl_idx);



    List<Map<String, Object>> get_sent_list(int param);

    Map<String, Object> get_empl_info(int empl_idx);

    int count_state(int doc_idx, int approval_state);

    String get_approval_state_time(int sent_doc_idx, int approval_state);

    int whether_final_approve(int sent_doc_idx);

    int get_read_date(int sent_doc_idx);

    List<Map<String, Object>> get_writing_list(int r_empl_idx);

    List<Map<String, Object>> get_received_list(int r_empl_idx);

    Map<String, Object> get_doc_info(int doc_idx);

    Map<String, Object> get_form_info(int doc_idx);

    List<Map<String,Object>> get_all_appr_line(int doc_idx);

    List<Map<String, Object>> get_all_refer_line(int doc_idx);

    int get_my_appr_state(int doc_idx, int empl_idx);


    int update_read_time(String read_time, int doc_idx, int empl_idx);

    String get_doc_file_key(int doc_idx);

    List<Map<String, Object>> get_file_info(String file_key);

    String get_doc_form_content(int doc_idx);

    String get_my_appr_name(int empl_idx);

    List<Map<String, Object>> get_recent_written(int empl_idx);
}
