package com.toast.document.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.toast.document.service.DocumentService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class DocumentController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final DocumentService documentService;
	
	public DocumentController(DocumentService documentService) {
		this.documentService = documentService;
	}

	// 문서 목록
	@RequestMapping(value = "/document_list.go")
	public ModelAndView document_list() {
		return new ModelAndView("document_list");
	}

}
