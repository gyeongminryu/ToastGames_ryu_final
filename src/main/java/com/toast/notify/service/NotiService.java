package com.toast.notify.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.notify.dao.NotiDAO;

@Service
public class NotiService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final NotiDAO notiDAO;
	
	public NotiService(NotiDAO notiDAO) {
		this.notiDAO = notiDAO;
	}

}
