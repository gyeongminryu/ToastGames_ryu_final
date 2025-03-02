package com.toast.approval.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import com.toast.approval.service.ApprovalService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ApprovalController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalService approvalService;


	//세션 처리
	//보낸 + 작성한
	//int empl_idx = 10111;

	//결재 요청
	//int empl_idx = 10286;
	public ApprovalController(ApprovalService approvalService) {
		this.approvalService = approvalService;
	}

	//결재 양식 목록 조회 - 옮기기
	@RequestMapping (value = "/approval_form_list.go")
	public String approval_form_list_go (Model model) {
		model.addAttribute("form_list",approvalService.form_list());
		return "approval_writing_select_form";
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


	//회사내 모든 사원 가져오기
	@RequestMapping (value="/approval_company_get_allempl.ajax")
	@ResponseBody
	public Map<String,Object> approval_company_get_allempl(String filter, String search){
		logger.info("filter:{}",filter);
		logger.info("search:{}",search);
		Map<String,Object> data = new HashMap<>();
		data.put("company_empl",approvalService.approval_company_get_allempl(filter,search));
		return data;
	}

	@RequestMapping(value="/approval_send_list.go")
	public String approval_sent_list(){
		return "approval_sent_list";
	}

	@RequestMapping(value="/approval_received_list.go")
	public String approval_received_list(){
		return "approval_received_list";
	}

	@RequestMapping(value="/approval_writing_list.go")
	public String approval_writing_list(){
		return "approval_writing_list";
	}

	/*내가 보낸 결재 목록 조회*/
	@RequestMapping (value="/approval_send_list.ajax")
	@ResponseBody
	public Map<String, Object> approval_sent_list(HttpSession session){
		//세션 처리
		int empl_idx = (int) session.getAttribute("empl_idx");

		Map<String, Object> data = new HashMap<>();
		logger.info("approval_send_list.go 컨트롤러 도착");
		List<Map<String, Object>> list = approvalService.approval_sent_list(empl_idx);
		data.put("list",list);
		return data;
	}

	/*내가 받은 결재 목록 조회*/
	@GetMapping (value= "/approval_received_list.ajax")
	@ResponseBody
	public Map<String, Object> approval_received_list(HttpSession session){
		//세션 처리
		int empl_idx = (int) session.getAttribute("empl_idx");

		Map<String, Object> data = new HashMap<>();
		List<Map<String, Object>> list = new ArrayList<>();
		logger.info("approval_send_list.go 컨트롤러 도착");

		list = approvalService.approval_received_list(empl_idx);
		data.put("list",list);


		return data;
	}


	/*작성 중인 목록 조회*/
	@GetMapping (value = "/approval_writing_list.ajax")
	@ResponseBody
	public Map<String, Object> approval_writing_list(HttpSession session){
		//세션 처리
		int empl_idx = (int) session.getAttribute("empl_idx");

		Map<String, Object> data = new HashMap<>();
		List<Map<String, Object>> list = new ArrayList<>();
		logger.info("approval_send_list.go 컨트롤러 도착");

		list = approvalService.get_approval_writing_list(empl_idx);
		data.put("list",list);
		return data;
	}


	/*detail 상세보기*/
	@RequestMapping (value={"/approval_sent_detail.go","/approval_received_detail.go"})
	public String approval_received_detail(int doc_idx,String type, Model model,HttpSession session){
		int empl_idx = (int) session.getAttribute("empl_idx");
		logger.info("doc_idx:{}", doc_idx);
		logger.info("type:{}", type);
		logger.info("approval_"+type+"_detail");

		approvalService.get_all_detail(doc_idx,empl_idx,model,type);

		//보낸 type에 따라 detail 경로 동적으로 생성
		return "approval_"+type+"_detail";
	}

	/*도장 가져오기*/
	@PostMapping(value = "/approval_get_stamp.ajax")
	@ResponseBody
	public Map<String,Object> approval_get_stamp(String approval_empl_idx){
		Map<String,Object> data = new HashMap<>();
		logger.info("도장 controller 도착 :{}",approval_empl_idx);
		String stamp =approvalService.get_stamp(approval_empl_idx);
		data.put("stamp",stamp);
		return data;
	}
	/*file_다운로드*/
	@RequestMapping (value ="/approval_download.do")
	public ResponseEntity<Resource> download(String new_filename,String ori_filename){
		logger.info(new_filename +":"+ ori_filename);
		return approvalService.file_download(new_filename,ori_filename);
	}


	/*문서 양식의 내용 가져오는 함수*/
	@PostMapping (value = "/appr_doc_form_content.ajax")
	@ResponseBody
	public Map<String,Object> appr_doc_form_content(int doc_idx){
		logger.info("form_doc_idx:{}",doc_idx);
		Map<String,Object> data = new HashMap<>();
		data.put("form_content",approvalService.get_doc_form_content(doc_idx));
		return data;
	}

	/*최근 작성한 문서 가져오기*/
	@PostMapping (value="/get_recent_written.ajax")
	@ResponseBody
	public Map<String,Object> get_recent_written(HttpSession session){
		int empl_idx = (int) session.getAttribute("empl_idx");
		Map<String,Object> data = new HashMap<>();
		List<Map<String,Object>> recent_doc = approvalService.get_recent_written(empl_idx);
		data.put("recent_doc",recent_doc);
		return data;
	}
}
