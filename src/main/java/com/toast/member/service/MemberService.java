package com.toast.member.service;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.toast.member.dao.MemberDAO;
import com.toast.member.dto.MemberDTO;

@Service
public class MemberService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final MemberDAO memberDAO;
	private final PasswordEncoder encoder;
	
	public MemberService(MemberDAO memberDAO, PasswordEncoder encoder) {
		this.memberDAO = memberDAO;
		this.encoder = encoder;
	}
	
	// spring.servlet.multipart.location=C:/files 이 경로로 주입. !!! 파일 저장위치 !!!
    @Value("${spring.servlet.multipart.location}")
    private String uploadAddr;
    
    public boolean isValidId(String id) {
		return memberDAO.isValidId(id);
	}
	
	public boolean login(String id, String pw) {
		String enc_pw = memberDAO.login(id);
		return encoder.matches(pw, enc_pw);
	}
	
	public int changePwCheck(String id) {
		return memberDAO.changePwCheck(id);
	}

	public String findId(String name, String email) {
		return memberDAO.findId(name, email);
	}
	
	public boolean isValidName(String name) {
		return memberDAO.isValidName(name);
	}

	public Map<String, String> findPw(String id, String email) {
		return memberDAO.findPw(id, email);
	}
	
	// 주의!!! 비밀번호 초기화(이메일) 시 자동으로 변경되는 pw!!! 사용자가 수동으로 변경하는 pw와는 다름.
	public int UpdatePw(String id, String tempPw) {
		String encryptPw = encoder.encode(tempPw);
		return memberDAO.UpdatePw(id, encryptPw);
	}

	public MemberDTO memberInfo(String id) {
		return memberDAO.memberInfo(id);
	}
	
	public String profileImage(MultipartFile file) throws IOException {

		String originalFileName = file.getOriginalFilename();
		String fileType = originalFileName.substring(originalFileName.lastIndexOf("."));
		String newFileName = UUID.randomUUID().toString();
		String fileAddr = uploadAddr + newFileName + fileType;
		
		// 파일을 서버에 저장..
		File dest = new File(fileAddr);
        file.transferTo(dest);
		
        return newFileName + fileType; // DB에 저장될 파일 이름을 반환.
	}
	
	// 입력한 비밀번호와 DB에 있는 비밀번호가 일치하는지 확인.
	public boolean checkCurrentPassword(String id, String currentPw) {
		String enc_pw = memberDAO.login(id); // login 메서드에 사용되는 거지만, 기능이 같다.
	    return encoder.matches(currentPw, enc_pw);
	}
	
	// 주의!!! 비밀번호를 수동으로 변경하는 service!!!
	public void changePw(String id, String newPw) {
		if (newPw != null && !newPw.isEmpty()) { // 사용자가 새로운 비밀번호를 입력할 경우.
			String encryptPw = encoder.encode(newPw); // 새로 입력한 비밀번호에 암호화를 한다.
			int changed = memberDAO.changePw(id, encryptPw);
			if (changed > 0) { // 회원 정보가 정상적으로 업데이트 된다면.
				memberDAO.changedPw(id); // empl_changepw가 1로 바뀐다.
			}
		}
	}
	
	// 비밀번호 제외한 정보 업데이트
	public int mypageUpdate(MemberDTO memberDTO) {
		int changed = memberDAO.mypageUpdate(memberDTO);
		return changed;
	}
	
}
