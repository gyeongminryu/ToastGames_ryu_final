package com.toast.approval.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.approval.service.ApprovalService;
import org.springframework.ui.Model;
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
		return "approval_list";
	}


	//수정
	@GetMapping (value = "/approval_highdept.ajax")
	@ResponseBody
	public Map<String,Object> approval_highdept (){
		Map<String,Object> data = new HashMap<>();
		data.put("dept",approvalService.highdept());
		return data;
	}

	@GetMapping(value = "/approval_dept_allempl.ajax")
	@ResponseBody
	public Map<String,Object> approval_alldept_allempl (int dept_idx){
		Map<String,Object> data = new HashMap<>();
		data.put("empl",approvalService.dept_allempl(dept_idx));
		return data;
	}


}
