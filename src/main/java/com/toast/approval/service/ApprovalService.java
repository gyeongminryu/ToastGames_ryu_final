package com.toast.approval.service;

import com.toast.approval.dto.ApprovalDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.approval.dao.ApprovalDAO;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class ApprovalService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final ApprovalDAO approvalDAO;
	
	public ApprovalService(ApprovalDAO approvalDAO) {
		this.approvalDAO = approvalDAO;
	}
	public List<Map<String,Object>> form_list() {
		return approvalDAO.form_list();
	}

	public Map<String, Object> form(int idx) {

		return approvalDAO.form(idx);
	}



	public int doc_write_initial(int formIdx, String formContent, int empl_idx) {
		int doc_idx = 0;
		//방금 저장한 idx 가져오기
		//BoardDTO에 값 저장하기
		ApprovalDTO app_dto = new ApprovalDTO();
		app_dto.setForm_idx(formIdx);
		app_dto.setDoc_content(formContent);
		app_dto.setDoc_empl_idx(empl_idx);
		if(approvalDAO.doc_write_initial(app_dto)>0){
			doc_idx = app_dto.getDoc_idx();
			logger.info("방금 insert한 idx :{}",doc_idx);
		}
		return doc_idx;
	}

	public Map<String, Object> doc_get(int docIdx, int empl_idx) {
		Map<String, Object> map = approvalDAO.doc_get(docIdx);
		map.put("empl_name", approvalDAO.doc_empl_name(empl_idx));
		map.put("dept_idx",approvalDAO.doc_dept_idx(empl_idx));
		return map;
	}

	public void doc_write(String doc_idx, String doc_end_date, String subject, String content_sub, String content, String doc_write_date, MultipartFile[] files, int empl_idx) {
		//doc write
		//이미 작성한 doc idx를 아니까 DTO 사용하지 않음


		if(approvalDAO.doc_write(doc_idx,doc_end_date,subject,content_sub,content,doc_write_date)>0){
			//file write
			//파일 분리
			logger.info("파일 갯수 :{}",files.length);

				for (MultipartFile file : files) {
					//ori_filename -> new_filename 설정

					String ori_filename = file.getOriginalFilename();
					//.확장자가 있는지 확인
					int file_type_split = ori_filename.lastIndexOf(".");
					logger.info("파일 확장자 여부 :{}",file_type_split);

					if(file_type_split>0){
						String file_type = ori_filename.substring(file_type_split);
						String new_filename = UUID.randomUUID().toString() + file_type;
						String file_key = UUID.randomUUID().toString();
						String file_addr = "C:/files/"+new_filename;
						//파일에 먼저 저장하기
						//1.byte
						try {
							byte [] bytes = file.getBytes();
							//2.path
							Path path = Paths.get(file_addr);

							//3. file write
							Files.write(path, bytes);


						} catch (IOException e) {
							throw new RuntimeException(e);
						}

						//DB에 저장하기
						if(approvalDAO.approval_doc_file_write(doc_idx,ori_filename,new_filename,file_key,empl_idx,file_type,file_addr)>0){
							logger.info("파일 입력 성공");
						}
					}

				}

		};




	}
}
