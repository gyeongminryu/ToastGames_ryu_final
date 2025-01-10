<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 파일 삭제하기 -->
<div class="tst_modal tst_modal_wide tst_modal_review">

    <!-- 삭제할 파일의 idx가 아래 입력창 값으로 저장됩니다. -->
    <input type="hidden" name="tst_modal_param" id="tst_modal_param" value="" />

    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">리뷰</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_review')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="list_no_desc list_tab">
                <li class="list_tab_item list_tab_item_active">
                    구글 플레이
                </li>
                <li class="list_tab_item" onclick="">
                    앱스토어
                </li>
            </ul>

            <ul class="tst_list list_no_desc list_block"></ul>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_review')"></div>
</div>
<!-- //파일 삭제하기 -->

<script src="resources/js/module_modal.js"></script>