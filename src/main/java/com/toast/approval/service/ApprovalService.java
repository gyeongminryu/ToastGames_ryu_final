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
import java.util.ArrayList;
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

	//이동
	public List<Map<String,Object>> form_list() {
		return approvalDAO.form_list();
	}

	//이동
	public Map<String, Object> form(int idx) {
		return approvalDAO.form(idx);
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

	public List<Map<String,Object>> show_team(int dept_idx) {
		return approvalDAO.show_team(dept_idx);
	}

	public List<Map<String,Object>> team_allempl(int team_idx) {
		return approvalDAO.team_allempl(team_idx);
	}

	public List<Map<String,Object>> approval_sent_list_initialize(int empl_idx) {
		//전달할 파라메터
		List<Map<String,Object>> sent_list_param = new ArrayList<>();

		//문서의 작성자에 count(사원 번호)가 있는지 확인
			if(approvalDAO.request_empl_count(empl_idx)>0){
				//문서의 작성자에 count(사원 번호)가 있으면 List<Map>형태로 작성한 값 가져오기
				List<Map<String,Object>> sent_list = approvalDAO.get_sent_list(empl_idx);
				/*int doc_empl_idx = sent_list.get();
				String doc_subject = sent_list.get();
				String doc_update_date = sent_list.get();
				int doc_empl_idx = sent_list.get();
*/





			}





		return sent_list_param;
	}
}
