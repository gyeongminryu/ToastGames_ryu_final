package com.toast.approval.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.approval.dao.ApprovalResponseDAO;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

@Service
public class ApprovalResponseService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalResponseDAO approvalResponseDAO;
	
	public ApprovalResponseService(ApprovalResponseDAO approvalResponseDAO) {
		this.approvalResponseDAO = approvalResponseDAO;
	}
	public boolean update_after_appr(String doc_content, String doc_idx,String line_order, int empl_idx) {
		logger.info("doc_content:{}",doc_content);
		logger.info("doc_idx:{}",doc_idx);
		boolean success = false;

		//처리 일시 업데이트
		LocalDate date = LocalDate.now();
		LocalTime time = LocalTime.now();


		//time format
		String formatted_time = time.format(DateTimeFormatter.ofPattern("HH:mm:ss"));

		logger.info("formatted_datetime:{}",date+ " "+formatted_time);
		String formatted_date = date+ " "+formatted_time;





		if(approvalResponseDAO.update_appr_content(doc_content,doc_idx)>0 && approvalResponseDAO.count_update_next_appr(line_order,doc_idx)>0 &&approvalResponseDAO.update_next_appr(line_order,doc_idx)>0&& approvalResponseDAO.update_my_approval_state(empl_idx,doc_idx,formatted_date)>0){
			success = true;
		}

		return success;
	}


}
