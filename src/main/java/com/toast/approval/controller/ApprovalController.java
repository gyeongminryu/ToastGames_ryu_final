package com.toast.approval.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.approval.service.ApprovalService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ApprovalController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalService approvalService;


	//세션 처리
	int empl_idx = 10024;


	public ApprovalController(ApprovalService approvalService) {
		this.approvalService = approvalService;
	}

	/*결재 작성 관련*/

	//결재 목록 조회 - 옮기기
	@RequestMapping(value = "/approval_writing_list.go")
	public String approval_writing_list() {
		return "approval_writing_list";
	}

	//결재 양식 목록 조회 - 옮기기
	@RequestMapping (value = "/approval_form_list.go")
	public String approval_form_list_go () {
		return "approval_form_list";
	}

	//결재 목록 양식 제목들 가져오기 - 옮기기
	@GetMapping(value = "/approval_form_list.ajax")
	@ResponseBody
	public Map<String, Object> approval_form_list() {
		Map<String, Object> data = new HashMap<>();
		data.put("list",approvalService.form_list());
		return data;
	}

	//선택한 결재 목록 양식 가져오기 - 옮기기
	@GetMapping (value = "/approval_form.ajax")
	@ResponseBody
	public Map<String, Object> approval_form(int form_idx) {
		Map<String, Object> data = approvalService.form(form_idx);
		return data;
	}

	//결재 양식 검색 기능
	@GetMapping(value = "/approval_form_search.ajax")
	@ResponseBody
	public Map<String,Object> approvalFormSearch(String search_val) {
		logger.info("컨트롤러 단 searchVal:{}", search_val);

		Map<String,Object> data = new HashMap<>();
		data.put("list",approvalService.form_list_searched(search_val));

		return data;
	}


	//결재선
	@RequestMapping (value = "/approval_list.go")
	public String approval_tree() {
		return "approval_write_line_child";
	}



	@GetMapping (value = "/approval_highdept.ajax")
	@ResponseBody
	public Map<String,Object> approval_highdept (){
		Map<String,Object> data = new HashMap<>();
		data.put("dept",approvalService.highdept());
		return data;
	}

	//부서의 모든 사원 가져오기
	@GetMapping(value = "/approval_dept_allempl.ajax")
	@ResponseBody
	public Map<String,Object> approval_alldept_allempl (int dept_idx){
		Map<String,Object> data = new HashMap<>();
		data.put("empl",approvalService.dept_allempl(dept_idx));
		return data;
	}

	//부서 아래의 모든 팀 가져오기
	@GetMapping (value = "/approval_show_team.ajax")
	@ResponseBody
	public Map<String,Object> approval_show_team (int dept_idx){
		Map<String,Object> data = new HashMap<>();
		data.put("dept",approvalService.show_team(dept_idx));
		return data;
	}

	//팀 내 모든 팀원 가져오기
	@GetMapping (value = "/approval_team_allempl.ajax")
	@ResponseBody
	public Map<String,Object> approval_team_allempl (int team_idx){
		Map<String,Object> data = new HashMap<>();

		data.put("empl",approvalService.team_allempl(team_idx));

		return data;
	}

	/*내가 보낸 결재 목록 조회*/
	@GetMapping (value="/approval_send_list.go")
	public String approval_sent_list(@RequestParam(value = "filter", required = false, defaultValue = "전체") String filter,
									 @RequestParam(value = "type", required = false, defaultValue = "전체") String type, Model model){
		//세션 처리
		List<Map<String,Object>> sent_list = new ArrayList<>();
		logger.info(filter);
		logger.info(type);

		//logger.info("type:{}",type);

		if(filter.equals("전체") && type.equals("전체")){
			logger.info("전체 보낸 목록 조회");
		}else{
			logger.info("보낸 목록 조건 조회");
		}

		sent_list =approvalService.approval_sent_list(empl_idx,filter,type);
		//empl_idx 전달 → 보낸 문서가 있는지 확인
		model.addAttribute("sent_list",sent_list);
		return "approval_sent_list";
	}

	/*내가 받은 결재 목록 조회*/
	@GetMapping (value= "/approval_received_list.go")
	public String approval_received_list(@RequestParam(value = "filter", required = false, defaultValue = "전체") String filter,
									 	@RequestParam(value = "type", required = false, defaultValue = "전체") String type, Model model){
		//세션 처리
		List<Map<String,Object>> received_list = new ArrayList<>();
		logger.info(filter);
		logger.info(type);

		//logger.info("type:{}",type);

		if(filter.equals("전체") && type.equals("전체")){
			logger.info("전체 받은 목록 조회");
		}else{
			logger.info("받은 목록 조건 조회");
		}

		received_list=approvalService.approval_received_list(empl_idx,filter,type);
		//empl_idx 전달 → 보낸 문서가 있는지 확인
		model.addAttribute("received_list",received_list);
		return "approval_received_list";
	}



}
