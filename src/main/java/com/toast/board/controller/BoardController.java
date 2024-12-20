package com.toast.board.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.toast.board.service.BoardService;

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

	@GetMapping(value = "/board_write.go")
	public String boardWriteForm() {
		return "board_write";
	}
	
	@PostMapping(value = "/board_write.do")
	public String boardWrite(@RequestParam Map<String, Object> params, @RequestParam("file") MultipartFile[] files, HttpSession session, Model model) {
		// 게시글 작성하면서, 파일도 같이 첨부가 되어야 하는 형식.
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

	@ResponseBody
	@GetMapping(value = "/board_list.ajax")
	public String boardList() {
		return "board_list";
	}
	
}
