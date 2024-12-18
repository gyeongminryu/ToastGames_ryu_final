package com.toast.regdata.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.regdata.service.RegFormService;

@Controller
public class RegFormController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final RegFormService regFormService;
	
	public RegFormController(RegFormService regFormService) {
		this.regFormService = regFormService;
	}

}
