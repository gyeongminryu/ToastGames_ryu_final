package com.toast.regdata.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.regdata.dao.RegDutyDAO;

@Service
public class RegDutyService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final RegDutyDAO regDutyDAO;
	
	public RegDutyService(RegDutyDAO regDutyDAO) {
		this.regDutyDAO = regDutyDAO;
	}

}
