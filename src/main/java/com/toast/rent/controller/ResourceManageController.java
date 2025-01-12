package com.toast.rent.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
	
	
	
	// 파일 경로 관리
	//관리부서 변경 시 idx 변경 가능
	
	
	/*공용 물품 관리*/ //-- -관리자 확인 해야함(로그인 & 부서 확인일듯)--------
	//물품관리 메인 이동
	@RequestMapping(value="/manage_rent_list.go")
	public String rentManageMain(Model model) {
		String loginId = (String) session.getAttribute("loginId");
		ResourceManageDTO dto =  resourceMgService.getEmplMg(loginId);
		session.setAttribute("empl_idx",dto.getEmpl_idx()); //사원 idx가져와
		//session.setAttribute("dept_idx",dto.getDept_idx());//사원 부서 가져와
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
	
	
	//물품 등록 가기
	@RequestMapping(value="/manage_rent_write.go")
	public String rentManageWrite(Model model) {
		String loginId = (String) session.getAttribute("loginId");
		ResourceManageDTO dto =  resourceMgService.getEmplMg(loginId);
		//session.setAttribute("empl_idx",dto.getEmpl_idx()); //사원 idx가져와
		//session.setAttribute("dept_idx",dto.getDept_idx());//사원 부서 가져와
		empl_idx = (int) session.getAttribute("empl_idx");  //세션에 저장한 사원idx 가져와
		//dept_idx = (int) session.getAttribute("dept_idx"); //세션에 저장한 사원 부서idx 가져와
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
	            	resourceMgService.prodOnlyWrite(map);
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
	            	resourceMgService.prodOnlyUpdate(map);
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

	
	//물품 대여 신청 승인(대여 여부 업뎃)
	@GetMapping(value="/permitProd.do")
	@ResponseBody
	@Transactional
	public Map<String, String> permitProd(@RequestParam int prod_rent_idx, @RequestParam int prod_idx) {
		int row = resourceMgService.permitProd(prod_idx, prod_rent_idx);
		Map<String, String> response = new HashMap<String, String>();
		resourceMgService.getReturnInfo(prod_rent_idx); //반납일정 추가정보 가져오기/일정 추가
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
	
	
	//폐기처리 리스트가기
	@RequestMapping(value="/manage_dispose_list.go")
	public String dispoListGo(Model model) {
		String loginId = (String) session.getAttribute("loginId");
		ResourceManageDTO dto =  resourceMgService.getEmplMg(loginId);
		//session.setAttribute("empl_idx",dto.getEmpl_idx()); //사원 idx가져와
		//session.setAttribute("dept_idx",dto.getDept_idx());//사원 부서 가져와
		empl_idx = (int) session.getAttribute("empl_idx");  //세션에 저장한 사원idx 가져와
		dept_idx = (int) session.getAttribute("dept_idx"); //세션에 저장한 사원 부서idx 가져와
		//dept_idx=122;
		String page = "rent_list";
		if(dept_idx == 122) {	
			List<ResourceManageDTO> categoryList =resourceMgService.resourceCateMg(); //카테고리 가져와
			model.addAttribute("categoryList", categoryList);
			page = "manage_dispose_list";
		}
		return page;
	}
	
	
	
	//카테고리 검색 목록 가져오기(폐기)
	@GetMapping(value="/dispoCategroySearch.ajax") 
	@ResponseBody
	public Map<String, Object> dispoCategroySearch(
	        @RequestParam("keyword") String keyword) {
	    return resourceMgService.categroySearch(keyword); // 특정 카테고리
	}

	
	//카테고리별 목록(폐기)
	@GetMapping(value="/manageDispoList.ajax")  
	@ResponseBody
	public Map<String, Object> manageDispoList(
			@RequestParam("page") String page, 
	        @RequestParam("cnt") String cnt, 
	        @RequestParam("category") String category) {
		
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
	    // 카테고리에 따른 처리
	    if ("all".equals(category)) {
	        return resourceMgService.dispoList(page_, cnt_); // 전체 보기
	    } else {
	        return resourceMgService.dispoFilterList(category, page_, cnt_); // 특정 카테고리
	    }
	}
	
	
	
	//물품 검색별 보기
	@PostMapping(value="/manageDispoSearch.ajax")
	@ResponseBody
	public Map<String, Object> manageDispoSearch(
            @RequestParam("page") String page,
            @RequestParam("cnt") String cnt,
            @RequestParam("category") String category,
            @RequestParam("option") String option,
            @RequestParam("keyword") String keyword){
		
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);

		
	    if ("all".equals(category)) {
	        return resourceMgService.dispoSearch(page_, cnt_,option, keyword); // 전체 보기
	    } else {
	        return resourceMgService.dispoFilterSearch(category, page_, cnt_,option, keyword); // 특정 카테고리
	    }

	}

	
	
	//물품 폐기 처리 가기
	@GetMapping(value="/manage_rent_dispose.go")
	public String dispoGo(@RequestParam("prod_idx") String prod_idx, Model model) {
		int prodIdx = Integer.parseInt(prod_idx);
		resourceMgService.prodInfo(prodIdx, model);
		return "manage_rent_dispose";
	}
	
	
	
	//물품 폐기 처리 하기
	@PostMapping(value="/productDisp.do")
	@ResponseBody
	public Map<String, Object> productDispo(
	        @RequestParam("file") List<MultipartFile> files,
	        @RequestParam("disp_reason") String disp_reason,
	        @RequestParam("prod_idx") String prod_idx
	) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        // 세션 처리: empl_idx가 없을 경우 예외 처리
	        Integer empl_idx = (Integer) session.getAttribute("empl_idx");
	        if (empl_idx == null) {
	            response.put("status", "error");
	            response.put("message", "User not logged in.");
	            return response;
	        }

	        Map<String, Object> map = new HashMap<>();
	        map.put("prod_idx", prod_idx);
	        map.put("dispo_reason", disp_reason);
	        map.put("disp_empl_idx", empl_idx);
	        map.put("disp_state", 0); // 처리 상태: 0 폐기

	        // 파일 처리
	        if (files != null && !files.isEmpty()) {
	            List<MultipartFile> validFiles = new ArrayList<>();

	            for (MultipartFile file : files) {
	                if (file.getOriginalFilename() != null 
	                        && !file.getOriginalFilename().isEmpty() 
	                        && file.getSize() > 0) {
	                    validFiles.add(file);
	                }
	            }

	            if (!validFiles.isEmpty()) {
	            	for (MultipartFile file : validFiles) {
	            		logger.info("파일 이름: " + file.getOriginalFilename());
	            		logger.info("파일 크기: " + file.getSize() + " bytes");
	            	}
	                resourceMgService.prodDispo(validFiles, map);
	            } else {
	                logger.info("유효한 파일이 없습니다.");
	            }
	        } else {
	            resourceMgService.prodOnlyDispo(map);
	            logger.info("업로드된 파일이 없습니다.");
	        }

	        // 성공적인 처리
	        response.put("status", "success");
	        response.put("redirectUrl", "/manage_rent_list.go");

	    } catch (Exception e) {
	        logger.error("파일 업로드 또는 데이터 처리 중 오류 발생", e);
	        response.put("status", "error");
	        response.put("message", "Error processing request: " + e.getMessage());
	    }
	    return response;
	}

	

	//물품 인계처리 가기
	@GetMapping(value="/manage_rent_transfer.go")
	public String dispoTransferGo(@RequestParam("prod_idx") String prod_idx, Model model) {
		int prodIdx = Integer.parseInt(prod_idx);
		List<ResourceManageDTO> deptList = resourceMgService.getDeptList();
		List<ResourceManageDTO> teamList= resourceMgService.getTeamList();
		model.addAttribute("deptList", deptList);
		model.addAttribute("teamList", teamList);
		resourceMgService.prodInfo(prodIdx, model);
		return "manage_rent_transfer";
	}
	
	//부서별 직원 가져오기
	@GetMapping(value="/getDeptEmpl.ajax")
	@ResponseBody
	public Map<String, Object> getDeptEmpl(@RequestParam("dept_idx") String dept_idx) {
		
		int deptIdx = Integer.parseInt(dept_idx);
		List<ResourceManageDTO> emplList = resourceMgService.getDeptEmpl(deptIdx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emplList", emplList);
		return map;
	}
	

	
	//팀별 직원 가져오기
	@GetMapping(value="/getTeamEmpl.ajax")
	@ResponseBody
	public Map<String, Object> getTeamEmpl(@RequestParam("team_idx") String team_idx) {
		
		int teamIdx = Integer.parseInt(team_idx);
		List<ResourceManageDTO> emplList = resourceMgService.getTeamEmpl(teamIdx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emplList", emplList);
		return map;
	}
	
	
	//사원 검색
	@PostMapping(value="/takeEmplSearch.ajax")
	@ResponseBody
	public Map<String, Object> takeEmplSearch(
			@RequestParam("option") String option, 
			@RequestParam("keyword") String keyword) {
		
		List<ResourceManageDTO> emplList = resourceMgService.takeEmplSearch(option, keyword);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emplList", emplList);
		return map;
		
	}
	
	
	//인수인계처리(진짜)
	@PostMapping(value="/productTransfer.do")
	@ResponseBody
	public Map<String, Object> productTransfer(
	        @RequestParam("file") List<MultipartFile> files,
	        @RequestParam("take_empl_idx") String take_empl_idx,
	        @RequestParam("prod_idx") String prod_idx
	) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        // 세션 처리: empl_idx가 없을 경우 예외 처리
	        Integer empl_idx = (Integer) session.getAttribute("empl_idx");
	        if (empl_idx == null) {
	            response.put("status", "error");
	            response.put("message", "User not logged in.");
	            return response;
	        }

	        Map<String, Object> map = new HashMap<>();
	        map.put("prod_idx", prod_idx);
	        map.put("take_empl_idx", take_empl_idx);
	        map.put("disp_empl_idx", empl_idx);
	        map.put("disp_state", 1); // 처리 상태: 1 인수인계

	        // 파일 처리
	        if (files != null && !files.isEmpty()) {
	            List<MultipartFile> validFiles = new ArrayList<>();

	            for (MultipartFile file : files) {
	                if (file.getOriginalFilename() != null 
	                        && !file.getOriginalFilename().isEmpty() 
	                        && file.getSize() > 0) {
	                    validFiles.add(file);
	                }
	            }

	            if (!validFiles.isEmpty()) {
	            	for (MultipartFile file : validFiles) {
	            		logger.info("파일 이름: " + file.getOriginalFilename());
	            		logger.info("파일 크기: " + file.getSize() + " bytes");
	            	}
	                resourceMgService.prodTransfer(validFiles, map);
	            } else {
	                logger.info("유효한 파일이 없습니다.");
	            }
	        } 

	        // 성공적인 처리
	        response.put("status", "success");
	        response.put("redirectUrl", "/manage_rent_list.go");

	    } catch (Exception e) {
	        logger.error("파일 업로드 또는 데이터 처리 중 오류 발생", e);
	        response.put("status", "error");
	        response.put("message", "Error processing request: " + e.getMessage());
	    }
	    return response;
	}
	
	//사용연한다되면물품 상태 0으로 업뎃
	@Scheduled(cron = "0 0 12 * * ?")
	public void updateProdState() {
		//모든 물품 날짜 확인
		List<ResourceManageDTO> prodList = resourceMgService.allProdList();
		for (ResourceManageDTO product : prodList) {
			int prodIdx = product.getProd_idx();
	        LocalDateTime prodDispoDateTime = product.getProd_dispo_date();

	        // LocalDate로 변환 (시간 정보는 제거)
	        LocalDate prodDispoDate = prodDispoDateTime.toLocalDate();

	        // 오늘 날짜 가져오기
	        LocalDate today = LocalDate.now();

	        // 과거 날짜인지 확인
	        if (prodDispoDate.isBefore(today)) {
	        	//지난거 업뎃
	            resourceMgService.updateProdState(0, prodIdx);
	        } else if (prodDispoDate.isEqual(today)) {
	        	logger.info("Product disposal date is today: " + prodDispoDate);
	        } else {
	            logger.info("Product disposal date is in the future: " + prodDispoDate);
	        }
		}
		
	}
	
	//연체시 상태 업뎃(prod_return_state: 2)
	@Scheduled(cron = "0 0 18 * * ?")
	public void updateReturnState() {
		//모든 물품 날짜 확인
		List<ResourceManageDTO> prodList = resourceMgService.allProdRentList();
		for (ResourceManageDTO product : prodList) {
			int prodRentIdx = product.getProd_rent_idx();
			LocalDateTime prodReturnDateTime = product.getProd_return_date();
	        LocalDateTime prodExpDateTime = product.getProd_exp_date();


	        // 오늘 날짜 가져오기
	        LocalDateTime now = LocalDateTime.now();

	        // 과거 날짜인지 확인
	        if (prodReturnDateTime == null && prodExpDateTime.isBefore(now)) {
	            resourceMgService.updateProdRentState(2, prodRentIdx);
	        } else if (prodExpDateTime.isEqual(now)) {
	        	logger.info("Product disposal date is today: " + prodExpDateTime);
	        } else {
	            logger.info("Product disposal date is in the future: " + prodExpDateTime);
	        }
		}
	}
	
	
	//물품 반납일정 안내
	@Scheduled(cron = "0 0 0 * * ?")
	public void notiReturnDate() {
		//모든 물품 날짜 확인
		List<ResourceManageDTO> prodList = resourceMgService.getRentDate();
		for (ResourceManageDTO product : prodList) {
			// prodExpDateTime에서 날짜만 추출
			LocalDate prodExpDateTime = product.getProd_exp_date().toLocalDate();

			// 오늘 날짜 가져오기
			LocalDate now = LocalDate.now();

			// 오늘 기준으로 1일 전 날짜 계산
			LocalDate oneDayBeforeExp = prodExpDateTime.minusDays(1);

			// 비교
			if (now.isEqual(oneDayBeforeExp)) {
			    // Logger로 출력
				resourceMgService.notiReturn(product);
			    logger.info("Product expiration date is 1 day away: {}", prodExpDateTime);
			}
		}
	}
	
	
	//폐기물품 상세보기
	@GetMapping(value="/manage_dispose_detail.go")
	public String disposeDetail(@RequestParam("prod_idx") String prod_idx, Model model) {
		int prodIdx = Integer.parseInt(prod_idx);
		resourceMgService.dispDetail(prodIdx, model);
	
		return "manage_dispose_detail";
	}
	
	
	//폐기물품 대여기록
	@GetMapping(value="/dispoRentList.ajax")
	@ResponseBody
	public Map<String, Object> dispoRentList(
			@RequestParam("page") String page,
			@RequestParam("cnt") String cnt,
			@RequestParam("prod_idx") String prod_idx
			){
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		int prodIdx = Integer.parseInt(prod_idx);
		return resourceMgService.dispRentList(prodIdx,page_,cnt_);	
	}
	
	
	
}
