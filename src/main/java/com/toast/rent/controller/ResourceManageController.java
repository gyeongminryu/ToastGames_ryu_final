package com.toast.rent.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.toast.rent.dto.ResourceDTO;
import com.toast.rent.dto.ResourceManageDTO;
import com.toast.rent.dto.ResourcePhotoDTO;
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
		//dept_idx = (int) session.getAttribute("dept_idx"); //세션에 저장한 사원 부서idx 가져와
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
	@GetMapping(value="/manageCategroySearch.ajax") 
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
	/*@RequestMapping(value="/prodMgDetail.go")
	public String prodDetail(@RequestParam("prod_idx") int prod_idx, Model model) {
		logger.info("prod_idx:"+prod_idx);
		ResourceDTO detail = resourceMgService.prodMgDetail(prod_idx);
		model.addAttribute("detail", detail);
		//model.addAttribute("file", file);
		return "rent_detail";
	}
	
	//물품 상태 상세보기
	@GetMapping(value = "/prodStateDetail.ajax")
	@ResponseBody
	public ResourceDTO prodRentDetail(@RequestParam("prod_idx") int prod_idx) {
	    return resourceMgService.prodStateDetail(prod_idx);
	}*/
	
	
	//물품 등록 가기
	@RequestMapping(value="/manage_rent_write.go")
	public String rentManageWrite(Model model) {
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
			page = "manage_rent_write";
		}
		return page;
	}
	
	
	//물품 등록(카테고리, 사용 기한, 첨부파일 포함)
	@PostMapping(value="/productAdd.do")
	@ResponseBody
	public Map<String, Object> productWrite(
			@RequestParam("attached_file") List<MultipartFile> attachedFiles,
	        @RequestParam("subject") String subject,
	        @RequestParam("information") String information,
	        @RequestParam("content") String content,
	        @RequestParam("category") String category,
	        @RequestParam("due_date") String dueDate,
	        @RequestParam("place") String place
	        ) {
		Map<String, Object> response = new HashMap<>();
	    try {
	        // 파라미터 값 로깅
	        logger.info("subject: " + subject);
	        logger.info("information: " + information);
	        logger.info("content: " + content);
	        logger.info("category: " + category);
	        logger.info("due_date: " + dueDate);

	        empl_idx = (int) session.getAttribute("empl_idx");
	        Map<String, Object> map = new HashMap<String, Object>();
	        
	        map.put("subject", subject);
	        map.put("information", information);
	        map.put("content", content);
	        map.put("category", category);
	        map.put("due_date", dueDate);
	        map.put("place", place);
	        map.put("empl_idx", empl_idx);
	        

	        if (attachedFiles != null && !attachedFiles.isEmpty()) {
	            List<MultipartFile> validFiles = new ArrayList<>();

	            for (MultipartFile file : attachedFiles) {
	                if (file.getOriginalFilename() != null 
	                        && !file.getOriginalFilename().isEmpty() 
	                        && file.getSize() > 0) {
	                    validFiles.add(file);
	                }
	            }

	            if (!validFiles.isEmpty()) {
	                resourceMgService.prodWrite(validFiles, map);
	                for (MultipartFile file : validFiles) {
	                    logger.info("파일 이름: " + file.getOriginalFilename());
	                    logger.info("파일 크기: " + file.getSize() + " bytes");
	                }
	            } else {
	                logger.info("유효한 파일이 없습니다.");
	            }
	        } else {
	            resourceMgService.prodOnlyWrite(map);
	            logger.info("업로드된 파일이 없습니다.");
	        }


	        // 성공적으로 처리된 경우
	        response.put("status", "success");
	        response.put("redirectUrl", "/manage_rent_list.go");

	    } catch (Exception e) {
	        logger.error("파일 업로드 또는 데이터 처리 중 오류 발생", e);
	        response.put("status", "error");
	        response.put("message", "Error processing request: " + e.getMessage());
	        // 오류 처리 페이지로 리다이렉트
	    }
	    return response;
	}
	
	
	//물품 상세보기
	@GetMapping(value="/prodMgDetail.go")
	public String prodMgDetail(@RequestParam("prod_idx") int prod_idx, Model model) {
		logger.info("prod_idx:"+prod_idx);
		Map<String, Object> detail = resourceMgService.prodMgDetail(prod_idx);
		
		List<ResourcePhotoDTO> files = resourceMgService.prodMgFile(prod_idx);
		model.addAttribute("detail", detail);
		model.addAttribute("files", files);
		return "manage_rent_detail";
	}
	
	//물품 기한 ajax
	@GetMapping(value="/prodDate.ajax")
	@ResponseBody
	public Map<String, Object> prodDate(@RequestParam int prod_idx){
		Map<String, Object> detail = resourceMgService.prodMgDetail(prod_idx);
		return detail;	
	}
	
	//물품 대여기록가져오기
	@GetMapping(value="/rentManageList.ajax")
	@ResponseBody
	public Map<String, Object> rentManageList(String page, String cnt, String prod_idx) {
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		int prodIdx = Integer.parseInt(prod_idx);
		Map<String, Object> list = resourceMgService.rentManageList(page_,cnt_,prodIdx);
		return list;
	}
	
	
	//물품 정보 수정(카테고리, 사용 기한, 첨부파일 포함)
	@GetMapping(value="/manage_rent_update.go")
	public String rentUpdate(@RequestParam int prod_idx, Model model) {
		logger.info("prod_idx:"+prod_idx);
		Map<String, Object> detail = resourceMgService.getProductinfo(prod_idx);		
		List<ResourcePhotoDTO> files = resourceMgService.prodMgFile(prod_idx);
		model.addAttribute("detail", detail);
		model.addAttribute("files", files);
		return "manage_rent_update";
	}
	
	
	//물품 정보수정
	@PostMapping(value="/productUpdate.do")
	@ResponseBody
	public Map<String, Object> productUpdate(
			@RequestParam("attached_file") List<MultipartFile> attachedFiles,
	        @RequestParam("subject") String subject,
	        @RequestParam("number") String number,
	        @RequestParam("information") String information,
	        @RequestParam("content") String content,
	        @RequestParam("category") String category,
	        @RequestParam("due_date") String dueDate,
	        @RequestParam("place") String place,
	        @RequestParam("state") String prod_state
	        ) {
		Map<String, Object> response = new HashMap<>();
	    try {
	        // 파라미터 값 로깅
	        logger.info("subject: " + subject);
	        logger.info("information: " + information);
	        logger.info("content: " + content);
	        logger.info("category: " + category);
	        logger.info("due_date: " + dueDate);

	        
	        Map<String, Object> map = new HashMap<String, Object>();
	        
	        map.put("number", number);
	        map.put("subject", subject);
	        map.put("information", information);
	        map.put("content", content);
	        map.put("category", category);
	        map.put("due_date", dueDate);
	        map.put("place", place);
	        map.put("state", prod_state);
	        
	        

	        if (attachedFiles != null && !attachedFiles.isEmpty()) {
	            List<MultipartFile> validFiles = new ArrayList<>();

	            for (MultipartFile file : attachedFiles) {
	                if (file.getOriginalFilename() != null 
	                        && !file.getOriginalFilename().isEmpty() 
	                        && file.getSize() > 0) {
	                    validFiles.add(file);
	                }
	            }

	            if (!validFiles.isEmpty()) {
	                resourceMgService.prodUpdate(validFiles, map);
	                for (MultipartFile file : validFiles) {
	                    logger.info("파일 이름: " + file.getOriginalFilename());
	                    logger.info("파일 크기: " + file.getSize() + " bytes");
	                }
	            } else {
	                logger.info("유효한 파일이 없습니다.");
	            }
	        } else {
	            resourceMgService.prodOnlyUpdate(map);
	            logger.info("업로드된 파일이 없습니다.");
	        }


	        // 성공적으로 처리된 경우
	        response.put("status", "success");
	        response.put("redirectUrl", "/manage_rent_list.go");

	    } catch (Exception e) {
	        logger.error("파일 업로드 또는 데이터 처리 중 오류 발생", e);
	        response.put("status", "error");
	        response.put("message", "Error processing request: " + e.getMessage());
	        // 오류 처리 페이지로 리다이렉트
	    }
	    return response;
	}
	
	
	
	
	
	//물품 목록보기
	
	
	
	
	
	//물품 대여 신청 승인(대여 여부 업뎃)
	@GetMapping(value="/permitProd.do")
	@ResponseBody
	public Map<String, String> permitProd(@RequestParam int prod_rent_idx, @RequestParam int prod_idx) {
		int row = resourceMgService.permitProd(prod_idx, prod_rent_idx);
		Map<String, String> response = new HashMap<String, String>();
		if(row >0) {
			response.put("redirectUrl", "/manage_rent_list.go?prod_idx=" + prod_idx);
		}
		return response;
	}
	
	//물품 반납 승인(대여 여부 업뎃)
	@GetMapping(value="/permitReturn.do")
	@ResponseBody
	public Map<String, String> permitReturn(@RequestParam int prod_rent_idx, @RequestParam int prod_idx) {
		boolean success = resourceMgService.permitReturn(prod_idx, prod_rent_idx);
		Map<String, String> response = new HashMap<String, String>();
		if(success) {
			response.put("redirectUrl", "/manage_rent_list.go?prod_idx=" + prod_idx);
		}
		return response;
	}
	
	
	
	
	//사용연한다되면물품 상태 0으로 업뎃
	
		
	//연체시 상태 업뎃(prod_return_state: 2)
	
	
	//대여 승인 시 반납일정 일정 표시
	
	
	
	//물품 인계 승인
	
	
	
	//물품 폐기 처리
	
	
	
	
	
	
	//
	
	
	
}
