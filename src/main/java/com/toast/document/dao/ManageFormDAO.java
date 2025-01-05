package com.toast.document.dao;

import com.toast.document.dto.ManageFormDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ManageFormDAO {

    // 문서 양식 목록
    int allCount(int cnt, String opt, String keyword);
    int countIdx(String opt, String keyword);
    List<ManageFormDTO> list(int limit, int offset, String opt, String keyword, String sort);
    String preview(int form_idx);

    // 문서 양식 상세보기
    ManageFormDTO detail(int form_idx);

    // 문서 양식 작성하기
    int getIdx(String empl_id);
    int getDeptIdx(int empl_idx);
    int getPositIdx(int empl_idx);
    int write(ManageFormDTO dto);

    // 문서 양식 수정하기
    int update(ManageFormDTO dto);
}
