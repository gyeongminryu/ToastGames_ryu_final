package com.toast.rent.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.rent.dao.ResourceManageDAO;
import com.toast.rent.dto.ResourceDTO;

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
	public Object getEmplMg(String loginId) {
		logger.info("loginId");
		return resourceMgDAO.getEmplMg(loginId);
	}

	//관리자 물품 관리 가기(카테고리 종류 가져오기)
	public List<ResourceDTO> resourceCateMg() {
		// TODO Auto-generated method stub
		return null;
	}





}
