package com.toast.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDAO {

	Map<String, Object> memberInfo(String id);

	int boardWrite(Map<String, Object> params);

	void saveFile(Map<String, Object> fileParams);

	List<Map<String, Object>> boardList(Map<String, Object> params);

	Map<String, Object> countBoardList(Map<String, Object> params);

	Map<String, Object> getBoardByIdx(int board_idx);

	int writeReply(int board_idx, String reply);

	Map<String, Object> getReplyList(int board_idx);

	int writeReReply(int parentReply, String re_reply);
	
}
