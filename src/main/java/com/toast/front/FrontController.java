package com.toast.front;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class FrontController {
    Logger logger = LoggerFactory.getLogger(getClass());

    // Login =========================================================

    // 로그인 폼
    @RequestMapping(value = "/")
    public ModelAndView front_login() {
        return new ModelAndView("login");
    }

    // 아이디 찾기 폼
    @RequestMapping(value = "/login_find_id")
    public ModelAndView front_login_find_id() {
        return new ModelAndView("login_find_id");
    }

    // 아이디 찾기 결과
    @RequestMapping(value = "/login_find_id_result")
    public ModelAndView front_login_find_id_result() {
        return new ModelAndView("login_find_id_result");
    }

    // 비밀번호 찾기 폼
    @RequestMapping(value = "/login_find_pw")
    public ModelAndView front_login_find_pw() {
        return new ModelAndView("login_find_pw");
    }

    // 비밀번호 찾기 결과
    @RequestMapping(value = "/login_find_pw_result")
    public ModelAndView front_login_find_pw_result() {
        return new ModelAndView("login_find_pw_result");
    }



    // Approval ======================================================

    // 수신한 전자결재 목록
    @RequestMapping(value = "/approval_received_list")
    public ModelAndView front_approval_received_list() {
        return new ModelAndView("approval_received_list");
    }

    // 수신한 전자결재 상세보기
    @RequestMapping(value = "/approval_received_detail")
    public ModelAndView front_approval_received_detail() {
        return new ModelAndView("approval_received_detail");
    }

    // 상신한 전자결재 목록
    @RequestMapping(value = "/approval_sent_list")
    public ModelAndView front_approval_sent_list() {
        return new ModelAndView("approval_sent_list");
    }

    // 상신한 전자결재 상세보기
    @RequestMapping(value = "/approval_sent_detail")
    public ModelAndView front_approval_send_detail() {
        return new ModelAndView("approval_sent_detail");
    }

    // 작성 중인 전자결재 목록
    @RequestMapping(value = "/approval_writing_list")
    public ModelAndView front_approval_writing_list() {
        return new ModelAndView("approval_writing_list");
    }

    // 문서 형식 선정
    @RequestMapping(value = "/approval_writing_select_form")
    public ModelAndView front_approval_writing_select_form() {
        return new ModelAndView("approval_writing_select_form");
    }

    // 전자결재 작성
    @RequestMapping(value = "/approval_writing_write")
    public ModelAndView front_approval_writing_write() {
        return new ModelAndView("approval_writing_write");
    }



    // Reservation Meeting Room ======================================

    // 회의실 예약 현황
    @RequestMapping(value = "/meeting_room_calendar")
    public ModelAndView front_meeting_room_calendar() {
        return new ModelAndView("meeting_room_calendar");
    }



    // Rent ==========================================================

    // 공용 물품 목록 (일반 직원)
    @RequestMapping(value = "/rent_list")
    public ModelAndView front_rent_list() {
        return new ModelAndView("rent_list");
    }

    // 공용 물품 상세보기 (일반 직원)
    @RequestMapping(value = "/rent_detail")
    public ModelAndView front_rent_detail() {
        return new ModelAndView("rent_detail");
    }

    // 내가 대여한/신청한 공용 물품 목록
    @RequestMapping(value = "/rent_mylist")
    public ModelAndView front_rent_mylist() {
        return new ModelAndView("rent_mylist");
    }

    // 내가 대여한/신청한 공용 물품 상세보기
    @RequestMapping(value = "/rent_mylist_detail")
    public ModelAndView front_rent_mylist_detail() {
        return new ModelAndView("rent_mylist_detail");
    }



    // Document ======================================================
    // Board =========================================================

    // 게시글 목록
    @RequestMapping(value = "/board_list")
    public ModelAndView front_board_list() {
        return new ModelAndView("board_list");
    }

    // 게시글 상세보기
    @RequestMapping(value = "/board_detail")
    public ModelAndView front_board_detail() {
        return new ModelAndView("board_detail");
    }

    // 게시글 작성
    @RequestMapping(value = "/board_write")
    public ModelAndView front_board_write() {
        return new ModelAndView("board_write");
    }

    // 게시글 수정
    @RequestMapping(value = "/board_update")
    public ModelAndView front_board_update() {
        return new ModelAndView("board_update");
    }



    // Company Info ==================================================

    // 회사 정보
    @RequestMapping(value = "/companyinfo_detail")
    public ModelAndView front_companyinfo_detail() {
        return new ModelAndView("companyinfo_detail");
    }

    // 회사 정보 수정
    @RequestMapping(value = "/companyinfo_update")
    public ModelAndView front_companyinfo_update() {
        return new ModelAndView("companyinfo_update");
    }



    // Organization ==================================================

    // 조직 관리
    @RequestMapping(value = "/organization_list")
    public ModelAndView front_organization_list() {
        return new ModelAndView("organization_list");
    }

    // 조직 상세보기
    @RequestMapping(value = "/organization_detail")
    public ModelAndView front_organization_detail() {
        return new ModelAndView("organization_detail");
    }

    // 프로젝트 팀 관리
    @RequestMapping(value = "/project_team_list")
    public ModelAndView front_project_team_list() {
        return new ModelAndView("project_team_list");
    }

    // 프로젝트 팀 상세보기
    @RequestMapping(value = "/project_team_detail")
    public ModelAndView front_project_team_detail() {
        return new ModelAndView("project_team_detail");
    }



    // Manage > Employee =============================================

    // 인사 관리, 직원 목록
    @RequestMapping(value = "/manage_employee_list")
    public ModelAndView front_manage_employee_list() {
        return new ModelAndView("manage_employee_list");
    }

    // 인사 관리, 직원 상세보기
    @RequestMapping(value = "/manage_employee_detail")
    public ModelAndView front_manage_employee_detail() {
        return new ModelAndView("manage_employee_detail");
    }

    // 인사 관리, 직원 정보 수정
    @RequestMapping(value = "/manage_employee_update")
    public ModelAndView front_manage_employee_update() {
        return new ModelAndView("manage_employee_update");
    }



    // Manage > Rent =================================================

    // 공용 물품 목록 (관리)
    @RequestMapping(value = "/manage_rent_list")
    public ModelAndView front_manage_rent_list() {
        return new ModelAndView("manage_rent_list");
    }

    // 공용 물품 등록
    @RequestMapping(value = "/manage_rent_write")
    public ModelAndView front_manage_rent_write() {
        return new ModelAndView("manage_rent_write");
    }

    // 공용 물품 수정
    @RequestMapping(value = "/manage_rent_update")
    public ModelAndView front_manage_rent_update() {
        return new ModelAndView("manage_rent_update");
    }

    // 공용 물품 상세보기 (관리)
    @RequestMapping(value = "/manage_rent_detail")
    public ModelAndView front_manage_rent_detail() {
        return new ModelAndView("manage_rent_detail");
    }

    // 공용 물품 폐기
    @RequestMapping(value = "/manage_rent_dispose")
    public ModelAndView front_manage_rent_dispose() {
        return new ModelAndView("manage_rent_dispose");
    }

    // 공용 물품 인계
    @RequestMapping(value = "/manage_rent_transfer")
    public ModelAndView front_manage_rent_transfer() {
        return new ModelAndView("manage_rent_transfer");
    }



    // Manage > Dispose ==============================================

    // 폐기한 공용 물품 목록
    @RequestMapping(value = "/manage_dispose_list")
    public ModelAndView front_manage_rent_dispose_list() {
        return new ModelAndView("manage_dispose_list");
    }

    // 폐기한 공용 물품 상세보기
    @RequestMapping(value = "/manage_dispose_detail")
    public ModelAndView front_manage_rent_dispose_detail() {
        return new ModelAndView("manage_dispose_detail");
    }



    // My Page =======================================================

    // 내 정보 열람
    @RequestMapping(value = "/mypage")
    public ModelAndView front_mypage() {
        return new ModelAndView("mypage");
    }

    // 내 정보 수정
    @RequestMapping(value = "/mypage_update")
    public ModelAndView front_mypage_update() {
        return new ModelAndView("mypage_update");
    }
}
