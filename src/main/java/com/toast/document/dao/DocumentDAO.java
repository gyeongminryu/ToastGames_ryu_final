package com.toast.document.dao;

import com.toast.document.dto.DocumentDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DocumentDAO {

    // 문서 목록
    int getEmplIdx(String empl_id);
    int getDeptIdx(int empl_idx);
    int allCount(int cnt);
    int countIdx();
    List<DocumentDTO> list(int limit, int offset);
    List<Integer> line(int doc_idx);
    List<Integer> deptList(int dept_idx);

}
