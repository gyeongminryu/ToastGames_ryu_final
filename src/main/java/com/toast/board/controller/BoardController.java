package com.toast.board.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
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
	public String boardWriteForm(Model model) {
		List<Map<String, Object>> department = boardService.getDepartmentList();
		model.addAttribute("department", department);
		return "board_write";
	}
	
	// 게시글 작성
	@PostMapping(value = "/board_write.do")
	public String boardWrite(@RequestParam Map<String, Object> params, @RequestParam("file") MultipartFile[] files, HttpSession session, Model model) {
		String id = (String) session.getAttribute("loginId"); // 세션에서 로그인한 id를 가져온다.
		Map<String, Object> memberInfo = boardService.memberInfo(id); // 필요한 개인 정보들을 담아온다.
		params.putAll(memberInfo);
		try {
			int boardIdx = boardService.boardWrite(params, files);
			boardService.saveBoardNotify(params, boardIdx);// 알림 테이블에 insert.
			if (boardIdx > 0) {
				model.addAttribute("msg", "게시글 작성 완료");
	            return "redirect:/board_detail.go?board_idx=" + boardIdx; // 게시글 작성 후 해당 게시글 페이지로 리다이렉트
			} else {
				model.addAttribute("msg", "게시글 작성 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "board_detail"; // 댓글 작성 후 해당 게시글 페이지로 리다이렉트
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

	    // 게시글 리스트 추출
	    List<Map<String, Object>> boardList = (List<Map<String, Object>>) result.get("list");

	    // 각 게시글에 대해 file_key 추가
	    for (Map<String, Object> board : boardList) {
	        Integer boardIdx = (Integer) board.get("board_idx");
	        
	        if (boardIdx != null) {
	            // 파일 키 조회
	            String fileKey = boardService.getFileKeyByBoardIdx(boardIdx); // 단일 board_idx만 전달
	            board.put("file_key", fileKey); // 게시글에 file_key 추가
	        }
	    }

	    return result;
	}
	
	// 게시판 상세보기
	@GetMapping(value = "/board_detail.go")
	public String boardDetail(@RequestParam("board_idx") int board_idx, Model model, HttpSession session) {
	    String id = (String) session.getAttribute("loginId");
	    Map<String, Object> memberInfo = boardService.memberInfo(id); // 필요한 개인 정보들을 담아온다.
		int empl_idx = (Integer) memberInfo.get("appo_empl_idx"); // 사용자 idx
		int isDeptHR = boardService.isDeptHR(id);
		session.setAttribute("empl_idx", empl_idx);
	    session.setAttribute("board_idx", board_idx); // board_idx를 세션에 저장
	    session.setAttribute("dept_idx", isDeptHR); // board_idx를 세션에 저장
		Map<String, Object> boardInfo = boardService.boardInfo(board_idx); // 필요한 개인 정보들을 담아온다.
		String file_key = (String) boardInfo.get("file_key");
		List<FileDTO> fileList = boardService.getFileList(board_idx, file_key);
		
		// boardIdx를 사용하여 DB에서 게시글을 조회
	    Map<String, Object> board = boardService.getBoardByIdx(board_idx);
	    boardService.incrementView(board_idx); // 조회수 증가 로직
	    
	    // 게시글이 삭제된 경우 처리
	    if ((int) board.get("board_deleted") == 1) {
	        return "board_list";
	    }
	    
	    // 개인이 소속된 dept를 가져오는 메서드
	    String deptName = boardService.getDeptName(id);
	    model.addAttribute("deptName", deptName);
    
	    // 댓글 목록 조회
	    List<Map<String, Object>> comments = boardService.getReplyList(board_idx);
        model.addAttribute("comments", comments);
        
        // 대댓글 목록은 댓글의 ID를 기준으로 조회할 수 있습니다.
        for (Map<String, Object> comment : comments) {
            int replyIdx = (int) comment.get("reply_idx");  // 댓글의 ID (idx)
            List<Map<String, Object>> reReplies = boardService.getReReplyList(replyIdx);  // 대댓글 목록 가져오기
            comment.put("reReplies", reReplies);  // 대댓글 목록을 댓글에 포함
        }
        
	    // 조회한 게시글 정보를 모델에 추가
	    model.addAttribute("board", board);
	    model.addAttribute("fileList", fileList);
		return "board_detail"; // 상세페이지 이동.
	}
	
	@GetMapping(value = "/board_update.go")
	public String board_update(@RequestParam("board_idx") int board_idx, Model model, HttpSession session) {
	    session.setAttribute("board_idx", board_idx); // board_idx를 세션에 저장
	    Map<String, Object> boardInfo = boardService.boardInfo(board_idx); // 필요한 개인 정보들을 담아온다.
		String file_key = (String) boardInfo.get("file_key");
		List<FileDTO> fileList = boardService.getFileList(board_idx, file_key);
	    Map<String, Object> board = boardService.getBoardByIdx(board_idx);
		List<Map<String, Object>> department = boardService.getDepartmentList();
	
		model.addAttribute("department", department);	 
	    model.addAttribute("board", board);
	    model.addAttribute("fileList", fileList);
		return "board_update";
	}
	
	// 파일 리스트 불러오기
	@ResponseBody
	@GetMapping(value = "/updateFileList.ajax")
    public ResponseEntity<List<FileDTO>> getFileList(HttpSession session) {
	    int board_idx = (int) session.getAttribute("board_idx"); // 세션에서 board_idx를 가져옴
	    Map<String, Object> boardInfo = boardService.boardInfo(board_idx); // 필요한 개인 정보들을 담아온다.
		String file_key = (String) boardInfo.get("file_key");
        // fileList를 가져오는 서비스 호출
        List<FileDTO> fileList = boardService.getFileList(board_idx, file_key);
        return ResponseEntity.ok(fileList); // 파일 목록을 JSON으로 반환
    }
		
	// 파일을 삭제하는 메서드
	@ResponseBody
	@PostMapping(value = "/deleteFile.ajax")
	public ResponseEntity<List<FileDTO>> deleteFile(HttpSession session, int file_idx) {
		String id = (String) session.getAttribute("loginId");
		int board_idx = (int) session.getAttribute("board_idx"); // 세션에서 board_idx를 가져옴
		boardService.deleteFile(file_idx);
	    // 삭제 후, 해당 게시글에 연결된 파일 목록을 가져옴
	    Map<String, Object> boardInfo = boardService.boardInfo(board_idx);
	    String file_key = (String) boardInfo.get("file_key");
	    List<FileDTO> fileList = boardService.getFileList(board_idx, file_key);

	    // 파일 목록을 JSON 형식으로 반환
	    return ResponseEntity.ok(fileList);
	}
	
	// 파일을 추가하는 메서드
	@ResponseBody
	@PostMapping(value = "/boardFileUpload.ajax")
	public ResponseEntity<List<FileDTO>> fileUpload(@RequestParam("file") MultipartFile[] files, HttpSession session, Model model) {
		int board_idx = (int) session.getAttribute("board_idx"); // 세션에서 board_idx를 가져옴
		String id = (String) session.getAttribute("loginId");
	    Map<String, Object> boardInfo = boardService.boardInfo(board_idx); // 필요한 개인 정보들을 담아온다.
		String file_key = (String) boardInfo.get("file_key"); // 해당 게시글의 file_key를 가져온다.	
		Map<String, Object> memberInfo = boardService.memberInfo(id); // 필요한 개인 정보들을 담아온다.
		int empl_idx = (Integer) memberInfo.get("appo_empl_idx"); // 사용자 idx
		try {
			boardService.fileUpload(empl_idx, file_key, files);
			List<FileDTO> fileList = boardService.getFileList(board_idx, file_key); // 업로드된 파일 리스트 불러오기
			return ResponseEntity.ok(fileList);
		} catch (IOException e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
	
	// 파일과는 별개로 게시글 내용을 수정하는 메서드
	@PostMapping(value = "/board_update.do")
	public String board_update(@RequestParam Map<String, Object>params, HttpSession session, Model model) {
		int board_idx = (int)session.getAttribute("board_idx"); // 세션에서 board_idx를 가져옴
		String id = (String) session.getAttribute("loginId");
		Map<String, Object> memberInfo = boardService.memberInfo(id); // 필요한 개인 정보들을 담아온다.
		int empl_idx = (Integer) memberInfo.get("appo_empl_idx"); // 사용자 idx
		logger.info("map ?"  + params);
		int success = boardService.updateBoard(params, board_idx, empl_idx);
		return "redirect:/board_detail.go?board_idx=" + board_idx;
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
	
	@PostMapping(value = "/board_delete.do")
	public String board_delete(HttpSession session) {
		int board_idx = (int)session.getAttribute("board_idx"); // 세션에서 board_idx를 가져옴
		boardService.boardDelete(board_idx);
		return "board_list";
	}
	
	// 댓글 작성
	@PostMapping(value = "/reply_write.do")
	public String writeReply(@RequestParam("board_idx") int board_idx, @RequestParam("reply") String reply, HttpSession session) {
	    String id = (String) session.getAttribute("loginId"); // 세션에서 로그인한 id를 가져온다.
	    Map<String, Object> memberInfo = boardService.memberInfo(id); // 필요한 개인 정보들을 담아온다.
	    int empl_idx = (int) memberInfo.get("appo_empl_idx");
	    int dept_idx = (int) memberInfo.get("board_empl_dept_idx");
	    int duty_idx = (int) memberInfo.get("duty_idx");
	    try {
	        boolean success = boardService.writeReply(board_idx, reply, empl_idx, dept_idx, duty_idx);
	        if (success) {
	            return "redirect:/board_detail.go?board_idx=" + board_idx; // 댓글 작성 후 해당 게시글 페이지로 리다이렉트
	        } else {
	            return "errorPage"; // 댓글 작성 실패 시 에러 페이지
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "errorPage"; // 예외 처리
	    }
	}
    
	// 댓글 수정
	@PostMapping(value = "/reply_update.do")
	public String updateReply(@RequestParam("reply_idx") String reply_idx, @RequestParam("reply") String reply, HttpSession session) {
	    int board_idx = (int) session.getAttribute("board_idx"); // 세션에서 board_idx를 가져옴
		String id = (String) session.getAttribute("loginId"); // 세션에서 로그인한 id를 가져온다.
	    Map<String, Object> memberInfo = boardService.memberInfo(id); // 필요한 개인 정보들을 담아온다.
	    int empl_idx = (Integer) memberInfo.get("appo_empl_idx");
	    boolean success = boardService.updateReply(reply_idx, reply, empl_idx);
	    if (success) {
            return "redirect:/board_detail.go?board_idx=" + board_idx; // 댓글 작성 후 해당 게시글 페이지로 리다이렉트
	    } else {
	        return "errorPage"; // 댓글 수정 실패 시 에러 페이지
	    }
	}
    
	// 댓글 삭제 
	@PostMapping(value = "/reply_delete.do")
	public String deleteReply(@RequestParam("reply_idx") int reply_idx, HttpSession session) {
	    int board_idx = (int) session.getAttribute("board_idx"); // 세션에서 board_idx를 가져옴
	    try {
	        // 댓글 삭제 서비스 호출
	        boolean success = boardService.deleteReply(reply_idx);
	        if (success) {
	            return "redirect:/board_detail.go?board_idx=" + board_idx; // 댓글 작성 후 해당 게시글 페이지로 리다이렉트
	        } else {
	            return "errorPage"; // 댓글 삭제 실패 시 에러 페이지로 이동
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "errorPage"; // 예외 처리
	    }
	}
    
    // 대댓글 작성
    @PostMapping(value = "/re_reply_write.do")
    public String writeReReply(@RequestParam("reply_idx") int reply_idx, @RequestParam("re_reply") String re_reply, HttpSession session) {
        int board_idx = (int) session.getAttribute("board_idx"); // 세션에서 board_idx를 가져옴
    	String id = (String) session.getAttribute("loginId"); // 세션에서 로그인한 id를 가져온다.
        Map<String, Object> memberInfo = boardService.memberInfo(id); // 필요한 개인 정보들을 담아온다.
        int re_reply_empl_idx = (int) memberInfo.get("appo_empl_idx");
	    int dept_idx = (int) memberInfo.get("board_empl_dept_idx");
	    int duty_idx = (int) memberInfo.get("duty_idx");
        try {
            boolean success = boardService.writeReReply(reply_idx, re_reply, re_reply_empl_idx, dept_idx, duty_idx);
            if (success) {
	            return "redirect:/board_detail.go?board_idx=" + board_idx; // 댓글 작성 후 해당 게시글 페이지로 리다이렉트
            } else {
                return "errorPage"; // 대댓글 작성 실패 시 에러 페이지
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "errorPage"; // 예외 처리
        }
    }
	
    // 대댓글 수정
    @PostMapping(value = "/re_reply_update.do")
    public String updateReReply(@RequestParam("re_reply_idx") int re_reply_idx, @RequestParam("re_reply") String re_reply, HttpSession session) {
        int board_idx = (int) session.getAttribute("board_idx"); // 세션에서 board_idx를 가져옴
    	// 세션에서 로그인한 ID를 가져온다.
        String id = (String) session.getAttribute("loginId");
        
        // 사용자의 정보를 가져온다.
        Map<String, Object> memberInfo = boardService.memberInfo(id);
        int re_reply_empl_idx = (int) memberInfo.get("appo_empl_idx"); // 대댓글을 수정하는 사람의 임직원 ID

        boolean success = boardService.updateReReply(re_reply_idx, re_reply, re_reply_empl_idx);

        if (success) {
        	return "redirect:/board_detail.go?board_idx=" + board_idx; // 댓글 작성 후 해당 게시글 페이지로 리다이렉트
        } else {
            return "errorPage"; // 대댓글 수정 실패 시 에러 페이지로 이동
        }
    }
    
    // 대댓글 삭제
    @PostMapping(value = "/re_reply_delete.do")
    public String deleteReReply(@RequestParam("re_reply_idx") int re_reply_idx, HttpSession session) {
        int board_idx = (int) session.getAttribute("board_idx"); // 세션에서 board_idx를 가져옴
    	try {
            // 대댓글 삭제 서비스 호출
            boolean success = boardService.deleteReReply(re_reply_idx);

            if (success) {
	            return "redirect:/board_detail.go?board_idx=" + board_idx; // 댓글 작성 후 해당 게시글 페이지로 리다이렉트
            } else {
                return "errorPage"; // 대댓글 삭제 실패 시 에러 페이지로 이동
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "errorPage"; // 예외 처리
        }
    }
}
