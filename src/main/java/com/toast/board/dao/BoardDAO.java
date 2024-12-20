package com.toast.board.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDAO {

	Map<String, Object> memberInfo(String id);

	int boardWrite(Map<String, Object> params);

	void saveFile(Map<String, Object> fileParams);

}
