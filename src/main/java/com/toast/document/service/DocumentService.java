package com.toast.document.service;

import com.toast.document.dto.DocumentDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.toast.document.dao.DocumentDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DocumentService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final DocumentDAO documentDAO;
	
	public DocumentService(DocumentDAO documentDAO) {
		this.documentDAO = documentDAO;
	}

	// 문서 목록
	public int findPresident() {

		return documentDAO.findPresident();
	}

	public Map<String, Object> depList(int dept_depth, int dept_high) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", documentDAO.depList(dept_depth, dept_high));

		return result;
	}

	public Map<String, Object> list(int page, int cnt, int dept_idx, String opt, String keyword, String dept1, String dept2, String accessible_filtering) {
		if (accessible_filtering.equals("true")) {
			dept1 = String.valueOf(dept_idx);
		}

		int limit = cnt;
		int offset = (page - 1) * cnt;
		int totalPages = documentDAO.allCount(cnt, opt, keyword, dept1, dept2);
		int totalIdx = documentDAO.countIdx(opt, keyword, dept1, dept2);

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("totalIdx", totalIdx);
		result.put("currentPage", page);
		result.put("offset", offset);

		// 열람 권한 확인하기
		List<Integer> dept = documentDAO.deptList(dept_idx); // 하위 부서 목록
		List<DocumentDTO> list = documentDAO.list(limit, offset, opt, keyword, dept1, dept2, dept);
		List<Integer> line = new ArrayList<Integer>();

		for (DocumentDTO dto : list) {
			line = documentDAO.line(dto.getDoc_idx());
			//logger.info(line.toString());

			if (dept_idx == documentDAO.findPresident()) {   // 대표는 모든 문서를 열람할 수 있음
				dto.setAuthority(true);
			} else {
				for (int idx : line) {
					//logger.info("idx = "+idx);
					//logger.info("dept_idx = "+dept_idx);

					if (idx == dept_idx) {
						dto.setAuthority(true);
						break;
					}

					for (int team : dept) {
						//logger.info("idx = "+idx);
						//logger.info("team = "+team);

						if (idx == team){
							dto.setAuthority(true);
							break;
						}
					}
				}
			}
		}

		// 열람 권한이 없는 문서의 idx 삭제하기
		for (DocumentDTO dto : list) {
			if (!dto.isAuthority()) {
				dto.setDoc_idx(-1);
			}
		}

		result.put("list", list);

		return result;
	}

	// 문서 열람
	public boolean authority(int dept_idx, int doc_idx) {
		boolean result = false;

		// 열람 권한 확인하기
		List<Integer> dept = documentDAO.deptList(dept_idx); // 하위 부서 목록

		if (dept_idx == documentDAO.findPresident()) {   // 대표는 모든 문서를 열람할 수 있음
			result = true;
		} else {
			List<Integer> line = documentDAO.line(doc_idx); // 문서와 연관된 부서 목록
			//logger.info(line.toString());

			for (int idx : line) {
				//logger.info("idx = "+idx);
				//logger.info("dept_idx = "+dept_idx);

				if (idx == dept_idx) {
					result = true;
					break;
				}

				for (int team : dept) {
					//logger.info("idx = "+idx);
					//logger.info("team = "+team);

					if (idx == team){
						result = true;
						break;
					}
				}
			}
		}

		//logger.info("result = "+result);
		return result;
	}

	public Map<String, Object> detail(int doc_idx) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("info", documentDAO.detail(doc_idx));

		return result;
	}

	public Map<String, Object> appr(int doc_idx) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", documentDAO.appr(doc_idx));

		return result;
	}

	public Map<String, Object> refer(int doc_idx) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", documentDAO.refer(doc_idx));

		return result;
	}

	public Map<String, Object> file(int doc_idx) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", documentDAO.file(doc_idx));

		return result;
	}
}
