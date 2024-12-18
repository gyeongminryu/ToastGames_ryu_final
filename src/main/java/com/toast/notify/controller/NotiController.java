package com.toast.notify.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.notify.service.NotiService;

@Controller
public class NotiController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final NotiService notiService;
	
	public NotiController(NotiService notiService) {
		this.notiService = notiService;
	}

}
