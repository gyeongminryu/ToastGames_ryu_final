package com.toast.front;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class FrontController {
    Logger logger = LoggerFactory.getLogger(getClass());

    // Login
    @RequestMapping(value = "/")
    public ModelAndView front_login() {
        return new ModelAndView("login");
    }

    @RequestMapping(value = "/login_find_id")
    public ModelAndView front_login_find_id() {
        return new ModelAndView("login_find_id");
    }

    @RequestMapping(value = "/login_find_id_result")
    public ModelAndView front_login_find_id_result() {
        return new ModelAndView("login_find_id_result");
    }

    @RequestMapping(value = "/login_find_pw")
    public ModelAndView front_login_find_pw() {
        return new ModelAndView("login_find_pw");
    }

    @RequestMapping(value = "/login_find_pw_result")
    public ModelAndView front_login_find_pw_result() {
        return new ModelAndView("login_find_pw_result");
    }



    // Approval
    @RequestMapping(value = "/approval_received_list")
    public ModelAndView front_approval_received_list() {
        return new ModelAndView("approval_received_list");
    }

    @RequestMapping(value = "/approval_received_detail")
    public ModelAndView front_approval_received_detail() {
        return new ModelAndView("approval_received_detail");
    }

    @RequestMapping(value = "/approval_send_list")
    public ModelAndView front_approval_send_list() {
        return new ModelAndView("approval_send_list");
    }

    @RequestMapping(value = "/approval_send_detail")
    public ModelAndView front_approval_send_detail() {
        return new ModelAndView("approval_send_detail");
    }

    @RequestMapping(value = "/approval_writing_list")
    public ModelAndView front_approval_writing_list() {
        return new ModelAndView("approval_writing_list");
    }

    @RequestMapping(value = "/approval_writing_select_form")
    public ModelAndView front_approval_writing_select_form() {
        return new ModelAndView("approval_writing_select_form");
    }

    @RequestMapping(value = "/approval_writing_write")
    public ModelAndView front_approval_writing_write() {
        return new ModelAndView("approval_writing_write");
    }



    // rent
    @RequestMapping(value = "/rent_list")
    public ModelAndView front_rent_list() {
        return new ModelAndView("rent_list");
    }

    @RequestMapping(value = "/rent_detail")
    public ModelAndView front_rent_detail() {
        return new ModelAndView("rent_detail");
    }

    @RequestMapping(value = "/rent_mylist")
    public ModelAndView front_rent_mylist() {
        return new ModelAndView("rent_mylist");
    }

    @RequestMapping(value = "/rent_mylist_detail")
    public ModelAndView front_rent_mylist_detail() {
        return new ModelAndView("rent_mylist_detail");
    }
}
