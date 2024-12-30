package com.toast.rent.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.toast.rent.dto.ResourceDTO;
import com.toast.rent.service.ResourceManageService;
import com.toast.rent.service.ResourceService;

@Controller
public class ResourceManageController {

	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private ResourceManageService resourceMgService;
	private HttpSession session;
	public int empl_idx = 0; //사원 idx
	public int dept_idx = 0;  //부서 idx
	//public String dept_name=''; //필요하면 부서 이름
	
	public ResourceManageController(ResourceManageService resourceMgService, HttpSession session) {
		this.resourceMgService = resourceMgService;
		this.session = session;
	}
	
	/*공용 물품 관리*/ //-- -관리자 확인 해야함(로그인 & 부서 확인일듯)--------
	//물품관리 메인 이동
	@RequestMapping(value="/manage_rent_list.go")
	public String rentManageMain(Model model) {
		List<ResourceDTO> categoryList =resourceMgService.resourceCateMg(); //카테고리 가져와
		String loginId = (String) session.getAttribute("loginId");
		session.setAttribute("empl_idx", resourceMgService.getEmplMg(loginId)); //사원 부서 가져와
		empl_idx = (int) session.getAttribute("empl_idx");  //세션에 부서 저장 해놔
		model.addAttribute("categoryList", categoryList);
		return null;
	}
	
	
	
	
	
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
