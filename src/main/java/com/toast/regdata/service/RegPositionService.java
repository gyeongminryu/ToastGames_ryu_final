package com.toast.regdata.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.regdata.dao.RegPositionDAO;

@Service
public class RegPositionService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final RegPositionDAO regPositionDAO;
	
	public RegPositionService(RegPositionDAO regPositionDAO) {
		this.regPositionDAO = regPositionDAO;
	}

}
