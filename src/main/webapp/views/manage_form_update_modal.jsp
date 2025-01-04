<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 결재선 선택하기 -->
<div class="tst_modal tst_modal_input tst_modal_select">
        <div class="tst_modal_container">
            <form>
                <div class="tst_modal_header">
                    <h1 class="tst_modal_title">결재선 설정하기</h1>
                    <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_select')"></i>
                </div>
                <div class="tst_modal_body">
                    <ul class="tst_list list_no_desc list_block">
                        <li>
                            <label class="form_label">부서 선택</label>
                            <div>
                                <select name="" onchange="">
                                    <option value="{부서 번호}">{부서명}</option>
                                    <option value="{부서 번호}">{부서명}</option>
                                </select>
                            </div>
                        </li>
                        <li>
                            <label class="form_label">팀 선택</label>
                            <div>
                                <select name="" onchange="">
                                    <option value="{부서 번호}">{부서명}</option>
                                    <option value="{부서 번호}">{부서명}</option>
                                </select>
                            </div>
                        </li>
                        <li>
                            <p>{부서명}/{팀명}의 부서장|팀장을 결재선으로 설정하시겠습니까?</p>
                        </li>
                    </ul>
                </div>
                <div class="tst_modal_footer">
                    <div class="tst_flex">
                        <div class="tst_col6">
                            <button type="button" onclick="location.href='/manage_form_setline'" class="btn_primary btn_full">결재선 설정하기</button>
                        </div>
                        <div class="tst_col6">
                            <button type="button" onclick="tst_modal_close('tst_modal_select')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_select')"></div>
</div>
<!-- //결재선 선택하기 -->

<!-- 취소하기 -->
<div class="tst_modal tst_modal_alert tst_modal_cancel">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">작성 취소하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_cancel')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <p>작성중인 문서를 삭제하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <!-- 삭제 경로를 입력하세요 --><button onclick="location.href='/manage_form_delete?form_idx='" class="btn_primary btn_full">삭제하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_cancel')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_cancel')"></div>
</div>
<!-- //취소하기 -->

<script src="resources/js/module_modal.js"></script>