package com.toast.notify.controller;

import com.toast.approval.dao.ApprovalResponseDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.notify.service.NotiService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.websocket.server.ServerEndpoint;
import java.util.HashMap;
import java.util.Map;

@Controller
public class NotiController {
	//회의실
	int empl_idx = 10000;

	//전자게시판 알림
	//int empl_idx = 10000;

	//결재 알림
	//int empl_idx = 10063;


	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final NotiService notiService;
	
	public NotiController(NotiService notiService) {
		this.notiService = notiService;
	}

	@PostMapping (value = "/approval_noti_insert.ajax")
	@ResponseBody
	public Map <String,Object> approval_noti_insert(@RequestBody Map <String,Object> param) {
		logger.info("param:{}",param);
		Map <String,Object> result = new HashMap<String,Object>();
		notiService.approval_noti_insert(param);

		return result;
	}

	@PostMapping (value="/get_noti_list.ajax")
	@ResponseBody
	public Map <String,Object> get_noti_list() {
		//세션 처리
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("all_noti",notiService.get_all_noti(empl_idx));
		return data;
	}


	//개별 알림 삭제 처리
	@PostMapping (value = "/delete_noti_one.ajax")
	@ResponseBody
	public Map <String,Object> delete_noti_one(String noti_idx) {
		logger.info("noti_idx:{}",noti_idx);
		Map<String,Object> data = new HashMap<>();
		data.put("success", notiService.delete_noti_one(noti_idx));
		return data;
	}

	//모든 알림 삭제 처리
	@PostMapping (value = "/delete_noti_all.ajax")
	@ResponseBody
	public Map <String,Object> delete_noti_all(String empl_idx) {
		logger.info("empl_idx:{}",empl_idx);
		Map<String,Object> data = new HashMap<>();
		data.put("success", notiService.delete_noti_all(empl_idx));
		return data;
	}

}
