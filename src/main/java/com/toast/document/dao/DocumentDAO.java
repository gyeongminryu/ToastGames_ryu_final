package com.toast.document.dao;

import com.toast.document.dto.DocumentDTO;
import com.toast.document.dto.DocumentLineDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DocumentDAO {

    // 문서 목록
    int allCount(int cnt, String opt, String keyword);
    int countIdx(String opt, String keyword);
    List<DocumentDTO> list(int limit, int offset, String opt, String keyword);
    List<Integer> line(int doc_idx);
    List<Integer> deptList(int dept_idx);

    //문서 열람
    DocumentDTO detail(int doc_idx);
    List<DocumentLineDTO> appr(int doc_idx);

}
