package com.toast.approval.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.approval.service.ApprovalRequestService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;

@Controller
public class ApprovalRequestController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalRequestService approvalRequestService;
	
	public ApprovalRequestController(ApprovalRequestService approvalRequestService) {
		this.approvalRequestService = approvalRequestService;
	}



	//결재 작성하기 페이지로 이동
	@PostMapping(value = "/approval_write.go")
	public String approval_write_go (Model model, String form_idx, String form_content) {
		logger.info("approvalWrite_go 컨트롤러 도착");
		logger.info("idx:{}", form_idx);

		//세션 처리
		int empl_idx = 10000;

		//작성하기부터는 update로 하기
		int doc_idx = approvalRequestService.doc_write_initial(Integer.parseInt(form_idx),form_content,empl_idx);



		//model.addAttribute("form_content", form_content);
		model.addAttribute("doc_idx", doc_idx);
		model.addAttribute("form_idx", form_idx);

		return "approval_write";
	}



	//미리보기에서 수정한 결재 문서 가져오기
	@GetMapping (value = "/approval_doc_get.ajax")
	@ResponseBody
	public Map<String,Object> doc_get (int doc_idx) {
		//세션 처리
		int empl_idx = 10000;

		logger.info("doc_get.ajax 컨트롤러 도착");
		logger.info("doc_idx: " + doc_idx);
		Map<String,Object> data = approvalRequestService.doc_get(doc_idx,empl_idx);
		return data;
	}


/*	//결재 문서 저장
	@PostMapping (value = "/approval_doc_write.ajax")
	@ResponseBody
	public Map<String,Object> doc_write_do (String doc_idx, String doc_write_date, String doc_end_date, String subject, String doc_content_sub, String doc_content,@RequestParam MultipartFile[]files,
											String empl_line1,String ) {
		//세션 처리
		int empl_idx = 10002;
		String success = "결재 문서 저장 실패";

		Map<String,Object> data = new HashMap<>();

		logger.info("write_date:{}", doc_write_date);
		logger.info("doc_idx:{}",doc_idx);
		logger.info("doc_end_date:{}",doc_end_date);
		logger.info("subject:{}",subject);
		logger.info("content:{}",doc_content_sub);

		//logger.info("form_content:{}",doc_content);
		logger.info("files:{}", (Object) files);
		//update로 하기
		if(approvalRequestService.doc_write(doc_idx,doc_end_date,subject,doc_content_sub,doc_content,doc_write_date,files,empl_idx)){
			success = "결재 문서 저장 성공";
		}

		data.put("success", success);

		return data;
	}*/

	//결재 문서 저장
	@PostMapping (value = "/approval_doc_write.ajax")
	@ResponseBody
	public Map<String,Object> doc_write_do (@RequestParam Map<String,String> param,@RequestParam MultipartFile[]files) {
		//세션 처리
		int empl_idx = 10000;
		String success = "결재 문서 저장 실패";
		param.put("empl_idx", String.valueOf(empl_idx));
		Map<String,Object> data = new HashMap<>();
		logger.info("저장해야할 param 값:{}", param);

		//logger.info("form_content:{}",doc_content);
		logger.info("files:{}", (Object) files);
		//update로 하기
		if(approvalRequestService.doc_write(param,files) && approvalRequestService.save_approval_line(param)){

			success = "결재 문서 저장 성공";
		}

		data.put("success", success);

		return data;
	}
}
