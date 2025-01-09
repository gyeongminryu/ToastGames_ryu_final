<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="tst_topnav">
    <div class="tst_wrapper tst_flex align_middle">
        <div class="tst_col2 logo align_middle">
            <img src="/resources/img/logo.jpg" alt="" />
        </div>
        <ul class="tst_col8 align_center list_no_desc list_inline">
            <li onclick="location.href='/approval_writing_list.go'" class="tst_pointer">
                <i class="bi bi-file-earmark-fill"></i>
            </li>
            <li onclick="location.href='/document_list.go'" class="tst_pointer">
                <i class="bi bi-archive-fill"></i>
            </li>
            <li onclick="location.href='/schedule.go'" class="tst_pointer">
                <i class="bi bi-calendar-event"></i>
            </li>
            <li onclick="location.href='/board_list.go'" class="tst_pointer">
                <i class="bi bi-layout-text-window-reverse"></i>
            </li>
            <%--            <li>--%>
            <%--                <i class="bi bi-send-fill"></i>--%>
            <%--            </li>--%>
            <li onclick="open_alert_list()" class="tst_pointer">
                <i class="bi bi-bell-fill"></i>
            </li>
        </ul>
        <div class="tst_col2"></div>
    </div>
</div>
<c:import url="layout_topnav_modal.jsp" /><!-- 간이 프로필 열람 -->
<c:import url="layout_topnav_offcanvas.jsp" /><!-- 알림 목록 -->
<script src="resources/js/notify_list_show.js"></script>