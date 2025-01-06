package com.toast.rent.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.toast.rent.dao.ResourceManageDAO;
import com.toast.rent.dto.ResourceManageDTO;
import com.toast.rent.dto.ResourcePhotoDTO;
import com.toast.schedule.dto.MeetingDTO;
import com.toast.schedule.dto.MeetingPhotoDTO;

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

	//물품 등록(파일O)
	@Transactional
	public int prodWrite(List<MultipartFile> attachedFiles, Map<String, Object> param) {
		ResourceManageDTO dto = new ResourceManageDTO();
		dto.setProd_name((String) param.get("subject"));
		dto.setProd_empl_idx((int) param.get("empl_idx"));
		dto.setProd_model((String) param.get("information"));
		dto.setProd_cate_idx(Integer.parseInt((String) param.get("category")));
		dto.setProd_info((String) param.get("content"));
		dto.setProd_rent(1); //대여 여부
		dto.setProd_state(1); //물품 상태
		dto.setProd_place((String) param.get("place"));
		dto.setProd_purch_date(LocalDateTime.now().withNano(0)); //등록일자
	    // 날짜 문자열 가져오기
	    String dueDateString = (String) param.get("due_date");

	    // 날짜만 있는 경우에 대한 처리
	    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    LocalDate localDate = LocalDate.parse(dueDateString, dateFormatter);

	    // LocalDateTime으로 변환 (시간은 00:00:00으로 설정)
	    LocalDateTime dueDate = localDate.atStartOfDay();
	    
	    // DTO에 설정
	    dto.setProd_dispo_date(dueDate);
		
		int row = 0;
		resourceMgDAO.prodWrite(dto);  //물품 등록
		int prod_idx = dto.getProd_idx();
		
		logger.info("prod_idx:"+prod_idx);
		
		if(prod_idx > 0) {
			logger.info("여기 들어왔다고");
			row = prodFileAdd(attachedFiles, prod_idx);
		}
		
		return row;
	}

	
	//물품 파일 등록
	private int prodFileAdd( List<MultipartFile> files, int prod_idx) {
		
		int row =0;
		for (MultipartFile file : files) {
			
			//1.파일명 추출
			String oriFilename = file.getOriginalFilename();
			logger.info(oriFilename);
			
			//2.기존 파일의 확장자만 분리
			String ext = oriFilename.substring(oriFilename.lastIndexOf("."));
			logger.info(ext);
			
			
			//3.새파일명 생성
			String newFilename = UUID.randomUUID().toString()+ext; //바로 해도됨 +문자는 문자열로 인식
			logger.info(newFilename);
			
			
			//4. 첨부파일 키 생성
			String fileKey = UUID.randomUUID().toString();
			
			
			int empl_idx = (int) session.getAttribute("empl_idx");
			//5. 파일 저장
			try {
				byte[] arr = file.getBytes();
				Path path = Paths.get("C:/files/"+newFilename);
				Files.write(path, arr);
				//6.저장 내용 files 테이블에 insert
				ResourcePhotoDTO photo_dto = new ResourcePhotoDTO();
				photo_dto.setNew_filename(newFilename);
				photo_dto.setOri_filename(oriFilename);
				photo_dto.setFile_addr(path.toString());
				photo_dto.setFile_type(ext);
				photo_dto.setFile_key(fileKey);
				photo_dto.setUploader_idx(empl_idx);
				photo_dto.setFile_size(file.getSize());
				row = resourceMgDAO.prodFileAdd(photo_dto); 
				
				resourceMgDAO.prodFileKeyAdd(prod_idx, fileKey);
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return row;
		
	}
	
	

	//물품 등록(파일X)
	public int prodOnlyWrite(Map<String, Object> param) {
		ResourceManageDTO dto = new ResourceManageDTO();
		dto.setProd_name((String) param.get("subject"));
		dto.setProd_model((String) param.get("information"));
		dto.setProd_cate_idx(Integer.parseInt((String) param.get("category")));
		dto.setProd_info((String) param.get("content"));
		dto.setProd_rent(1); //대여 여부
		dto.setProd_state(1); //물품 상태
		dto.setProd_place((String) param.get("place"));
		dto.setProd_purch_date(LocalDateTime.now().withNano(0)); //등록일자
	    // 날짜 문자열 가져오기
	    String dueDateString = (String) param.get("due_date");

	    // 날짜만 있는 경우에 대한 처리
	    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    LocalDate localDate = LocalDate.parse(dueDateString, dateFormatter);

	    // LocalDateTime으로 변환 (시간은 00:00:00으로 설정)
	    LocalDateTime dueDate = localDate.atStartOfDay();

	    // DTO에 설정
	    dto.setProd_dispo_date(dueDate);
		
		
		int row = resourceMgDAO.prodWrite(dto);  //물품 등록
		
		return row;
	}

	//물품 상세보기
	public Map<String, Object> prodMgDetail(int prod_idx) {
		ResourceManageDTO dto= resourceMgDAO.prodMgDetail(prod_idx);
		ResourceManageDTO empl =resourceMgDAO.rentEmpl(dto.getProd_rent_empl_idx());
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
		Map<String, Object> map = new HashMap<String, Object>();
		dto.getProd_dispo_date();
		dto.getProd_rent_date();
		dto.getProd_return_date();
		dto.getProd_exp_date();
		dto.getProd_purch_date();
        // 날짜 포맷
        Map<String, String> formattedDates = new HashMap<>();
        formattedDates.put("prodDispoDate", formatDateTime(dto.getProd_dispo_date()));
        formattedDates.put("prodRentDate", formatDateTime(dto.getProd_rent_date()));
        formattedDates.put("prodReturnDate", formatDateTime(dto.getProd_return_date()));
        formattedDates.put("prodExpDate", formatDateTime(dto.getProd_exp_date()));
        formattedDates.put("prodPurchDate", formatDateTime(dto.getProd_purch_date()));
        
        // Model에 Map 객체 추가
        map.put("formattedDates", formattedDates);
		map.put("dto", dto);
		map.put("empl", empl);
		return map;
	}

	
	//물품 상세 첨부파일 보기(테이블 추가 필요할 것으로 예상)
	public List<ResourcePhotoDTO> prodMgFile(int prod_idx) {
		//(첨부파일키 추가 필요)
		List<String> fileKeys = resourceMgDAO.getProdFileKey(prod_idx);
		List<ResourcePhotoDTO> fileList = new ArrayList<ResourcePhotoDTO>();
	    for (String fileKey : fileKeys) {
	        // fileKey를 기반으로 ResourcePhotoDTO 객체를 가져옴
	        ResourcePhotoDTO file = resourceMgDAO.prodMgFile(fileKey);
	        if (file != null) {
	            fileList.add(file); // 가져온 파일 정보를 리스트에 추가
	        }
	    }
		
		return fileList;
	}
	
	
    // 날짜 포맷 함수 (LocalDateTime을 포맷하는 함수)
    private String formatDateTime(LocalDateTime dateTime) {
        if (dateTime == null) return "";  // null 값 처리
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return dateTime.format(formatter);
    }

	//물품 대여 기록 가져오기
	public Map<String, Object> rentManageList(int page, int cnt, int prodIdx) {
		
		
		logger.info("현재 페이지:"+page);	
		logger.info("한 페이지에 보여줄 갯수: "+cnt);
		logger.info("물품 번호: "+prodIdx);

		
		int limit = cnt;
		int offset = (page-1)*cnt ; //0~19, 20~39, 40~59, 60~79
		
		int totalPages = resourceMgDAO.allHisCount(cnt, prodIdx);
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currPage", page);
		result.put("list", resourceMgDAO.rentManageList(limit,offset,prodIdx));
		
		
		return result;
	}

	//대여 승인
	@Transactional
	public int permitProd(int prod_idx,int prod_rent_idx) {
		resourceMgDAO.permitProd(prod_idx);
		int row = resourceMgDAO.permitProdState(prod_rent_idx);
		return row;
		
	}

	//물품 반납
	@Transactional
	public boolean permitReturn(int prod_idx,int prod_rent_idx) {
		boolean success = false;
		int  row = resourceMgDAO.permitReturn(prod_idx); //대여가능으로 업뎃
		ResourceManageDTO dto = new ResourceManageDTO();
		dto.setProd_exp_date(resourceMgDAO.getExpDate(prod_rent_idx));
	    LocalDateTime returnDate = LocalDateTime.now().withNano(0); // 현재 날짜 및 시간 (밀리초 제거)
	    dto.setProd_return_date(returnDate);

	    // 반납 예정일시
	    LocalDateTime dueDate = dto.getProd_exp_date(); // DTO에서 예정일시 가져오기

	    // 반납일시와 예정일시 비교
	    if (dueDate != null && returnDate.isAfter(dueDate)) {
	        dto.setProd_return_state(3); // 반납 상태를 3으로 설정 (연체 반납)
	    } else {
	        dto.setProd_return_state(1); // 정상 반납
	    }
		dto.setProd_rent_idx(prod_rent_idx);
		int isReturn = resourceMgDAO.insertReturnDate(dto);
		if(row !=0 && isReturn !=0) {
			success = true;
		}
		return success;
	}

	//물품 정보 가져오기
	public Map<String, Object> getProductinfo(int prod_idx) {
		ResourceManageDTO product = resourceMgDAO.getProductinfo(prod_idx);
		//(첨부파일키 추가 필요)
		List<String> fileKeys = resourceMgDAO.getProdFileKey(prod_idx);
		List<ResourcePhotoDTO> files = new ArrayList<ResourcePhotoDTO>();
	    for (String fileKey : fileKeys) {
	        // fileKey를 기반으로 ResourcePhotoDTO 객체를 가져옴
	        ResourcePhotoDTO file = resourceMgDAO.prodMgFile(fileKey);
	        if (file != null) {
	            files.add(file); // 가져온 파일 정보를 리스트에 추가
	        }
	    }
	    
		Map<String, Object> prodInfo = new HashMap<String, Object>();
		List<ResourceManageDTO> categoryList = resourceMgDAO.resourceCateMg();
		prodInfo.put("prodDispoDate", formatDateTime(product.getProd_dispo_date()));
		prodInfo.put("product", product);
		prodInfo.put("files", files);
		prodInfo.put("categoryList", categoryList);
		return prodInfo;
	}

	//물품정보 수정(파일O)
	@Transactional
	public int prodUpdate(List<MultipartFile> validFiles, Map<String, Object> map) {
		ResourceManageDTO dto = new ResourceManageDTO();
		dto.setProd_idx(Integer.parseInt((String) map.get("number")));
		dto.setProd_name((String) map.get("subject"));
		dto.setProd_model((String) map.get("information"));
		dto.setProd_cate_idx(Integer.parseInt((String) map.get("category")));
		dto.setProd_info((String) map.get("content"));
		dto.setProd_state(Integer.parseInt((String) map.get("state"))); //물품 상태
		dto.setProd_place((String) map.get("place"));
	    // 날짜 문자열 가져오기
	    String dueDateString = (String) map.get("due_date");

	    // 날짜만 있는 경우에 대한 처리
	    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    LocalDate localDate = LocalDate.parse(dueDateString, dateFormatter);

	    // LocalDateTime으로 변환 (시간은 00:00:00으로 설정)
	    LocalDateTime dueDate = localDate.atStartOfDay();
	    
	    // DTO에 설정
	    dto.setProd_dispo_date(dueDate);
		
		int row = 0;
		resourceMgDAO.prodUpdate(dto);  //물품 등록
		int prod_idx = dto.getProd_idx();
		
		logger.info("prod_idx:"+prod_idx);
		
		if(prod_idx > 0) {
			logger.info("여기 들어왔다고");
			List<String> fileKeys = resourceMgDAO.getProdFileKey(prod_idx);
			for (String fileKey : fileKeys) {
				resourceMgDAO.prodFileRemove(prod_idx,fileKey);
				resourceMgDAO.prodFileKeyRemove(prod_idx,fileKey);				
			}
			row = prodFileAdd(validFiles, prod_idx);
		}
		
		return row;	
	}

	//물품정보 수정(파일X)
	public int prodOnlyUpdate(Map<String, Object> map) {
		ResourceManageDTO dto = new ResourceManageDTO();
		dto.setProd_idx(Integer.parseInt((String) map.get("number")));
		dto.setProd_name((String) map.get("subject"));
		dto.setProd_model((String) map.get("information"));
		dto.setProd_cate_idx(Integer.parseInt((String) map.get("category")));
		dto.setProd_info((String) map.get("content"));
		dto.setProd_state(Integer.parseInt((String) map.get("state"))); //물품 상태
		dto.setProd_place((String) map.get("place"));
	    // 날짜 문자열 가져오기
	    String dueDateString = (String) map.get("due_date");

	    // 날짜만 있는 경우에 대한 처리
	    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    LocalDate localDate = LocalDate.parse(dueDateString, dateFormatter);

	    // LocalDateTime으로 변환 (시간은 00:00:00으로 설정)
	    LocalDateTime dueDate = localDate.atStartOfDay();
	    
	    // DTO에 설정
	    dto.setProd_dispo_date(dueDate);
		
		int row = 0;
		row = resourceMgDAO.prodUpdate(dto);  //물품 등록

		return row;
	}


}
