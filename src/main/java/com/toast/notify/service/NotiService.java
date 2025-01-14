package com.toast.notify.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.notify.dao.NotiDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class NotiService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final NotiDAO notiDAO;
	
	public NotiService(NotiDAO notiDAO) {
		this.notiDAO = notiDAO;
	}

    public boolean approval_noti_insert(Map<String, Object> param) {
		boolean success = false;
		List<Integer> receiver_list = (List<Integer>) param.get("receiver_list");
		Map<String, Object> parameter = new HashMap<>();
		String sender_idx = (String) param.get("sender_idx");
		String doc_subject = (String) param.get("doc_subject");
		String doc_content = (String) param.get("doc_content");
		String doc_date = (String) param.get("doc_date");
		String url = (String)param.get("url");
		Integer notify_category = (int) param.get("notify_category");

		logger.info("doc_subject = " + doc_subject);
		logger.info("receiver_list = " + receiver_list);
		logger.info("doc_content = " + doc_content);
		logger.info("doc_date = " + doc_date);
		logger.info("url = " + url);


		for(int receiver : receiver_list){
			logger.info("receiver_idx = " + receiver);
			parameter.put("receiver_idx", receiver);
			parameter.put("sender_idx", sender_idx);
			parameter.put("doc_subject", doc_subject);
			parameter.put("doc_content", doc_content);
			parameter.put("doc_date", doc_date);
			parameter.put("url", url);
			parameter.put("notify_category", notify_category);

			logger.info("parameter= " + parameter);

			success = notiDAO.approval_noti_insert(parameter)>0;
		}

		return success;
    }

	public List<Map<String,Object>> get_all_noti(int empl_idx) {
		List<Map<String,Object>> all_noti = notiDAO.get_all_noti(empl_idx);
		List<Map<String,Object>> noti_info = new ArrayList<>();
		logger.info("all_noti size= " + all_noti.size());

		int noti_cate = 0;

			for(Map<String,Object> noti : all_noti){
				noti_cate = (int) noti.get("noti_cate_idx");
				if(noti_cate == 22){ //부서

					//만약 sender_empl_idx의 부서와 receiver_empl_idx의 부서 혹은 상위 부서가 같은 경우
					//int sender_empl_idx = (int) noti.get("noti_sender_empl_idx");
					int receiver_empl_idx= (int) noti.get("noti_receiver_empl_idx");
					logger.info("receiver_empl_idx = " + receiver_empl_idx);


				//부서 가져와서 넣기
					//empl_idx가 속한 부서 idx 및 depth, 상위 부서 idx 가져오기
					Map<String,Object> dept_info = notiDAO.get_empl_dept_info(receiver_empl_idx);
					//1. 만약 상위 부서면
					logger.info("dept_depth= " + dept_info.get("dept_depth"));
					int dept_depth= (int) dept_info.get("dept_depth");
					if(dept_depth == 2){
						//해당 부서 명 가져오기
						noti.put("dept_name",notiDAO.get_dept_name(dept_info.get("dept_idx")));
						//2. 만약 하위 팀이면
					}else if (dept_depth == 3){
						logger.info("dept_high" + dept_info.get("dept_high"));
						// 상위 부서 idx 넣어서 부서명 가져오기
						noti.put("dept_name",notiDAO.get_dept_name(dept_info.get("dept_high")));
					}


				}else if(noti_cate == 23){//팀
				//팀 가져와서 넣기
					//본인의 하위부서 idx 넣어서 부서명 알아내기
					Map<String,Object> dept_info = notiDAO.get_empl_dept_info(empl_idx);
					noti.put("dept_name",notiDAO.get_dept_name(dept_info.get("dept_idx")));
				}
				logger.info("noti:{}",noti);
				noti_info.add(noti);
			}

		logger.info("noti_info = " + noti_info);
	return noti_info;
	}

	public boolean delete_noti_one(String noti_idx) {
		logger.info("noti_idx = " + noti_idx);
		boolean success = false;

		if(notiDAO.delete_noti_one(noti_idx)>0){
			success = true;
		}

		return success;
	}

	public boolean delete_noti_all(String empl_idx) {
		logger.info("empl_idx= " + empl_idx);
		boolean success = false;

		if(notiDAO.delete_noti_all(empl_idx)>0){
			success = true;
		}

		return success;
	}
}
