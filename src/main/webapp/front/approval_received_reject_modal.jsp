<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="tst_modal tst_modal_input tst_modal_reject">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">결재 반려 사유 입력하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_reject')"></i>
        </div>
        <form>
            <div class="tst_modal_body">
                <ul class="list_no_desc list_block">
                    <li>
                        <p class="min font_subtle">반려할 문서</p>
                        <h3>{반려할 문서명}</h3>
                    </li>
                    <li>
                        <label class="form_label">반려 사유</label>
                        <textarea rows="5" maxlength="1000"></textarea>
                    </li>
                </ul>
            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <!-- 실제 작업시에는 아래 코드에서 주석을 제외하고 입력하세요 -->
                        <!-- <input type="submit" value="반려하기" class="btn_primary btn_full" /> -->

                        <!-- 실제 작업시에는 아래 코드를 삭제하세요 -->
                        <input type="button" onclick="location.href='/approval_received_list'" value="반려하기" class="btn_primary btn_full" />
                    </div>
                    <div class="tst_col6">
                        <button type="button" class="btn_secondary btn_full" onclick="tst_modal_close('tst_modal_reject')">취소하기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_reject')"></div>
</div>
<script src="resources/js/module_modal.js"></script>