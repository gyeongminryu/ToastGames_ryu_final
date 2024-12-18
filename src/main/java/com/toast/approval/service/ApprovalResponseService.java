package com.toast.approval.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.approval.dao.ApprovalResponseDAO;

@Service
public class ApprovalResponseService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalResponseDAO approvalResponseDAO;
	
	public ApprovalResponseService(ApprovalResponseDAO approvalResponseDAO) {
		this.approvalResponseDAO = approvalResponseDAO;
	}

}
