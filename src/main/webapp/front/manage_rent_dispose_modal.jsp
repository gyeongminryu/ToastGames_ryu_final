<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/module_modal.css" />

<!-- 폐기하기 -->
<div class="tst_modal tst_modal_alert tst_modal_dispose">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">공용 물품 폐기하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_dispose')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <h3 id="prod_name" class="prod_name">{물품명}</h3>
                </li>
                <li>
                    <p>위 물품을 폐기하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <button onclick="<!-- 폐기 처리 함수를 입력하세요 -->" class="btn_primary btn_full">물품 폐기하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_dispose')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_dispose')"></div>
</div>
<!-- //폐기하기 -->

<script src="resources/js/module_modal.js"></script>