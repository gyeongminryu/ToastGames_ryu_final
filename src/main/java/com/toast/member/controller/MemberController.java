package com.toast.member.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.toast.member.dto.FileDTO;
import com.toast.member.dto.MemberDTO;
import com.toast.member.service.MailService;
import com.toast.member.service.MemberService;

@Controller
public class MemberController {
	Logger logger = LoggerFactory.getLogger(getClass());

	private final MemberService memberService;
	private final MailService mailService;

	public MemberController(MemberService memberService, MailService mailService) {
		this.memberService = memberService;
		this.mailService = mailService;
	}

	// spring.servlet.multipart.location=C:/files 이 경로로 주입!!! 파일 저장위치!!!
	@Value("${spring.servlet.multipart.location}")
	private String uploadAddr;

	// 로그인 페이지 이동
	@GetMapping(value = "/login.go")
	public String loginView() {
		return "login";
	}

	// 로그인
		@PostMapping(value = "/login.do")
		public String login(HttpSession session, Model model, String id, String pw) {
			String page = "login";
			boolean isValidId = memberService.isValidId(id); // DB에 저장된 아이디와 일치하는가? + 대소문자 구분하는 코드 필요!!!
			if (!isValidId) { // 1. 아이디가 존재하지 않는 경우
				model.addAttribute("idError", "아이디를 확인하세요."); // 아이디 오류 메시지 전달
			} else { // 2. 아이디가 존재 하는 경우
				if (memberService.login(id, pw)) { // 3. 아이디와 비밀번호가 일치한 경우.
					int changePwCheck = memberService.changePwCheck(id); // 3-1. 비밀번호 변경했는지 여부를 가져옴.
					int getEmployeeIdx = memberService.getEmployeeIdx(id); // id로 해당 사원의 idx를 가져온다.
					int getDeptIdx = memberService.getDeptIdx(id); // id로 해당 dept_idx를 가져온다.		
					logger.info("getDeptIdx?" + getDeptIdx);
					session.setAttribute("loginId", id);
					session.setAttribute("empl_idx", getEmployeeIdx);
					session.setAttribute("dept_idx", getDeptIdx);
					// 사원 idx , 부서 dept_idx 세션에 넣어야 함..
					if (changePwCheck != 0) { // 3-2. 비밀번호 변경한 경우.
						return "redirect:/approval_writing_list.go"; // !!!나중에 다른 jsp로 수정필요!!!
					} else { // 3-3. 비밀번호 변경을 안한 경우.
						model.addAttribute("msg", "보안을 위해 비밀번호를 변경해주세요.");
						page = "redirect:/mypage_update.go?msg=changePw";
					}
				} else { // 4. 아이디는 맞으나, 비밀번호가 틀린 경우.
					model.addAttribute("pwError", "비밀번호를 확인하세요."); // 비밀번호 오류 메시지 전달
				}
			}
			model.addAttribute("inputId", id); // 아이디 및 비밀번호가 틀려도 사용자가 입력한 아이디는 남김(편의성).
			return page;
		}

	// 로그아웃
	@GetMapping(value = "/logOut.do")
	public String logout(HttpSession session, Model model) {
		String id = (String) session.getAttribute("loginId");
		if (id == null) { // 세션에 저장된 상태. 즉 로그인이 되어있어야만 실행 가능.
			model.addAttribute("msg", "로그아웃은 로그인 상태에서만 가능합니다.");
			return "login";
		} else {
			session.invalidate(); // 세션 전체를 무효화 (세션에 저장된 모든 정보가 삭제됨).
			model.addAttribute("msg", "로그아웃 되었습니다.");
			return "login"; // 로그인 페이지로.
		}
	}

	// 아이디 찾기 페이지 이동
	@GetMapping(value = "/findId.go")
	public String findIdView() {
		return "login_find_id";
	}

	// 아이디 찾기(이름과 이메일)
	@PostMapping(value = "/findId.do")
	public String findMemberId(Model model, String name, String email) {
		// 이름과 이메일을 db에서 확인 로직이 필요..
		String page = "login_find_id";
		boolean isValidName = memberService.isValidName(name); // 사용자가 입력한 이름이 일치하는가?
		if (!isValidName) { // 일치하지 않는 경우.
			model.addAttribute("nameError", "이름이 존재하지 않습니다.");
			model.addAttribute("inputName", name); // 편의성을 위해 입력한 정보를 남겨둠.
			model.addAttribute("inputEmail", email);
		} else { // 이름이 유효하면 이메일 확인
			String findId = memberService.findId(name, email);
			if (findId == null) { // 이메일이 일치하지 않다면.
				model.addAttribute("emailError", "이메일이 존재하지 않습니다.");
				model.addAttribute("inputName", name);
				model.addAttribute("inputEmail", email);
			} else { // 이름과 이메일이 모두 맞는 경우.
				model.addAttribute("findName", name);
				model.addAttribute("findId", findId);
				page = "login_find_id_result";
			}
		}
		return page;
	}

	// 비밀번호 찾기 페이지 이동
	@GetMapping(value = "/findPw.go")
	public String findPwView() {
		return "login_find_pw";
	}

	// 비밀번호 찾기 (아이디, 이메일) /(암호화된 비밀번호 DB저장 및 변경된 비밀번호 이메일로 전송)
	@Transactional
	@PostMapping(value = "/findPw.do")
	public String tempPw(Model model, String id, String email) {
		String page = "login_find_pw";
		boolean isValidId = memberService.isValidId(id); // 입력한 아이디가 일치하는지 확인.
		if (!isValidId) { // 존재 하지 않는다면?
			model.addAttribute("idError", "ID가 존재하지 않습니다."); // 아이디 오류 메시지 전달
			model.addAttribute("inputId", id);
			model.addAttribute("inputEmail", email);
			return page;
		}
		Map<String, String> userInfo = memberService.findPw(id, email); // DB에 저장된 정보와 일치하는지 확인. map형식은 empl_name을 가져오기 위함.
		if (userInfo != null) { // 저장된 정보가 일치한다면.
			String tempPw = UUID.randomUUID().toString().substring(0, 8); // 비밀번호는 UUID로 새로 설정.
			memberService.UpdatePw(id, tempPw); // 해당 id에 변경된 비밀번호 저장.
			mailService.sendPwMail(email, tempPw); // 저장된 email에 변경된 비밀번호 전송.
			model.addAttribute("findName", userInfo.get("empl_name"));
			model.addAttribute("findEmail", email);
			page = "login_find_pw_result";
		} else {
			model.addAttribute("emailError", "이메일이 존재하지 않습니다.");
			model.addAttribute("inputId", id);
			model.addAttribute("inputEmail", email);
		}
		return page;
	}

	// 마이페이지(상세보기)
	@GetMapping(value = "/mypage.go")
	public String myPageView(Model model, HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		MemberDTO memberInfo = memberService.memberInfo(id).get(0); // 리스트 형태로 가져옴. 해당 id에 맞는 사용자 정보를 가져옴.
		String file_key = memberInfo.getFile_key(); // employee에 저장된 file_key를 가져오기 위함.
		List<FileDTO> fileList = memberService.getFileList(id, file_key); // 사용자가 첨부한 파일 리스트만 불러온다.
		int empl_idx = (int)session.getAttribute("empl_idx");
		int weekWorkRecord = memberService.weekWorkRecord(empl_idx);
		model.addAttribute("memberInfo", memberInfo); // 인포에 직인 정보도 포함!!!
		model.addAttribute("fileList", fileList); // 사용자가 첨부한 파일리스트를 불러온다.
		model.addAttribute("totalHours", weekWorkRecord);
		return "mypage";
	}

	// 사원인사 이동내역 확인.
	@ResponseBody
	@GetMapping(value = "/employmentHistory.ajax")
	public Map<String, Object> employmentHistory(String page, String cnt, HttpSession session, Model model) {
		String id = (String) session.getAttribute("loginId");
		int page_ = Integer.parseInt(page); // 페이지
		int cnt_ = Integer.parseInt(cnt); // 항목 수

		Map<String, Object> result = memberService.employmentHistory(page_, cnt_, id);
		return result;
	}

	// 다운로드 요청이 들어오면 작동되는 메서드.
	@GetMapping(value = "/memberDownload/{filename}") 
	public ResponseEntity<Resource> downloadFile(@PathVariable String filename) throws Exception {
		Resource resource = new FileSystemResource(uploadAddr + "files/" + filename); // 경로 설정
		if (resource.exists()) { // 파일이 존재 한다면.
			String originalFileName = memberService.originalFileName(filename); // 기존 이름을 가져온다.
			String fileName = URLEncoder.encode(originalFileName, "UTF-8"); // 이걸 써야 한글로된 파일을 다운 받을 때, 오류 X.
			fileName = fileName.replaceAll("\\+", "%20"); // 위와 동일한 이유.
			return ResponseEntity.ok().header("Content-Disposition", "attachment; filename=\"" + fileName + "\"")
					.body(resource);
		} else {
			return ResponseEntity.notFound().build();
		}
	}

	// 이미지 파일 요청이 들어오면 작동되는 메서드.
	@GetMapping(value = "/memberFiles/{filename}")
	public ResponseEntity<Resource> Image(@PathVariable String filename) {
		Path filePath = Paths.get(uploadAddr + "files/" + filename); // uploadAddr = /usr/local/tomcat/webapps/
		if (Files.exists(filePath)) { // 파일이 존재하는지 확인
			Resource resource = new FileSystemResource(filePath); // 파일을 Resource로 반환
			return ResponseEntity.ok() // Content-Type을 자동으로 설정하고 파일을 반환
					// .contentType(MediaType.IMAGE_JPEG) // 이미지의 경우 예시로 JPEG 사용, 실제 이미지 타입에 맞게 설정
					.body(resource);
		} else {
	        return ResponseEntity.ok().build(); // 또는 다른 응답 처리를 할 수 있음. 그런데 이거는 파일 없어도 404보고 싶지않아서 ok처리함..
		}
	}

	// 마이페이지(수정) 이동
	@GetMapping(value = "/mypage_update.go")
	public String myPageUpdateForm(Model model, HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		MemberDTO memberInfo = memberService.memberInfo(id).get(0);
		model.addAttribute("memberInfo", memberInfo);
		return "mypage_update";
	}

	// 파일 업로드 할 때.
	@ResponseBody
	@PostMapping(value = "/fileUpload.ajax")
	public ResponseEntity<List<FileDTO>> fileUpload(@RequestParam("file") MultipartFile[] files, HttpSession session, Model model) {
		String id = (String) session.getAttribute("loginId");
		Map<String, Object> Uploaderidx = memberService.getUploaderIdx(id); // file_key를 가지고 오기 위한 로직.
		int empl_idx = (Integer) Uploaderidx.get("empl_idx"); // 사용자 idx
		String file_key = (String) Uploaderidx.get("file_key"); // 사용자의 file_key
		try {
			memberService.fileUpload(empl_idx, file_key, files); // 기존 empl_idx, file_key, 올릴 파일
			List<FileDTO> fileList = memberService.getUploadedFiles(Uploaderidx); // 업로드된 파일 리스트 불러오기
			return ResponseEntity.ok(fileList);
		} catch (IOException e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	// 파일 목록 조회
	@ResponseBody
	@GetMapping(value = "/getFileList.ajax")
	public ResponseEntity<List<FileDTO>> getFileList(HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		Map<String, Object> Uploaderidx = memberService.getUploaderIdx(id);
//		int empl_idx = (Integer) Uploaderidx.get("empl_idx");
//		String file_key = (String) Uploaderidx.get("file_key");
		List<FileDTO> fileList = memberService.getUploadedFiles(Uploaderidx); // 업로드된 파일 목록 조회
		return ResponseEntity.ok(fileList); // 파일 목록을 JSON으로 반환
	}

	@ResponseBody
	@PostMapping(value = "/checkCurrentPw.ajax")
	public Map<String, String> checkCurrentPw(@RequestParam("currentPassword") String currentPw, HttpSession session) {
	    String id = (String) session.getAttribute("loginId");
	    boolean isValid = memberService.checkCurrentPassword(id, currentPw);

	    Map<String, String> response = new HashMap<>();
	    if (isValid) {
	        response.put("status", "success");
	    } else {
	        response.put("status", "error");
	    }
	    return response;
	}

	@ResponseBody
	@PostMapping(value = "/changePw.ajax") // 비밀번호 변경 처리 로직
	public Map<String, String> changePw(HttpSession session, @RequestParam("currentPassword") String currentPw, @RequestParam("newPassword") String newPw, @RequestParam("confirmPassword") String confirmPw) {
		Map<String, String> response = new HashMap<>();
		String id = (String) session.getAttribute("loginId");
		
		if (newPw == null || newPw.trim().isEmpty()) { // 사용자가 입력하지 않았을 경우.
			response.put("status", "error");
			return response;
		}
		if (!newPw.equals(confirmPw)) { // 새 비밀번호와 확인 비밀번호가 일치하는지 확인.
			response.put("status", "error");
			return response;
		}
		memberService.changePw(id, newPw); // 새 비밀번호로 변경.
		response.put("status", "success"); 
		return response;
	}
	
	// 회원 정보 수정
	@PostMapping(value = "/mypageUpdate.do")
	public String mypageUpdate(@RequestParam("imageFile") MultipartFile file, MemberDTO memberDTO, HttpSession session, Model model) {
		String id = (String)session.getAttribute("loginId");
		memberDTO.setEmpl_id(id);
		if (!file.isEmpty()) { // 이미지 파일을 업로드 했다면.
			try {
				String imageFile = memberService.profileImage(file); // 프로파일 이미지를 저장할 때.
				memberDTO.setEmpl_profile(imageFile); // 프로필 이미지 설정.
			} catch (IOException e) {
				model.addAttribute("msg", "파일 업로드 실패");
				e.printStackTrace();
			}
		}
		int row = memberService.mypageUpdate(memberDTO); // 회원정보 업데이트
		if (row > 0) {
			model.addAttribute("msg", "회원정보가 수정되었습니다.");
		} else {
			model.addAttribute("msg", "회원정보 수정이 실패했습니다.");
		}
		return "redirect:/mypage.go";
	}

	@ResponseBody
	@GetMapping(value = "/profileDetail")
	public ResponseEntity<MemberDTO> getProfile(@RequestParam("tst_modal_employee_idx") int employeeIdx) {
	    try {
	        String id = memberService.getIdByIdx(employeeIdx);
	        MemberDTO memberInfo = memberService.memberInfo(id).get(0);
	        // 응답으로 JSON 데이터 반환
	        return ResponseEntity.ok(memberInfo);
	    } catch (Exception e) {
	        // 에러 발생 시 처리
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	    }
	}
	
	@ResponseBody
	@GetMapping(value = "/layout_memberInfo", produces = "application/json")
	public MemberDTO layoutMemberInfo(HttpSession session) {
	    String id = (String) session.getAttribute("loginId");
	    MemberDTO memberInfo = memberService.layoutMemberInfo(id);
	    return memberInfo;  // Returning memberInfo as JSON
	}
	
}
