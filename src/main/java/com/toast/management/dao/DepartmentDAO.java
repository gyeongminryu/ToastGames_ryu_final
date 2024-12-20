package com.toast.management.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.toast.management.dto.DepartmentDTO;
import com.toast.management.dto.DeptDetailMemberDTO;
import com.toast.management.dto.DeptHistoryDTO;
import com.toast.management.dto.DeptInfoTreeDTO;
import com.toast.management.dto.DutyDTO;
import com.toast.management.dto.PositionDTO;


@Mapper
public interface DepartmentDAO {

	int organizationAdd(Map<String, String> param);

	List<DepartmentDTO> getdept();

	List<PositionDTO> getposi();

	List<DutyDTO> getduty();

	DepartmentDTO getdeptinfo(String dept_idx);

	int organizationUpdate(Map<String, String> param);

	List<DeptInfoTreeDTO> getdeptTree();

	List<Map<String, Object>> getDeptMemberCounts();

	List<DeptHistoryDTO> getdeptheadhistory(String dept_idx);

	DeptHistoryDTO getfirstdate(String dept_idx);

	List<DeptDetailMemberDTO> getdeptmeberlist(String dept_idx);

	List<DeptDetailMemberDTO> searchDeptMember(String emplName, String cmpEmail, String dept_idx);

	

	 

	//	int organizationDudyAdd(String duty_name);



}
