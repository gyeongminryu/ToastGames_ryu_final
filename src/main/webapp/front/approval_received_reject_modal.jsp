<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/modal.css" />
<div class="tst_modal tst_approval_reject_modal">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">결재 반려 사유 입력하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_approval_reject_modal')"></i>
        </div>
        <form>
            <div class="tst_modal_body">
                <ul class="list_no_desc list_block">
                    <li>
                        <p class="min font_subtle">반려할 문서</p>
                        <h3>{반려할 문서명}</h3>
                    </li>
                    <li>
                        <p class="min font_subtle">반려 사유</p>
                        <textarea rows="5" maxlength="1000"></textarea>
                    </li>
                </ul>
            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <input type="submit" value="반려하기" class="btn_primary btn_full" />
                    </div>
                    <div class="tst_col6">
                        <button type="button" class="btn_secondary btn_full" onclick="tst_modal_close('tst_approval_reject_modal')">취소하기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_approval_reject_modal')"></div>
</div>
<script src="resources/js/module_modal.js"></script>