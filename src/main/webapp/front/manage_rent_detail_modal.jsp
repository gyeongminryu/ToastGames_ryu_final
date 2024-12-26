<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/module_modal.css" />

<!-- 대여하기 -->
<div class="tst_modal tst_modal_alert tst_modal_rent">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">공용 물품 대여하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_rent')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <h3>{물품명}</h3>
                    <p>(대여자: {직원명 (부서/직급)})</p>
                </li>
                <li>
                    <p>위 물품을 대여하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <!-- 대여 처리 경로를 입력하세요 --><button onclick="location.href='/'" class="btn_primary btn_full">대여하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_rent')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_rent')"></div>
</div>
<!-- //대여하기 -->

<!-- 반납 처리하기 -->
<div class="tst_modal tst_modal_alert tst_modal_return">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">공용 물품 반납 처리하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_return')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <h3>{물품명}</h3>
                    <p>(대여자: {직원명 (부서/직급)})</p>
                </li>
                <li>
                    <p>위 물품을 반납 처리하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <!-- 반납 처리 경로를 입력하세요 --><button onclick="location.href='/'" class="btn_primary btn_full">반납 처리하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_return')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_return')"></div>
</div>
<!-- //반납 처리하기 -->

<script src="resources/js/module_modal.js"></script>