<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/modal.css" />
<link rel="stylesheet" type="text/css" href="resources/css/approval_send_modal.css" />

<!-- 상신하기 > 서명하기/직인찍기 -->
<div class="tst_modal tst_modal_input tst_approval_send_modal">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">서명/직인</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_approval_send_modal')"></i>
        </div>
        <form>
            <div class="tst_modal_body">

                <!-- 서명/직인 선택 -->
                <ul class="tst_tablist list_no_desc list_inline">
                    <li class="tst_tablist_item item_sign tst_tablist_item_active" onclick="select_type('sign')">
                        <h3>서명</h3>
                    </li>
                    <li class="tst_tablist_item item_stamp" onclick="select_type('stamp')">
                        <h3>직인</h3>
                    </li>
                </ul>
                <!-- //서명/직인 선택 -->

                <!-- 서명란 -->
                <div class="sign_area"></div>
                <!-- //서명란 -->

                <!-- 직인란 -->
                <div class="stamp_area tst_flex align_center disp_hide">
                    <p class="min font_subtle">직인 변경은 인사과에 문의하세요.</p>

                    <!-- 직인 이미지 -->
                    <i class="bi bi-c-circle" style="color: var(--tst-color-warning); font-size: 48px;"></i>
                    <!-- //직인 이미지 -->
                </div>
                <!-- //직인란 -->

            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <!-- 상신 경로를 입력하세요 --><button type="submit" onclick="location.href='/'" class="btn_primary btn_full">상신하기</button>
                    </div>
                    <div class="tst_col6">
                        <button type="button" class="btn_secondary btn_full" onclick="tst_modal_close('tst_approval_send_modal')">취소하기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_approval_reject_modal')"></div>
</div>
<!-- //상신하기 > 서명하기/직인찍기 -->

<!-- 취소하기 -->
<div class="tst_modal tst_modal_alert tst_approval_cancel_modal">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">작성 취소하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_approval_cancel_modal')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <p>작성중인 문서를 삭제하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <!-- 삭제 경로를 입력하세요 --><button onclick="location.href='/'" class="btn_primary btn_full">삭제하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_approval_cancel_modal')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_approval_cancel_modal')"></div>
</div>
<!-- // -->
<script src="resources/js/module_modal.js"></script>
<script src="resources/js/approval_send_modal.js"></script>