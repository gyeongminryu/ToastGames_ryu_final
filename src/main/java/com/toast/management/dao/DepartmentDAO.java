package com.toast.management.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.toast.management.dto.DepartmentDTO;
import com.toast.management.dto.DutyDTO;
import com.toast.management.dto.PositionDTO;

@Mapper
public interface DepartmentDAO {

	int organizationAdd(Map<String, String> param);

	List<DepartmentDTO> getdept();

	List<PositionDTO> getposi();

	List<DutyDTO> getduty();



}
