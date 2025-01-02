package com.toast.board.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.toast.board.service.BoardService;
import com.toast.member.dto.FileDTO;

@Controller
public class BoardController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final BoardService boardService;
	
	public BoardController(BoardService boardService) {
		this.boardService = boardService;
	}
	
	// spring.servlet.multipart.location=C:/files 이 경로로 주입. !!! 파일 저장위치 !!!
    @Value("${spring.servlet.multipart.location}")
    private String uploadAddr;

    // 전자 게시판 이동
	@GetMapping(value = "/board_write.go")
	public String boardWriteForm() {
		return "board_write";
	}
	
	// 게시글 작성
	@PostMapping(value = "/board_write.do")
	public String boardWrite(@RequestParam Map<String, Object> params, @RequestParam("file") MultipartFile[] files, HttpSession session, Model model) {
		String id = (String) session.getAttribute("loginId"); // 세션에서 로그인한 id를 가져온다.
		Map<String, Object> memberInfo = boardService.memberInfo(id); // 필요한 개인 정보들을 담아온다.
		params.putAll(memberInfo);
		try {
			boolean boardWrite = boardService.boardWrite(params, files);
			if (boardWrite) {
				model.addAttribute("msg", "게시글 작성 완료");
			} else {
				model.addAttribute("msg", "게시글 작성 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board_list"; // 상세보기로 이동하면 좋을 듯.
	}

	// 전자 게시판 리스트 이동
	@GetMapping(value = "/board_list.go")
	public String boardList(Model model) {
		List<Map<String, Object>> department = boardService.getDepartmentList();
		model.addAttribute("department", department);
		return "board_list";
	}
	
	// 전자 게시판 리스트 ajax방식으로 가져옴.
	@ResponseBody
	@GetMapping(value = "/board_list.ajax")
	public Map<String, Object> boardList(String page, String cnt, String dept, String type, String searchType, String keyword, HttpSession session) {	    
	    String id = (String) session.getAttribute("loginId");
	    String userDept = boardService.getUserDept(id);
	    int page_ = Integer.parseInt(page);
	    int cnt_ = (cnt != null && !cnt.isEmpty()) ? Integer.parseInt(cnt) : 15;  // 기본값을 15로 설정

	    // 서비스 호출 시 필터 파라미터 전달
	    Map<String, Object> result = boardService.boardList(page_, cnt_, id, dept, type, searchType, keyword, userDept);
	    return result;
	}
	
	// 게시판 상세보기
	@GetMapping(value = "/board_detail.go")
	public String boardDetail(@RequestParam("board_idx") int board_idx, Model model, HttpSession session) {
		Map<String, Object> boardInfo = boardService.boardInfo(board_idx); // 필요한 개인 정보들을 담아온다.
		String file_key = (String) boardInfo.get("file_key");
		List<FileDTO> fileList = boardService.getFileList(board_idx, file_key);
		// boardIdx를 사용하여 DB에서 게시글을 조회
	    Map<String, Object> board = boardService.getBoardByIdx(board_idx);
	    boardService.incrementView(board_idx); // 조회수 증가 로직
	    // 조회한 게시글 정보를 모델에 추가
	    model.addAttribute("board", board);
	    model.addAttribute("fileList", fileList);
		return "board_detail"; // 상세페이지 이동.
	}
	
	// 다운로드 요청이 들어오면 작동되는 메서드.
	@GetMapping(value = "/boardDownload/{filename}") 
	public ResponseEntity<Resource> downloadFile(@PathVariable String filename) throws Exception {
		Resource resource = new FileSystemResource(uploadAddr + "/" + filename); // 경로 설정
		if (resource.exists()) { // 파일이 존재 한다면.
			String originalFileName = boardService.originalFileName(filename); // 기존 이름을 가져온다.
			String fileName = URLEncoder.encode(originalFileName, "UTF-8"); // 이걸 써야 한글로된 파일을 다운 받을 때, 오류 X.
			fileName = fileName.replaceAll("\\+", "%20"); // 위와 동일한 이유.
			return ResponseEntity.ok().header("Content-Disposition", "attachment; filename=\"" + fileName + "\"")
					.body(resource);
		} else {
			return ResponseEntity.notFound().build();
		}
	}
	
	 // 댓글 목록 조회
	@ResponseBody
    @GetMapping(value = "/reply_list.ajax")
	public Map<String, Object> getReplyList(@RequestParam("board_idx") int board_idx) {
        Map<String, Object> response = new HashMap<>();
        try {
            // 댓글 목록 조회 서비스 호출
        	List<Map<String, Object>> comments = boardService.getReplyList(board_idx);
            response.put("comments",comments);
            logger.info("response : ? " + response);
        } catch (Exception e) {
            response.put("comments", new ArrayList<>());
            e.printStackTrace();
        }
        return response;
    }
	
	// 대댓글 목록 조회
	@ResponseBody
	@GetMapping(value = "/re_reply_list.ajax")
	public Map<String, Object> getReReplyList(@RequestParam("reply_idx") int reply_idx) {
		logger.info("Received reply_idx: " + reply_idx);		
		Map<String, Object> response = new HashMap<>();
		List<Map<String, Object>> comments = boardService.getReReplyList(reply_idx);
		response.put("reReplies", comments);
		logger.info("reReplies:?" + comments);
		//response.put("reReplies", new ArrayList<>());
		return response;
	}
	
	// 댓글 작성
    @ResponseBody
    @PostMapping(value = "/reply_write.ajax")
    public Map<String, Object> writeReply(@RequestParam("board_idx") int board_idx, @RequestParam("reply") String reply, HttpSession session) {
    	String id = (String) session.getAttribute("loginId"); // 세션에서 로그인한 id를 가져온다.
		Map<String, Object> memberInfo = boardService.memberInfo(id); // 필요한 개인 정보들을 담아온다.
		logger.info("memberInfo :? " + memberInfo);
        Map<String, Object> response = new HashMap<>();
		response.putAll(memberInfo);
	    int empl_idx = (Integer)response.get("appo_empl_idx");
		try {
            boolean success = boardService.writeReply(board_idx, reply, empl_idx);
            response.put("success", success);
        } catch (Exception e) {
            response.put("success", false);
            e.printStackTrace();
        }
        return response;
    }
    
    @ResponseBody
    @PostMapping(value = "/reply_update.ajax")
    public Map<String, Object> updateReply(@RequestParam("reply_idx") String reply_idx, @RequestParam("reply") String reply, HttpSession session) {
    	String id = (String) session.getAttribute("loginId"); // 세션에서 로그인한 id를 가져온다.
    	Map<String, Object> response = new HashMap<>();
    	Map<String, Object> memberInfo = boardService.memberInfo(id);
    	int empl_idx = (int) memberInfo.get("appo_empl_idx");
    	boolean success = boardService.updateReply(reply_idx, reply, empl_idx);
    	if (success) {
			response.put("success", true);
			response.put("message", "댓글이 수정되었습니다.");
		} else {
			response.put("success", false);
			response.put("message", "댓글 수정에 실패했습니다.");
		}
    	return response;
    }
    
    @ResponseBody
    @PostMapping(value = "/reply_delete.ajax")
    public String deleteReply() {
    	return "";
    }
    
    // 대댓글 작성
    @ResponseBody
    @PostMapping(value = "/re_reply_write.ajax")
    public Map<String, Object> writeReReply(@RequestParam("reply_idx") int reply_idx, @RequestParam("re_reply") String re_reply, HttpSession session) {
    	String id = (String) session.getAttribute("loginId"); // 세션에서 로그인한 id를 가져온다.
		Map<String, Object> memberInfo = boardService.memberInfo(id); // 필요한 개인 정보들을 담아온다.
		int re_reply_empl_idx = (int) memberInfo.get("appo_empl_idx"); 
    	Map<String, Object> response = new HashMap<>();
        try {
            boolean success = boardService.writeReReply(reply_idx, re_reply, re_reply_empl_idx);
            response.put("success", success);
        } catch (Exception e) {
            response.put("success", false);
            e.printStackTrace();
        }
        return response;
    }
	    
}
