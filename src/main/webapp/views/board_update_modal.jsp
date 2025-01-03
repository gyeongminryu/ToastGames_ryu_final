<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 수정하기 -->
<div class="tst_modal tst_modal_alert tst_modal_update">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">게시글 수정하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_update')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <h3>${board_title}</h3>
                </li>
                <li>
                    <p>게시글을 수정하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <!-- 등록 경로를 입력하세요 --><button onclick="submitForm()" class="btn_primary btn_full">게시글 수정하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_update')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_update')"></div>
</div>
<!-- //수정하기 -->

<script src="resources/js/module_modal.js"></script>
<script src="resources/js/board_write_modal.js"></script>