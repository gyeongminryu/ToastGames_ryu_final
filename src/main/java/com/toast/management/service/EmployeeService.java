package com.toast.management.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.toast.dataconfig.DataConfig;
import com.toast.management.dao.DepartmentDAO;
import com.toast.management.dao.EmployeeDAO;
import com.toast.management.dto.AppointmentDTO;
import com.toast.management.dto.DepartmentDTO;
import com.toast.management.dto.DutyDTO;
import com.toast.management.dto.EmployeeDTO;
import com.toast.management.dto.MainFileDTO;
import com.toast.management.dto.PositionDTO;

@Service
public class EmployeeService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PasswordEncoder encoder;
	@Autowired DepartmentDAO deptDAO;
	
	private final EmployeeDAO employeeDAO;
	
	private final DataConfig dataconfig;
	
	public EmployeeService(EmployeeDAO employeeDAO,DataConfig dataconfig) {
		this.employeeDAO = employeeDAO;
		this.dataconfig = dataconfig;
		
	}

	public void employeeAdd(Map<String, String> param) {
		
		String file_key = UUID.randomUUID().toString();
		// empl_stamp , empl_profile >> uuid 파일 키 사용안하고 newfilename 넣어서 저장된 이름 경로 사용하기
		String empl_stamp = UUID.randomUUID().toString();
		String empl_profile = UUID.randomUUID().toString();
		param.put("file_key", file_key);
		param.put("empl_profile", empl_profile);
		param.put("empl_stamp", empl_stamp);
		String pw = param.get("empl_pw");
		String encodepw = encoder.encode(pw); // 스프링 시큐리티 사용한 암호화 비밀번호
		param.put("empl_pw", encodepw);
		
		
		try {
			String ssn2 = param.get("empl_ssn2");
			// 주민번호 뒷자리 암호화 시키기
			String encodessn2 = dataconfig.aesCBCEncode(ssn2);
			param.put("empl_ssn2", encodessn2);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		logger.info("param : "+param);
		logger.info("암호화 주민번호 : "+param.get("empl_ssn2"));
		logger.info("암호화 비밀번호 : "+param.get("empl_pw"));
		logger.info("파일키 : "+param.get("file_key"));
		try {
			logger.info("복호화 주민번호 : "+dataconfig.aesCBCDecode(param.get("empl_ssn2")));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		employeeDAO.employeeAdd(param);
		
		
		
	} // employeeAdd(MultipartFile[] files, Map<String, String> param)
	
	// 직원 상세보기 
	public void employeeDetail(String empl_idx,Model model) { // 직원 상세보기, 직급 직책 부서, 인사변경내역, 첨부파일, 직인 가져오기
		AppointmentDTO appolast = new AppointmentDTO();
		List<AppointmentDTO> appoList = new ArrayList<>();
		EmployeeDTO employee = new EmployeeDTO();
		List<MainFileDTO> file = new ArrayList<>();
		// 직원 정보 
		employee = employeeDAO.employeeDetail(empl_idx);
		// 직원 직급 직책 부서 가져오기 - 발령정보중 가장 최근꺼 가져오기
		appolast = employeeDAO.employeeAppolast(empl_idx);
		// 직원 발령정보
		appoList = employeeDAO.employeeAppoList(empl_idx);
		// 직원 첨부파일 가져오기 >> employeeDAO.employeeDetail(empl_idx); 에서 가져온 파일키 넣기
		String file_key =employee.getFile_key();
		file = employeeDAO.employeeFile(file_key);
		
		  model.addAttribute("employee", employee);
	        model.addAttribute("appoLast", appolast);
	        model.addAttribute("appoList", appoList);
	        model.addAttribute("file", file);
		
	} // public void employeeDetail(String empl_idx,Model model)



	// 인사발령 서비스
	@Transactional
	public void employeeAppoDo(String empl_idx, String dept_idx, String position_idx, String duty_idx,
			String movein_date) {
		AppointmentDTO appolast = new AppointmentDTO();
		appolast = employeeDAO.employeeAppolast(empl_idx);
		EmployeeDTO employee = employeeDAO.employeeDetail(empl_idx);
		int dutyidx = Integer.parseInt(duty_idx);
		String empl_job = employee.getEmpl_job();
		// employeeappodo 에 직무 넣기 >> 직원의 직무 가져와서 넣기?
		
		if(appolast==null) { // 이전 인사발령 이력이 없으면
			employeeDAO.employeeAppoDo(empl_idx,dept_idx,position_idx,duty_idx,movein_date,empl_job);
		}
		else { // 인사발령이력이 있으면
		int appo_idx =appolast.getAppo_idx();
			employeeDAO.employeeAppoDo(empl_idx,dept_idx,position_idx,duty_idx,movein_date,empl_job);
			// 전출날짜 넣기
			employeeDAO.employeeTransfer(appo_idx,movein_date);
		}
		
		if(dutyidx>1 && dutyidx <5) { // 부서장 직책이라면? 사장 ~ 팀장이라면 사장idx = 2 부장idx=3 팀장idx=4
			// department의 head_idx가 비어있지 않으면 - 부서장이 있는 경우라면 
			DepartmentDTO dept =deptDAO.getdeptinfo(dept_idx);			
			int head_idx = dept.getDept_head_idx();
			
			if(head_idx != 0) { // 이전 부서장이 존재한다면
				AppointmentDTO appolasthead = new AppointmentDTO();
				String headidx = String.valueOf(head_idx);
				appolasthead = employeeDAO.employeeAppolast(headidx);
				int head_appo_idx = appolasthead.getAppo_idx();
				String headdudy = String.valueOf(20);
				employeeDAO.employeeAppoDo(headidx,dept_idx,position_idx,headdudy,movein_date,empl_job);
				// 전출날짜 넣기
				employeeDAO.employeeTransfer(head_appo_idx,movein_date);
			}
			
			// 부서장인데 부서장으로 발령한다면? >> dept 테이블에서 empl_idx 조회 만약 있다면 부서장이다 
			if(employeeDAO.deptheadcheck(empl_idx)>0) {
				// 이전 부서의 head_idx를 null로 바꿈
				employeeDAO.deptheadmoveout(empl_idx);
			}
			
			// department 테이블에 부서장 업데이트
			employeeDAO.deptHeadAdd(dept_idx,empl_idx);
					
		} // public void employeeAppoDo(String empl_idx, String dept_idx, String position_idx, String duty_idx,String movein_date)
		
		
		
	}
	
	// 직원 퇴사, 근무, 휴직 처리
	public void employeeChangeDo(String empl_idx, String statement_idx) {
		if(statement_idx.equals("3")) { // 퇴직처리이면
		employeeDAO.employeeResigDo(empl_idx,statement_idx);
		}else {
		employeeDAO.employeeChangeDo(empl_idx,statement_idx);
		}
	}
	

	
}
