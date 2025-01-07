package com.toast.management.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.toast.management.dao.DepartmentDAO;
import com.toast.management.dao.EmployeeDAO;
import com.toast.management.dto.AppointmentDTO;
import com.toast.management.dto.CompInfo;
import com.toast.management.dto.DepartmentDTO;
import com.toast.management.dto.DeptDetailInfoDTO;
import com.toast.management.dto.DeptDetailMemberDTO;
import com.toast.management.dto.DeptHistoryDTO;
import com.toast.management.dto.DeptInfoTreeDTO;
import com.toast.management.dto.DutyDTO;
import com.toast.management.dto.EmployeeDTO;
import com.toast.management.dto.EmployeeDetailDTO;
import com.toast.management.dto.PositionDTO;
import com.toast.member.dto.FileDTO;

@Service
public class DepartmentService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final DepartmentDAO departmentDAO;
	
	@Autowired EmployeeDAO employeeDAO;
	@Value("${spring.servlet.multipart.location}")
    private String uploadAddr;
	
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
	
	} // public void organizationAdd(Map<String, String> param)

	public List<DutyDTO> getdudy() {
		
		return departmentDAO.getduty();
	}

	public List<PositionDTO> getposi() {
		
		return departmentDAO.getposi();
	}
	
	public List<DepartmentDTO> getdept(){
		return departmentDAO.getdept();
	}
	
	public List<DepartmentDTO> getdepthigh() {
		
		List<DepartmentDTO> dept_list = new ArrayList();
		List<DepartmentDTO> dept_alllist = departmentDAO.getdept();
		
		for (DepartmentDTO departmentDTO : dept_alllist) {
			String dept_depth = departmentDTO.getDept_depth();
			logger.info( "부서 depth 는 "+dept_depth);
			if(dept_depth != null &&!dept_depth.equals("3")) {
			dept_list.add(departmentDTO);
			}
		}
		
		return dept_list;
	} // public List<DepartmentDTO> getdepthigh()

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
	
	// 부서장 변경이력 서비스
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
	} // public List<DeptHistoryDTO> getdeptheadhistory(String dept_idx)

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
				
				int dept_member_cnt = dept_member.size();
				
			//	departmentService.organizationTree();	
				model.addAttribute("deptinfo",dept);
				model.addAttribute("deptmember",dept_member);
				model.addAttribute("highdeptinfo",high_dept);
				model.addAttribute("appoLast",appolast);
				model.addAttribute("employee",employee);
				model.addAttribute("deptfirstdate",dept_his);
				model.addAttribute("deptcnt",dept_member_cnt);
		
	} // public void organizationDetailGo(String dept_idx, Model model)

	public List<DeptDetailMemberDTO> searchDeptMember(String dept_idx,String category,String keyword) {
		
		
		
		
		
		return  departmentDAO.searchDeptMember(dept_idx,category,keyword);
	} // public List<DeptDetailMemberDTO> searchDeptMember(String emplName, String cmpEmail, String dept_idx)

	public CompInfo getcompinfo() {
		
		return departmentDAO.getcompinfo();
	}

	public DeptDetailMemberDTO getemplinfo(int ceo_idx) {
		
		return departmentDAO.getemplinfo(ceo_idx);
	}

	public void companyinfoUpdateDo(Map<String, String> param) {
		
		String file_key = UUID.randomUUID().toString();
		param.put("file_key", file_key);

		// 사장 인사 발령하기
		String ceo_idx = param.get("ceo_idx");
		String dept_idx = "2"; // 대표 부서 idx 
		String position_idx = "7"; // 임원 idx
		String duty_idx = "2";
		EmployeeDTO employee = employeeDAO.employeeDetail(ceo_idx);
		String appo_idx = employee.getAppolast_idx();
		String empl_job = "사장이올시다";
		 // 포맷 정의
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");       
        // 현재 시간 가져오기
        Date now = new Date();
        // 문자열로 포맷팅
        String formattedTime = formatter.format(now);
        // 다시 Date 객체로 변환
      //  Date movein_date = formatter.parse(formattedTime);
        int before_ceo = departmentDAO.getcompinfo().getCeo_idx();
        String before_ceo_idx = String.valueOf(before_ceo);
        EmployeeDTO beforeceo_info = employeeDAO.employeeDetail(before_ceo_idx);
		String beforeceo_appo = beforeceo_info.getAppolast_idx();
        
		
		if(!ceo_idx.equals(before_ceo_idx)) { // 사장이 바뀐다면
        
		if(appo_idx==null) { // 이전 인사발령 이력이 없으면 
			employeeDAO.employeeAppoDo(ceo_idx,dept_idx,position_idx,duty_idx,formattedTime,empl_job);
		}
		else { // 인사발령이력이 있으면
			int appoidx = Integer.parseInt(appo_idx);
			employeeDAO.employeeAppoDo(ceo_idx,dept_idx,position_idx,duty_idx,formattedTime,empl_job);
			// 전출날짜 넣기
			employeeDAO.employeeTransfer(appoidx,formattedTime);
		}
		
		if(employeeDAO.deptheadcheck(ceo_idx)>0) { // 새 사장이 이전부서의 부서장이면
			// 이전 부서의 head_idx를 null로 바꿈
			employeeDAO.deptheadmoveout(ceo_idx);
		}
	
		if(before_ceo!= 0) { // 사장이 이미 존재한다면
			employeeDAO.deptheadmoveout(before_ceo_idx); // 대표부서에서 이전 부서장 null 처리
			dept_idx = "1"; // 부서 없음 처리
			duty_idx = "1"; // 직책 없음 처리
			empl_job = "사장직위 변경"; // 
			
			int beforeceoappo = Integer.parseInt(beforeceo_appo);
			employeeDAO.employeeAppoDo(before_ceo_idx,dept_idx,position_idx,duty_idx,formattedTime,empl_job);
			// 전출날짜 넣기
			employeeDAO.employeeTransfer(beforeceoappo,formattedTime);
		}
		String ceo_dept_idx = "2"; // 대표 부서 테이블에 데이터 쌓기
		employeeDAO.deptHeadAdd(ceo_dept_idx,ceo_idx);
	} // if(!ceo_idx.equals(before_ceo_idx)) 
		
			// 회사정보 업데이트 처리
			departmentDAO.companyinfoUpdateDo(param);
	} // public void companyinfoUpdateDo(Map<String, String> param)
	
	// 회사 직인 등록
		public void compStampUpload(MultipartFile singleFile) {
			
			String originalFileName = singleFile.getOriginalFilename();
			String fileType = originalFileName.substring(originalFileName.lastIndexOf("."));
			String newFileName = UUID.randomUUID().toString() + "." + fileType;
			String fileAddr = uploadAddr + "/" + newFileName;
			
			File dest = new File(fileAddr);
			if (!dest.exists()) {
		        dest.mkdirs();  // 디렉토리가 없으면 생성
		    }
			  try {
			        // 파일을 지정한 경로에 저장
			        singleFile.transferTo(dest);
			        logger.info("파일 이름은 : "+newFileName);
			        // 업로드된 파일 이름을 DB에 저장
			        
			        departmentDAO.compStampUpload(newFileName);

			    } catch (IOException e) {
			        e.printStackTrace();
			        throw new RuntimeException("파일 업로드 실패: " + e.getMessage());
			    }
			
		} // public void compStampUpload(MultipartFile singleFile)
		
		// 회사 첨부 파일 목록 가져오기
		public List<FileDTO> getcompfile(String file_key) {
			
			return departmentDAO.getcompfile(file_key);
		}

		public void compFileUpload(MultipartFile[] files, String file_key) {
			
			// 세션 아이디로 idx 가져오기
			int uploader_idx = 0;
			
			for (MultipartFile multipartFile : files) {
				String originalFileName = multipartFile.getOriginalFilename();
				String fileType = originalFileName.substring(originalFileName.lastIndexOf("."));
				String newFileName = UUID.randomUUID().toString() + "." + fileType;
				String fileAddr = uploadAddr + "/" + newFileName;
				
				FileDTO filedto = new FileDTO();
				File dest = new File(fileAddr);
				
				if (!dest.exists()) {
			        dest.mkdirs();  // 디렉토리가 없으면 생성
			    }
				  try {
					 
				        // 파일을 지정한 경로에 저장
					  	multipartFile.transferTo(dest);
					  	 long file_size = dest.length();
				        logger.info("파일 이름은 : "+newFileName);
				        // 업로드된 파일 이름을 DB에 저장
				        filedto.setFile_addr(fileAddr);
				        filedto.setFile_key(file_key);
				        filedto.setFile_size(file_size);
				        filedto.setFile_type(fileType);
				        filedto.setNew_filename(newFileName);
				        filedto.setOri_filename(originalFileName);
				        filedto.setUploader_idx(uploader_idx);
				        departmentDAO.compFileUpload(filedto);

				    } catch (IOException e) {
				        e.printStackTrace();
				        throw new RuntimeException("파일 업로드 실패: " + e.getMessage());
				    }
			}
			
		} // public void compFileUpload(MultipartFile[] files, String file_key)

		public boolean compStampDel(String new_filename) {
			boolean success = false;
			departmentDAO.compStampDel();
			File file = new File(uploadAddr + "/" + new_filename);
			if(file.exists()) {
				 success = file.delete();
				
			}
			return success;
		} // public boolean compStampDel(String new_filename)

		
		public Map<String,Object> getdeptlist() {
		
			// 뎁스가 2인 부서들 출력
			List<DepartmentDTO> high_dept =departmentDAO.gethighdeptlist();
			
			// 뎁스가 3인 부서들 출력
			List<DepartmentDTO> low_dept = departmentDAO.getlowdeptlist();
			
			Map<String,Object> deptlist = new HashMap();
			
			for (DepartmentDTO highDTO : high_dept) {
					int high_idx = highDTO.getDept_idx();
					String highidx = String.valueOf(high_idx);
					
					 List<DepartmentDTO> filteredLowDept = new ArrayList<>();
					 filteredLowDept.add(highDTO); // 맨앞에 상위부서 정보 추가
				for (DepartmentDTO lowDTO : low_dept) {
						int low_idx = lowDTO.getDept_high();
						if( high_idx == low_idx) {
							 filteredLowDept.add(lowDTO);
						}
				}
				 deptlist.put(highidx, filteredLowDept);
			}
			
			
			return deptlist;
		}

		public List<EmployeeDetailDTO> getDeptMembers(String dept_idx) {
			
			return departmentDAO.getDeptMembers(dept_idx);
		}

		public List<EmployeeDetailDTO> getDeptSearchMembers(String dept_idx, String category, String keyword,String team_idx) {
			
			return departmentDAO.getDeptSearchMembers(dept_idx,category,keyword,team_idx);
		}

		public List<EmployeeDetailDTO> getDeptTeamMembers(String dept_idx, String team_idx) {
			// TODO Auto-generated method stub
			return departmentDAO.getDeptTeamMembers(dept_idx,team_idx);
		}
		


}

