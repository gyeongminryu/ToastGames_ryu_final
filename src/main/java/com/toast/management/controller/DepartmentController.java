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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.toast.management.dto.CompInfo;
import com.toast.management.dto.DepartmentDTO;
import com.toast.management.dto.DeptDetailMemberDTO;
import com.toast.management.dto.DeptHistoryDTO;
import com.toast.management.dto.DeptInfoTreeDTO;
import com.toast.management.dto.DutyDTO;
import com.toast.management.dto.EmployeeDTO;
import com.toast.management.dto.EmployeeDetailDTO;
import com.toast.management.dto.PositionDTO;
import com.toast.management.service.DepartmentService;
import com.toast.management.service.EmployeeService;
import com.toast.member.dto.FileDTO;

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
	
	@GetMapping(value="/appo_name_list.ajax") // 직급 직책 부서명 가져오기
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
	
	@GetMapping(value="/appo_name_high_list.ajax") // 직급 직책 부서명 가져오기
	@ResponseBody
	public Map<String, Object> apponamehighlist(){
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<DutyDTO> dudy = new ArrayList<>();
		List<PositionDTO> posi = new ArrayList<>();
		List<DepartmentDTO> dept = new ArrayList<>();
		
		dudy = departmentService.getdudy();
		posi = departmentService.getposi();
		dept = departmentService.getdepthigh();
		map.put("dept", dept);
		map.put("posi", posi);
		map.put("dudy", dudy);
				
		return map;
	}
	
	@GetMapping(value="/dept_list.ajax") // 부서 선택시 리스트 나열
	@ResponseBody
	public Map<String, Object> deptlist(){

		Map<String, Object> map = new HashMap<String, Object>();
		List<DepartmentDTO> dept = new ArrayList<>();
		dept = departmentService.getdept();
		map.put("dept", dept);	
		
		return map;
	}
	
	@GetMapping(value="/dept_high_list.ajax") // 부서 선택시 리스트 나열
	@ResponseBody
	public Map<String, Object> depthighlist(){

		Map<String, Object> map = new HashMap<String, Object>();
		List<DepartmentDTO> dept = new ArrayList<>();
		dept = departmentService.getdepthigh();
		map.put("dept", dept);	
		
		return map;
	}
	
	@GetMapping(value="/organization_update.go")
	public String organizationUpdateGo(@RequestParam String dept_idx,Model model) {
		
		DepartmentDTO dept = new DepartmentDTO();
		
		dept = departmentService.getdeptinfo(dept_idx);
		
		model.addAttribute("dept",dept);
		
		return "organization_update";
	}
	
	@PostMapping(value="/organization_update.do")
	public String organizationUpdateDo(@RequestParam Map<String,String> param) {
	
		departmentService.organizationUpdate(param);
	
		
		return "organization_update";
	}
	
	@GetMapping(value="/organization_list.go")
	public String organizationTreeGo(Model model) {
		
	
		
	//	departmentService.organizationTree();	
	//	model.addAttribute("treeinfo",deptlist);
		
		return "organization_list";
	}
	
	@GetMapping(value="/dept_tree_list.ajax") // 부서,부서장이름,부서장직책,부서원
	@ResponseBody
	public Map<String, Object> deptTreelist(){
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<DeptInfoTreeDTO> dept = new ArrayList<>();
		dept = departmentService.getdeptTree();
		map.put("deptlist", dept);	
		
		return map;
	}
	
	@GetMapping(value="/organization_detail.go")
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
	
	@GetMapping(value="/search_dept_member.ajax")
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

	@GetMapping(value="/companyinfo_detail.go")
	public String companyinfoGo(Model model) {

		CompInfo comp_info = departmentService.getcompinfo();
		int	ceo_idx =	comp_info.getCeo_idx();
		String file_key = comp_info.getFile_key();
		// 회사정보 테이블에서 사장 이름 가져오기
		DeptDetailMemberDTO ceo_info = departmentService.getemplinfo(ceo_idx);
		List<FileDTO> file_list = departmentService.getcompfile(file_key);
		
		model.addAttribute("comp_info",comp_info);
		model.addAttribute("ceo_info",ceo_info);
		 model.addAttribute("file", file_list);
		return "companyinfo_detail";
	}
	
	@GetMapping(value="/companyinfo.do")
	public String companyinfoDo(@RequestParam Map<String,String> param) {

		
		return "companyinfo";
	}
	
	@GetMapping(value="/companyinfo_update.go")
	public String companyinfoUpdateGo(Model model) {
	
		CompInfo comp_info = departmentService.getcompinfo();
		String file_key = comp_info.getFile_key();
		List<FileDTO> file_list = departmentService.getcompfile(file_key);
		if(comp_info != null) {
			model.addAttribute("comp_info",comp_info);
			int	ceo_idx =	comp_info.getCeo_idx();
			if(ceo_idx != 0) {
				// 회사정보 테이블에서 사장 정보 가져오기
				DeptDetailMemberDTO ceo_info = departmentService.getemplinfo(ceo_idx);
				model.addAttribute("ceo_info",ceo_info);
				}
				// 직원 전체 리스트 가져오기
		}
		model.addAttribute("file", file_list);
		return "companyinfo_update";
	}
	
	@PostMapping(value="/companyinfo_update.do")
	public String companyinfoUpdateDo(@RequestParam Map<String,String> param) {
	
		departmentService.companyinfoUpdateDo(param);
		logger.info("ceo_idx : "+ param.get("ceo_idx"));
		
		return "redirect:/companyinfo_detail.go";
	}
	
	@PostMapping(value="/company_stamp.do")
	public String compStampUpload(@RequestParam(value ="singleFile", required = false) MultipartFile singleFile) {
		
		departmentService.compStampUpload(singleFile);
		
		
		return "redirect:/companyinfo_update.go";
	}
	
		@PostMapping(value="/comp_file_upload.do")
		public String compFileUpload(@RequestParam(value ="files", required = false) MultipartFile[] files) {
			
			CompInfo comp_info = departmentService.getcompinfo();
			String file_key =	comp_info.getFile_key();
			
			departmentService.compFileUpload(files,file_key);
			return "redirect:/companyinfo_detail.go";
		}
		
		// 파일 삭제
		@GetMapping(value="/comp_file_del.do/{new_filename}")
		public String compFileDel(@PathVariable String new_filename) {
			String page = "";
			boolean isDeleted = employeeService.emplFileDel(new_filename);
			logger.info("comp_filenew_filename : "+new_filename);
			
			return "redirect:/companyinfo_update.go";
		}
		
		// 회사 직인파일 삭제 comp_stamp_del.do
		@GetMapping(value="/comp_stamp_del.do/{new_filename}")
		public String compStampDel(@PathVariable String new_filename) {
			String page = "";
			boolean isDeleted = departmentService.compStampDel(new_filename);
			
			
			return "redirect:/companyinfo_update.go";
		}
		
		@GetMapping(value="/get_dept_list.ajax")
		@ResponseBody
		public Map<String,Object> getdeptlist(){
			
			Map<String,Object> dept_list =	departmentService.getdeptlist();
			
			return dept_list;
		}
		
		@GetMapping(value="/get_dept_members.ajax")
		@ResponseBody
		public List<EmployeeDetailDTO> getDeptMembers(@RequestParam String dept_idx){
			
			List<EmployeeDetailDTO> dept_member_list = departmentService.getDeptMembers(dept_idx);
			
			return dept_member_list;
		}
		
}
