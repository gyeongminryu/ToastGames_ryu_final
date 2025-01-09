package com.toast.rent.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.toast.rent.dao.ResourceDAO;
import com.toast.rent.dto.ResourceDTO;
import com.toast.rent.dto.ResourcePhotoDTO;

@Service
public class ResourceService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ResourceDAO resourceDAO;
	
	public ResourceService(ResourceDAO resourceDAO) {
		this.resourceDAO = resourceDAO;
	}
	
	//사원번호 가져오기
	public int getEmpl(String loginId) {
		logger.info("loginId");
		return resourceDAO.getEmpl(loginId);
	}

	//공용물품 리스트 가져오기
	public List<ResourceDTO> resourceCate() {
		return resourceDAO.resourceCate();
		
	}

	//물품 목록 가져오기
	public Map<String, Object> resourceList(int page, int cnt) {
		logger.info("현재 페이지:"+page);	
		logger.info("한 페이지에 보여줄 갯수: "+cnt);
		
		int limit = cnt;
		int offset = (page-1)*cnt ; //0~19, 20~39, 40~59, 60~79
		
		int totalPages = resourceDAO.allCount(cnt);
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currPage", page);
		List<ResourceDTO> list = resourceDAO.resourceList(limit,offset);
		for (ResourceDTO dto : list) {
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
		
		int totalPages = resourceDAO.filterListCount(cnt,category);
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currPage", page);
		List<ResourceDTO> list = resourceDAO.resourceFilterList(category,limit,offset);
		for (ResourceDTO dto : list) {
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
 
	//물품 목록 검색(전체)
	public Map<String, Object> resourceSearch(int page, int cnt, String option, String keyword) {
		logger.info("현재 페이지:"+page);	
		logger.info("한 페이지에 보여줄 갯수: "+cnt);
		
		int limit = cnt;
		int offset = (page-1)*cnt ; //0~19, 20~39, 40~59, 60~79
		
		int totalPages = resourceDAO.allSearchCount(cnt,option,keyword);
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currPage", page);
		List<ResourceDTO> list = resourceDAO.resourceSearchList(option,keyword,limit,offset);
		for (ResourceDTO dto : list) {
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
	
	
	//물품 목록 검색(특정 카테고리)
	public Map<String, Object> resourceFilterSearch(String category, int page, int cnt, String option,
			String keyword) {
		logger.info("현재 페이지:"+page);	
		logger.info("한 페이지에 보여줄 갯수: "+cnt);
		
		int limit = cnt;
		int offset = (page-1)*cnt ; //0~19, 20~39, 40~59, 60~79
		
		int totalPages = resourceDAO.filterSearchCount(cnt,option,keyword,category);
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currPage", page);
		List<ResourceDTO> list = resourceDAO.filterSearchList(option,keyword,category,limit,offset);
		for (ResourceDTO dto : list) {
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


	//검색한 카테고리 가져오기
	public Map<String, Object> categroySearch(String keyword) {
		return resourceDAO.categroySearch(keyword);
	}

	//물품 상세보기
	public ResourceDTO prodDetail(int prod_idx) {
		return resourceDAO.prodDetail(prod_idx);
		
	}
	
	//물품 첨부파일 가져오기(첨부파일키 추가 필요)
	public List<ResourcePhotoDTO> prodFile(int prod_idx) {
		//(첨부파일키 추가 필요)
		//(첨부파일키 추가 필요)
		String fileKey = resourceDAO.getProdFileKey(prod_idx);
	    // fileKey를 기반으로 ResourcePhotoDTO 객체를 가져옴
	    List<ResourcePhotoDTO> fileList = resourceDAO.prodFile(fileKey);
		return fileList;
	}

	//물품 대여 상태 보기
	public ResourceDTO prodRentDetail(int prod_idx) {
		ResourceDTO dto = resourceDAO.prodRentDetail(prod_idx);
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
		return dto;
		
	}

	//물품 대여 신청(대여 상태 업뎃)
	@Transactional
	public int rentRequest(ResourceDTO dto) {
		resourceDAO.rentRequest(dto);
		dto.setProd_rent(2);
		int row = resourceDAO.updateRentState(dto);
		return row;
		
	}

	
	//파일 다운로드
	public ResponseEntity<Resource> fileDownload(String new_filename, String ori_filename) {
		
		//body
		Resource res = new FileSystemResource("C:/files/"+new_filename);
		
		//header
		HttpHeaders header = new HttpHeaders();
		//한글처리
		header.add("content-type", "application/octet-stream");
		
		try {
			String filename = URLEncoder.encode(ori_filename, "UTF-8");
			header.add("content-Disposition", "attechment;filename=\""+filename+"\"");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		//body,header,status
		return new ResponseEntity<Resource>(res, header, HttpStatus.OK);
	}

	//prod_rent_state 0: 미반납 
	//prod_rent_state 1: 정상 반납 
	//prod_rent_state 2: 연체중
	//prod_rent_state 3: 연체 반납
	//prod_rent_state 4: 대여 신청 중



	//나의 물건 리스트 전체보기
	public Map<String, Object> myResourceList(int page, int cnt , int empl_idx) {
		Map<String,Object> result = new HashMap<String, Object>();
			logger.info("현재 페이지:"+page);	
			logger.info("한 페이지에 보여줄 갯수: "+cnt);
			
			int limit = cnt;
			int offset = (page-1)*cnt ; //0~19, 20~39, 40~59, 60~79
			
			int totalPages = resourceDAO.myAllCount(cnt, empl_idx);
			
			result.put("totalPages", totalPages);
			result.put("currPage", page);
			List<ResourceDTO> list = resourceDAO.myProdList(empl_idx,limit,offset);
			for (ResourceDTO dto : list) {
				switch (dto.getProd_return_state()) {
				case 0:
					dto.setProd_return_state_str("미반납");
					break;
				case 1:
					dto.setProd_return_state_str("정상 반납");
					break;
				case 2:
					dto.setProd_return_state_str("연체 중");
					break;
				case 3:
					dto.setProd_return_state_str("연체 반납");
					break;
				case 4:
					dto.setProd_return_state_str("대여 신청 중");
					break;
				default:
					dto.setProd_return_state_str("알 수 없음");
					break;
				}
			}
			result.put("list", list);

		return result;
	}

	//반납여부에따라 나의 물건 보기
	public Map<String, Object> myResourceReturnList(int rent_state, int page, int cnt, int empl_idx) {
		int state = 0;
		if(rent_state == 11) { //반납한물품
			state = 1;
		} else if(rent_state == 30){
			state = 0; //미반납 물품
		} else {
			state = rent_state;
		}
		logger.info("현재 페이지:"+page);	
		logger.info("한 페이지에 보여줄 갯수: "+cnt);
		Map<String, Integer> map = new HashMap<String, Integer>();
		int limit = cnt;
		int offset = (page-1)*cnt ; //0~19, 20~39, 40~59, 60~79
		map.put("cnt", cnt);
		map.put("limit", limit);
		map.put("offset", offset);
		map.put("state", state);
		map.put("empl_idx", empl_idx);

		
		int totalPages = resourceDAO.myReturnListCount(map);
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currPage", page);
		List<ResourceDTO> list = resourceDAO.myReturnList(map);
		for (ResourceDTO dto : list) {
			switch (dto.getProd_return_state()) {
			case 0:
				dto.setProd_return_state_str("미반납"); 
				break;
			case 1:
				dto.setProd_return_state_str("정상 반납");
				break;
			case 2:
				dto.setProd_return_state_str("연체 중");
				break;
			case 3:
				dto.setProd_return_state_str("연체 반납");
				break;
			case 4:
				dto.setProd_return_state_str("대여 신청 중");
				break;
			default:
				dto.setProd_return_state_str("알 수 없음");
				break;
			}
		}
		result.put("list", list);
		return result;
	}


	//내 물품 자세히보기(파일 가져오기)
	public void myRentDetail(int prod_rent_idx, Model model) {
		ResourceDTO detail = resourceDAO.myRentDetail(prod_rent_idx);
		switch (detail.getProd_return_state()) {
		case 0:
			detail.setProd_return_state_str("미반납");
			break;
		case 1:
			detail.setProd_return_state_str("정상 반납");
			break;
		case 2:
			detail.setProd_return_state_str("연체 중");
			break;
		case 3:
			detail.setProd_return_state_str("연체 반납");
			break;
		case 4:
			detail.setProd_return_state_str("대여 신청 중");
			break;
		default:
			detail.setProd_return_state_str("알 수 없음");
			break;
		}
        // 날짜 포맷
        Map<String, String> formattedDates = new HashMap<>();
        formattedDates.put("prodExpDate", formatDateTime(detail.getProd_exp_date()));
        formattedDates.put("prodRentDate", formatDateTime(detail.getProd_rent_date()));
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("formattedDates", formattedDates);
        model.addAttribute("detail", detail);
        model.addAttribute("map", map);
	}
	
    // 날짜 포맷 함수 (LocalDateTime을 포맷하는 함수)
    private String formatDateTime(LocalDateTime dateTime) {
        if (dateTime == null) return "";  // null 값 처리
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return dateTime.format(formatter);
    }

    //물품 idx가져오기
	public int getIdx(int prod_rent_idx) {
		return resourceDAO.getIdx(prod_rent_idx);
	}

	//물품 대여신청 취소
	@Transactional
	public int rentCancel(int prodIdx, int prodRentIdx) {
		resourceDAO.rentCancel(1,prodIdx);
		int row =resourceDAO.rentReturnCancel(prodRentIdx);
		return row;
		
	}


	


}
