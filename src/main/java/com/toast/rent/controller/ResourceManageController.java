package com.toast.rent.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.toast.rent.dto.ResourceManageDTO;
import com.toast.rent.service.ResourceManageService;
import com.toast.rent.service.ResourceService;

@Controller
public class ResourceManageController {

	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private ResourceManageService resourceMgService;
	private HttpSession session;
	public int empl_idx = 0; //사원 idx
	public int dept_idx = 0;  //부서 idx

	
	public ResourceManageController(ResourceManageService resourceMgService, HttpSession session) {
		this.resourceMgService = resourceMgService;
		this.session = session;
	}
	
	//관리부서 변경 시 idx 변경 가능
	
	
	/*공용 물품 관리*/ //-- -관리자 확인 해야함(로그인 & 부서 확인일듯)--------
	//물품관리 메인 이동
	@RequestMapping(value="/manage_rent_list.go")
	public String rentManageMain(Model model) {
		String loginId = (String) session.getAttribute("loginId");
		ResourceManageDTO dto =  resourceMgService.getEmplMg(loginId);
		session.setAttribute("empl_idx",dto.getEmpl_idx()); //사원 idx가져와
		session.setAttribute("dept_idx",dto.getDept_idx());//사원 부서 가져와
		empl_idx = (int) session.getAttribute("empl_idx");  //세션에 저장한 사원idx 가져와
		//dept_idx = (int) session.getAttribute("empl_idx"); //세션에 저장한 사원 부서idx 가져와
		dept_idx=122;
		String page = "rent_list";
		if(dept_idx == 122) {	
			List<ResourceManageDTO> categoryList =resourceMgService.resourceCateMg(); //카테고리 가져와
			model.addAttribute("categoryList", categoryList);
			page = "manage_rent_list";
		}
		return page;
	}
	
	//카테고리 검색 목록 가져오기//get
	@GetMapping(value=" /manageCategroySearch.ajax") 
	@ResponseBody
	public Map<String, Object> categroySearch(
	        @RequestParam("keyword") String keyword) {
		
	    return resourceMgService.categroySearch(keyword); // 특정 카테고리
	}
	
	
	//물품 목록 보기(대여 가능 여부 및 반납일시 포함)//get
	@GetMapping(value="/manageProdList.ajax")  
	@ResponseBody
	public Map<String, Object> resourceList(
			@RequestParam("page") String page, 
	        @RequestParam("cnt") String cnt, 
	        @RequestParam("category") String category) {
		
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
	    // 카테고리에 따른 처리
	    if ("all".equals(category)) {
	        return resourceMgService.resourceList(page_, cnt_); // 전체 보기
	    } else {
	        return resourceMgService.resourceFilterList(category, page_, cnt_); // 특정 카테고리
	    }
	}
	
	
	//물품 검색별 보기//post
	@PostMapping(value="/manageProdSearch.ajax")  
	@ResponseBody
	public Map<String, Object> resourceSearch(
            @RequestParam("page") String page,
            @RequestParam("cnt") String cnt,
            @RequestParam("category") String category,
            @RequestParam("option") String option,
            @RequestParam("keyword") String keyword,
            @RequestParam("prod_state") String prod_state){
		
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		int prod_state_ = Integer.parseInt(prod_state);
		
	    if ("all".equals(category)) {
	        return resourceMgService.resourceSearch(page_, cnt_,option, keyword,prod_state_); // 전체 보기
	    } else {
	        return resourceMgService.resourceFilterSearch(category, page_, cnt_,option, keyword,prod_state_); // 특정 카테고리
	    }

	}
	
	
	//물품 상세보기(사진, 첨부파일 필요함)
	
	
	
	
	//물품 상태 상세보기
	
	
	//물품 등록(카테고리, 사용 기한, 첨부파일 포함)
	
	//물품 상세보기
	
	//물품 상세보기(대여 중)
	
	//물품 상세보기(대여 신청중)
	
	//물품 상세보기(연체)
	
	//물품 정보 수정(카테고리, 사용 기한, 첨부파일 포함)
	
	//물품 종류별 보기
	
	//물품 목록보기
	
	//물품 대여 신청 승인(대여 여부 업뎃)
	
	//
	
	
	
}
