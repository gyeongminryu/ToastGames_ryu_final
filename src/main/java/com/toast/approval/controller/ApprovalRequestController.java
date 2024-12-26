package com.toast.approval.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.approval.service.ApprovalRequestService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ApprovalRequestController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalRequestService approvalRequestService;
	
	public ApprovalRequestController(ApprovalRequestService approvalRequestService) {
		this.approvalRequestService = approvalRequestService;
	}



	//결재 작성하기 페이지로 이동 + 최초 저장
	@PostMapping(value = "/approval_write.go")
	public String approval_write_go (Model model, String form_idx, String form_content) {
		logger.info("approvalWrite_go 컨트롤러 도착");
		logger.info("idx:{}", form_idx);

		//세션 처리
		int empl_idx = 10023;

		//작성하기부터는 update로 하기
		int doc_idx = approvalRequestService.doc_write_initial(Integer.parseInt(form_idx),form_content,empl_idx);



		//model.addAttribute("form_content", form_content);
		model.addAttribute("doc_idx", doc_idx);
		model.addAttribute("form_idx", form_idx);

		return "approval_write";
	}



	//미리보기에서 수정해서 1차 저장한 결재 문서 가져오기
	@GetMapping (value = "/approval_doc_get.ajax")
	@ResponseBody
	public Map<String,Object> doc_get (int doc_idx) {
		//세션 처리
		int empl_idx = 10023;

		logger.info("doc_get.ajax 컨트롤러 도착");
		logger.info("doc_idx: " + doc_idx);
		Map<String,Object> data = approvalRequestService.doc_get(doc_idx,empl_idx);
		return data;
	}

	//저장된 결재선 가져오기
	@GetMapping (value = "/approval_doc_line_get.ajax")
	@ResponseBody
	public Map<String,Object> doc_line_get (int doc_idx) {
		logger.info("컨트롤러에서 받은 doc_idx"+doc_idx);
		Map<String,Object> data = new HashMap<>();
		data.put("doc_lines", approvalRequestService.doc_line_get(doc_idx));

		return data;
	};

	//결재 문서 저장
	@PostMapping (value = "/approval_doc_write.ajax")
	@ResponseBody
	public Map<String,Object> doc_write_do (@RequestParam Map<String,String> param,@RequestParam MultipartFile[]files) {
		//세션 처리
		int empl_idx = 10023;
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

	@PostMapping (value="/refer_save_doc.ajax")
	@ResponseBody
	public Map<String,Object> refer_save(@RequestBody Map<String, Object> payload){
		logger.info("참조 컨트롤러 도착 param:{}",payload.get("refer_line"));
		logger.info("참조 컨트롤러 도착 doc_idx:{}",payload.get("doc_idx"));

		List<String> refer_line = (List<String>) payload.get("refer_line");
		String doc_idx = (String) payload.get("doc_idx");
		Map<String,Object> data = new HashMap<>();
		approvalRequestService.save_refer_line(refer_line,doc_idx);
		data.put("success","참조 라인 저장 성공");
		return data;
	}

	@GetMapping(value = "/approval_write_delete.ajax")
	@ResponseBody
	public Map<String,Object> approval_write_delete(String doc_idx){
		logger.info(doc_idx);
		Map<String,Object> data = new HashMap<>();
		approvalRequestService.write_delete(doc_idx);
		data.put("success","문서 삭제 성공!");
		return data;
	}


}
