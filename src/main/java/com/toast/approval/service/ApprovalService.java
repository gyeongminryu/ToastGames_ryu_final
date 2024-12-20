package com.toast.approval.service;

import com.toast.approval.dto.ApprovalDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.approval.dao.ApprovalDAO;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class ApprovalService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalDAO approvalDAO;
	
	public ApprovalService(ApprovalDAO approvalDAO) {
		this.approvalDAO = approvalDAO;
	}


	public List<Map<String,Object>> highdept() {
		return approvalDAO.highdept();
	}

	public List<Map<String,Object>> dept_allempl(int deptIdx) {

		return approvalDAO.dept_allempl(deptIdx);
	}

	public List<Map<String,Object>> form_list_searched(String search_val) {
		logger.info("서비스 단 searchVal:{}", search_val);

		return approvalDAO.form_list_searched(search_val);
	}
}
