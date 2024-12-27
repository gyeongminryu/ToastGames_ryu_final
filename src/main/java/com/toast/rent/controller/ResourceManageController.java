package com.toast.rent.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.toast.rent.service.ResourceManageService;
import com.toast.rent.service.ResourceService;

@Controller
public class ResourceManageController {

	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private ResourceManageService resourceMgService;
	private HttpSession session;
	
	public ResourceManageController(ResourceManageService resourceMgService, HttpSession session) {
		this.resourceMgService = resourceMgService;
		this.session = session;
	}
	
	/*공용 물품 관리*/ //-- -관리자 확인--------
	
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
