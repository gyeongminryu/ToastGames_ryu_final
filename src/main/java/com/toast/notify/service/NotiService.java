package com.toast.notify.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.notify.dao.NotiDAO;

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
		int notify_category = (int) param.get("notify_category");
		String url = (String)param.get("url");

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
}
