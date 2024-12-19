package com.toast.approval.service;

import com.toast.approval.dto.ApprovalRequestDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.approval.dao.ApprovalRequestDAO;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class ApprovalRequestService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalRequestDAO approvalRequestDAO;
	
	public ApprovalRequestService(ApprovalRequestDAO approvalRequestDAO) {
		this.approvalRequestDAO = approvalRequestDAO;
	}
	public List<Map<String,Object>> form_list() {
		return approvalRequestDAO.form_list();
	}

	public Map<String, Object> form(int idx) {

		return approvalRequestDAO.form(idx);
	}



	public int doc_write_initial(int formIdx, String formContent, int empl_idx) {
		int doc_idx = 0;
		//방금 저장한 idx 가져오기
		//BoardDTO에 값 저장하기
		ApprovalRequestDTO app_dto = new ApprovalRequestDTO();
		app_dto.setForm_idx(formIdx);
		app_dto.setDoc_content(formContent);
		app_dto.setDoc_empl_idx(empl_idx);
		if(approvalRequestDAO.doc_write_initial(app_dto)>0){
			doc_idx = app_dto.getDoc_idx();
			logger.info("방금 insert한 idx :{}",doc_idx);
		}
		return doc_idx;
	}

	public Map<String, Object> doc_get(int docIdx, int empl_idx) {
		Map<String, Object> map = approvalRequestDAO.doc_get(docIdx);
		map.put("empl_name", approvalRequestDAO.doc_empl_name(empl_idx));
		map.put("dept_idx",approvalRequestDAO.doc_dept_idx(empl_idx));
		return map;
	}

	public boolean doc_write(String doc_idx, String doc_end_date, String subject, String content_sub, String content, String doc_write_date, MultipartFile[] files, int empl_idx) {
		//doc write
		//이미 작성한 doc idx를 아니까 DTO 사용하지 않음
		boolean success = false;
		boolean file_empty = false;


		String file_key = UUID.randomUUID().toString();
		logger.info("첫 file_key 생성:{}",file_key);

		//(글쓰기 - file_key 없이)
		//만약 글쓰기가 끝나면,
		if(approvalRequestDAO.doc_write(doc_idx,doc_end_date,subject,content_sub,content,doc_write_date)>0) {

			//(파일이 있는지 확인하기)
			for (MultipartFile file : files) {
				file_empty = file.isEmpty();
				logger.info("파일 파라메터 값이 있는가?{}:", file_empty);
			}


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
						logger.info("파일 확장자 여부 :{}", file_type_split);

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
							if(approvalRequestDAO.approval_doc_file_write(doc_idx,ori_filename,new_filename,file_key,empl_idx,file_type,file_addr)>0){
								logger.info("DB에 저장한 file_key:{}",file_key);


								logger.info("파일 입력 성공");

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

	//저장된 파일키가 있을 경우 = 이전 파일 및 파일 경로 안의 파일 삭제 메소드
	public void approval_filekey_exist (String doc_idx){
		int previous_filekey_count =  approvalRequestDAO.doc_saved_filekey_count(doc_idx);
		logger.info("이전 파일키 갯수:{}",previous_filekey_count);

		//파일 키가 있을 경우
		if(previous_filekey_count >0){
			String previous_filekey = approvalRequestDAO.doc_saved_filekey(doc_idx);

			//[1]path 삭제
			//파일키의 파일 URL 가져오기 - SELECT file_addr FROM file WHERE file_key = #{file_key}
			Map<String,String> previous_path = approvalRequestDAO.get_previous_file_addr(previous_filekey);
			//파일 url이 여러 개일 수 있음
			for (String key : previous_path.keySet()) {
				File file = new File(previous_path.get(key));

				if(!file.exists()){
					boolean path_file_deleted = file.delete();
					logger.info("이전에 있던 파일 삭제되었음:{}",path_file_deleted);
				}
			}

			//[2]file DB 안의 file 삭제
			approvalRequestDAO.delete_previous_files(previous_filekey);

		}
	}

}
