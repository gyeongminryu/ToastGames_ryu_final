package com.toast.approval.controller;

import com.toast.approval.service.ApprovalService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.approval.service.ApprovalResponseService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class ApprovalResponseController {
	private final ApprovalService approvalService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalResponseService approvalResponseService;
	
	public ApprovalResponseController(ApprovalResponseService approvalResponseService, ApprovalService approvalService) {
		this.approvalResponseService = approvalResponseService;
		this.approvalService = approvalService;
	}

	@RequestMapping (value="/approval_received_detail.go")
	public String approval_received_detail(){
		return "approval_received_detail";
	}

	//결재 후
	@PostMapping (value="save_approved_doc_content.ajax")
	@ResponseBody
	public Map<String,Object> save_approved_doc_content(String doc_content, String doc_idx, String line_order){
		Map<String,Object> data = new HashMap<>();
		logger.info("doc_idx:{}", doc_idx);
		logger.info("line_order:{}", line_order);

		//폼 양식 html 업데이트
		//다음 결재자 show 및 알림 1
		approvalResponseService.update_after_appr(doc_content,doc_idx,line_order);


		data.put("success", "성공");
		return data;
	}

}
