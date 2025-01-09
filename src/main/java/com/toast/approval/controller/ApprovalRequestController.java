package com.toast.approval.controller;

import com.toast.approval.service.ApprovalService;
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
	int empl_idx = 10024;
	private final ApprovalService approvalService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalRequestService approvalRequestService;
	
	public ApprovalRequestController(ApprovalRequestService approvalRequestService, ApprovalService approvalService) {
		this.approvalRequestService = approvalRequestService;
		this.approvalService = approvalService;
	}

	@GetMapping(value = "/approval_update.go")

	public String approval_update_go (int doc_idx,Model model) {
		model.addAttribute("doc_idx", doc_idx);
		//날짜 어떻게 처리하는지 확인
		//return "approval_write";
		return "approval_writing_write";
	}


	//결재 작성하기 페이지로 이동 + 최초 저장 //+ 문서양식만 복사
	@RequestMapping(value = "/approval_write.go")
	public String approval_write_go (Model model, String form_idx) {
		logger.info("approvalWrite_go 컨트롤러 도착");
		logger.info("idx:{}", form_idx);

		//세션 처리
		int empl_idx = 10024;


		logger.info("empl_idx:{}",empl_idx);
		//작성하기부터는 update로 하기
		int doc_idx = approvalRequestService.doc_write_initial(Integer.parseInt(form_idx),empl_idx,model);




		return "approval_writing_write";
	}


	//문서 doc 복사하기
	@RequestMapping(value="/approval_copy_doc.do")
	public String approval_copy_doc (int doc_idx,int form_idx,Model model) {
		//세션 처리

		logger.info("doc_idx:{}",doc_idx);
		logger.info("form_idx:{}",form_idx);

		model.addAttribute("form_idx", form_idx);

		//approvalService 통해
		// 1. doc_idx의 내용 뽑아서 가져온후 insert
		// 2. 얻은 doc_idx 전달
		int doc_idx_copied = approvalRequestService.copy_doc(doc_idx,form_idx,empl_idx);
		model.addAttribute("doc_idx",doc_idx_copied);
		return "approval_writing_write";
	}
	//미리보기에서 수정해서 1차 저장한 결재 문서 가져오기
	@GetMapping (value = "/approval_doc_get.ajax")
	@ResponseBody
	public Map<String,Object> doc_get (int doc_idx) {
		//세션 처리

		logger.info("doc_get.ajax 컨트롤러 도착");
		logger.info("doc_idx: " + doc_idx);
		Map<String,Object> data = approvalRequestService.doc_get(doc_idx,empl_idx);
		return data;
	}

	//저장된 결재선 가져오기
	@GetMapping (value = "/approval_doc_line_get.ajax")
	@ResponseBody
	public Map<String,Object> doc_line_get (int doc_idx) {
		logger.info("doc_line_get 컨트롤러에서 받은 doc_idx"+doc_idx);
        return approvalRequestService.doc_appr_line_get(doc_idx);
	};


	@GetMapping (value="/refer_doc_line_get.ajax")
	@ResponseBody
	public Map<String,Object> refer_doc_line_get(int doc_idx){
		logger.info("refer_doc_line_get 컨트롤러에서 받은 doc_idx"+doc_idx);
		return approvalRequestService.doc_refer_line_get(doc_idx);
	}

	//결재 문서 저장
	@PostMapping (value = "/approval_doc_write.ajax")
	@ResponseBody
	public Map<String,Object> doc_write_do (@RequestParam Map<String,String> param,@RequestParam MultipartFile[]attached_file) {
		logger.info("결재 문서 저장 ajax 실행");
		//세션 처리
		int empl_idx = 10024;
		String success = "결재 문서 저장 실패";
		param.put("empl_idx", String.valueOf(empl_idx));
		Map<String,Object> data = new HashMap<>();
		logger.info("저장해야할 param 값:{}", param);

		//logger.info("form_content:{}",doc_content);
		//logger.info("files:{}", (Object) files);
		//update로 하기
		if(approvalRequestService.doc_write(param,attached_file) && approvalRequestService.save_approval_line(param)){

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


	//문서 작성 취소
	@GetMapping(value = "/approval_write_delete.ajax")
	@ResponseBody
	public Map<String,Object> approval_write_delete(String doc_idx){
		logger.info(doc_idx);
		Map<String,Object> data = new HashMap<>();
		approvalRequestService.write_delete(doc_idx);
		data.put("success","문서 삭제 성공!");
		return data;
	}


	//문서 상신
	@GetMapping (value = "/approval_request.ajax")
	@ResponseBody
	public Map<String,Object> approval_request(String doc_idx){
		//세션 처리
		int empl_idx = 10024;

		Map<String,Object> data = new HashMap<>();
		data.put("target_user",approvalRequestService.approval_request(doc_idx,empl_idx));
		return data;
	}


	/*작성 중인 문서 삭제*/
	@RequestMapping (value="/approval_doc_del.do")
	public String approval_doc_del(String doc_idx){
		approvalRequestService.write_delete(doc_idx);
		return "redirect:/approval_writing_list.go";
	}




}
