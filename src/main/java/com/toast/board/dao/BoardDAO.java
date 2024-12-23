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

	Map<String, Object> getBoardById(int boardIdx);

	int writeComment(int boardIdx, String commentContent);

	Map<String, Object> getCommentsList(int boardIdx);

	int writeReply(int parentCommentId, String replyContent);
	
}
