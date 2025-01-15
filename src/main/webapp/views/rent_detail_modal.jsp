<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/module_modal.css" />
<div class="tst_modal tst_modal_input tst_modal_detail">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">물품 대여 신청하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_detail')"></i>
        </div>
        <form action="/rentRequest.do" method="post" onsubmit="return validateForm(event);">
            <div class="tst_modal_body">
                <ul class="list_no_desc list_block">
                    <li>
                        <p class="min font_subtle">신청할 물품</p>
                        <h3>${detail.prod_name}</h3>
                        <input type="hidden" name="prod_idx" value="${detail.prod_idx}" />
                    </li>
                    <li>
                        <label class="form_label">반납 예정일</label>
                        <input type="date" name="prod_exp_date" id="prod_exp_date"/>
                    </li>
                    <li>
                        <label class="form_label">대여 사유</label>
                        <textarea rows="5" maxlength="1000" name="prod_rent_reason" id="prod_rent_reason"></textarea>
                    </li>
                </ul>
            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <input type="submit" value="신청하기" class="btn_primary btn_full" />
                    </div>
                    <div class="tst_col6">
                        <button type="button" class="btn_secondary btn_full" onclick="tst_modal_close('tst_modal_detail')">취소하기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_detail')"></div>
</div>
<script src="resources/js/rent_detail_module_modal.js"></script>