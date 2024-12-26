package com.toast.approval.service;

import com.toast.approval.dto.ApprovalRequestDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Service;

import com.toast.approval.dao.ApprovalRequestDAO;
import org.springframework.web.multipart.MultipartFile;

import java.io.Console;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Service
public class ApprovalRequestService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalRequestDAO approvalRequestDAO;
	
	public ApprovalRequestService(ApprovalRequestDAO approvalRequestDAO) {
		this.approvalRequestDAO = approvalRequestDAO;
	}


	//미리보기에서 수정한 문서 1차로 저장하기
	public int doc_write_initial(int form_idx, String form_content, int empl_idx) {
		int doc_idx = 0;

				//방금 저장한 idx 가져오기
		//BoardDTO에 값 저장하기
		ApprovalRequestDTO app_dto = new ApprovalRequestDTO();
		app_dto.setForm_idx(form_idx);
		app_dto.setDoc_content(form_content);
		app_dto.setDoc_empl_idx(empl_idx);

		if(approvalRequestDAO.doc_write_initial(app_dto)>0){
			doc_idx = app_dto.getDoc_idx();
			logger.info("방금 insert한 idx :{}",doc_idx);

			//방금 작성한 doc_idx 기반으로 결재선에 값 저장하기 =======================================================
				//1.form_idx의 결재선 가져오기
				List<Map<String,Object>> g_approval_lines = approvalRequestDAO.get_g_approval_line(form_idx);
				//2. 사원의 부서 가져오기
				int dept_idx = approvalRequestDAO.doc_dept_idx(empl_idx);
				logger.info("본인 부서 idx:{}",dept_idx);

				//3.결재선 + doc_idx 저장하기
					// 여기서는 부서 idx는 사원 부서 기준으로 잡고, 해당 부서 idx 및 직책을 가진 결재자를 조회하여 가져오기
					// 사장은 직책만 가지고 이름 idx 가져오기


				//전달할 파라메터 만드는 map
				Map<String, Object> approval_initial_write_param = new HashMap<>();

			//param에 넣을 값 -> 변수 선언
				int approval_empl_idx = 0;
				int approval_dept_idx =0;
				int position_idx = 0;

				int line_order = 1;
				for (int i = 0; i < g_approval_lines.size(); i++) {
					Map<String, Object> g_approval_line = g_approval_lines.get(i);

					//직책 받아오기
					int duty_idx = (int) g_approval_line.get("duty_idx");
					logger.info("직책 idx:{}",duty_idx);

					//1_만약 상위 부서값이 있으면(select count(*))
					if(approvalRequestDAO.get_high_dept_count(dept_idx)>0){
						logger.info("팀에 소속된 팀원임");

						//if duty_idx == 3 부서장인 경우
						if(duty_idx ==3){
							logger.info("부서장");
							
							//상위 부서의 idx의 값 가져오기
							int high_dept_idx = approvalRequestDAO.get_high_dept(dept_idx);

							//부서장이 있는지 확인
							if(approvalRequestDAO.get_high_dept_head_count(high_dept_idx, duty_idx)>0) {
								//자기 부서의 상위 부서의 부서장 가져옴 (get_high_dept_head())
								//	- dept_idx = 상위부서
								Map<String, Object> get_high_dept_head = approvalRequestDAO.get_high_dept_head(high_dept_idx, duty_idx);
								approval_empl_idx = (int) get_high_dept_head.get("empl_idx");
								approval_dept_idx = (int) get_high_dept_head.get("dept_idx");
								position_idx = (int) get_high_dept_head.get("position_idx");

								logger.info("파라메터 만드는 메소드 실행 전");
								//파라메터 만드는 메소드 실행
								set_approval_init_param(approval_initial_write_param,doc_idx,line_order,approval_dept_idx,duty_idx,approval_empl_idx,position_idx);

								line_order++;
							}else{
								logger.info("부서장 없음");
							}
						}else if(duty_idx==4){//if duty_idx == 4 팀장인 경우
							//팀장이 있는지 확인
							logger.info("팀장");
							
							if(approvalRequestDAO.get_team_head_count(dept_idx, duty_idx)>0){
								//자기 부서의 팀장 정보 가져옴
								//자기 부서의 팀장 가져옴
								//- dept_idx = 자기부서
								Map<String, Object> get_team_head = approvalRequestDAO.get_team_head(dept_idx, duty_idx);
								approval_empl_idx = (int) get_team_head.get("empl_idx");
								approval_dept_idx = (int) get_team_head.get("dept_idx");
								position_idx = (int) get_team_head.get("position_idx");

								//파라메터 만드는 메소드 실행
								logger.info("파라메터 만드는 메소드 실행");

								set_approval_init_param(approval_initial_write_param,doc_idx,line_order,approval_dept_idx,duty_idx,approval_empl_idx,position_idx);
								line_order++;

							}else{
								logger.info("팀장 없음");
							}
						}




					}else{
						logger.info("부서에 소속된 부서원임");
						
						//=============================================
						//2_만약 상위 부서값이 없으면
						//본인 idx
						//duty_idx == 3 부서장인 경우
						if(duty_idx ==3){
							//부서장이 있는지 확인
							if(approvalRequestDAO.get_high_dept_head_count(dept_idx, duty_idx)>0) {
								//자기 부서 부서장 가져옴
								// dept_idx = 자기부서
								Map<String, Object> get_high_dept_head = approvalRequestDAO.get_high_dept_head(dept_idx, duty_idx);
								approval_empl_idx = (int) get_high_dept_head.get("empl_idx");
								approval_dept_idx = (int) get_high_dept_head.get("dept_idx");
								position_idx = (int) get_high_dept_head.get("position_idx");

								//파라메터 만드는 메소드 실행
								set_approval_init_param(approval_initial_write_param,doc_idx,line_order,approval_dept_idx,duty_idx,approval_empl_idx,position_idx);

								line_order++;
							}else{
								logger.info("부서장 없음");
							}
						}
					}

					if(duty_idx ==2){
						logger.info("사장 가져오기");

						//사장 작업 중
						Map<String,Object> head_info = approvalRequestDAO.get_head_info();
						approval_empl_idx = (int) head_info.get("empl_idx");
						approval_dept_idx = (int) head_info.get("dept_idx");
						position_idx = (int) head_info.get("position_idx");

						set_approval_init_param(approval_initial_write_param,doc_idx,line_order,approval_dept_idx,duty_idx,approval_empl_idx,position_idx);
						line_order++;

					}
				}
			//방금 작성한 doc_idx 기반으로 참조선에 값 저장하기 =======================================================
					//approvalRequestDAO.save_refer_line_initial(doc_idx);
		}
		return doc_idx;
	}


	//파라메터 만들어서 최초의 저장을 하게 도와주는 메서드
	public void set_approval_init_param(Map<String,Object> approval_initial_write_param,int doc_idx, int line_order, int approval_dept_idx, int duty_idx, int approval_empl_idx, int position_idx) {

		approval_initial_write_param.put("doc_idx", doc_idx);
		approval_initial_write_param.put("line_order", line_order);
		approval_initial_write_param.put("dept_idx", approval_dept_idx);
		approval_initial_write_param.put("duty_idx", duty_idx);
		approval_initial_write_param.put("empl_idx", approval_empl_idx);
		approval_initial_write_param.put("position_idx", position_idx);



		logger.info("파라메터 만드는 메소드 실행:{}",approval_initial_write_param);

		save_approval_line_initial(approval_initial_write_param);
	}
	//결재선 최초 저장해주는 메서드
	public void save_approval_line_initial(Map<String,Object> approval_initial_write_param){
		logger.info("결재선 최초 저장");
		approvalRequestDAO.save_approval_line_initial(approval_initial_write_param);
	}

	//1차 저장한 문서 가져오기
	public Map<String, Object> doc_get(int docIdx, int empl_idx) {
		Map<String, Object> map = approvalRequestDAO.doc_get(docIdx);
		//문서양식에 이름이랑 부서 넣기 위함
		map.put("empl_name", approvalRequestDAO.doc_empl_name(empl_idx));
		map.put("dept_idx",approvalRequestDAO.doc_dept_idx(empl_idx));
		return map;
	}

	//1차로 저장된 결재 라인 가져오기
	public List<Map<String,Object>> doc_line_get(int doc_idx) {
		return approvalRequestDAO.doc_line_get(doc_idx);
	}



	//작성한 문서 저장하기
	public boolean doc_write(Map<String,String> param, MultipartFile[] files) {
		//doc write
		//이미 작성한 doc idx를 아니까 DTO 사용하지 않음
		boolean success = false;
		boolean file_empty = false;
		String empl_idx = param.get("empl_idx");

		String file_key = UUID.randomUUID().toString();
		//logger.info("첫 file_key 생성:{}",file_key);

		//(글쓰기 - file_key 없이)
		//만약 글쓰기가 끝나면,
		if(approvalRequestDAO.doc_write(param)>0) {

			//(파일이 있는지 확인하기)
			for (MultipartFile file : files) {
				file_empty = file.isEmpty();
				//logger.info("파일 파라메터 값이 있는가?{}:", file_empty);
			}

			String doc_idx = param.get("doc_idx");
			// 새로운 파일 있음
			if(!file_empty){
				//저장된 파일키가 있을 경우 = 이전 파일 및 파일 경로 안의 파일 삭제 메소드
				approval_filekey_exist(doc_idx);

				//파일키 없거나 파일키 삭제되면
				// 파일 분리해서 새로운 파일 저장 및 document의 file_key update

				for (MultipartFile file : files) {
					//ori_filename -> new_filename 설정

					String ori_filename = file.getOriginalFilename();
					//.확장자가 있는지 확인
					int file_type_split = ori_filename.lastIndexOf(".");
					//logger.info("파일 확장자 여부 :{}", file_type_split);

					//만약 확장자가 있으면
					if (file_type_split > 0) {
						String file_type = ori_filename.substring(file_type_split);
						String new_filename = UUID.randomUUID().toString() + file_type;

						String file_addr = "C:/files/" + new_filename;
						//파일에 먼저 저장하기
						//1.byte
						try {
							byte[] bytes = file.getBytes();
							//2.path
							Path path = Paths.get(file_addr);

							//3. file write
							Files.write(path, bytes);


						} catch (Exception e) {
							throw new RuntimeException(e);
						}
						//DB에 새로운 파일 업로드
						if(approvalRequestDAO.approval_doc_file_write(doc_idx,ori_filename,new_filename,file_key, Integer.parseInt(empl_idx),file_type,file_addr)>0){
							//logger.info("DB에 저장한 file_key:{}",file_key);


							//logger.info("파일 입력 성공");

							//document에 file key update
							approvalRequestDAO.doc_write_file_key(doc_idx,file_key);

						}


					}

				}

				// ===========================================================================================================
				//(파일이 있는지 확인하기)
				// 새로운 파일 없음
			}else{
				//저장된 파일키가 있을 경우 = 이전 파일 및 파일 경로 안의 파일 삭제 메소드
				approval_filekey_exist(doc_idx);
				//document의 file_key = ''로 업데이트하기
				approvalRequestDAO.doc_filekey_delete(doc_idx);
			}

			success = true;
		}
		return success;
	}

	//선택한 결재선 저장
	public boolean save_approval_line(Map<String, String> param) {
		boolean success = false;
		String doc_idx = param.get("doc_idx");


		Map<String,Object> data = new HashMap<>();

		//결재 임시 저장 로직
		//먼저 이전 값에서 line_order이 있는지 확인
		//만약 전달 받은 값이 있는데 이전에는 없었으면 insert 시키기
		//만약 전달 받은 값이 없는데 이전에는 있었으면 delete 시키기
		//만약 전달 받은 값이 있고 이전에도 있으면 update 시키기
		//전달 받은 값이 없고, 이전에도 없는 경우면 x


		for(int i = 1; i <=3; i++){
			logger.info("empl_line1:{}",param.get("empl_line"+i));

			//결재자 사원번호가 있는지 확인
			var empl_line = param.get("empl_line"+i);

			data.put("line_order", i);
			data.put("doc_idx", doc_idx);
			data.put("empl_idx",param.get("empl_line"+i));
			data.put("dept_idx",param.get("dept_line"+i));
			data.put("duty_idx",param.get("duty_line"+i));
			data.put("position_idx",param.get("position_line"+i));

			logger.info("map값 :{}",data);
			//doc_idx 문서의 이전 값에서 line_order 있었는지 확인
			var prev_line_exists = approvalRequestDAO.show_prev_line_order(i,doc_idx);

			//만약 전달 받은 값이 있는데 이전에는 없었으면 insert 시키기
			if(prev_line_exists==0 && !empl_line.isEmpty()){
				//만약 전달 받은 값이 있는데 이전에는 없었으면 insert 시키기
                success = approvalRequestDAO.save_approval_line(data) > 0;
				//만약 전달 받은 값이 없는데 이전에는 있었으면 delete 시키기
			}else if(prev_line_exists>0 && empl_line.isEmpty()){
                success = approvalRequestDAO.delete_approval_line(data) > 0;
				//만약 전달 받은 값이 있고 이전에도 있으면 update 시키기
			}else if(prev_line_exists>0 && !empl_line.isEmpty()){
                success = approvalRequestDAO.update_approval_line(data) > 0;
			}
		}

		return success;
	}

	//기존에 저장된 파일키가 있을 경우 = 이전 파일 및 파일 경로 안의 파일 삭제 메소드
	public void approval_filekey_exist (String doc_idx){
		int previous_filekey_count =  approvalRequestDAO.doc_saved_filekey_count(doc_idx);
		logger.info("이전 파일키 갯수:{}",previous_filekey_count);

		//파일 키가 있을 경우
		if(previous_filekey_count >0){
			String previous_filekey = approvalRequestDAO.doc_saved_filekey(doc_idx);
			logger.info(previous_filekey);

			//[1]path 삭제
			//파일키의 파일 URL 가져오기 - SELECT file_addr FROM file WHERE file_key = #{file_key}
			List<Map<String,String>> previous_paths = approvalRequestDAO.get_previous_file_addr(previous_filekey);
			//파일 url이 여러 개일 수 있음
			for (Map<String,String> previous_path : previous_paths) {
				for (String key : previous_path.keySet()) {
					File file = new File(previous_path.get(key));

					if(!file.exists()){
						boolean path_file_deleted = file.delete();
						logger.info("이전에 있던 파일 삭제되었음:{}",path_file_deleted);
					}
				}
			}
			//[2]file DB 안의 file 삭제
			approvalRequestDAO.delete_previous_files(previous_filekey);

		}
	}



	public boolean save_refer_line(List<String> refer_lines, String doc_idx) {
		boolean success = false;
		int exists = approvalRequestDAO.prev_refer_exists(doc_idx);

		logger.info("exists:{}",exists);
		//이전에 doc_idx가 참조 테이블에 존재하면 삭제하기
		if(exists>0){
			if(approvalRequestDAO.delete_prev_refer(doc_idx)>0){
				logger.info("이전 참조값 삭제되었음");
			}
		}



		for(String referrer_idx : refer_lines){
			if(approvalRequestDAO.save_refer_line(Integer.parseInt(referrer_idx),doc_idx)>0){
				success = true;
			}
		}



		return success;
	}


	public void write_delete(String doc_idx) {
		//file Path 삭제 + file 삭제
		approval_filekey_exist(doc_idx);

		//문서 삭제
		approvalRequestDAO.delete_doc(doc_idx);

		//결재 라인 삭제
		approvalRequestDAO.delete_all_approval_line(doc_idx);
		//참조 라인 삭제
		approvalRequestDAO.delete_prev_refer(doc_idx);

	}
}
