package com.toast.schedule.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.schedule.service.MeetingService;

@Controller
public class MeetingController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final MeetingService meetingService;
	
	public MeetingController(MeetingService meetingService) {
		this.meetingService = meetingService;
	}

}
