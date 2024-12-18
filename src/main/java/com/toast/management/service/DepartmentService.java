package com.toast.management.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.management.dao.DepartmentDAO;
import com.toast.management.dto.DepartmentDTO;
import com.toast.management.dto.DutyDTO;
import com.toast.management.dto.PositionDTO;

@Service
public class DepartmentService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final DepartmentDAO departmentDAO;
	
	public DepartmentService(DepartmentDAO departmentDAO) {
		this.departmentDAO = departmentDAO;
	}

	public void organizationAdd(Map<String, String> param) {
		String dept_high =	param.get("dept_high");
		logger.info("dept_high : ",dept_high);
		departmentDAO.organizationAdd(param);
	
	}

	public List<DutyDTO> getdudy() {
		
		return departmentDAO.getduty();
	}

	public List<PositionDTO> getposi() {
		
		return departmentDAO.getposi();
	}

	public List<DepartmentDTO> getdept() {
		
		return departmentDAO.getdept();
	}

}
