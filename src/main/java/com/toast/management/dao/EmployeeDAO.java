package com.toast.management.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmployeeDAO {

	int employeeAdd(Map<String, String> param);
	
	// 직원 등록시 첨부 파일 저장
	// void employeefileWrite(String new_filename, String ori_filename, String file_key);
	
}
