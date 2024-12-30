<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 알림 목록 -->
<div class="tst_modal tst_modal_input tst_offcanvas_alert_list">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">알림</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_close_alertlist()"></i>
        </div>
        <div class="tst_modal_body">
            <p onclick="<!-- 모든 알림을 삭제하는 함수를 입력하세요 -->" class="font_caution tst_pointer">모든 알림 삭제하기</p>
            <ul class="tst_list list_no_desc list_block">

                <!-- 회의 일정 안내 -->
                <li>
                    <div class="alert_item">
                        <div class="alert_item_header tst_flex">
                            <div class="tst_col6">
                                <p><i class="bi bi-person-video3 margin_right"></i>회의 일정 안내</p>
                            </div>
                            <div class="tst_col6 align_right">
                                <p class="min font_subtle">
                                    <span>{발송일시|yyyy-MM-dd HH:mm}</span>
                                    <span><i onclick="<!-- 해당 알림을 삭제하는 함수를 입력하세요 -->" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span>
                                </p>
                            </div>
                        </div>
                        <div onclick="location.href='<!-- 해당 회의 일정으로 이동하는 링크를 입력하세요 -->'" class="alert_item_body tst_pointer">
                            <h3>{회의 제목}</h3>
                            <p class="font_subtle">{회의 시작 일시|yyyy-MM-dd HH:mm}/{회의 장소}</p>
                        </div>
                    </div>
                </li>
                <!-- //회의 일정 안내 -->

                <!-- 전체 공지사항 -->
                <li>
                    <div class="alert_item">
                        <div class="alert_item_header tst_flex">
                            <div class="tst_col6">
                                <p><i class="bi bi-megaphone-fill margin_right"></i>전체 공지사항</p>
                            </div>
                            <div class="tst_col6 align_right">
                                <p class="min font_subtle">
                                    <span>{발송일시|yyyy-MM-dd HH:mm}</span>
                                    <span><i onclick="<!-- 해당 알림을 삭제하는 함수를 입력하세요 -->" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span>
                                </p>
                            </div>
                        </div>
                        <div onclick="location.href='<!-- 해당 공지사항으로 이동하는 링크를 입력하세요 -->'" class="alert_item_body tst_pointer">
                            <h3>{공지사항 제목}</h3>
                            <p class="single_line_paragraph">{공지사항 내용} 한 줄이 넘어가면 자동으로 잘립니다.</p><!-- html태그 그대로 입력하지 마시고 되도록 plain text로 변환하여 입력해 주세요 -->
                        </div>
                    </div>
                </li>
                <!-- //전체 공지사항 -->

                <!-- 부서별 공지사항 -->
                <li>
                    <div class="alert_item">
                        <div class="alert_item_header tst_flex">
                            <div class="tst_col6">
                                <p><i class="bi bi-megaphone margin_right"></i>{부서명} 공지사항</p>
                            </div>
                            <div class="tst_col6 align_right">
                                <p class="min font_subtle">
                                    <span>{발송일시|yyyy-MM-dd HH:mm}</span>
                                    <span><i onclick="<!-- 해당 알림을 삭제하는 함수를 입력하세요 -->" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span>
                                </p>
                            </div>
                        </div>
                        <div onclick="location.href='<!-- 해당 공지사항으로 이동하는 링크를 입력하세요 -->'" class="alert_item_body tst_pointer">
                            <h3>{공지사항 제목}</h3>
                            <p class="single_line_paragraph">{공지사항 내용} 한 줄이 넘어가면 자동으로 잘립니다.</p><!-- html태그 그대로 입력하지 마시고 되도록 plain text로 변환하여 입력해 주세요 -->
                        </div>
                    </div>
                </li>
                <!-- //부서별 공지사항 -->

                <!-- 팀별 공지사항 -->
                <li>
                    <div class="alert_item">
                        <div class="alert_item_header tst_flex">
                            <div class="tst_col6">
                                <p><i class="bi bi-megaphone margin_right"></i>{팀명} 공지사항</p>
                            </div>
                            <div class="tst_col6 align_right">
                                <p class="min font_subtle">
                                    <span>{발송일시|yyyy-MM-dd HH:mm}</span>
                                    <span><i onclick="<!-- 해당 알림을 삭제하는 함수를 입력하세요 -->" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span>
                                </p>
                            </div>
                        </div>
                        <div onclick="location.href='<!-- 해당 공지사항으로 이동하는 링크를 입력하세요 -->'" class="alert_item_body tst_pointer">
                            <h3>{공지사항 제목}</h3>
                            <p class="single_line_paragraph">{공지사항 내용} 한 줄이 넘어가면 자동으로 잘립니다.</p><!-- html태그 그대로 입력하지 마시고 되도록 plain text로 변환하여 입력해 주세요 -->
                        </div>
                    </div>
                </li>
                <!-- //팀별 공지사항 -->

                <!-- 결재 승인 -->
                <li>
                    <div class="alert_item">
                        <div class="alert_item_header tst_flex">
                            <div class="tst_col6">
                                <p><i class="bi bi-file-earmark-check margin_right"></i>결재 승인 안내</p>
                            </div>
                            <div class="tst_col6 align_right">
                                <p class="min font_subtle">
                                    <span>{발송일시|yyyy-MM-dd HH:mm}</span>
                                    <span><i onclick="<!-- 해당 알림을 삭제하는 함수를 입력하세요 -->" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span>
                                </p>
                            </div>
                        </div>
                        <div onclick="location.href='<!-- 해당 워크플로우로 이동하는 링크를 입력하세요 -->'" class="alert_item_body tst_pointer">
                            <p>문서 <b>{문서 제목}</b> 이/가 결재되었습니다. (결재자: {결재한 직원명})</p>
                        </div>
                    </div>
                </li>
                <!-- //결재 승인 -->

                <!-- 결재 반려 -->
                <li>
                    <div class="alert_item">
                        <div class="alert_item_header tst_flex">
                            <div class="tst_col6">
                                <p class="font_caution"><i class="bi bi-file-earmark-break margin_right"></i>결재 반려 안내</p>
                            </div>
                            <div class="tst_col6 align_right">
                                <p class="min font_subtle">
                                    <span>{발송일시|yyyy-MM-dd HH:mm}</span>
                                    <span><i onclick="<!-- 해당 알림을 삭제하는 함수를 입력하세요 -->" class="bi bi-dash-circle-dotted margin_left tst_pointer"></i></span>
                                </p>
                            </div>
                        </div>
                        <div onclick="location.href='<!-- 해당 워크플로우로 이동하는 링크를 입력하세요 -->'" class="alert_item_body tst_pointer">
                            <p>문서 <b>{문서 제목}</b> 이/가 결재 반려되었습니다. (결재자: {결재한 직원명})</p>
                        </div>
                    </div>
                </li>
                <!-- //결재 반려 -->
            </ul>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_close_alertlist()"></div>
</div>
<!-- //알림 목록 -->