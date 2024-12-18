package com.toast.regdata.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.regdata.service.RegPositionService;

@Controller
public class RegPositionController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final RegPositionService regPositionService;
	
	public RegPositionController(RegPositionService regPositionService) {
		this.regPositionService = regPositionService;
	}

}
