package com.toast.document.dao;

import com.toast.document.dto.ManageFormDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ManageFormDAO {

    // 문서 양식 목록
    int allCount(int cnt, String opt, String keyword, String sort, int form_writer_idx);
    int countIdx(String opt, String keyword, String sort, int form_writer_idx);
    List<ManageFormDTO> list(int limit, int offset, String opt, String keyword, String sort, int form_writer_idx);
    String preview(int form_idx);

    // 문서 양식 상세보기
    ManageFormDTO detail(int form_idx);

    // 문서 양식 작성하기
    int getPositIdx(int empl_idx);
    int write(ManageFormDTO dto);
    int setLine1(int form_idx);
    int setLine2(int form_idx);
    int setLine3(int form_idx);

    // 문서 양식 수정하기
    int update(ManageFormDTO dto);

    // 결재선 설정하기
    List<ManageFormDTO> callDept(int dept_high);
    String callDeptName(int dept_idx);
    void setLine(Map<String, Integer> params);

    // 작성중인 문서 양식 등록하기
    void register(int form_idx);

    // 작성중인 문서 양식 삭제하기
    void deleteForm(int form_idx);
    void deleteLines(int form_idx);

    // 등록한 문서 양식 삭제하기 (사용하지 않기)
    void disuse(int form_idx);

    // 문서 양식 복사하기
    String copySubject(int form_idx);
    String copyContent(int form_idx);
}
