package com.toast.approval.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.approval.service.ApprovalResponseService;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ApprovalResponseController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalResponseService approvalResponseService;
	
	public ApprovalResponseController(ApprovalResponseService approvalResponseService) {
		this.approvalResponseService = approvalResponseService;
	}

	@RequestMapping (value="/approval_received_detail.go")
	public String approval_received_detail(){
		return "approval_received_detail";
	}

}
