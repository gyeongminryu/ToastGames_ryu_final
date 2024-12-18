package com.toast.regdata.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.regdata.dao.RegFormDAO;

@Service
public class RegFormService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final RegFormDAO regFormDAO;
	
	public RegFormService(RegFormDAO regFormDAO) {
		this.regFormDAO = regFormDAO;
	}

}
