package com.toast.management.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.toast.dataconfig.DataConfig;
import com.toast.management.dao.EmployeeDAO;
import com.toast.management.dto.DepartmentDTO;
import com.toast.management.dto.DutyDTO;
import com.toast.management.dto.EmployeeDTO;
import com.toast.management.dto.PositionDTO;
import com.toast.management.service.EmployeeService;
import com.toast.member.dto.FileDTO;



@Controller
public class EmployeeController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PasswordEncoder encoder;
	@Autowired EmployeeDAO employeeDAO;
	
	// spring.servlet.multipart.location=C:/files 이 경로로 주입. !!! 파일 저장위치 !!!
    @Value("${spring.servlet.multipart.location}")
    private String uploadAddr;
	

	private final EmployeeService employeeService;
	
	public EmployeeController(EmployeeService employeeService) {
		this.employeeService = employeeService;
	
	}
	
	@GetMapping(value="/employeeAdd.go")
	public String employeeAddGo(Model model) {
		
		//	employeeService.getbankname();
		
		// model.addAllAttributes(null);
		
		return "employee_add";
	}
	
	@PostMapping(value="/employeeAdd.do")
	public String employeeAddDo(@RequestParam Map<String,String> param) {
		
		employeeService.employeeAdd(param);
		
		return "";
	}
	
	@GetMapping(value="/employeeDetail.go")
	public String employeeDetailGo(@RequestParam String empl_idx,Model model) {
		
		//	employeeService.getbankname();
		// model.addAllAttributes(null);
	
		employeeService.employeeDetail(empl_idx,model);
		
		return "employee_detail";
	}
	
	@ResponseBody
	@PostMapping(value = "/emplfileUpload.do")
	public ResponseEntity<List<FileDTO>> fileUpload(@RequestParam(value ="file", required = false) MultipartFile[] files,@RequestParam String empl_idx ,Model model) {
	
		try {
			// 파일 업로드 실행
			employeeService.emplfileUpload(empl_idx, files);
	        List<FileDTO> fileList = employeeService.getemplUploadedFiles(empl_idx);  // 업로드된 파일 리스트
			return ResponseEntity.ok(fileList);
		} catch (IOException e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}

	}
	
	
	@PostMapping(value = "/emplStampUpload.do")
	public String emplStampUpload(@RequestParam(value ="singleFile", required = false) MultipartFile singleFile ,@RequestParam String empl_idx ,Model model) {
		
		EmployeeDTO emplinfo = employeeDAO.employeeDetail(empl_idx);
		String empl_stamp =	emplinfo.getEmpl_stamp();
		
		
	    try {
	        // 파일이 업로드되었는지 확인
	        if (singleFile != null && !singleFile.isEmpty()) {
	            String uploadedFilename = singleFile.getOriginalFilename(); // 업로드된 파일 이름

	            // DB에 저장된 파일 이름과 비교
	            if (empl_stamp == null || !empl_stamp.equals(uploadedFilename)) {
	                
	                // 파일 업로드 처리 (직인 파일 업로드)
	                employeeService.emplStampUpload(empl_idx, singleFile);

	                // 업로드가 완료되면 새로운 파일 이름을 반환
	                
	            } 
	        } 
	    } catch (Exception e) {
	        // 다른 예외 발생 시
	        e.printStackTrace();
	        
	    }
	    return "redirect:/employeeDetail.go"+empl_idx;
	}
	
	// 사원 인사발령
	@PostMapping(value="/employeeAppo.do")
	public String employeeAppoDo(@RequestParam String empl_idx,String dept_idx,String position_idx,String duty_idx,String movein_date) {
		
		logger.info(empl_idx);
		logger.info(dept_idx);
		logger.info(position_idx);
		logger.info(duty_idx);
		logger.info(movein_date);
		
		// 처리한사원번호 >> 세션추가하고 세션아이디넣기 > 세션아이디로 사원번호 가져오기
		employeeService.employeeAppoDo(empl_idx,dept_idx,position_idx,duty_idx,movein_date);
		
		return "redirect:/employee_detail";
	}
	
	// 사원 근무상태 변경
	@PostMapping(value="/employeeChange.do")
	public String employeeChangeDo(@RequestParam String empl_idx,String statement_idx) {
		
		logger.info(empl_idx);
		logger.info(statement_idx);
		
		// 처리한사원번호 >> 세션추가하고 세션아이디넣기 > 세션아이디로 사원번호 가져오기
		
		employeeService.employeeChangeDo(empl_idx,statement_idx);
		
		return "redirect:/employee_detail";
	}
	
}
