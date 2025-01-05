package com.toast.document.service;

import com.toast.document.dao.ManageFormDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class ManageFormService {
    Logger logger = LoggerFactory.getLogger(getClass());

    private final ManageFormDAO manageFormDAO;

    public ManageFormService(ManageFormDAO manageFormDAO) {
        this.manageFormDAO = manageFormDAO;
    }

    // 문서 양식 목록
    public Map<String, Object> list(int page, int cnt, String opt, String keyword) {
        int limit = cnt;
        int offset = (page - 1) * cnt;
        int totalPages = manageFormDAO.allCount(cnt, opt, keyword);
        int totalIdx = manageFormDAO.countIdx(opt, keyword);

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("totalPages", totalPages);
        result.put("totalIdx", totalIdx);
        result.put("currentPage", page);
        result.put("offset", offset);
        result.put("list", manageFormDAO.list(limit, offset, opt, keyword));

        return result;
    }

    public Map<String, Object> preview(int form_idx) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("preview", manageFormDAO.preview(form_idx));

        return result;
    }

    // 문서 양식 상세보기
    public Map<String, Object> detail(int form_idx) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("info", manageFormDAO.detail(form_idx));
        //logger.info("This is service. The result is "+result.toString());

        return result;
    }
}
