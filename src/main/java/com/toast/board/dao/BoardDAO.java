package com.toast.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;

import com.toast.member.dto.FileDTO;

@Mapper
public interface BoardDAO {

	Map<String, Object> memberInfo(String id);

	Map<String, Object> boardInfo(int board_idx);

	int boardWrite(Map<String, Object> params);

	void saveFile(Map<String, Object> fileParams);

	List<Map<String, Object>> getDepartmentList();
	
	List<Map<String, Object>> boardList(Map<String, Object> params);
	
	Map<String, Object> countBoardList(Map<String, Object> params);

	int commentCount(int board_idx);
	
	String getUserDept(String id);

	Map<String, Object> getBoardByIdx(int board_idx);

	void incrementView(int board_idx);
	
	List<Map<String, Object>> getReplyList(int board_idx);
	
	List<Map<String, Object>> getReReplyList(int reply_idx);

	int writeReply(int board_idx, String reply, int empl_idx);

	boolean updateReply(String reply_idx, String reply, int empl_idx);
	
	int writeReReply(int reply_idx, String re_reply, int re_reply_empl_idx);

	List<FileDTO> getFileList(int board_idx, String file_key);

	String originalFileName(String filename);

	boolean updateReReply(int re_reply_idx, String re_reply, int re_reply_empl_idx);

	String getDeptName(String id);

	void fileUpload(FileDTO fileDTO);

	void deleteFile(int file_idx);

	int updateBoard(Map<String, Object> params, int board_idx, int empl_idx);
	
	
}
