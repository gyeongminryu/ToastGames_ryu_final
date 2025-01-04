package com.toast.document.dao;

import com.toast.document.dto.ManageFormDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ManageFormDAO {

    // 문서 양식 목록
    int allCount(int cnt);
    int countIdx();
    List<ManageFormDTO> list(int limit, int offset);

}
