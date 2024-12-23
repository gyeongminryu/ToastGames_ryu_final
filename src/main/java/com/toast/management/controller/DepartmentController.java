package com.toast.management.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.toast.management.dto.DepartmentDTO;
import com.toast.management.dto.DeptDetailMemberDTO;
import com.toast.management.dto.DeptHistoryDTO;
import com.toast.management.dto.DeptInfoTreeDTO;
import com.toast.management.dto.DutyDTO;
import com.toast.management.dto.PositionDTO;
import com.toast.management.service.DepartmentService;
import com.toast.management.service.EmployeeService;

@Controller
public class DepartmentController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final DepartmentService departmentService;
	
	@Autowired EmployeeService employeeService;
	
	public DepartmentController(DepartmentService departmentService) {
		this.departmentService = departmentService;
	}
	
	// 부서 추가하러 가기
	@GetMapping(value="/organization.go")
	public String organizationAddGo() {
		
		return "organization_add";
	}
	
	// 부서 추가하기
	@PostMapping(value="/organization.do")
	public String organizationAdd(@RequestParam Map<String,String> param) {
		String dept_depth = "";
		String dept_high =	param.get("dept_high");
		DepartmentDTO deptinfo =departmentService.getdeptinfo(dept_high);
		dept_depth = deptinfo.getDept_depth();
		int int_dept_depth =	Integer.parseInt(dept_depth);
		int_dept_depth += 1;
		dept_depth = String.valueOf(int_dept_depth);
		param.put("dept_depth", dept_depth);
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
	
	@GetMapping(value="/deptlist.ajax") // 부서 선택시 리스트 나열
	@ResponseBody
	public Map<String, Object> deptlist(){

		Map<String, Object> map = new HashMap<String, Object>();
		List<DepartmentDTO> dept = new ArrayList<>();
		dept = departmentService.getdept();
		map.put("dept", dept);	
		
		return map;
	}
	
	@GetMapping(value="/organizationUpdate.go")
	public String organizationUpdateGo(@RequestParam String dept_idx,Model model) {
		
		DepartmentDTO dept = new DepartmentDTO();
		
		dept = departmentService.getdeptinfo(dept_idx);
		
		model.addAttribute("dept",dept);
		
		return "organization_update";
	}
	
	@PostMapping(value="/organizationUpdate.do")
	public String organizationUpdateDo(@RequestParam Map<String,String> param) {
	
		departmentService.organizationUpdate(param);
	
		
		return "organization_update";
	}
	
	@GetMapping(value="/organizationTree.go")
	public String organizationTreeGo(Model model) {
		
	
		
	//	departmentService.organizationTree();	
	//	model.addAttribute("treeinfo",deptlist);
		
		return "organization_tree";
	}
	
	@GetMapping(value="/deptTreelist.ajax") // 부서,부서장이름,부서장직책,부서원
	@ResponseBody
	public Map<String, Object> deptTreelist(){
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<DeptInfoTreeDTO> dept = new ArrayList<>();
		dept = departmentService.getdeptTree();
		map.put("deptlist", dept);	
		
		return map;
	}
	
	@GetMapping(value="/organizationDetail.go")
	public String organizationDetailGo(@RequestParam String dept_idx,Model model) {
		
		departmentService.organizationDetailGo(dept_idx,model);
		
		// 부서장 히스토리
		List<DeptHistoryDTO> dept_his = departmentService.getdeptheadhistory(dept_idx);
		model.addAttribute("depthis",dept_his);
		/*
		// 부서 히스토리 정보
		List<DeptHistoryDTO> dept_his = departmentService.getdeptheadhistory(dept_idx);
		
		// 부서정보 가져오기 - 부서명 부서idx 부서직무 부서주소 부서상태
		DepartmentDTO dept =departmentService.getdeptinfo(dept_idx);
		int high_int_idx = dept.getDept_high();
		String high_dept_idx =	String.valueOf(high_int_idx);
		// 부서장 이름 직책 직급 가져오기
		employeeService.employeeDetail(high_dept_idx, model);
		// 상위 부서명 가져오기
		DepartmentDTO high_dept = departmentService.getdeptinfo(high_dept_idx);
		// 사원 리스트
		
	//	departmentService.organizationTree();	
		model.addAttribute("deptinfo",dept);
		model.addAttribute("depthis",dept_his);
		model.addAttribute("highdeptinfo",high_dept);
		*/
		return "organization_detail";
	}
	
	@GetMapping(value="/searchDeptMember.ajax")
	@ResponseBody
	public Map<String, Object>searchDeptMember(@RequestParam(required = false) String emplName,
            @RequestParam(required = false) String cmpEmail, String dept_idx){
		logger.info(dept_idx+" = dept_idx, cmpemail = "+cmpEmail +" emplName = "+emplName);
		Map<String, Object> map = new HashMap<String, Object>();
		List<DeptDetailMemberDTO> dept_member = new ArrayList<>();
		dept_member = departmentService.searchDeptMember(emplName,cmpEmail,dept_idx);
		map.put("searchmember", dept_member);	
		
		return map;
	}



}
