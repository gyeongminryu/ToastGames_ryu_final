package com.toast.document.controller;

import com.toast.document.service.ManageFormService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
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
    @RequestMapping (value = "/manage_form_list.go")
    public ModelAndView manage_form_list(HttpSession session) {
        
        return new ModelAndView("manage_form_list");
    }

    @RequestMapping (value = "/manage_form_list.ajax")
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

    @RequestMapping (value = "/manage_form_preview.ajax")
    public Map<String, Object> manage_form_preview(String idx) {
        int idxInt = Integer.parseInt(idx);

        return manageFormService.preview(idxInt);
    }
}
