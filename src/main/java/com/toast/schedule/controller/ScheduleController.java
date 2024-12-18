package com.toast.schedule.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.schedule.service.ScheduleService;

@Controller
public class ScheduleController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ScheduleService scheduleService;
	
	public ScheduleController(ScheduleService scheduleService) {
		this.scheduleService = scheduleService;
	}

}
