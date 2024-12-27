package com.toast.rent.service;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.rent.dao.ResourceManageDAO;

@Service
public class ResourceManageService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	private ResourceManageDAO resourceMgDAO;
	private HttpSession session;
	
	public ResourceManageService(ResourceManageDAO resourceMgDAO, HttpSession session) {
		this.resourceMgDAO = resourceMgDAO;
		this.session = session;
	}
}
