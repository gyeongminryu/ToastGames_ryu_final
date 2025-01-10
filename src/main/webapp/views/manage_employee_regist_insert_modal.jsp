<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 열 삭제하기 -->
<div class="tst_modal tst_modal_alert tst_modal_delete">

    <!-- 삭제할 열의 식별 정보가 아래 입력창 값으로 저장됩니다. -->
    <input type="hidden" name="tst_modal_param" id="tst_modal_param" value=""/>

    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">열 삭제하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_delete')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li class = "delete_empl_info">
                    <h3></h3>
                </li>
                <li>
                    <p>위 직원 정보를 삭제하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <button onclick="manage_empl_row_delete()" class="btn_primary btn_full">열 삭제하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_delete')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_delete')"></div>
</div>
<!-- //파일 삭제하기 -->

<!-- 직원 정보 일괄 등록하기 -->
<div class="tst_modal tst_modal_alert tst_modal_insert">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">직원 정보 일괄 등록하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_insert')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <p>총 <span id="cnt" class="cnt">00</span>건의 직원 정보를 등록하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <button onclick="<!-- 직원 정보를 일괄 등록하는 함수를 입력하세요 -->" class="btn_primary btn_full">일괄 등록하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_insert')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_insert')"></div>
</div>
<!-- //직원 정보 일괄 등록하기 -->

<script src="resources/js/module_modal.js"></script>
<script src="resources/js/manage_employee_regist_insert.js"></script>
