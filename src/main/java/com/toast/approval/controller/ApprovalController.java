package com.toast.approval.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.approval.service.ApprovalService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class ApprovalController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalService approvalService;
	
	public ApprovalController(ApprovalService approvalService) {
		this.approvalService = approvalService;
	}
	//결재 목록 조회
	@RequestMapping(value = "/approval_writing_list.go")
	public String approval_writing_list() {
		return "approval_writing_list";
	}

	//결재 양식 목록 조회
	@RequestMapping (value = "/approval_form_list.go")
	public String approval_form_list_go () {
		return "approval_form_list";
	}

	//결재 목록 양식 제목들 가져오기
	@GetMapping(value = "/approval_form_list.ajax")
	@ResponseBody
	public Map<String, Object> approval_form_list() {
		Map<String, Object> data = new HashMap<>();
		data.put("list",approvalService.form_list());
		return data;
	}

	//선택한 결재 목록 양식 가져오기
	@GetMapping (value = "/approval_form.ajax")
	@ResponseBody
	public Map<String, Object> approval_form(int form_idx) {
		Map<String, Object> data = approvalService.form(form_idx);
		return data;
	}


	//결재 작성하기 페이지로 이동
	@PostMapping(value = "/approval_write.go")
	public String approval_write_go (Model model, String form_idx, String form_content) {
		logger.info("approvalWrite_go 컨트롤러 도착");
		logger.info("idx:{}", form_idx);

		//세션 처리
		int empl_idx = 10002;

		//작성하기부터는 update로 하기
		int doc_idx = approvalService.doc_write(Integer.parseInt(form_idx),form_content,empl_idx);



		//model.addAttribute("form_content", form_content);
		model.addAttribute("doc_idx", doc_idx);
		model.addAttribute("form_idx", form_idx);

		return "approval_write";
	}

	@GetMapping (value = "/doc_get.ajax")
	@ResponseBody
	public Map<String,Object> doc_get (int doc_idx) {
		//세션 처리
		int empl_idx = 10002;

		logger.info("doc_get.ajax 컨트롤러 도착");
		logger.info("doc_idx: " + doc_idx);
		Map<String,Object> data = approvalService.doc_get(doc_idx,empl_idx);
		return data;
	}
}
