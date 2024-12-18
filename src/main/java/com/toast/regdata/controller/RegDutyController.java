package com.toast.regdata.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.regdata.service.RegDutyService;

@Controller
public class RegDutyController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final RegDutyService regDutyService;
	
	public RegDutyController(RegDutyService regDutyService) {
		this.regDutyService = regDutyService;
	}

}
