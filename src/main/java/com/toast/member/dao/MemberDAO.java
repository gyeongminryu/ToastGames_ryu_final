package com.toast.member.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.toast.member.dto.MemberDTO;

@Mapper
public interface MemberDAO {

	boolean isValidId(String id);
	
	String login(String id);

	String findId(String name, String email);
	boolean isValidName(String name);

	Map<String, String> findPw(String id, String email);

	int UpdatePw(String id, String encryptPw);	

	int changePwCheck(String id);

	MemberDTO memberInfo(String id);

	boolean checkCurrentPassword(String id, String encryptPw);
	
	// 이건 pw를 바꿈.
	int changePw(String id, String encryptPw);
	// 이건 employee 테이블에 empl_chagepw를 1로 변경한다.
	void changedPw(String id);

	int mypageUpdate(MemberDTO memberDTO);
	
}

