package com.toast.schedule.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.schedule.dao.ScheduleDAO;

@Service
public class ScheduleService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ScheduleDAO scheduleDAO;
	
	public ScheduleService(ScheduleDAO scheduleDAO) {
		this.scheduleDAO = scheduleDAO;
	}

}
