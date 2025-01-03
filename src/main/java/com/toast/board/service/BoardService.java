package com.toast.board.service;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.toast.board.dao.BoardDAO;
import com.toast.member.dto.FileDTO;

@Service
public class BoardService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final BoardDAO boardDAO;
	
	public BoardService(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}
	
	// spring.servlet.multipart.location=C:/files 이 경로로 주입. !!! 파일 저장위치 !!!
	@Value("${spring.servlet.multipart.location}")
	private String uploadAddr;

	public Map<String, Object> memberInfo(String id) {
		return boardDAO.memberInfo(id);
	}
	
	public String getDeptName(String id) {
		return boardDAO.getDeptName(id);
	}
	
	public Map<String, Object> boardInfo(int board_idx) {
		return boardDAO.boardInfo(board_idx);
	}

	public int boardWrite(Map<String, Object> params, MultipartFile[] files) throws Exception {
		String file_key = UUID.randomUUID().toString();
		params.put("file_key", file_key);
	    // 게시글 작성 후, 자동 생성된 board_idx를 params에 저장
	    boardDAO.boardWrite(params);
	    
	    // board_idx는 BigInteger로 반환될 수 있으므로, 이를 int로 변환
	    BigInteger boardIdxBigInteger = (BigInteger) params.get("board_idx");
	    int boardIdx = boardIdxBigInteger.intValue();  // BigInteger -> int 변환
	    
	    int uploader_idx = (Integer) params.get("appo_empl_idx"); // params에서 uploader_idx 가져오기
		if (files != null && files.length > 0) { // 파일이 업로드 된다면.
			for (MultipartFile file : files) {
				if (!file.isEmpty()) {
					String ori_filename = file.getOriginalFilename();
					String file_type = ori_filename.substring(ori_filename.lastIndexOf("."));
					String new_filename = UUID.randomUUID().toString() + "." + file_type;
					String file_addr = uploadAddr + "/" + new_filename;

					File dest = new File(file_addr);
					file.transferTo(dest);
					
					 Map<String, Object> fileParams = new HashMap<>();
					    fileParams.put("file_key", file_key);
					    fileParams.put("uploader_idx", uploader_idx);
					    fileParams.put("ori_filename", ori_filename);
					    fileParams.put("new_filename", new_filename);
					    fileParams.put("file_type", file_type);
					    fileParams.put("file_addr", file_addr);
					
					boardDAO.saveFile(fileParams);
				}
			}
		}
		return boardIdx;
	}
	
	public List<Map<String, Object>> getDepartmentList() {
		return boardDAO.getDepartmentList();
	}
	
	public Map<String, Object> boardList(int page, int cnt, String id, String dept, String type, String searchType, String keyword, String userDept) {
	    // 페이지와 항목 수 계산
	    int limit = cnt;
	    int offset = (page - 1) * cnt;

	    // 쿼리 파라미터 Map 생성
	    Map<String, Object> params = new HashMap<>();
	    params.put("limit", limit);
	    params.put("offset", offset);
	    params.put("id", id);
	    params.put("dept", dept);
	    params.put("type", type);
	    params.put("searchType", searchType);
	    params.put("keyword", keyword);	    
	    params.put("userDept", userDept);	    

	    // 게시글 목록 및 전체 페이지 수 조회
	    Map<String, Object> totalPagesResult = boardDAO.countBoardList(params);
	    // totalPagesResult.get("pages")는 BigDecimal 타입일 수 있음
	    BigDecimal pages = (BigDecimal) totalPagesResult.get("pages");

	    // BigDecimal을 int로 안전하게 변환
	    int totalPages = (pages != null) ? pages.intValue() : 0; // null인 경우 기본값 0을 설정

	    // 게시글 목록 조회
	    List<Map<String, Object>> boardList = boardDAO.boardList(params);
	    for (Map<String, Object> board : boardList) {
	    	int board_idx = (int) board.get("board_idx");
	    	int commentCount = boardDAO.commentCount(board_idx);
	    	board.put("commentCount", commentCount);
		}
	    
	    // 결과 Map 생성
	    Map<String, Object> result = new HashMap<>();
	    result.put("totalpages", totalPages);
	    result.put("currPage", page);
	    result.put("list", boardList);

	    return result;
	}
	
	public String getUserDept(String id) {
		return boardDAO.getUserDept(id);
	}	

	public Map<String, Object> getBoardByIdx(int board_idx) {
		return boardDAO.getBoardByIdx(board_idx);
	}
	
	public void incrementView(int board_idx) {
		boardDAO.incrementView(board_idx);	
	}
	
	// 댓글 목록 조회
    public List<Map<String, Object>> getReplyList(int board_idx) {
        return boardDAO.getReplyList(board_idx);
    }
    
    // 대댓글 목록 조회
    public List<Map<String, Object>> getReReplyList(int reply_idx) {
		return boardDAO.getReReplyList(reply_idx);
	}
    
	 // 댓글 작성
    public boolean writeReply(int board_idx, String reply, int empl_idx) {
        return boardDAO.writeReply(board_idx, reply, empl_idx) > 0;
    }
    
    // 대댓글 작성
    public boolean writeReReply(int reply_idx, String re_reply, int re_reply_empl_idx) {
        return boardDAO.writeReReply(reply_idx, re_reply, re_reply_empl_idx) > 0;
    }

	public String originalFileName(String filename) {
		return boardDAO.originalFileName(filename);
	}

	public boolean updateReply(String reply_idx, String reply, int empl_idx) {
		return boardDAO.updateReply(reply_idx, reply, empl_idx);
	}

	public boolean deleteReply(int reply_idx) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean updateReReply(int re_reply_idx, String re_reply, int re_reply_empl_idx) {
		return boardDAO.updateReReply(re_reply_idx, re_reply, re_reply_empl_idx);
	}

	public boolean deleteReReply(int re_reply_idx) {
		// TODO Auto-generated method stub
		return false;
	}
	
	public List<FileDTO> getFileList(int board_idx, String file_key) {
		return boardDAO.getFileList(board_idx, file_key);
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
				boardDAO.fileUpload(fileDTO);
			}
		}
	}

	public void deleteFile(int file_idx) {
		boardDAO.deleteFile(file_idx);
	}

	public int updateBoard(Map<String, Object> params, int board_idx, int empl_idx) {
		return boardDAO.updateBoard(params, board_idx, empl_idx);
	}
}
