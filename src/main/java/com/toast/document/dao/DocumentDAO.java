package com.toast.document.dao;

import com.toast.document.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DocumentDAO {

    // 문서 목록
    int findPresident();
    List<DocumentDeptDTO> depList(int dept_depth, int dept_high);

    int allCount(int cnt, String opt, String keyword, String dept1, String dept2);
    int countIdx(String opt, String keyword, String dept1, String dept2);
    List<DocumentDTO> list(int limit, int offset, String opt, String keyword, String dept1, String dept2, List<Integer> dept);
    List<Integer> line(int doc_idx);
    List<Integer> deptList(int dept_idx);

    //문서 열람
    DocumentDTO detail(int doc_idx);
    List<DocumentLineDTO> appr(int doc_idx);
    List<DocumentRefDTO> refer(int doc_idx);
    List<DocumentFileDTO> file(int doc_idx);

}
