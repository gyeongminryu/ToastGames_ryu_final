package com.toast.schedule.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.schedule.dao.MeetingDAO;

@Service
public class MeetingService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final MeetingDAO meetingDAO;
	
	public MeetingService(MeetingDAO meetingDAO) {
		this.meetingDAO = meetingDAO;
	}

}
