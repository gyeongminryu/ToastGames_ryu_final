package com.toast.regdata.controller;

import com.toast.regdata.service.ManageFormService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpRequest;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RestController
public class ManageFormController {
    Logger logger = LoggerFactory.getLogger(getClass());

    private final ManageFormService manageFormService;

    public ManageFormController(ManageFormService manageFormService) {
        this.manageFormService = manageFormService;
    }

    // 권한 확인
    public ModelAndView authorize(HttpSession session, String addr) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("manage_form_unauthorized");

        // 세션이 존재하는지 확인
        if (session.getAttribute("loginId") != null) {
            // 세션 내 부서 번호 인출
            int dept_idx = Integer.parseInt(session.getAttribute("dept_idx").toString());

            // 부서 번호 확인
            if (dept_idx == 122 || (dept_idx >= 152 && dept_idx <= 157)) {
                //logger.info("Valid dept_idx = " + dept_idx);
                mav.setViewName(addr);
            } else {
                //logger.warn("Invalid dept_idx = " + dept_idx);
            }
        } else {
            mav.setViewName("login");
        }

        return mav;
    }

    // 문서 양식 목록
    @GetMapping (value = "/manage_form_unauthorized.go")
    public ModelAndView manage_form_unauthorized(HttpSession session) {

        return new ModelAndView("manage_form_unauthorized");
    }

    // 문서 양식 목록
    @GetMapping (value = "/manage_form_list.go")
    public ModelAndView manage_form_list(HttpSession session) {

        return authorize(session, "manage_form_list");
    }

    // 사용하지 않는 문서 양식 목록
    @GetMapping (value = "/manage_form_disuse_list.go")
    public ModelAndView manage_form_disuse_list(HttpSession session) {

        return authorize(session, "manage_form_disuse_list");
    }

    // 작성중인 문서 양식 목록
    @GetMapping (value = "/manage_form_wip_list.go")
    public ModelAndView manage_form_wip_list(HttpSession session) {

        return authorize(session, "manage_form_wip_list");
    }

    @PostMapping (value = "/manage_form_list.ajax")
    public Map<String, Object> manage_form_list(HttpSession session, String page, String cnt, String opt, String keyword, String sort) {
        int form_writer_idx = Integer.parseInt(session.getAttribute("empl_idx").toString());

        int pageInt = Integer.parseInt(page);
        int cntInt = Integer.parseInt(cnt);
        String optName = "";

        if (opt.equals('0')) {
            optName = "form_subject";
        } else {
            optName = "form_content";
        }

        return manageFormService.list(pageInt, cntInt, optName, keyword, sort, form_writer_idx);
    }

    @PostMapping (value = "/manage_form_preview.ajax")
    public Map<String, Object> manage_form_preview(String form_idx) {
        int form_idxInt = Integer.parseInt(form_idx);

        return manageFormService.preview(form_idxInt);
    }

    // 문서 양식 상세보기
    @GetMapping (value = "/manage_form_detail.go")
    public ModelAndView manage_form_detail(HttpSession session) {

        return authorize(session, "manage_form_detail");
    }
    @GetMapping (value = "/manage_form_disuse_detail.go")
    public ModelAndView manage_form_disuse_detail(HttpSession session) {

        return authorize(session, "manage_form_disuse_detail");
    }

    @PostMapping (value = "/manage_form_detail.ajax")
    public Map<String, Object> manage_form_detail(String form_idx) {
        //logger.info("This is controller. The form idx is: "+form_idx);
        int form_idxInt = Integer.parseInt(form_idx);

        return manageFormService.detail(form_idxInt);
    }

    // 문서 양식 작성하기
    @RequestMapping (value = "/manage_form_write.do")
    public ModelAndView manage_form_write(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        String writer = session.getAttribute("loginId").toString();
        int empl_idx = Integer.parseInt(session.getAttribute("empl_idx").toString());
        int dept_idx = Integer.parseInt(session.getAttribute("dept_idx").toString());
        int form_idx = manageFormService.write(writer, empl_idx, dept_idx, "write", 0);

        String viewName = "";
        if (form_idx < 0) {
            viewName = "redirect:/manage_form_list.go";
        } else {
            viewName = "redirect:/manage_form_update.go?form_idx="+form_idx;
        }

        return authorize(session, viewName);
    }

    // 문서 양식 수정하기
    @GetMapping (value = "/manage_form_update.go")
    public ModelAndView manage_form_update(HttpSession session) {

        return authorize(session, "manage_form_update");
    }

    @PostMapping (value = "/manage_form_update.ajax")
    public Map<String, Object> manage_form_detail(HttpSession session, String form_idx, String form_subject, String form_content) {
        Map<String,Object> map = new HashMap<String, Object>();

        String updater = session.getAttribute("loginId").toString();
        int empl_idx = Integer.parseInt(session.getAttribute("empl_idx").toString());
        int dept_idx = Integer.parseInt(session.getAttribute("dept_idx").toString());
        int form_idxInt = Integer.parseInt(form_idx);
        //logger.info("form_idxInt = "+form_idxInt);

        map.put("success", manageFormService.update(updater, form_idxInt, form_subject, form_content, empl_idx, dept_idx));

        return map;
    }

    // 작성중인 문서 양식 수정하기
    @GetMapping (value = "/manage_form_wip_update.go")
    public ModelAndView manage_form_wip_update(HttpSession session) {

        return authorize(session, "manage_form_wip_update");
    }

    // 결재선 설정하기
    @PostMapping (value = "/manage_form_call_dept.ajax")
    public Map<String, Object> manage_form_call_dept(String dept_high) {
        int dept_highInt = Integer.parseInt(dept_high);

        return manageFormService.callDept(dept_highInt);
    }

    @PostMapping (value = "/manage_form_call_name.ajax")
    public Map<String, Object> manage_form_call_name(String dept_idx) {
        //logger.info("dept_idx = "+dept_idx);
        int dept_idxInt = Integer.parseInt(dept_idx);

        return manageFormService.callDeptname(dept_idxInt);
    }

    @RequestMapping (value = "/manage_form_set_line.do")
    public ModelAndView manage_form_set_line(@RequestParam Map<String, String> params) {
        ModelAndView mav = new ModelAndView();
        //logger.info("params: {}", params);
        manageFormService.setLine(params);
        int form_state = manageFormService.getState(Integer.parseInt(params.get("form_idx_modal")));

        if (form_state == 1) {
            mav.setViewName("redirect:/manage_form_update.go?form_idx=" + params.get("form_idx_modal"));
        } else if (form_state == 2) {
            mav.setViewName("redirect:/manage_form_wip_update.go?form_idx=" + params.get("form_idx_modal"));
        }

        return mav;
    }

    // 작성중인 문서 양식 등록하기
    @RequestMapping (value = "/manage_form_register.do")
    public ModelAndView manage_form_register(HttpSession session, String form_idx) {
        //logger.info("form_idx = "+form_idx);
        manageFormService.register(Integer.parseInt(form_idx), session.getAttribute("loginId").toString());

        return new ModelAndView("redirect:/manage_form_detail.go?form_idx=" + form_idx);
    }

    // 작성중인 문서 양식 삭제하기
    @RequestMapping (value = "/manage_form_delete.do")
    public ModelAndView manage_form_delete(String form_idx) {
        //logger.info("form_idx = "+form_idx);
        int form_idxInt = Integer.parseInt(form_idx);
        manageFormService.delete(form_idxInt);

        return new ModelAndView("redirect:/manage_form_wip_list.go");
    }

    // 등록한 문서 양식 삭제하기 (사용하지 않기)
    @RequestMapping (value = "/manage_form_disuse.do")
    public ModelAndView manage_form_disuse(String form_idx) {
        //logger.info("form_idx = "+form_idx);
        int form_idxInt = Integer.parseInt(form_idx);
        manageFormService.disuse(form_idxInt);

        return new ModelAndView("redirect:/manage_form_disuse_list.go");
    }

    // 양식 복구하기
    @RequestMapping (value = "/manage_form_restore.do")
    public ModelAndView manage_form_restore(HttpSession session, String form_idx) {
        //logger.info("form_idx = "+form_idx);
        manageFormService.register(Integer.parseInt(form_idx), session.getAttribute("loginId").toString());

        return new ModelAndView("redirect:/manage_form_detail.go?form_idx=" + form_idx);
    }

    // 양식 복사하기
    @RequestMapping (value = "/manage_form_copy.do")
    public ModelAndView manage_form_copy(HttpSession session, String form_idx_ori) {
        ModelAndView mav = new ModelAndView();

        String writer = session.getAttribute("loginId").toString();
        int empl_idx = Integer.parseInt(session.getAttribute("empl_idx").toString());
        int dept_idx = Integer.parseInt(session.getAttribute("dept_idx").toString());
        int form_idx_oriInt = Integer.parseInt(form_idx_ori);
        int form_idx = manageFormService.write(writer, empl_idx, dept_idx, "copy", form_idx_oriInt);

        String viewName = "";
        if (form_idx < 0) {
            viewName = "redirect:/manage_form_list.go";
        } else {
            viewName = "redirect:/manage_form_wip_update.go?form_idx="+form_idx;
        }

        return authorize(session, viewName);
    }
}
