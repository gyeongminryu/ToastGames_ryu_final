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
	public int getEmplIdx(String empl_id) {
		return documentDAO.getEmplIdx(empl_id);
	}

	public int getDeptIdx(int empl_idx) {
		return documentDAO.getDeptIdx(empl_idx);
	}

	public Map<String, Object> list(int page, int cnt, int dept_idx) {
		int limit = cnt;
		int offset = (page - 1) * cnt;
		int totalPages = documentDAO.allCount(cnt);
		int totalIdx = documentDAO.countIdx();

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("totalIdx", totalIdx);
		result.put("currentPage", page);
		result.put("offset", offset);

		// 열람 권한 확인하기
		List<DocumentDTO> list = documentDAO.list(limit, offset);
		List<Integer> line = new ArrayList<Integer>();
		List<Integer> dept = documentDAO.deptList(dept_idx); // 하위 부서 목록

		for (DocumentDTO dto : list) {
			line = documentDAO.line(dto.getDoc_idx());
			//logger.info(line.toString());

			if (dept_idx == 114) {   // 대표는 모든 문서를 열람할 수 있음
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
}
