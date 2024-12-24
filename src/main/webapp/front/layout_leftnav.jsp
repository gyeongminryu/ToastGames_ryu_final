<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="tst_container_left">
    <div class="tst_contents tst_leftnav">
        <div class="tst_contents_inner">
            <div class="tst_flex">
                <div class="tst_col4 leftnav_profile_left">
                    <img src="https://images3.theispot.com/1024x1024/a4140a1012.jpg?v=210305105300" alt="{직원명}의 프로필 사진" class="leftnav_profile_image" />
                </div>
                <div class="tst_col8 leftnav_profile_right">
                    <h3 id="empl_name" class="empl_name">{직원명}</h3>
                    <h4 class="font_subtle">(<span id="dept_name" class="dept_name">{부서}</span>/<span id="position_name" class="position_name">{직급}</span>)</h4>
                </div>
            </div>
            <hr class="separator" />

            <div class="tst_flex leftnav_attendance">
                <div class="tst_col12">
                    <button onclick="location.href='/'" class="btn_primary btn_full">출근하기</button>
                </div>
            </div>
            <hr class="separator" />

<%--            <ul class="list_no_desc list_block disp_hide">--%>
<%--                <li class="tst_pointer">--%>
<%--                    <i class="bi bi-search"></i><h3>빠른 검색</h3>--%>
<%--                </li>--%>
<%--                <li class="tst_pointer">--%>
<%--                    <i class="bi bi-bell-fill"></i><h3>알림</h3>--%>
<%--                </li>--%>
<%--            </ul>--%>
<%--            <hr class="separator" />--%>

            <ul class="list_no_desc list_block">
<%--                <li class="tst_pointer disp_hide">--%>
<%--                    <i class="bi bi-menu-button-wide-fill"></i><h3>대시보드</h3>--%>
<%--                </li>--%>
                <li class="tst_pointer">
                    <i class="bi bi-file-earmark-fill"></i><h3>전자결재 (워크플로우)</h3>
                </li>
                <li class="tst_pointer">
                    <i class="bi bi-person-video3"></i><h3>회의실 대여</h3>
                </li>
                <li class="tst_pointer">
                    <i class="bi bi-pc-display"></i><h3>공용 물품 대여</h3>
                </li>
                <li class="tst_pointer">
                    <i class="bi bi-archive-fill"></i><h3>문서함</h3>
                </li>
                <li class="tst_pointer">
                    <i class="bi bi-layout-text-window-reverse"></i><h3>전자 게시판</h3>
                </li>
<%--                <li class="tst_pointer disp_hide">--%>
<%--                    <i class="bi bi-megaphone-fill"></i><h3>공지사항</h3>--%>
<%--                </li>--%>
<%--                <li class="tst_pointer disp_hide">--%>
<%--                    <i class="bi bi-send-fill"></i><h3>메시지</h3>--%>
<%--                </li>--%>
                <li class="tst_pointer">
                    <i class="bi bi-building-fill"></i><h3>회사 정보 관리</h3>
                </li>
                <li class="tst_pointer">
                    <i class="bi bi-diagram-3-fill"></i><h3>조직 관리</h3>
                </li>
                <li class="tst_pointer">
                    <i class="bi bi-person-lines-fill"></i><h3>인사 관리</h3>
                </li>
                <li class="tst_pointer">
                    <i class="bi bi-clipboard2"></i><h3>회의실 관리</h3>
                </li>
                <li class="tst_pointer">
                    <i class="bi bi-pencil-square"></i><h3>공용 물품 관리</h3>
                </li>
                <li class="tst_pointer">
                    <i class="bi bi-people-fill"></i><h3>구성원 관리</h3>
                </li>
                <li class="tst_pointer disp_hide">
                    <i class="bi bi-stopwatch-fill"></i><h3>근태 관리</h3>
                </li>
<%--                <li class="tst_pointer disp_hide">--%>
<%--                    <i class="bi bi-luggage-fill"></i><h3>연차 관리</h3>--%>
<%--                </li>--%>
                <li class="tst_pointer">
                    <i class="bi bi-stickies-fill"></i><h3>증명서 신청</h3>
                </li>
                <li class="tst_pointer">
                    <i class="bi bi-person-fill-gear"></i><h3>내 정보 관리</h3>
                </li>
                <li class="tst_pointer">
                    <i class="bi bi-building-fill-gear"></i><h3>데이터 설정</h3>
                </li>
            </ul>
        </div>
    </div>
</div>