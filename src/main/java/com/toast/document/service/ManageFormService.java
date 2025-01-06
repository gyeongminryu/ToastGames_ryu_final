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
        int totalPages = manageFormDAO.allCount(cnt, opt, keyword, sort);
        int totalIdx = manageFormDAO.countIdx(opt, keyword, sort);

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

    // 문서 양식 상세보기
    public Map<String, Object> detail(int form_idx) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("info", manageFormDAO.detail(form_idx));
        //logger.info("This is service. The result is "+result.toString());

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

        manageFormDAO.setLine1(form_idx);
        manageFormDAO.setLine2(form_idx);
        manageFormDAO.setLine3(form_idx);

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

    // 결재선 설정하기
    public Map<String, Object> callDept(int dept_high) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("info", manageFormDAO.callDept(dept_high));

        return result;
    }

    public Map<String, Object> callDeptname(int dept_idx) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("name", manageFormDAO.callDeptName(dept_idx));

        return result;
    }

    public void setLine(Map<String, String> params) {
        Map<String, Integer> newParams = new HashMap<String, Integer>();
        newParams.put("form_idx", Integer.parseInt(params.get("form_idx_modal")));
        newParams.put("gline_order", Integer.parseInt(params.get("tst_modal_param")));
        newParams.put("dept_idx", Integer.parseInt(params.get("select_team")));
        newParams.put("duty_idx", Integer.parseInt(params.get("duty_idx_modal")));

        if (newParams.get("dept_idx") == 0 && newParams.get("duty_idx") == 0) {
            if (newParams.get("gline_order") == 3) {
                manageFormDAO.setLine(newParams);
            } else if (newParams.get("gline_order") == 2) {
                manageFormDAO.setLine(newParams);

                newParams.put("gline_order", 3);
                manageFormDAO.setLine(newParams);
            } else if (newParams.get("gline_order") == 1) {
                manageFormDAO.setLine(newParams);

                newParams.put("gline_order", 2);
                manageFormDAO.setLine(newParams);

                newParams.put("gline_order", 3);
                manageFormDAO.setLine(newParams);
            }
        }
    }
}
