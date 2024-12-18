package com.toast.approval.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.approval.service.ApprovalRequestService;

@Controller
public class ApprovalRequestController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalRequestService approvalRequestService;
	
	public ApprovalRequestController(ApprovalRequestService approvalRequestService) {
		this.approvalRequestService = approvalRequestService;
	}

}
