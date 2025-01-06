<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 결재선 선택하기 -->
<div class="tst_modal tst_modal_input tst_modal_select">
    <div class="tst_modal_container">
        <form action="manage_form_set_line.do" method="post">

            <!-- 결재선 순서 -->
            <input type="hidden" name="tst_modal_param" id="tst_modal_param" value="" />

            <!-- 문서 양식 idx -->
            <input type="hidden" name="form_idx_modal" value="" />

            <!-- 직책 idx -->
            <input type="hidden" name="duty_idx_modal" value="" />

            <div class="tst_modal_header">
                <h1 class="tst_modal_title">결재선 설정하기</h1>
                <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_select')"></i>
            </div>
            <div class="tst_modal_body">
                <ul class="tst_list list_no_desc list_block">
                    <li>
                        <label class="form_label">부서 선택</label>
                        <div>
                            <select name="select_dept" onchange="callDeptToModalTeam(this.value)"></select>
                        </div>
                    </li>
                    <li>
                        <label class="form_label">팀 선택</label>
                        <div>
                            <select name="select_team" onchange="saveValues()">
                                <option value="0">--부서를 선택하세요--</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <p class="tst_modal_select_msg"></p>
                    </li>
                </ul>
            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <button type="submit" class="btn_primary btn_full">결재선 설정하기</button>
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

<!-- 등록하기 -->
<div class="tst_modal tst_modal_alert tst_modal_register">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">문서 양식 등록하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_register')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <h3 class="modal_form_name"></h3>
                </li>
                <li>
                    <p>위 문서 양식을 등록하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <button name="form_wip_register" class="btn_primary btn_full">양식 등록하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_register')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_register')"></div>
</div>
<!-- //등록하기 -->

<!-- 삭제하기 -->
<div class="tst_modal tst_modal_alert tst_modal_cancel">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">작성 취소하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_cancel')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <p>작성중인 문서 양식을 삭제하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <button name="form_wip_delete" class="btn_primary btn_full">삭제하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_cancel')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_cancel')"></div>
</div>
<!-- //삭제하기 -->

<!-- <script src="resources/js/module_modal.js"></script> -->