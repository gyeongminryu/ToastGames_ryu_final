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
	
	public String getDutyName(String id) {
		return boardDAO.getDutyName(id);
	}
	
	public Map<String, Object> boardInfo(int board_idx) {
		return boardDAO.boardInfo(board_idx);
	}

	public int boardWrite(Map<String, Object> params, MultipartFile[] files) throws Exception {
		String file_key = UUID.randomUUID().toString();
		params.put("file_key", file_key);
	    // 게시글 작성 후, 자동 생성된 board_idx를 params에 저장
	    boardDAO.boardWrite(params);
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
	                long file_size = file.getSize();  // 파일 크기를 바이트 단위로 가져옵니다.


					File dest = new File(file_addr);
					file.transferTo(dest);
					
					 Map<String, Object> fileParams = new HashMap<>();
					    fileParams.put("file_key", file_key);
					    fileParams.put("uploader_idx", uploader_idx);
					    fileParams.put("ori_filename", ori_filename);
					    fileParams.put("new_filename", new_filename);
					    fileParams.put("file_type", file_type);
					    fileParams.put("file_addr", file_addr);
		                fileParams.put("file_size", file_size);  // 파일 크기 추가
					
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
	
	public void boardDelete(int board_idx) {
		boardDAO.boardDelete(board_idx);
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
    public boolean writeReply(int board_idx, String reply, int empl_idx, int dept_idx, int duty_idx) {
        return boardDAO.writeReply(board_idx, reply, empl_idx, dept_idx, duty_idx) > 0;
    }
    
    // 대댓글 작성
    public boolean writeReReply(int reply_idx, String re_reply, int re_reply_empl_idx, int dept_idx, int duty_idx) {
        return boardDAO.writeReReply(reply_idx, re_reply, re_reply_empl_idx, dept_idx, duty_idx) > 0;
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
                long file_size = file.getSize();  // 파일 크기를 바이트 단위로 가져옵니다.

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
				fileDTO.setFile_size(file_size);
				// file 테이블에 파일정보 저장.
				boardDAO.fileUpload(fileDTO);
			}
		}
	}
	
	public void saveBoardNotify(Map<String, Object> params, int boardIdx) {
	     int board_type_idx = Integer.parseInt(params.get("board_type_idx").toString()); // 안전하게 변환
		 String boardTitle = (String) params.get("board_title");
		 String boardContent = (String) params.get("board_content");
		 String notiLink = "/board_detail.go?board_idx=" + boardIdx;  // 게시글 링크
		 	
		 	if (board_type_idx == 1) {
				// 1은 기본 문서이기 때문에, 알림에 저장이 되면 안됨.
		 		return;
			}
		 
		    // 알림 유형에 따라 알림 테이블에 데이터 삽입
		 	// 부서 공지(board_type_idx == 2): dept_idx를 기준으로 해당 부서에 속한 직원들을 조회.
		 	// 게시글의 상세 페이지 URL
		    if (board_type_idx == 2) {  // 부서공지
		        int dept_idx = Integer.parseInt(params.get("dept_idx").toString());  // 부서 ID
		    	List<Integer> deptMembers = boardDAO.getDeptMembers(dept_idx); // 부서에 속한 사람들 리스트 가져오기
		    	for (int empl_idx : deptMembers) {
		    		Map<String, Object> notifyParams = new HashMap<>();
		            notifyParams.put("noti_cate_idx", 22); // 부서 공지
		            notifyParams.put("noti_sender_empl_idx", params.get("appo_empl_idx"));
		            notifyParams.put("noti_receiver_empl_idx", empl_idx);
		            notifyParams.put("noti_subject", boardTitle);
		            notifyParams.put("noti_content", boardContent);
		            notifyParams.put("noti_read_date", null);       // 읽지 않은 상태로 설정 (기본값 null)
		            notifyParams.put("noti_link", notiLink);
		            boardDAO.saveBoardNotify(notifyParams);
				}
		    } 
		    
		    // 전체 공지(board_type_idx == 3): 모든 직원들에게 알림을 보내는 경우.
		    // 게시글의 상세 페이지 URL
		    if (board_type_idx == 3) {  // 전체공지
		    	List<Integer> getAllMembers = boardDAO.getAllMembers();  // 전체 직원 가져오기		        
		        for (int empl_idx : getAllMembers) {
		        Map<String, Object> notifyParams = new HashMap<>();
		            notifyParams.put("noti_cate_idx", 21); // 부서 공지
		            notifyParams.put("noti_sender_empl_idx", params.get("appo_empl_idx"));
		            notifyParams.put("noti_receiver_empl_idx", empl_idx);
		            notifyParams.put("noti_subject", boardTitle);
		            notifyParams.put("noti_content", boardContent);
		            notifyParams.put("noti_read_date", null);       // 읽지 않은 상태로 설정 (기본값 null)
		            notifyParams.put("noti_link", notiLink);
			        boardDAO.saveBoardNotify(notifyParams);
		        }
		    }
	}

	public void deleteFile(int file_idx) {
		boardDAO.deleteFile(file_idx);
	}

	public int updateBoard(Map<String, Object> params, int board_idx, int empl_idx) {
		return boardDAO.updateBoard(params, board_idx, empl_idx);
	}

	public String getFileKeyByBoardIdx(Integer boardIdx) {
	    return boardDAO.getFileKeyByBoardIdx(boardIdx);
	}

	public int isDeptHR(String id) {
		return boardDAO.isDeptHR(id);
	}

}
