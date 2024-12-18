package com.toast.management.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.toast.dataconfig.DataConfig;
import com.toast.management.dao.EmployeeDAO;

@Service
public class EmployeeService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PasswordEncoder encoder;
	
	private final EmployeeDAO employeeDAO;
	
	private final DataConfig dataconfig;
	
	public EmployeeService(EmployeeDAO employeeDAO,DataConfig dataconfig) {
		this.employeeDAO = employeeDAO;
		this.dataconfig = dataconfig;
		
	}

	public void employeeAdd(Map<String, String> param) {
		
		String file_key = UUID.randomUUID().toString();
		param.put("file_key", file_key);
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

	
}
