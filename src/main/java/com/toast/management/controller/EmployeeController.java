package com.toast.management.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.toast.dataconfig.DataConfig;
import com.toast.management.dao.EmployeeDAO;
import com.toast.management.dto.DepartmentDTO;
import com.toast.management.dto.DutyDTO;
import com.toast.management.dto.EmployeeDTO;
import com.toast.management.dto.EmployeeDetailDTO;
import com.toast.management.dto.PositionDTO;
import com.toast.management.service.EmployeeService;
import com.toast.member.dto.FileDTO;
import com.toast.member.service.MemberService;



@Controller
public class EmployeeController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PasswordEncoder encoder;
	@Autowired EmployeeDAO employeeDAO;
	
	// spring.servlet.multipart.location=C:/files 이 경로로 주입. !!! 파일 저장위치 !!!
    @Value("${spring.servlet.multipart.location}")
    private String uploadAddr;
    private final DataConfig dataconfig;

	private final EmployeeService employeeService;
	private final MemberService memberService;
	
	public EmployeeController(EmployeeService employeeService,DataConfig dataconfig,MemberService memberService) {
		this.employeeService = employeeService;
		this.dataconfig = dataconfig;
		this.memberService = memberService;
	}
	
	@GetMapping(value="/employee_add.go")
	public String employeeAddGo(Model model) {
		
		//	employeeService.getbankname();
		
		// model.addAllAttributes(null);
		
		return "manage_employee_regist";
	}
	
	@PostMapping(value="/employee_add.do")
	public String employeeAddDo(@RequestParam(value ="files", required = false) MultipartFile[] files,@RequestParam(value ="singleFile", required = false) MultipartFile singleFile ,@RequestParam Map<String,String> param) {
		String empl_gender = param.get("gender");
		
		param.put("empl_gender", empl_gender);
		
		employeeService.employeeAdd(files,singleFile,param);
		
		return "redirect:/manage_employee_list.go";
	}
	
	@GetMapping(value="/employee_detail.go")
	public String employeeDetailGo(@RequestParam String empl_idx,Model model) {
		
		//	employeeService.getbankname();
		// model.addAllAttributes(null);
	
		employeeService.employeeDetail(empl_idx,model);
		
		return "manage_employee_detail";
	}
	
	@GetMapping(value="/manage_employee_update.go")
	public String employeeUpdateGo(@RequestParam String empl_idx,Model model) {
		
		//	employeeService.getbankname();
		// model.addAllAttributes(null);
	
		employeeService.employeeDetail(empl_idx,model);
		
		return "manage_employee_update";
	}
	
	@ResponseBody
	@PostMapping(value = "/empl_file_upload.do")
	public ResponseEntity<List<FileDTO>> fileUpload(@RequestParam(value ="files", required = false) MultipartFile[] files,@RequestParam String empl_idx ,Model model,HttpServletResponse response) {
	
		try {
			// 파일 업로드 실행
			employeeService.emplfileUpload(files,empl_idx);
	        List<FileDTO> fileList = employeeService.getemplUploadedFiles(empl_idx);  // 업로드된 파일 리스트
	        response.sendRedirect("./employee_detail.go?empl_idx=" + empl_idx); // 상대경로 설정
	      //  return ResponseEntity.ok(fileList);
	        return null;
		} catch (IOException e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}

	}
	
	
	@PostMapping(value = "/empl_stamp_upload.do")
	public String emplStampUpload(@RequestParam(value ="singleFile", required = false) MultipartFile singleFile ,@RequestParam String empl_idx ,Model model) {
		
		logger.info("직인 업로드 직원 idx : "+empl_idx);
		
		// 안쓰는 쿼리
		EmployeeDTO emplinfo = employeeDAO.employeeDetail(empl_idx);
		String empl_stamp =	emplinfo.getEmpl_stamp();
		
	    try {
	                employeeService.emplStampUpload(singleFile,empl_idx);
	       
	    } catch (Exception e) {
	        // 다른 예외 발생 시
	        e.printStackTrace();
	        
	    }
	    return "redirect:/employee_detail.go?empl_idx="+empl_idx;
	}
	
	// 사원 인사발령
	@PostMapping(value="/employee_appo.do")
	public String employeeAppoDo(@RequestParam String empl_idx,String dept_idx,String position_idx,String duty_idx,String movein_date,String empl_duty) {
		
		logger.info(empl_idx);
		logger.info(dept_idx);
		logger.info(position_idx);
		logger.info(duty_idx);
		logger.info(movein_date);
		
		// 처리한사원번호 >> 세션추가하고 세션아이디넣기 > 세션아이디로 사원번호 가져오기
		employeeService.employeeAppoDo(empl_idx,dept_idx,position_idx,duty_idx,movein_date,empl_duty);
		
		return "redirect:/employee_detail.go?empl_idx="+empl_idx;
	}
	
	// 사원 근무상태 변경
	@PostMapping(value="/employee_change.do")
	public String employeeChangeDo(@RequestParam String empl_idx,String statement_idx) {
		
		logger.info(empl_idx);
		logger.info(statement_idx);
		
		// 처리한사원번호 >> 세션추가하고 세션아이디넣기 > 세션아이디로 사원번호 가져오기
		
		employeeService.employeeChangeDo(empl_idx,statement_idx);
		
		return "redirect:/employee_detail.go?empl_idx="+empl_idx;
	}
	
	// 파일 삭제
	@GetMapping(value="/empl_file_del.do/{new_filename}/{empl_idx}")
	public String emplFileDel(@PathVariable String new_filename,@PathVariable String empl_idx) {
		String page = "";
		if(employeeService.emplFileDel(new_filename)) { // 파일 삭제 성공하면
			page = "redirect:/employee_detail.go?empl_idx="+empl_idx;
		}
		
		return page;
	}
	
	@GetMapping(value = "/employee_list.ajax")
    @ResponseBody // 데이터를 JSON 형식으로 반환
    public List<EmployeeDetailDTO> getEmployeeList() {
        // 예제 데이터 생성
        List<EmployeeDetailDTO> employees = new ArrayList<>();
        employees = employeeService.getEmployeeList();
        
        
        return employees;
    }
	
	@GetMapping(value="/staff_list.go")
	public String staffListGo(@RequestParam(value ="dept_idx", required = false) String dept_idx,Model model,HttpSession session) {
		
		String page = "";
		
		// 로그인 세션아이디 가져오기
		String id = (String) session.getAttribute("loginId");
		// 로그인 세션아이디로 empl_idx 가져오기
		int getEmployeeIdx = memberService.getEmployeeIdx(id);
		String empl_idx = String.valueOf(getEmployeeIdx); 
		// 부서장이면 부서 정보 가져오기 
		EmployeeDetailDTO empl_info = employeeService.staffListGo(empl_idx);
		if(empl_info != null) { // 부서장이면
			int deptidx =	empl_info.getDept_idx();
			String dept_idx_ = String.valueOf(deptidx);
			model.addAttribute("empl_info", empl_info);
			
			// 초기 멤버리스트 출력
			model.addAttribute("dept_info",employeeService.getStaffList(dept_idx_));
			page = "manage_staff_list";
		}
		else { // 부서장이 아니면
			page = "redirect:/approval_writing_list.go";
		}
		
		return page;
	}
	
	@GetMapping(value="/staff_list.ajax")
	@ResponseBody
	public List<EmployeeDetailDTO> staffListAjax(@RequestParam(value ="dept_idx", required = false) String dept_idx,
 											     @RequestParam(value = "searchKey", required = false) String searchKey,
										         @RequestParam(value = "searchValue", required = false) String searchValue) {
        // 예제 데이터 생성
        List<EmployeeDetailDTO> employees = new ArrayList<>();
        employees = employeeService.getFilteredStaffList(dept_idx,searchKey,searchValue);
        
        
        return employees;
    }

	@GetMapping(value="/staff_detail.go")
	public String staffDetailGo(@RequestParam(value ="empl_idx", required = false) String empl_idx,Model model) {
		
		EmployeeDetailDTO employee = new EmployeeDetailDTO();
		employee = employeeService.getStaffDetail(empl_idx);
		String enssn2 = employee.getEmpl_ssn2();
		employee.setEmpl_ssn2(empl_idx);
		
		try {
			String dnssn2 = dataconfig.aesCBCDecode(enssn2);
			logger.info("복호화 주민번호 : "+dnssn2);
			employee.setEmpl_ssn2(dnssn2);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Double weekWork = employeeService.getweekWorkRecord(empl_idx);
		
		model.addAttribute("weekWork",weekWork);
		model.addAttribute("empl_info",employee);
		return "manage_staff_detail";
	}
	
	@GetMapping(value="/manage_employee_list.go")
	public String emplListGo() {
		
		
		return "manage_employee_list";
	}
	
	// 사원 모든 리스트(퇴사자 제외)
	@GetMapping(value="/empl_all_list.ajax")
	@ResponseBody
	public List<EmployeeDetailDTO> emplAllList() {
        // 예제 데이터 생성
        List<EmployeeDetailDTO> employees = new ArrayList<>();
        employees = employeeService.emplAllList();

        return employees;
    }
	
	//  가발령인 목록 가져오기
	@GetMapping(value="/empl_pre_all_list.ajax")
	@ResponseBody
	public List<EmployeeDetailDTO> emplPreAllList() {
        // 예제 데이터 생성
        List<EmployeeDetailDTO> employees = new ArrayList<>();
        employees = employeeService.emplPreAllList();

        return employees;
    }
	
	@GetMapping(value="/manage_employee_resign_list.go")
	public String emplresignListGo() {
		
		
		return "manage_employee_resign_list";
	}
	
	// 퇴사자 모든 리스트
	@GetMapping(value="/empl_resign_all_list.ajax")
	@ResponseBody
	public List<EmployeeDetailDTO> emplresignAllList() {
        // 예제 데이터 생성
        List<EmployeeDetailDTO> employees = new ArrayList<>();
        employees = employeeService.emplresignAllList();

        return employees;
    }
	
	@GetMapping(value="/check_duplicate_id.ajax")
	@ResponseBody
	 public Map<String, Boolean> checkDuplicateId(@RequestParam("empl_id") String emplId) {
        // 서비스 레이어에서 중복 체크
        boolean isDuplicate = employeeService.isIdDuplicate(emplId);

        // 결과 반환
        Map<String, Boolean> response = new HashMap<>();
        response.put("isDuplicate", isDuplicate); // true: 중복됨, false: 사용 가능
        return response;
    }
}
