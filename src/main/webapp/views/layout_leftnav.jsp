<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="tst_container_left">
    <div class="tst_contents tst_leftnav">
        <div class="tst_contents_inner">
            <div class="tst_flex">
                <div class="tst_col4 leftnav_profile_left">
                    <img id="profileImage" src="" alt="{직원명}의 프로필 사진" class="leftnav_profile_image" />
                </div>
                <div class="tst_col8 leftnav_profile_right">
                    <h3 id="memberName"></h3>
                    <h4 id="memberDept" class="font_subtle"></h4>
                </div>
            </div>
            <hr class="separator" />

            <div class="tst_flex leftnav_attendance">
                <div class="tst_col12">
       				<button id="attendanceButton" onclick="toggleAttendance()" class="btn_primary btn_full">출근하기</button>
                </div>
            </div>
            <hr class="separator" />

            <ul class="list_no_desc list_block">
                <li class="tst_pointer" onclick="location.href='/approval_writing_list.go'">
                    <i class="bi bi-file-earmark-fill"></i><h3>전자결재</h3>
                </li>
                <li>
                    <ul class="list_block list_leftnav_sub">
                        <li class="tst_pointer" onclick="location.href='/approval_received_list.go'">
                            <h3 class="font_subtle">수신함</h3>
                        </li>
                        <li class="tst_pointer" onclick="location.href='/approval_send_list.go'">
                            <h3 class="font_subtle">발신함</h3>
                        </li>
                        <li class="tst_pointer" onclick="location.href='/approval_writing_list.go'">
                            <h3 class="font_subtle">작성중인 문서</h3>
                        </li>
                        <li class="tst_pointer" onclick="location.href='/approval_form_list.go'">
                            <h3 class="font_subtle">문서 작성하기</h3>
                        </li>
                    </ul>
                </li>
                <li class="tst_pointer" onclick="location.href='/meeting.go'">
                    <i class="bi bi-person-video3"></i><h3>회의실 대여</h3>
                </li>
                <li class="tst_pointer" onclick="location.href='/rent_list.go'">
                    <i class="bi bi-pc-display"></i><h3>공용 물품 대여</h3>
                </li>
                <li class="tst_pointer" onclick="location.href='/schedule.go'">
                    <i class="bi bi-calendar-event"></i><h3>일정 관리</h3>
                </li>
                <li class="tst_pointer" onclick="location.href='/document_list.go'">
                    <i class="bi bi-archive-fill"></i><h3>문서함</h3>
                </li>
                <li class="tst_pointer" onclick="location.href='/board_list.go'">
                    <i class="bi bi-layout-text-window-reverse"></i><h3>전자 게시판</h3>
                </li>
                <li class="tst_pointer" onclick="location.href='/stats_dashboard.go'">
                    <i class="bi bi-bar-chart-line-fill"></i><h3>게임 통계</h3>
                </li>
                <li class="tst_pointer" onclick="location.href='/companyinfo_detail.go'">
                    <i class="bi bi-building-fill"></i><h3>회사 정보 관리</h3>
                </li>
                <li class="tst_pointer" onclick="location.href='/organization_list.go'">
                    <i class="bi bi-diagram-3-fill"></i><h3>조직 관리</h3>
                </li>
                <li class="tst_pointer" onclick="location.href='/manage_employee_list.go'">
                    <i class="bi bi-person-lines-fill"></i><h3>인사 관리</h3>
                </li>
                <li class="tst_pointer" onclick="location.href='/manage_form_list.go'">
                    <i class="bi bi-file-earmark-text"></i><h3>문서 양식 관리</h3>
                </li>
                <li class="tst_pointer" onclick="location.href='/manage_rent_list.go'">
                    <i class="bi bi-pencil-square"></i><h3>공용 물품 관리</h3>
                </li>
                <li class="tst_pointer" onclick="location.href='/staff_list.go'">
                    <i class="bi bi-people-fill"></i><h3>구성원 관리</h3>
                </li>
                <li class="tst_pointer" onclick="location.href='/work_record.go'">
                    <i class="bi bi-stopwatch-fill"></i><h3>근태 관리</h3>
                </li>
                <li class="tst_pointer" onclick="location.href='/mypage.go'">
                    <i class="bi bi-person-fill-gear"></i><h3>내 정보 관리</h3>
                </li>
            </ul>
        </div>
    </div>
</div>
<script src="resources/js/layout_leftnav.js"></script>
<script src="resources/js/work_record.js"></script>