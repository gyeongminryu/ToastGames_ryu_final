package com.toast.document.service;

import com.toast.document.dao.ManageFormDAO;
import com.toast.document.dto.ManageFormDTO;
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
    public Map<String, Object> list(int page, int cnt, String opt, String keyword, String sort) {
        int limit = cnt;
        int offset = (page - 1) * cnt;
        int totalPages = manageFormDAO.allCount(cnt, opt, keyword);
        int totalIdx = manageFormDAO.countIdx(opt, keyword);

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("totalPages", totalPages);
        result.put("totalIdx", totalIdx);
        result.put("currentPage", page);
        result.put("offset", offset);
        result.put("list", manageFormDAO.list(limit, offset, opt, keyword, sort));

        return result;
    }

    public Map<String, Object> preview(int form_idx) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("preview", manageFormDAO.preview(form_idx));

        return result;
    }

    // 문서 양식 작성하기
    public int write(String writer) {
        int form_idx = 0;
        int empl_idx = manageFormDAO.getIdx(writer);

        ManageFormDTO dto = new ManageFormDTO();
        dto.setForm_writer_idx(empl_idx);
        dto.setForm_writer_dept(manageFormDAO.getDeptIdx(empl_idx));
        dto.setForm_writer_position(manageFormDAO.getPositIdx(empl_idx));

        if (manageFormDAO.write(dto) > 0) {
            form_idx = dto.getForm_idx();
        } else {
            form_idx = -1;
        }
        //logger.info("The form idx is " + form_idx + ".");

        return form_idx;
    }

    // 문서 양식 수정하기
    public boolean update(String updater, int form_idx, String form_subject, String form_content) {
        boolean success = false;
        int empl_idx = manageFormDAO.getIdx(updater);

        ManageFormDTO dto = new ManageFormDTO();
        dto.setForm_idx(form_idx);
        dto.setForm_subject(form_subject);
        dto.setForm_content(form_content);
        dto.setForm_updater_idx(empl_idx);
        dto.setForm_updater_dept(manageFormDAO.getDeptIdx(empl_idx));
        dto.setForm_updater_position(manageFormDAO.getPositIdx(empl_idx));

        if (manageFormDAO.update(dto) > 0) {
            success = true;
        }

        return success;
    }

    // 문서 양식 상세보기
    public Map<String, Object> detail(int form_idx) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("info", manageFormDAO.detail(form_idx));
        //logger.info("This is service. The result is "+result.toString());

        return result;
    }
}
