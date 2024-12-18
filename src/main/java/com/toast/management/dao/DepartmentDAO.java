package com.toast.management.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DepartmentDAO {

	int organizationAdd(Map<String, String> param);

}
