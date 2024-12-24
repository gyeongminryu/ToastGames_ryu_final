package com.toast.approval.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.approval.service.ApprovalService;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
public class ApprovalController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalService approvalService;
	
	public ApprovalController(ApprovalService approvalService) {
		this.approvalService = approvalService;
	}

	//결재 목록 조회 - 옮기기
	@RequestMapping(value = "/approval_writing_list.go")
	public String approval_writing_list() {
		return "approval_writing_list";
	}

	//결재 양식 목록 조회 - 옮기기
	@RequestMapping (value = "/approval_form_list.go")
	public String approval_form_list_go () {
		return "approval_form_list";
	}

	//결재 목록 양식 제목들 가져오기 - 옮기기
	@GetMapping(value = "/approval_form_list.ajax")
	@ResponseBody
	public Map<String, Object> approval_form_list() {
		Map<String, Object> data = new HashMap<>();
		data.put("list",approvalService.form_list());
		return data;
	}

	//선택한 결재 목록 양식 가져오기 - 옮기기
	@GetMapping (value = "/approval_form.ajax")
	@ResponseBody
	public Map<String, Object> approval_form(int form_idx) {
		Map<String, Object> data = approvalService.form(form_idx);
		return data;
	}










	//결재 양식 검색 기능
	@GetMapping(value = "/approval_form_search.ajax")
	@ResponseBody
	public Map<String,Object> approvalFormSearch(String search_val) {
		logger.info("컨트롤러 단 searchVal:{}", search_val);

		Map<String,Object> data = new HashMap<>();
		data.put("list",approvalService.form_list_searched(search_val));

		return data;
	}


	//결재선
	@RequestMapping (value = "/approval_list.go")
	public String approval_tree() {
		return "approval_write_line_child";
	}



	@GetMapping (value = "/approval_highdept.ajax")
	@ResponseBody
	public Map<String,Object> approval_highdept (){
		Map<String,Object> data = new HashMap<>();
		data.put("dept",approvalService.highdept());
		return data;
	}

	//부서의 모든 사원 가져오기
	@GetMapping(value = "/approval_dept_allempl.ajax")
	@ResponseBody
	public Map<String,Object> approval_alldept_allempl (int dept_idx){
		Map<String,Object> data = new HashMap<>();
		data.put("empl",approvalService.dept_allempl(dept_idx));
		return data;
	}

	//부서 아래의 모든 팀 가져오기
	@GetMapping (value = "/approval_show_team.ajax")
	@ResponseBody
	public Map<String,Object> approval_show_team (int dept_idx){
		Map<String,Object> data = new HashMap<>();
		data.put("dept",approvalService.show_team(dept_idx));
		return data;
	}

	//팀 내 모든 팀원 가져오기
	@GetMapping (value = "/approval_team_allempl.ajax")
	@ResponseBody
	public Map<String,Object> approval_team_allempl (int team_idx){
		Map<String,Object> data = new HashMap<>();
		data.put("empl",approvalService.team_allempl(team_idx));

		return data;
	}

}
