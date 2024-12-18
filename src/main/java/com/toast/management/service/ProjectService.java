package com.toast.management.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.management.dao.ProjectDAO;

@Service
public class ProjectService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ProjectDAO projectDAO;
	
	public ProjectService(ProjectDAO projectDAO) {
		this.projectDAO = projectDAO;
	}

}
