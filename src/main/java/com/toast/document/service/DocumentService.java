package com.toast.document.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.document.dao.DocumentDAO;

@Service
public class DocumentService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final DocumentDAO documentDAO;
	
	public DocumentService(DocumentDAO documentDAO) {
		this.documentDAO = documentDAO;
	}

}
