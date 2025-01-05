package com.toast.document.controller;

import com.toast.document.service.ManageFormService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Map;

@RestController
public class ManageFormController {
    Logger logger = LoggerFactory.getLogger(getClass());

    private final ManageFormService manageFormService;

    public ManageFormController(ManageFormService manageFormService) {
        this.manageFormService = manageFormService;
    }

    // 권한 확인 - 작업하는 중
    public ModelAndView authorize(HttpSession session, String addr) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("approval_writing_list");
        // 세션 임의 저장
        session.setAttribute("loginId", "tndls0110");

        return mav;
    }

    // 문서 양식 목록
    @GetMapping (value = "/manage_form_list.go")
    public ModelAndView manage_form_list(HttpSession session) {
        
        return new ModelAndView("manage_form_list");
    }

    @PostMapping(value = "/manage_form_list.ajax")
    public Map<String, Object> manage_form_list(String page, String cnt, String opt, String keyword) {
        int pageInt = Integer.parseInt(page);
        int cntInt = Integer.parseInt(cnt);
        String optName = "";

        if (opt.equals('0')) {
            optName = "form_subject";
        } else {
            optName = "form_content";
        }

        return manageFormService.list(pageInt, cntInt, optName, keyword);
    }

    @PostMapping (value = "/manage_form_preview.ajax")
    public Map<String, Object> manage_form_preview(String form_idx) {
        int form_idxInt = Integer.parseInt(form_idx);

        return manageFormService.preview(form_idxInt);
    }

    // 문서 양식 상세보기
    @GetMapping (value = "/manage_form_detail.go")
    public ModelAndView manage_form_detail(HttpSession session) {

        return new ModelAndView("manage_form_detail");
    }

    @PostMapping(value = "/manage_form_detail.ajax")
    public Map<String, Object> manage_form_detail(String form_idx) {
        //logger.info("This is controller. The form idx is: "+form_idx);
        int form_idxInt = Integer.parseInt(form_idx);

        return manageFormService.detail(form_idxInt);
    }

    // 문서 양식 작성하기
    @RequestMapping (value = "/manage_form_write.do")
    public ModelAndView manage_form_write(HttpSession session) {
        session.setAttribute("loginId", "tndls0110");
        String writer = session.getAttribute("loginId").toString();
        int form_idx = manageFormService.write(writer);

        return new ModelAndView("redirect:/manage_form_update.go?form_idx="+form_idx);
    }

    // 문서 양식 수정하기
    @GetMapping (value = "/manage_form_update.go")
    public ModelAndView manage_form_update(HttpSession session) {

        return new ModelAndView("manage_form_update");
    }
}
