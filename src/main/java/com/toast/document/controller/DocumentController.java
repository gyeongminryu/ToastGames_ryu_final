package com.toast.document.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.toast.document.service.DocumentService;
import org.springframework.web.bind.annotation.GetMapping;
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
	public Map<String, Object> document_list(HttpSession session, String page, String cnt, String opt, String keyword, String dept1, String dept2, String accessible_filtering) {
		session.setAttribute("loginId", "tndls0110");
		session.setAttribute("empl_idx", "10001");
		session.setAttribute("dept_idx", "122");
		int dept_idx = Integer.parseInt(session.getAttribute("dept_idx").toString());
		//logger.info("dept_idx = " + dept_idx);

		int pageInt = Integer.parseInt(page);
		int cntInt = Integer.parseInt(cnt);

		return documentService.list(pageInt, cntInt, dept_idx, opt, keyword, dept1, dept2, accessible_filtering);
	}

	@PostMapping(value = "/document_list_call_dept.ajax")
	public Map<String, Object> document_list_call_dept(String dept_depth, String dept_high) {
		int dept_depthInt = Integer.parseInt(dept_depth);
		int dept_highInt = Integer.parseInt(dept_high);
		//logger.info("dept_depth = " + dept_depthInt + ", dept_high = " + dept_highInt);

		if (dept_highInt == 0) {
			dept_highInt = documentService.findPresident();
			//logger.info("president_idx = " + dept_highInt);
		}

		return documentService.depList(dept_depthInt, dept_highInt);
	}

	// 문서 열람
	@GetMapping (value = {"/document_detail.go", "/document_detail"})
	public ModelAndView document_detail(HttpSession session, String doc_idx) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manage_form_unauthorized");

		// 세션 임의 지정
		session.setAttribute("loginId", "tndls0110");
		session.setAttribute("empl_idx", "10001");
		session.setAttribute("dept_idx", "122");

		int dept_idxInt = Integer.parseInt(session.getAttribute("dept_idx").toString());
		int doc_idxInt = Integer.parseInt(doc_idx);
		//logger.info("Is this controller work?");

		// 부서 번호 일치 여부 확인
		if (documentService.authority(dept_idxInt, doc_idxInt)) {
			//logger.info("Valid dept_idx = " + session.getAttribute("dept_idx").toString());
			mav.setViewName("document_detail");
		} else {
			//logger.warn("Invalid dept_idx = " + session.getAttribute("dept_idx").toString());
		}

		return mav;
	}

	@PostMapping(value = "/document_detail.ajax")
	public Map<String, Object> document_detail(String doc_idx) {
		int doc_idxInt = Integer.parseInt(doc_idx);

		return documentService.detail(doc_idxInt);
	}

	@PostMapping(value = "/document_line.ajax")
	public Map<String, Object> document_line(String doc_idx) {
		int doc_idxInt = Integer.parseInt(doc_idx);

		return documentService.appr(doc_idxInt);
	}

	@PostMapping(value = "/document_reference.ajax")
	public Map<String, Object> document_reference(String doc_idx) {
		int doc_idxInt = Integer.parseInt(doc_idx);

		return documentService.refer(doc_idxInt);
	}

	@PostMapping(value = "/document_file.ajax")
	public Map<String, Object> document_file(String doc_idx) {
		int doc_idxInt = Integer.parseInt(doc_idx);

		return documentService.file(doc_idxInt);
	}

}
