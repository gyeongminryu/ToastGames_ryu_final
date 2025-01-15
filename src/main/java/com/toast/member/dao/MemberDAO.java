package com.toast.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.toast.member.dto.FileDTO;
import com.toast.member.dto.MemberDTO;

@Mapper
public interface MemberDAO {
	
	// 테스트용 로그인!!! 나중에 삭제할 예정!!!
	Map<String, Object> getUserByIdx(int idx);

	boolean isValidId(String id);
	String login(String id);
	int changePwCheck(String id);
	
	boolean isValidName(String name);
	String findId(String name, String email);

	Map<String, String> findPw(String id, String email);

	int UpdatePw(String id, String encryptPw);	

	List<MemberDTO> memberInfo(String id);
	
	List<FileDTO> getFileList(Map<String, Object> params);
	
	String originalFileName(String filename);
	
	List<FileDTO> getUploadedFiles(Map<String, Object> Uploaderidx);

	Map<String, Object> getUploaderIdx(String id);

	boolean checkCurrentPassword(String id, String encryptPw);
	
	// 이건 pw를 바꿈.
	int changePw(String id, String encryptPw);
	// 이건 employee 테이블에 empl_chagepw를 1로 변경한다.
	void changedPw(String id);

	int mypageUpdate(MemberDTO memberDTO);

	int countHistory(String id, int cnt);

	List<Map<String, Object>> employmentHistory(int limit, int offset, String id);

	void fileUpload(FileDTO fileDTO);

	String getIdByIdx(int emplIdx);

	int getEmployeeIdx(String id);

	int getDeptIdx(String id);

	int weekWorkRecord(int empl_idx, String startDate);
	
}

