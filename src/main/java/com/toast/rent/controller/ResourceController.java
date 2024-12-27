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

import com.toast.rent.dto.ResourceDTO;
import com.toast.rent.service.ResourceService;

@Controller
public class ResourceController {
	
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private ResourceService resourceService;
	private HttpSession session;
	
	public ResourceController(ResourceService resourceService, HttpSession session) {
		this.resourceService = resourceService;
		this.session = session;
	}
	
	/*공용 물품 대여*/
	
	//카테고리 목록 가져오기
	@RequestMapping(value="/rent_list.go")
	public String rentList(Model model) {
		List<ResourceDTO> categoryList =resourceService.resourceCate();
		model.addAttribute("categoryList", categoryList);
		return "rent_list";
	}
	
	//카테고리 검색 목록 가져오기
	@GetMapping(value="/categroySearch.ajax")
	@ResponseBody
	public Map<String, Object> categroySearch(
	        @RequestParam("keyword") String keyword) {
		
	    return resourceService.categroySearch(keyword); // 특정 카테고리
	}
	
	//내가 대여한 물품 페이지 이동
	//@RequestMapping(value="/rent_mylist.do")
	
	
	//물품 목록 보기(대여 가능 여부 및 반납일시 포함)
	@GetMapping(value="/resourceList.ajax")
	@ResponseBody
	public Map<String, Object> resourceList(
			@RequestParam("page") String page, 
	        @RequestParam("cnt") String cnt, 
	        @RequestParam("category") String category) {
		
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
	    // 카테고리에 따른 처리
	    if ("all".equals(category)) {
	        return resourceService.resourceList(page_, cnt_); // 전체 보기
	    } else {
	        return resourceService.resourceFilterList(category, page_, cnt_); // 특정 카테고리
	    }
	}

	//물품 검색별 보기
	@PostMapping(value="/resourceSearch.ajax")
	@ResponseBody
	public Map<String, Object> resourceSearch(
            @RequestParam("page") String page,
            @RequestParam("cnt") String cnt,
            @RequestParam("category") String category,
            @RequestParam("option") String option,
            @RequestParam("keyword") String keyword){
		
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		
	    if ("all".equals(category)) {
	        return resourceService.resourceSearch(page_, cnt_,option, keyword); // 전체 보기
	    } else {
	        return resourceService.resourceFilterSearch(category, page_, cnt_,option, keyword); // 특정 카테고리
	    }

	}
	

	
	//물품 상세보기
	@RequestMapping(value="/rentDetail.go")
	public String rentDetail(@RequestParam("prod_idx") int prod_idx, Model model) {
		logger.info("prod_idx:"+prod_idx);
		ResourceDTO detail = resourceService.prodDetail(prod_idx);
		model.addAttribute("detail", detail);
		model.addAttribute("file", file);
		return "rent_detail";
	}
	
	
	
	
	
	
	
	
	//물품 첨부파일 확인하기 및 다운받기
	
	//물품 대여 신청하기
	
	//내가 대여한 물품(목록 보기 물품 상태 포함)
	
	//내가 대여한 물품 종류별 보기
	
	//내가 대여한 물품 상세보기(반납장소 포함)
	
	//대여 승인 시 반납일정 일정 표시
	
	
	
	
	
	
	
	
}
