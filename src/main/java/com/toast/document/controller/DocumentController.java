package com.toast.document.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.toast.document.service.DocumentService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Map;

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

	@PostMapping(value = "/document_list.ajax")
	public Map<String, Object> document_list(HttpSession session, String page, String cnt) {
		session.setAttribute("loginId", "tndls0110");
		session.setAttribute("empl_idx", "10001");
		session.setAttribute("dept_idx", "100");
		int dept_idx = Integer.parseInt(session.getAttribute("dept_idx").toString());
		//logger.info("dept_idx = " + dept_idx);

		int pageInt = Integer.parseInt(page);
		int cntInt = Integer.parseInt(cnt);
		//int dept1Int = Integer.parseInt(dept1);
		//int dept2Int = Integer.parseInt(dept2);
//		boolean accessibleFiltering = false;
//		if (accessible_filtering.equals("true")) {
//			accessibleFiltering = true;
//		} else if (accessible_filtering.equals("false")) {
//			accessibleFiltering = false;
//		}

		return documentService.list(pageInt, cntInt, dept_idx);
	}

	// 문서 열람
	@RequestMapping(value = "/document_detail.go")
	public ModelAndView document_detail() {
		return new ModelAndView("document_detail");
	}

}
