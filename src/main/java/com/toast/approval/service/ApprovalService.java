package com.toast.approval.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.toast.approval.dao.ApprovalDAO;
import org.springframework.ui.Model;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class ApprovalService {
	Logger logger = LoggerFactory.getLogger(getClass());

	@Value("${spring.servlet.multipart.location}")
	private String uploadAddr;

	private final ApprovalDAO approvalDAO;
	
	public ApprovalService(ApprovalDAO approvalDAO) {
		this.approvalDAO = approvalDAO;
	}

	//이동
	public List<Map<String,Object>> form_list() {
		return approvalDAO.form_list();
	}

	//이동
	public Map<String, Object> form(int idx) {
		return approvalDAO.form(idx);
	}







	public List<Map<String,Object>> highdept() {
		return approvalDAO.highdept();
	}

	public List<Map<String,Object>> dept_allempl(int deptIdx) {

		return approvalDAO.dept_allempl(deptIdx);
	}

	public List<Map<String,Object>> form_list_searched(String search_val) {
		logger.info("서비스 단 searchVal:{}", search_val);

		return approvalDAO.form_list_searched(search_val);
	}

	public List<Map<String,Object>> show_team(int dept_idx) {
		return approvalDAO.show_team(dept_idx);
	}

	public List<Map<String,Object>> team_allempl(int team_idx) {
		return approvalDAO.team_allempl(team_idx);
	}
	public List<Map<String,Object>> approval_company_get_allempl(String filter,String search) {
		List<Map<String,Object>> all_empl = approvalDAO.approval_company_get_allempl();
		List<Map<String,Object>> empl_filtered = new ArrayList<>();
		logger.info("all_empl{}",all_empl);

			if(filter.equals("전체")){
				for (Map<String,Object> empl : all_empl){
					logger.info("empl:{}",empl);
					String dept_name = (String) empl.get("dept_name");
					String empl_name = (String) empl.get("empl_name");
					logger.info("empl:{}",empl_name);
					logger.info("dept_name:{}",dept_name);

					logger.info("성공:{}",dept_name.contains(search));
					logger.info("성공:{}",empl_name.contains(search));
					if(dept_name.contains(search)||empl_name.contains(search)){
						empl_filtered.add(empl);
						logger.info("empl_filtered:{}",empl_filtered);
					}
				}
			}else if(filter.equals("부서")){
				for (Map<String,Object> empl : all_empl){
					logger.info("empl:{}",empl);
					String dept_name = (String) empl.get("dept_name");
					logger.info("dept_name:{}",dept_name);

					if(dept_name.contains(search)){
						empl_filtered.add(empl);
						logger.info("empl_filtered:{}",empl_filtered);
					}
				}
			}else if(filter.equals("이름")){
				for (Map<String,Object> empl : all_empl){
					String empl_name = (String) empl.get("empl_name");
					logger.info("empl_name:{}",empl_name);
					if(empl_name.contains(search)){
						empl_filtered.add(empl);
						logger.info("empl_filtered:{}",empl_filtered);
					}
				}
			}else{
				empl_filtered = all_empl;
			}








		logger.info("empl_filtered:{}",empl_filtered);

		return empl_filtered;
	}


	//내가 보낸 업무 목록 조회
	public List<Map<String, Object>> approval_sent_list(int empl_idx) {

		// 전달할 파라메터
		List<Map<String, Object>> sent_list_params = new ArrayList<>();
		// 문서의 작성자에 count(사원 번호)가 있는지 확인
		if (approvalDAO.empl_count(empl_idx,1) > 0) {
			// 문서의 작성자에 count(사원 번호)가 있으면 List<Map>형태로 작성한 값 가져오기
			logger.info("문서 작성한 사원임");
			Map<String, Object> sent_empl_info = approvalDAO.get_empl_info(empl_idx);

			sent_list_params = get_list_info(sent_empl_info,sent_list_params,"보낸 결재");

		}
		return sent_list_params;
	}




	//내가 받은 업무 목록 조회
	public List<Map<String,Object>> approval_received_list(int empl_idx){
		//최종 전달 파라메터
		List<Map<String,Object>> received_list_params = new ArrayList<>();
		//approval receiver idx에 있는지 확인
		//있으면 정보 가져오기
		if(approvalDAO.receiver_empl_count(empl_idx)>0){
			logger.info("문서 받은 사원임");
			Map<String, Object> receiver_empl_info = approvalDAO.get_empl_info(empl_idx);
			received_list_params = get_list_info(receiver_empl_info,received_list_params,"받은 결재");

		}

		return received_list_params;
	}

	//내가 작성 중인 목록
	public List<Map<String, Object>> get_approval_writing_list(int empl_idx) {
		List<Map<String,Object>> written_list_params = new ArrayList<>();
		//approval receiver idx에 있는지 확인
		//있으면 정보 가져오기
		if(approvalDAO.empl_count(empl_idx,0)>0){
			logger.info("작성한 목록 조회, 사원임");
			Map<String, Object> empl_info = approvalDAO.get_empl_info(empl_idx);

			written_list_params = get_list_info(empl_info,written_list_params,"작성 중인 결재");

		}
		return written_list_params;
	}

	//(공용) 직원 정보 및 문서 정보 및 문서 상태 가져오는 함수
	public List<Map<String, Object>> get_list_info(Map<String, Object> get_empl_info,List<Map<String,Object>> list_params, String list_type) {

		//공용 코드
		// 사원번호 기반으로 사원 이름/ 부서/ 직급 가져오기

		//내용 전달
		String empl_name = (String) get_empl_info.get("empl_name");
		String dept_name = (String) get_empl_info.get("dept_name");
		String position_name = (String) get_empl_info.get("position_name");
		int r_empl_idx = (int) get_empl_info.get("empl_idx");


		int received_doc_idx = 0;


		// 전달된 사원 번호에 해당하는 문서 목록 가져오기
		List<Map<String, Object>> doc_infos = new ArrayList<>();


		//보낸 결재와 받은 결재 분기 처리(doc_infos 달리 가져옴)
		if(list_type.equals("보낸 결재")) {
			doc_infos = approvalDAO.get_sent_list(r_empl_idx);
		}else if(list_type.equals("받은 결재")){
			//Map으로 받아온 doc 정보
			doc_infos = approvalDAO.get_received_list(r_empl_idx);


			//doc_infos.add(doc_infos_part);
		}else if(list_type.equals("작성 중인 결재")){
			doc_infos = approvalDAO.get_writing_list(r_empl_idx);
		}

		logger.info("sent_lists:{}", doc_infos);

		// 문서 리스트 순회
		for (Map<String, Object> doc_info : doc_infos) {
			// List 전 1차 param Map 만들기
			Map<String, Object> list_param = new HashMap<>();

			logger.info("sent_list:{}", doc_info);

			int sent_doc_idx = (int) doc_info.get("doc_idx");
			String sent_doc_subject = (String) doc_info.get("doc_subject");
			int doc_state = (int) doc_info.get("doc_state");

			list_param.put("empl_name", empl_name);
			list_param.put("dept_name", dept_name);
			list_param.put("position_name", position_name);

			list_param.put("empl_idx", r_empl_idx);
			list_param.put("doc_idx", sent_doc_idx);

			if(sent_doc_subject!=null){
				list_param.put("doc_subject", sent_doc_subject);
			}else{
				list_param.put("doc_subject", "제목 없음");
			}


			list_param.put("doc_state", doc_state);
			list_param.put("write_date", doc_info.get("write_date"));
			list_param.put("update_date", doc_info.get("update_date"));

			if(doc_info.get("end_date") !=null){
				list_param.put("end_date", doc_info.get("end_date"));
			}else{
				list_param.put("end_date", "없음");
			}

			//form 양식 유형
			if (doc_info.get("form_subject") != null) {
				list_param.put("form_subject", doc_info.get("form_subject"));
			} else {
				list_param.put("form_subject", "기타");
			}

			if(!list_type.equals("작성 중인 결재")){

				// 반려가 있는지 확인
				String approval_response_date = "";
				int approval_state = 2;

				if (approvalDAO.count_state(sent_doc_idx, approval_state) > 0) {
					logger.info("반려 있음");

					// 반려 상태 처리
					list_param.put("approval_state", "반려");
					list_param.put("doc_subject", "결재가 반려되었습니다.");
					if(list_type.equals("보낸 결재")){
						// 전체 반려 처리 일시
						approval_response_date = approvalDAO.get_approval_state_time(sent_doc_idx, approval_state);
					}
				} else {
					// 반려가 없으면
					logger.info("반려 없음");

					approval_state = 1;

					// 승인이 있는지 확인
					if (approvalDAO.count_state(sent_doc_idx, approval_state) > 0) {
						logger.info("승인 있음");
						if(list_type.equals("보낸 결재")){
							// 전체 승인 처리
							approval_response_date = approvalDAO.get_approval_state_time(sent_doc_idx, approval_state);
						}
						// 최종 승인 여부 확인
						if (approvalDAO.whether_final_approve(sent_doc_idx) == 1) {
							logger.info("최종 승인임");

							// 최종 승인 처리
							list_param.put("approval_state", "최종 승인");
							list_param.put("doc_subject", "결재가 최종 승인되었습니다.");
						} else {
							logger.info("최종 승인 아님");

							// 결재 진행 중인지 확인
							if (approvalDAO.get_read_date(sent_doc_idx) > 0) {
								// 읽음 확인 (읽은 시간 있음)
								list_param.put("approval_state", "결재 진행");
							} else {
								logger.info("결재 대기");
								// 읽지 않음 (읽은 시간 없음)
								list_param.put("approval_state", "결재 대기");
							}
						}
					} else {
						logger.info("승인 없음");

						// 승인이 없으면 "없음" 처리
						approval_response_date = "없음";
						//approval_state = "결재 대기"
						list_param.put("approval_state", "결재 대기");
					}
				}
				list_param.put("approval_response_date", approval_response_date);
			}

			logger.info("sent_list_param:{}", list_param);


			//만약 받은 업무이면, 개인의 받은 업무 처리 상태 표시
			if(list_type.equals("받은 결재")){
				if(doc_info.get("appr_date") != null){
					list_param.put("appr_date",doc_info.get("appr_date"));
				}else{
					list_param.put("appr_date","없음");
				}

				if(doc_info.get("read_date")!=null){
					int i_approval_state = (int) doc_info.get("appr_state");
					logger.info("approval_state:{}",i_approval_state);
					if(i_approval_state ==1){
						list_param.put("i_approval_state","승인");
					}else if(i_approval_state ==2){
						list_param.put("i_approval_state","반려");
					}else if(i_approval_state ==0){
						list_param.put("i_approval_state","결재중");
					}
				}else{
					list_param.put("i_approval_state","읽지 않음");

				}
			}

			// 탭 처리 + 검색 처리 위해 -> 결과 리스트에 추가하는 로직에서 분기처리
			//distinct_list_filter(filter,type,list_param,list_params,list_type);
			list_params.add(list_param);
			logger.info("sent_list_params:{}", list_params);
		}
        return list_params;
    }


	//(공용) 탭 처리 + 검색 처리해주는 메서드(공통)
	public void distinct_list_filter(String filter, String type, Map<String, Object> list_param, List<Map<String, Object>> list_params, String list_type) {
		logger.info("distinct_list_filter 도착");

		logger.info("list_param:{}",list_param);
		logger.info("list_param_state:{}",list_param.get("doc_state"));


		logger.info("list_type:{}",list_type);
		logger.info("filter:{}",filter);

		switch (type) {
			case "전체":
				list_params.add(list_param);
				break;
			case "탭":
				logger.info("탭");
				logger.info("filter:{}",filter);
				if(list_type.equals("보낸 결재")){
					logger.info("보낸 결재 확인");
					if (list_param.get("approval_state").equals(filter)) { //approval_state가 결재 대기일 때만 param 넣기
						list_params.add(list_param);
					}
				}else if(list_type.equals("작성 중인 결재")){
					logger.info("작성한 결재 확인");

					if (list_param.get("doc_state").equals(Integer.parseInt(filter)) ) { //approval_state가 결재 대기일 때만 param 넣기
						list_params.add(list_param);
					}else{
						logger.info("doc_state에 해당하는 값 없음");
					}
				}else if(list_type.equals("받은 결재")){
					if (list_param.get("i_approval_state").equals(filter)) { //approval_state가 결재 대기일 때만 param 넣기
						list_params.add(list_param);
					}else{
						logger.info("i_approval_state에 해당하는 값 없음");
					}
				}
				break;
			case "검색":
				logger.info("검색");
				String doc_subject = (String) list_param.get("doc_subject");
				logger.info("doc_subject :{}",doc_subject);

				if(doc_subject.contains(filter)){ //만약 filter 문자열을 포함하고 있으면,
					list_params.add(list_param);
				}
				break;
		}
	}


	public void get_all_detail(int doc_idx, int empl_idx, Model model, String type) {

		//내 empl_idx, doc_idx의 읽음 시간 기록하기
		LocalDate date = LocalDate.now();
		LocalTime time = LocalTime.now();


		//time format
		String formatted_time = time.format(DateTimeFormatter.ofPattern("HH:mm:ss"));

		logger.info("formatted_datetime:{}",date+ " "+formatted_time);
		String formatted_date = date+ " "+formatted_time;

		if(type.equals("received")){
			//읽은 시간 업데이트
			if(approvalDAO.update_read_time(formatted_date,doc_idx,empl_idx)>0){
				logger.info("읽은 시간 업데이트 되었음");
			}

			//내 결재 상태 가져오기 - 이에 따라 버튼이 보일지 안 보일지
			model.addAttribute("my_appr_state",approvalDAO.get_my_appr_state(doc_idx,empl_idx));

			//결재하는 내 이름 가져오기
			model.addAttribute("my_appr_name",approvalDAO.get_my_appr_name(empl_idx));

		}



		//문서 정보 (doc_info)
		Map<String,Object> doc_info = approvalDAO.get_doc_info(doc_idx);
		model.addAttribute("doc_info",doc_info);
		model.addAttribute("doc_idx",doc_idx);
		logger.info("doc_info:{}",doc_info);

		//폼 정보
		Map<String,Object> form_info = approvalDAO.get_form_info(doc_idx);
		logger.info("form_info:{}",form_info);
		logger.info("doc_idx:{}",doc_idx);

		model.addAttribute("form_info",form_info);

		//파일 정보
		//1.먼저 doc_idx에 해당하는 file_key 가져오기
		String file_key = approvalDAO.get_doc_file_key(doc_idx);
		List<Map<String,Object>> file_infos = approvalDAO.get_file_info(file_key);
		model.addAttribute("file_infos",file_infos);

		//결재자 정보 (appr_line) - 만약 sent면 모두, received면
		List<Map<String,Object>> appr_lines =approvalDAO.get_all_appr_line(doc_idx);
		logger.info("appr_lines:{}",appr_lines);

		model.addAttribute("appr_lines",appr_lines);
		for(Map<String,Object> appr_line : appr_lines){
			logger.info("appr_line:{}",appr_line);
			if((int)appr_line.get("appr_receiver_idx") == empl_idx && (int)appr_line.get("appr_order")!=0){
				model.addAttribute("my_appr_order",(int)appr_line.get("appr_order"));
			}
		}


		//참조 정보 (refer_line)
		List<Map<String,Object>> refer_lines =approvalDAO.get_all_refer_line(doc_idx);
		model.addAttribute("refer_lines",refer_lines);


		//내 empl_idx 가져오기
		model.addAttribute("empl_idx", empl_idx);


	}

	public ResponseEntity<Resource> file_download(String new_filename, String ori_filename) {
		//1. Header 만들기
		//보낼 컨텐츠 타입, 형태 (문자인지, 파일인지), 파일일 경우 "저장할" 파일 명
		HttpHeaders header = new HttpHeaders();

		//2.본문 - FileSystem을 통해 특정 위치의 파일 가져오기

		Resource resource = new FileSystemResource(uploadAddr+new_filename);
		//Resource resource = new FileSystemResource(uploadAddr+"files/"+new_filename);

		//한글 명인 파일 깨지지 않게 처리
        try {
			String encode_name = URLEncoder.encode(ori_filename,"UTF-8");
			header.add("content-type", "application/octet-stream");
			header.add("content-Disposition","attachment;filename="+encode_name);
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}
        return new ResponseEntity<Resource>(resource,header, HttpStatus.OK);
    }

	public String get_doc_form_content(int doc_idx) {
		logger.info("doc_idx:{}",doc_idx);

		return approvalDAO.get_doc_form_content(doc_idx);
	}

	public List<Map<String, Object>> get_recent_written(int empl_idx) {
		return approvalDAO.get_recent_written(empl_idx);
	}

	public String get_stamp(String approval_empl_idx) {
		logger.info("approval_empl_idx:{}",approval_empl_idx);
		String stamp_url = "/files/"+approvalDAO.get_approval_stamp(approval_empl_idx);
		return stamp_url;
	}
}
