package com.toast.management.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.toast.management.dao.DepartmentDAO;
import com.toast.management.dao.EmployeeDAO;
import com.toast.management.dto.AppointmentDTO;
import com.toast.management.dto.DepartmentDTO;
import com.toast.management.dto.DeptDetailMemberDTO;
import com.toast.management.dto.DeptHistoryDTO;
import com.toast.management.dto.DeptInfoTreeDTO;
import com.toast.management.dto.DutyDTO;
import com.toast.management.dto.EmployeeDTO;
import com.toast.management.dto.PositionDTO;

@Service
public class DepartmentService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final DepartmentDAO departmentDAO;
	
	@Autowired EmployeeDAO employeeDAO;
	
	public DepartmentService(DepartmentDAO departmentDAO) {
		this.departmentDAO = departmentDAO;
	}

	public void organizationAdd(Map<String, String> param) {
		String dept_high =	param.get("dept_high");
		logger.info("dept_high : ",dept_high);
		String dept_name = param.get("dept_name");
		String duty_name = dept_name + "장";
		departmentDAO.organizationAdd(param);
	//	departmentDAO.organizationDudyAdd(duty_name);
	
	}

	public List<DutyDTO> getdudy() {
		
		return departmentDAO.getduty();
	}

	public List<PositionDTO> getposi() {
		
		return departmentDAO.getposi();
	}

	public List<DepartmentDTO> getdept() {
		
		return departmentDAO.getdept();
	}

	public DepartmentDTO getdeptinfo(String dept_idx) {
		
		return departmentDAO.getdeptinfo(dept_idx);
	}

	public int organizationUpdate(Map<String, String> param) {
		
		return departmentDAO.organizationUpdate(param);
		
	}

	public List<DeptInfoTreeDTO> getdeptTree() {
		List<DeptInfoTreeDTO> dept = new ArrayList<>();
		dept = departmentDAO.getdeptTree();
		
		List<Map<String, Object>> deptMemberCounts = departmentDAO.getDeptMemberCounts();
		
		// 각 부서에 대해 인원 수 설정
		for (DeptInfoTreeDTO deptInfoTreeDTO : dept) {
		    String dept_idx = deptInfoTreeDTO.getDept_idx();
		    
		    // 부서별 인원 수 찾기
		    String dept_mem_cnt = "0";  // 기본값 설정
		 
		    for (Map<String, Object> result : deptMemberCounts) {
		        // result에서 dept_idx와 member_count 값을 꺼내어 비교
		        String resultDeptIdx = result.get("dept_idx").toString();  // dept_idx를 String으로 변환
		        String resultMemberCount = result.get("member_count").toString();  // member_count를 String으로 변환
   
		        logger.info(resultDeptIdx+" 부서 인원 수 : "+resultMemberCount);
		        
		        // 부서 ID 비교
		        if (resultDeptIdx.equals(dept_idx)) {
		            dept_mem_cnt = resultMemberCount;  // 인원 수 설정
		            break;  // 해당 부서의 인원 수를 찾았으면 반복문 종료
		        }	       
		    }

		    // 해당 부서에 인원 수 설정
		    deptInfoTreeDTO.setTotal_dept_count(dept_mem_cnt);
		   
		}
	
		return dept;
	} // public List<DeptInfoTreeDTO> getdeptTree()

	public List<DeptHistoryDTO> getdeptheadhistory(String dept_idx) {
		
		
		List<DeptHistoryDTO> dept_his =	departmentDAO.getdeptheadhistory(dept_idx);
		
		for (DeptHistoryDTO deptHistoryDTO : dept_his) {
			String head_idx =deptHistoryDTO.getDept_head_idx();
			
			// 직급 직책 가져오기
			AppointmentDTO appo_info =	employeeDAO.employeeAppolast(head_idx);
			EmployeeDTO empl_info =	employeeDAO.employeeDetail(head_idx);
			String duty_name =	appo_info.getDuty_name();
			String posi_name =	appo_info.getPosition_name();
			String empl_name =	empl_info.getEmpl_name();
			
			deptHistoryDTO.setEmpl_name(empl_name);
			deptHistoryDTO.setPosition_name(posi_name);
			deptHistoryDTO.setDuty_name(duty_name);
		
		}
		
		
		return dept_his;
	}

	public void organizationDetailGo(String dept_idx, Model model) {
		// 부서 히스토리 정보
				
				
				// 부서정보 가져오기 - 부서명 부서idx 부서직무 부서주소 부서상태
				DepartmentDTO dept =departmentDAO.getdeptinfo(dept_idx);
				int high_int_idx = dept.getDept_high();
				String high_dept_idx =	String.valueOf(high_int_idx);
				int head_idx =	dept.getDept_head_idx();
				String str_head_idx = String.valueOf(head_idx);
				// 부서장 이름 직책 직급 가져오기
				EmployeeDTO employee = employeeDAO.employeeDetail(str_head_idx);
				AppointmentDTO appolast =employeeDAO.employeeAppolast(str_head_idx);
				
				// 상위 부서명 가져오기
				DepartmentDTO high_dept = departmentDAO.getdeptinfo(high_dept_idx);
				
				// 조직 최초 일시
				DeptHistoryDTO dept_his = departmentDAO.getfirstdate(dept_idx);
				
				// 조직원 수 >> 리스트 길이 체크
				// 사원 리스트 employee + appointment + duty + position
				List<DeptDetailMemberDTO> dept_member = departmentDAO.getdeptmeberlist(dept_idx);
				
			//	departmentService.organizationTree();	
				model.addAttribute("deptinfo",dept);
				model.addAttribute("deptmember",dept_member);
				model.addAttribute("highdeptinfo",high_dept);
				model.addAttribute("appoLast",appolast);
				model.addAttribute("employee",employee);
				model.addAttribute("deptfirstdate",dept_his);
		
	}

	public List<DeptDetailMemberDTO> searchDeptMember(String emplName, String cmpEmail, String dept_idx) {
		
		return departmentDAO.searchDeptMember(emplName,cmpEmail,dept_idx);
	}

}
