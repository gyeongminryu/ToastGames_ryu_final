package com.toast.member.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.member.dao.MemberDAO;

@Service
public class MemberService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final MemberDAO memberDAO;
	
	public MemberService(MemberDAO memberDAO) {
		this.memberDAO = memberDAO;
	}

}
