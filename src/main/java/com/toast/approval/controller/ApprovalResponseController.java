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
	int empl_idx = 10022; //세션 적용 후 없애기

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
		//내 결재 상태 - 승인으로 처리 & 처리 일시 업데이트
		//다음 결재자 show 및 알림 1
		approvalResponseService.update_after_appr(doc_content,doc_idx,line_order,empl_idx);


		data.put("success", "성공");
		return data;
	}

	//반려 후
	@RequestMapping (value="/approval_reject.ajax")
	@ResponseBody
	public Map<String,Object> approval_reject(String doc_idx,String reject_reason,String line_order){
		logger.info("doc_idx:{}", doc_idx);
		logger.info("reject_reason:{}", reject_reason);
		logger.info("line_order:{}", line_order);

		Map<String,Object> data = new HashMap<>();

		data.put("success",approvalResponseService.approval_reject(doc_idx,reject_reason,line_order,empl_idx));
		return data;
	}

}
