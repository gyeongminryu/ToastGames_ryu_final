package com.toast.notify.controller;

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

}
