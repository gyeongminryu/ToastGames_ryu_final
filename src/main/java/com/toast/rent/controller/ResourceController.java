package com.toast.rent.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.rent.service.ResourceService;

@Controller
public class ResourceController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ResourceService resourceService;
	
	public ResourceController(ResourceService resourceService) {
		this.resourceService = resourceService;
	}

}
