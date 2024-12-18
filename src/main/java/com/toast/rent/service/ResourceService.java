package com.toast.rent.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.rent.dao.ResourceDAO;

@Service
public class ResourceService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ResourceDAO resourceDAO;
	
	public ResourceService(ResourceDAO resourceDAO) {
		this.resourceDAO = resourceDAO;
	}

}
