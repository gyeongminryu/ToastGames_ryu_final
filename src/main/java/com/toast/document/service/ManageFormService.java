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
    public Map<String, Object> list(int page, int cnt, String opt, String keyword, String sort, int form_writer_idx) {
        int limit = cnt;
        int offset = (page - 1) * cnt;
        int totalPages = manageFormDAO.allCount(cnt, opt, keyword, sort);
        int totalIdx = manageFormDAO.countIdx(opt, keyword, sort);

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("totalPages", totalPages);
        result.put("totalIdx", totalIdx);
        result.put("currentPage", page);
        result.put("offset", offset);
        result.put("list", manageFormDAO.list(limit, offset, opt, keyword, sort, form_writer_idx));

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
    public int write(String writer, int empl_idx, int dept_idx, String flag, int form_idx_ori) {
        int form_idx = 0;

        ManageFormDTO dto = new ManageFormDTO();
        dto.setForm_writer_idx(empl_idx);
        dto.setForm_writer_dept(dept_idx);
        dto.setForm_writer_position(manageFormDAO.getPositIdx(empl_idx));

        if (flag.equals("write")) {
            dto.setForm_subject("문서 양식");
            dto.setForm_content("<p style='text-align: center; margin-bottom: 36px;'><span id='form_title' style='font-size: 24px; font-weight: 700;'>문서 양식</span></p>\n" +
                    "<div id='approval_info' style='width: 100%; height: fit-content; margin: 0 0 36px; padding: 0; display: flex;'>\n" +
                    "<div id='sender_info' style='width: 220px; margin: 0; padding: 0; flex: 0 0 auto;'>\n" +
                    "<table id='sender_left' style='width: 220px; height: 120px;text-align: left; border-collapse: collapse;'>\n" +
                    "\t<colgroup>\n" +
                    "\t<col style='width: 70px' />\n" +
                    "\t<col style='width: auto' />\n" +
                    "\t</colgroup>\n" +
                    "\t<tbody>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td style='background-color: rgb(220, 220, 220); font-weight: 800; text-align: center; background-color: rgb(220, 220, 220);'>기안자</td>\n" +
                    "\t\t\t<td id='sender_name_left'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td style='background-color: rgb(220, 220, 220); font-weight: 800; text-align: center; background-color: rgb(220, 220, 220);'>기안부서</td>\n" +
                    "\t\t\t<td id='sender_dept_left'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td style='background-color: rgb(220, 220, 220); font-weight: 800; text-align: center; background-color: rgb(220, 220, 220);'>기안일</td>\n" +
                    "\t\t\t<td id='send_date_left'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td style='background-color: rgb(220, 220, 220); font-weight: 800; text-align: center; background-color: rgb(220, 220, 220);'>문서번호</td>\n" +
                    "\t\t\t<td id='document_idx_left'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t</tbody>\n" +
                    "</table>\n" +
                    "</div>\n" +
                    "<div id='approval_line' style='width: auto;margin: 0 0 0 auto;padding: 0;flex: 0 0 auto;'>\n" +
                    "<table id='approval_3' style='width: 90px;height: 120px;margin-left: -1px;text-align: center;border-collapse: collapse;float: right; display: none;'>\n" +
                    "\t<colgroup>\n" +
                    "\t<col style='width: auto' />\n" +
                    "\t</colgroup>\n" +
                    "\t<tbody>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td id='approval_duty_3' style='height: 20px;'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td id='approval_name_3'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td id='approval_date_3' style='height: 20px;'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t</tbody>\n" +
                    "</table>\n" +
                    "<table id='approval_2' style='width: 90px;height: 120px;margin-left: -1px;text-align: center;border-collapse: collapse;float: right; display: none;'>\n" +
                    "\t<colgroup>\n" +
                    "\t<col style='width: auto' />\n" +
                    "\t</colgroup>\n" +
                    "\t<tbody>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td id='approval_duty_2' style='height: 20px;'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td id='approval_name_2'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td id='approval_date_2' style='height: 20px;'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t</tbody>\n" +
                    "</table>\n" +
                    "<table id='approval_1' style='width: 110px;height: 120px;margin-left: 12px;text-align: center;border-collapse: collapse;float: right; display: none;'>\n" +
                    "\t<colgroup>\n" +
                    "\t<col style='width: 20px' />\n" +
                    "\t<col style='width: auto' />\n" +
                    "\t</colgroup>\n" +
                    "\t<tbody>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td rowspan='3' colspan='1' style='background-color: rgb(220, 220, 220); font-weight: 800;' br=''>승<br />\n" +
                    "\t\t\t인</td>\n" +
                    "\t\t\t<td id='approval_duty_1' style='height: 20px;'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td id='approval_name_1'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td id='approval_date_1' style='height: 20px;'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t</tbody>\n" +
                    "</table>\n" +
                    "<table id='sender_right' style='width: 110px;height: 120px;text-align: center;border-collapse: collapse;float: right;'>\n" +
                    "\t<colgroup>\n" +
                    "\t<col style='width: 20px' />\n" +
                    "\t<col style='width: auto' />\n" +
                    "\t</colgroup>\n" +
                    "\t<tbody>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td rowspan='3' colspan='1' style='background-color: rgb(220, 220, 220); font-weight: 800;'>기<br />\n" +
                    "\t\t\t안</td>\n" +
                    "\t\t\t<td id='sender_duty_right' style='height: 20px;'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td id='sender_name_right'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t\t<tr>\n" +
                    "\t\t\t<td id='send_date_right' style='height: 20px;'><br />\n" +
                    "\t\t\t</td>\n" +
                    "\t\t</tr>\n" +
                    "\t</tbody>\n" +
                    "</table>\n" +
                    "</div>\n" +
                    "</div>\n" +
                    "<p>여기에 표를 입력하세요.</p>\n");
        } else if (flag.equals("copy")) {
            dto.setForm_subject(manageFormDAO.copySubject(form_idx_ori));
            dto.setForm_content(manageFormDAO.copyContent(form_idx_ori));
        }

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
    public boolean update(String updater, int form_idx, String form_subject, String form_content, int empl_idx, int dept_idx) {
        boolean success = false;

        ManageFormDTO dto = new ManageFormDTO();
        dto.setForm_idx(form_idx);
        dto.setForm_subject(form_subject);
        dto.setForm_content(form_content);
        dto.setForm_updater_idx(empl_idx);
        dto.setForm_updater_dept(dept_idx);
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

        if (newParams.get("dept_idx") == -1 && newParams.get("duty_idx") == 0) {
            int i = newParams.get("gline_order");
            //logger.info("i="+i);

            while (i < 4) {
                manageFormDAO.setLine(newParams);
                i++;
               // logger.info("i="+i);
                newParams.put("gline_order", i);
            }

        } else {
            manageFormDAO.setLine(newParams);
        }
    }

    // 작성중인 문서 양식 등록하기
    public void register(int form_idx) {
        manageFormDAO.register(form_idx);
    }

    // 작성중인 문서 양식 삭제하기
    public void delete(int form_idx) {
        manageFormDAO.deleteForm(form_idx);
        manageFormDAO.deleteLines(form_idx);
    }

    // 등록한 문서 양식 삭제하기 (사용하지 않기)
    public void disuse(int form_idx) {
        manageFormDAO.disuse(form_idx);
    }

}
