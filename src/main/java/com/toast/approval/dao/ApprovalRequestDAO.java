package com.toast.approval.dao;

import com.toast.approval.dto.ApprovalRequestDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ApprovalRequestDAO {
    /*문서 조회 -> 옮기기*/
    List<Map<String, Object>> form_list();

    Map<String, Object> form(int idx);

    /*저장*/
    int doc_write_initial(ApprovalRequestDTO app_dto);

    Map<String, Object> doc_get(int doc_idx);

    //폼 양식에 저장할 값 가져오기
    String doc_empl_name(int empl_idx);
    int doc_dept_idx(int empl_idx);


    //문서 작성, 문서 파일 작성,문서 파일키 작성
    int doc_write(String doc_idx, String doc_end_date, String doc_subject, String doc_content_sub, String doc_content, String doc_write_date);

    int approval_doc_file_write(String doc_idx, String ori_filename, String new_filename, String file_key, int empl_idx, String file_type, String file_addr);

    int doc_write_file_key(String doc_idx, String file_key);


    //이전에 저장된 파일 삭제하기 위함
    int doc_saved_filekey_count(String doc_idx);

    String doc_saved_filekey(String docIdx);

    List<Map<String,String>> get_previous_file_addr(String prev_file_key);

    void delete_previous_files(String previous_filekey);

    void doc_filekey_delete(String doc_idx);








 /*   //임시저장 혹은 수정할 때 이전 파일 삭제
    int find_previous_file(String docIdx);
    void delete_previous_file(String file_key);*/

    /*상신*/

}
