package com.toast.management.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.toast.dataconfig.DataConfig;
import com.toast.management.dto.DepartmentDTO;
import com.toast.management.dto.DutyDTO;
import com.toast.management.dto.PositionDTO;
import com.toast.management.service.EmployeeService;



@Controller
public class EmployeeController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PasswordEncoder encoder;
	
	

	private final EmployeeService employeeService;
	
	public EmployeeController(EmployeeService employeeService) {
		this.employeeService = employeeService;
	
	}
	
	@GetMapping(value="/employeeAdd.go")
	public String employeeAddGo(Model model) {
		
		//	employeeService.getbankname();
		
		// model.addAllAttributes(null);
		
		return "employee_add";
	}
	
	@PostMapping(value="/employeeAdd.do")
	public String employeeAddDo(@RequestParam Map<String,String> param) {
	
		employeeService.employeeAdd(param);
		
		return "";
	}
	
	@GetMapping(value="/employeeDetail.go")
	public String employeeDetailGo(@RequestParam String empl_idx,Model model) {
		
		//	employeeService.getbankname();
		// model.addAllAttributes(null);
	
		employeeService.employeeDetail(empl_idx,model);
		
		return "employee_detail";
	}
	
	@PostMapping(value="/employeeAppo.do")
	public String employeeAppoDo(@RequestParam String empl_idx,String dept_idx,String position_idx,String duty_idx,String movein_date) {
		
		logger.info(empl_idx);
		logger.info(dept_idx);
		logger.info(position_idx);
		logger.info(duty_idx);
		logger.info(movein_date);
		
		// 처리한사원번호 >> 세션추가하고 세션아이디넣기 > 세션아이디로 사원번호 가져오기
		employeeService.employeeAppoDo(empl_idx,dept_idx,position_idx,duty_idx,movein_date);
		
		return "redirect:/employee_detail";
	}
	
	@PostMapping(value="/employeeChange.do")
	public String employeeChangeDo(@RequestParam String empl_idx,String statement_idx) {
		
		logger.info(empl_idx);
		logger.info(statement_idx);
		
		// 처리한사원번호 >> 세션추가하고 세션아이디넣기 > 세션아이디로 사원번호 가져오기
		
		employeeService.employeeChangeDo(empl_idx,statement_idx);
		
		return "redirect:/employee_detail";
	}
	
}
