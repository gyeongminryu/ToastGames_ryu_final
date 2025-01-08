package com.toast.employee_add.dao;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface EmployeeAddDAO {
    //int saveExcel(List<Map<String, Object>> dataList);
    int empl_add_all(List<Map<String, Object>> list);

}
