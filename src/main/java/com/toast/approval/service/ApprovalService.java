package com.toast.approval.service;

import com.toast.approval.dto.ApprovalDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.approval.dao.ApprovalDAO;

import java.util.List;
import java.util.Map;

@Service
public class ApprovalService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalDAO approvalDAO;
	
	public ApprovalService(ApprovalDAO approvalDAO) {
		this.approvalDAO = approvalDAO;
	}
	public List<Map<String,Object>> form_list() {
		return approvalDAO.form_list();
	}

	public Map<String, Object> form(int idx) {

		return approvalDAO.form(idx);
	}



	public int doc_write(int formIdx, String formContent, int empl_idx) {
		int doc_idx = 0;
		//방금 저장한 idx 가져오기
		//BoardDTO에 값 저장하기
		ApprovalDTO app_dto = new ApprovalDTO();
		app_dto.setForm_idx(formIdx);
		app_dto.setDoc_content(formContent);
		app_dto.setDoc_empl_idx(empl_idx);
		if(approvalDAO.doc_write(app_dto)>0){
			doc_idx = app_dto.getDoc_idx();
			logger.info("방금 insert한 idx :{}",doc_idx);
		}
		return doc_idx;
	}

	public Map<String, Object> doc_get(int docIdx) {
		return approvalDAO.doc_get(docIdx);
	}
}
