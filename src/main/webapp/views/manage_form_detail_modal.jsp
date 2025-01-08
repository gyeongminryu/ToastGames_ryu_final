<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 삭제하기 -->
<div class="tst_modal tst_modal_alert tst_modal_disuse">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">작성 취소하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_disuse')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <h3 class="info_subject"></h3>
                </li>
                <li>
                    <p>위 문서를 삭제하시겠습니까? 삭제한 문서는 '사용하지 않는 문서 양식'에서 확인 및 복구할 수 있습니다.</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <button onclick="disuseForm()" class="btn_primary btn_full">삭제하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_disuse')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_disuse')"></div>
</div>
<!-- //삭제하기 -->

<!-- 복구하기 -->
<div class="tst_modal tst_modal_alert tst_modal_restore">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">작성 취소하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_restore')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <h3 class="info_subject"></h3>
                </li>
                <li>
                    <p>위 문서를 다시 사용하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <button onclick="restoreForm()" class="btn_primary btn_full">사용하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_restore')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_restore')"></div>
</div>
<!-- //복구하기 -->

<script src="resources/js/module_modal.js"></script>