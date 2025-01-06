package com.toast.approval.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.approval.dao.ApprovalResponseDAO;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@Service
public class ApprovalResponseService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalResponseDAO approvalResponseDAO;
	
	public ApprovalResponseService(ApprovalResponseDAO approvalResponseDAO) {
		this.approvalResponseDAO = approvalResponseDAO;
	}
	public int update_after_appr(String doc_content, String doc_idx,String line_order, int empl_idx) {
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



		int target_user = 0;

		if(approvalResponseDAO.update_appr_content(doc_content,doc_idx)>0 && approvalResponseDAO.count_update_next_appr(line_order,doc_idx)>0 &&approvalResponseDAO.update_next_appr(line_order,doc_idx)>0&& approvalResponseDAO.update_my_approval_state(empl_idx,doc_idx,formatted_date)>0){
			target_user = approvalResponseDAO.get_next_appr(line_order,doc_idx);
		}

		return target_user;
	}


    public boolean approval_reject(String doc_idx, String reject_reason, String line_order, int empl_idx) {
		//1. doc_idx 및 empl_idx 기반으로 내 state를 반려로 바꿈
		//2. 내 반려 사유를 업데이트
		approvalResponseDAO.appr_reject_state(doc_idx,empl_idx,reject_reason);
		boolean success = false;
		//3. 내 line_order을 가져와서 그 line_order보다 큰 line_order 값이 있으면 그 값들을 가져와서 그것들의 state를 3(중단)으로 바꿈
		success = approvalResponseDAO.count_top_line_order(doc_idx,line_order)>0 &&approvalResponseDAO.update_top_line_order(doc_idx,line_order)>0;
		logger.info("success:{}",success);
		return success;
	}
}
