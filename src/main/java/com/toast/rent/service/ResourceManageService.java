package com.toast.rent.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.rent.dao.ResourceManageDAO;
import com.toast.rent.dto.ResourceManageDTO;

@Service
public class ResourceManageService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	private ResourceManageDAO resourceMgDAO;
	private HttpSession session;
	
	public ResourceManageService(ResourceManageDAO resourceMgDAO, HttpSession session) {
		this.resourceMgDAO = resourceMgDAO;
		this.session = session;
	}

	//사원 정보 가져오기(부서 정보, idx etc)
	public ResourceManageDTO getEmplMg(String loginId) {
		logger.info("loginId");
		return resourceMgDAO.getEmplMg(loginId);
	}

	//관리자 물품 관리 가기(카테고리 종류 가져오기)
	public List<ResourceManageDTO> resourceCateMg() {
		return resourceMgDAO.resourceCateMg();
	}

	//검색한 카테고리 가져오기
	public Map<String, Object> categroySearch(String keyword) {
		return resourceMgDAO.categroySearch(keyword);
	}

	//물품 목록 가져오기
	public Map<String, Object> resourceList(int page, int cnt) {
		logger.info("현재 페이지:"+page);	
		logger.info("한 페이지에 보여줄 갯수: "+cnt);
		
		int limit = cnt;
		int offset = (page-1)*cnt ; //0~19, 20~39, 40~59, 60~79
		
		int totalPages = resourceMgDAO.allCount(cnt);
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currPage", page);
		List<ResourceManageDTO> list = resourceMgDAO.resourceList(limit,offset);
		for (ResourceManageDTO dto : list) {
			switch (dto.getProd_rent()) {
			case 0:
				dto.setProd_rent_str("대여 불가"); //물품 상태가 0(사용 불가)일때 
				break;
			case 1:
				dto.setProd_rent_str("대여 가능");
				break;
			case 2:
				dto.setProd_rent_str("대여 신청 중");
				break;
			case 3:
				dto.setProd_rent_str("대여 중");
				break;
			case 4:
				dto.setProd_rent_str("연체");
				break;
			default:
				dto.setProd_rent_str("알 수 없음");
				break;
			}
		}
		result.put("list", list);
		return result;
	}

	//카테고리별 목록보기
	public Map<String, Object> resourceFilterList(String category, int page, int cnt) {
		logger.info("현재 페이지:"+page);	
		logger.info("한 페이지에 보여줄 갯수: "+cnt);
		
		int limit = cnt;
		int offset = (page-1)*cnt ; //0~19, 20~39, 40~59, 60~79
		
		int totalPages = resourceMgDAO.filterListCount(cnt,category);
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currPage", page);
		List<ResourceManageDTO> list = resourceMgDAO.resourceFilterList(category,limit,offset);
		for (ResourceManageDTO dto : list) {
			switch (dto.getProd_rent()) {
			case 0:
				dto.setProd_rent_str("대여 불가"); //물품 상태가 0(사용 불가)일때 
				break;
			case 1:
				dto.setProd_rent_str("대여 가능");
				break;
			case 2:
				dto.setProd_rent_str("대여 신청 중");
				break;
			case 3:
				dto.setProd_rent_str("대여 중");
				break;
			case 4:
				dto.setProd_rent_str("연체");
				break;
			default:
				dto.setProd_rent_str("알 수 없음");
				break;
			}
		}
		result.put("list", list);
		return result;
	}
 
	
	//물품 목록 보기(전체)
	public Map<String, Object> resourceSearch(int page, int cnt, String option, String keyword,int prod_state) {
		logger.info("현재 페이지:"+page);	
		logger.info("한 페이지에 보여줄 갯수: "+cnt);
		
		int limit = cnt;
		int offset = (page-1)*cnt ; //0~19, 20~39, 40~59, 60~79
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("limit", limit);
		map.put("offset", offset);
		map.put("cnt", cnt);
		map.put("option", option);
		map.put("keyword", keyword);
		map.put("prod_state", prod_state);
		
		int totalPages = resourceMgDAO.allSearchCount(map);
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currPage", page);
		List<ResourceManageDTO> list = resourceMgDAO.resourceSearchList(map);
		for (ResourceManageDTO dto : list) {
			switch (dto.getProd_rent()) {
			case 0:
				dto.setProd_rent_str("대여 불가"); //물품 상태가 0(사용 불가)일때 
				break;
			case 1:
				dto.setProd_rent_str("대여 가능");
				break;
			case 2:
				dto.setProd_rent_str("대여 신청중");
				break;
			case 3:
				dto.setProd_rent_str("대여 중");
				break;
			case 4:
				dto.setProd_rent_str("연체");
				break;
			default:
				dto.setProd_rent_str("알 수 없음");
				break;
			}
		}
		
		result.put("list", list);
		return result;
	}
	
	
	//물품 목록 보기(특정 카테고리)
	public Map<String, Object> resourceFilterSearch(String category, int page, int cnt, String option,
			String keyword,int prod_state) {
		logger.info("현재 페이지:"+page);	
		logger.info("한 페이지에 보여줄 갯수: "+cnt);
		
		int limit = cnt;
		int offset = (page-1)*cnt ; //0~19, 20~39, 40~59, 60~79
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("limit", limit);
		map.put("offset", offset);
		map.put("cnt", cnt);
		map.put("option", option);
		map.put("keyword", keyword);
		map.put("prod_state", prod_state);
		map.put("category", category);
		
		
		
		int totalPages = resourceMgDAO.filterSearchCount(map);
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currPage", page);
		List<ResourceManageDTO> list = resourceMgDAO.filterSearchList(map);
		for (ResourceManageDTO dto : list) {
			switch (dto.getProd_rent()) {
			case 0:
				dto.setProd_rent_str("대여 불가"); //물품 상태가 0(사용 불가)일때 
				break;
			case 1:
				dto.setProd_rent_str("대여 가능");
				break;
			case 2:
				dto.setProd_rent_str("대여 신청중");
				break;
			case 3:
				dto.setProd_rent_str("대여 중");
				break;
			case 4:
				dto.setProd_rent_str("연체");
				break;
			default:
				dto.setProd_rent_str("알 수 없음");
				break;
			}
		}
		
		result.put("list", list);
		return result;
	}




}
