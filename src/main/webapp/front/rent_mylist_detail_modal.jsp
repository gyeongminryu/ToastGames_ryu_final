<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/module_modal.css" />

<!-- 취소하기 -->
<div class="tst_modal tst_modal_alert tst_rent_detail_cancel_modal">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">대여 신청 취소하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_rent_detail_cancel_modal')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <p>대여 신청을 취소하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <!-- 취소 경로를 입력하세요 --><button onclick="location.href='/'" class="btn_primary btn_full">신청 취소하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_rent_detail_cancel_modal')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_rent_detail_cancel_modal')"></div>
</div>
<!-- //취소하기 -->

<script src="resources/js/module_modal.js"></script>