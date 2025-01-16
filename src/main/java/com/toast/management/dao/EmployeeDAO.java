package com.toast.management.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.toast.management.dto.AppointmentDTO;
import com.toast.management.dto.EmployeeDTO;
import com.toast.management.dto.EmployeeDetailDTO;
import com.toast.management.dto.MainFileDTO;
import com.toast.member.dto.FileDTO;

@Mapper
public interface EmployeeDAO {

	int employeeAdd(Map<String, String> param);

	EmployeeDTO employeeDetail(String empl_idx);

	AppointmentDTO employeeAppolast(String empl_idx);

	List<AppointmentDTO> employeeAppoList(String empl_idx);

	List<MainFileDTO> employeeFile(String file_key);

	int employeeAppoDo(String empl_idx, String dept_idx, String position_idx, String duty_idx, String movein_date,String empl_job);

	int employeeChangeDo(String empl_idx, String statement_idx);

	int employeeResigDo(String empl_idx, String statement_idx);

	int employeeTransfer(int appo_idx,String movein_date);

	int deptHeadAdd(String dept_idx, String empl_idx);

	int deptheadcheck(String empl_idx);

	int deptheadmoveout(String empl_idx);

	List<FileDTO> getemplUploadedFiles(String file_key);

	int emplStampUpload(String newFileName,String empl_idx);

	int emplFileDel(String new_filename);

	int employeeDutyUpdate(String empl_idx, String empl_duty);

	List<EmployeeDetailDTO> getEmployeeList();

	void emplfileUpload(FileDTO fileDTO);

	List<EmployeeDetailDTO> getStaffList(String dept_idx);

	List<EmployeeDetailDTO> getFilteredStaffList(String dept_idx, String searchKey, String searchValue);

	EmployeeDetailDTO getStaffDetail(String empl_idx);

	List<EmployeeDetailDTO> emplAllList();

	List<EmployeeDetailDTO> emplPreAllList();

	List<EmployeeDetailDTO> emplresignAllList();

	Double getweekWorkRecord(String empl_idx);

	boolean isIdDuplicate(String emplId);

	

	

	
	
	// 직원 등록시 첨부 파일 저장
	// void employeefileWrite(String new_filename, String ori_filename, String file_key);
	
}
