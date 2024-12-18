package com.toast.management.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.toast.management.dto.DepartmentDTO;
import com.toast.management.dto.DutyDTO;
import com.toast.management.dto.PositionDTO;
import com.toast.management.service.DepartmentService;

@Controller
public class DepartmentController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final DepartmentService departmentService;
	
	public DepartmentController(DepartmentService departmentService) {
		this.departmentService = departmentService;
	}
	
	@GetMapping(value="/organization.go")
	public String organizationAddGo() {
		
		return "organization_add";
	}
	
	@PostMapping(value="/organization.do")
	public String organizationAdd(@RequestParam Map<String,String> param) {
		departmentService.organizationAdd(param);
		return "";
	}
	
	@GetMapping(value="/apponamelist.ajax") // 직급 직책 부서명 가져오기
	@ResponseBody
	public Map<String, Object> apponamelist(){
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<DutyDTO> dudy = new ArrayList<>();
		List<PositionDTO> posi = new ArrayList<>();
		List<DepartmentDTO> dept = new ArrayList<>();
		
		dudy = departmentService.getdudy();
		posi = departmentService.getposi();
		dept = departmentService.getdept();
		map.put("dept", dept);
		map.put("posi", posi);
		map.put("dudy", dudy);
		
		
		return map;
	}
}
