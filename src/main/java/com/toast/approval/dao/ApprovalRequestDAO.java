package com.toast.approval.dao;

import com.toast.approval.dto.ApprovalRequestDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ApprovalRequestDAO {



    /*저장*/
    int doc_write_initial(ApprovalRequestDTO app_dto);

    Map<String, Object> doc_get(int doc_idx);

    //폼 양식에 저장할 값 가져오기
    String doc_empl_name(int empl_idx);
    Map<String,Object> doc_dept_info(int empl_idx);


    //문서 작성, 문서 파일 작성,문서 파일키 작성
   // int doc_write(String doc_idx, String doc_end_date, String doc_subject, String doc_content_sub, String doc_content, String doc_write_date);
    int doc_write(Map<String, String> param);


    int approval_doc_file_write(String doc_idx, String ori_filename, String new_filename, String file_key, int empl_idx, String file_type, String file_addr, String file_size_format);

    int doc_write_file_key(String doc_idx, String file_key);


    //이전에 저장된 파일 삭제하기 위함
    int doc_saved_filekey_count(String doc_idx);

    String doc_saved_filekey(String doc_idx);

    List<Map<String,String>> get_previous_file_addr(String prev_file_key);

    void delete_previous_files(String previous_filekey);

    void doc_filekey_delete(String doc_idx);


    int show_prev_line_order(int line_order, String doc_idx);

    //결재선 임시 저장 로직

    void save_approval_line_initial(Map<String,Object> g_approval_line);

    int save_approval_line(Map<String, Object> data);

    int delete_approval_line(Map<String, Object> data);

    int update_approval_line(Map<String, Object> data);




    List<Map<String, Object>> get_g_approval_line(int formIdx);
    //결재자 이름 및 직책 idx 가져오기

    //Map<String,Object> get_approval_empl_idx(int dept_idx,int form_idx, int step);

    Map<String,Object> get_head_info();

    List<Map<String, Object>> doc_appr_line_get(int doc_idx);

    List<Map<String,Object>> doc_refer_line_get(int doc_idx);


    int prev_refer_exists(String doc_idx);

    int delete_prev_refer(String doc_idx);

    int save_refer_line(int referrer_idx,String doc_idx);



    int get_high_dept_count(int dept_idx);

    int get_high_dept_head_count(int high_dept_idx, int duty_idx);

    Map<String,Object> get_high_dept_head(int high_dept_idx, int duty_idx);

    int get_team_head_count(int dept_idx, int duty_idx);

    Map<String, Object> get_team_head(int dept_idx, int duty_idx);

    int get_high_dept(int deptIdx);

    int delete_all_approval_line(String doc_idx);

    int delete_doc(String doc_idx);

    Map<String, Object> final_doc_get(String doc_idx);

    int request(Map<String, String> param);

    int update_approval_doc_state(String doc_idx);

    int update_first_approval_line(String doc_idx);

    //알림 위해 첫번째 결재 라인의 사람 가져오기
    int get_first_approval_line(String doc_idx);

    Map<String, Object> get_empl_info(int empl_idx);
    //확인하기

    int doc_line_changed_update(Map<String, Object> lineEmplInfo);

    int copy_doc_form(ApprovalRequestDTO app_dto);

    String get_form_content(int form_idx);


    Map<String, Object> get_doc_info(int doc_idx);

    List<Map<String,Object>> get_doc_line_infos(int doc_idx);

    //여기서부터 작업

    int copy_doc_info(ApprovalRequestDTO appDto);

    void copy_doc_line_info(Map<String, Object> doc_line_info);

    
    //이거 해야함
    Map<String, Object> get_appr_selected_info(int approval_dept_idx, int duty_idx);


    int count_appr_selected(int approval_dept_idx, int duty_idx);

    int appr_line_exists(int doc_idx);

    List<Map<String,Object>> get_files(String file_key);

    int approval_file_delete(String file_idx);

    String get_approval_file_name(String file_idx);
}
