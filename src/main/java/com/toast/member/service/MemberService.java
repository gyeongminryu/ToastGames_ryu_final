package com.toast.member.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.toast.member.dao.MemberDAO;
import com.toast.member.dto.FileDTO;
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

	// 테스트용 로그인!!! 나중에 삭제할 예정!!!
	public Map<String, Object> getUserByIdx(int idx) {
		return memberDAO.getUserByIdx(idx);
	}
	
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

	public boolean isValidName(String name) {
		return memberDAO.isValidName(name);
	}

	public String findId(String name, String email) {
		return memberDAO.findId(name, email);
	}

	public Map<String, String> findPw(String id, String email) {
		return memberDAO.findPw(id, email);
	}

	// 주의!!! 비밀번호 초기화(이메일) 시 자동으로 변경되는 pw!!! 사용자가 수동으로 변경하는 pw와는 다름!!!
	public int UpdatePw(String id, String tempPw) {
		String encryptPw = encoder.encode(tempPw);
		return memberDAO.UpdatePw(id, encryptPw);
	}

	public List<MemberDTO> memberInfo(String id) {
		return memberDAO.memberInfo(id);
	}
	
	public List<FileDTO> getFileList(String id, String file_key) {
		Map<String, Object> params = new HashMap<>(); // DB에 map형식으로 parameterType을 지정하기 위함.
		params.put("id", id);
		params.put("file_key", file_key);
		return memberDAO.getFileList(params);
	}

	public Map<String, Object> employmentHistory(int page, int cnt, String id) {
		logger.info("Service list called with page: {}, cnt: {}, memberId: {}", page, cnt, id);
		int limit = cnt;
		int offset = (page - 1) * cnt;
		int totalPages = memberDAO.countHistory(id, cnt); // ID를 이용해 전체 페이지 수 계산

		Map<String, Object> result = new HashMap<>();
		result.put("totalpages", totalPages);
		result.put("currPage", page);
		result.put("list", memberDAO.employmentHistory(limit, offset, id)); // ID를 이용해 리스트 가져오기
		return result;
	}

	public String originalFileName(String filename) { // 다운로드에 필요한 로직
		return memberDAO.originalFileName(filename);
	}

	public Map<String, Object> getUploaderIdx(String id) {
		return memberDAO.getUploaderIdx(id);
	}

	public List<FileDTO> getUploadedFiles(Map<String, Object> Uploaderidx) {
		return memberDAO.getUploadedFiles(Uploaderidx);
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

	public String profileImage(MultipartFile file) throws IOException {
		String originalFileName = file.getOriginalFilename(); // ori name.
		String fileType = originalFileName.substring(originalFileName.lastIndexOf(".")); // 확장자 명
		String newFileName = UUID.randomUUID().toString(); // new name.
		String fileAddr = uploadAddr + "/" + newFileName + fileType; // 프로퍼티즈 값이 C:/files 라서 + "/" 한것!!!

		// 파일을 서버에 저장..
		File dest = new File(fileAddr);
		file.transferTo(dest);

		return newFileName + fileType; // DB에 저장될 파일 이름을 반환.
	}

	public void fileUpload(int empl_idx, String file_key, MultipartFile[] files) throws IOException {
		// String file_key = UUID.randomUUID().toString();
		for (MultipartFile file : files) {
			if (!file.isEmpty()) {
				String originalFileName = file.getOriginalFilename();
				String fileType = originalFileName.substring(originalFileName.lastIndexOf("."));
				String newFileName = UUID.randomUUID().toString() + "." + fileType;
				String fileAddr = uploadAddr + "/" + newFileName;

				// 경로 설정 부분. 파일을 서버에 저장함. 필요한가? 이거 어떻게 해야할지 정해야 함..
				File dest = new File(fileAddr);
				file.transferTo(dest);

				// 첨부 파일 정보를 DTO에 저장.
				FileDTO fileDTO = new FileDTO();
				fileDTO.setFile_key(file_key);
				fileDTO.setOri_filename(originalFileName);
				fileDTO.setNew_filename(newFileName);
				fileDTO.setFile_type(fileType);
				fileDTO.setFile_addr(fileAddr);
				fileDTO.setUploader_idx(empl_idx);

				// file 테이블에 파일정보 저장.
				memberDAO.fileUpload(fileDTO);
			}
		}
	}

	public String getIdByIdx(int emplIdx) {
		return memberDAO.getIdByIdx(emplIdx);
	}

	public int getEmployeeIdx(String id) {
		return memberDAO.getEmployeeIdx(id);
	}

	public int getDeptIdx(String id) {
		return memberDAO.getDeptIdx(id);
	}
	
}
