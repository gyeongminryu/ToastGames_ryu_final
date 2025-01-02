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
	public boolean update_after_appr(String doc_content, String doc_idx,String line_order) {
		logger.info("doc_content:{}",doc_content);
		logger.info("doc_idx:{}",doc_idx);
		boolean success = false;
		if(approvalResponseDAO.update_appr_content(doc_content,doc_idx)>0 && approvalResponseDAO.update_next_appr(line_order,doc_idx)>0){
			success = true;
		};

		return success;
	}


}
