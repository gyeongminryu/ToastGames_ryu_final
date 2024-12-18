package com.toast.document.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.document.service.DocumentService;

@Controller
public class DocumentController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final DocumentService documentService;
	
	public DocumentController(DocumentService documentService) {
		this.documentService = documentService;
	}

}
