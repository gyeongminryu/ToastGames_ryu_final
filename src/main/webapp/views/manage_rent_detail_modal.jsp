<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 대여하기 -->
<div class="tst_modal tst_modal_alert tst_modal_rent">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">공용 물품 대여하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="cancelRegistration()"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <h3>${detail.dto.prod_name}</h3>
                    <p>${detail.empl.empl_name}(${detail.empl.dept_name}/${detail.empl.position_name})</p>
                </li>
                <li>
                    <p>위 물품을 대여 승인 하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <!-- 대여 처리 경로를 입력하세요 --><button onclick="confirmRegistration()" class="btn_primary btn_full" id="permit_product">대여 승인하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="cancelRegistration()" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="cancelRegistration()"></div>
</div>
<!-- //대여하기 -->

<!-- 반납 처리하기 -->
<div class="tst_modal tst_modal_alert tst_modal_return">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">공용 물품 반납 처리하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="cancelReturn()"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <h3>${detail.dto.prod_name}</h3>
                    <p>${detail.empl.empl_name}(${detail.empl.dept_name}/${detail.empl.position_name})</p>
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
                    <!-- 반납 처리 경로를 입력하세요 --><button onclick="confirmReturn()" class="btn_primary btn_full" id="permit_return">반납 처리하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="cancelReturn()" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="cancelReturn()"></div>
</div>
<!-- //반납 처리하기 -->

<script src="resources/js/manage_rent_detail_modal.js"></script>