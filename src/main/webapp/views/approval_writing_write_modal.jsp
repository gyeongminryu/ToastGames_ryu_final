<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/module_modal.css" />
<link rel="stylesheet" type="text/css" href="resources/css/approval_send_modal.css" />
<!-- 결재선 선택하기 -->
<div class="tst_modal tst_modal_wide tst_modal_select">
    <%--결재선 step 받아오는 것--%>
    <input type="hidden" name="tst_modal_param" id="tst_modal_param" value="" />

    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">결재선 선택하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_select')"></i>
        </div>
        <div class="tst_modal_body">
            <div class="tst_flex">
                <div class="tst_col5">
                    <table class="tst_table table_align_left">
                        <colgroup>
                            <col style="width: 23px;" />
                            <col style="width: auto;" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th colspan="2">부서 선택</th>
                        </tr>
                        </thead>

                        <!-- 부서 목록 출력 -->
                        <tbody class="tst_pointer" id = "all_dept_wrapper">

                        </tbody>
                        <!-- //부서 목록 출력 -->

                    </table>
                </div>
                <div class="tst_col7">

                    <!-- 검색 -->

                        <div class="tst_search_container">
                            <div class="tst_search_select">
                                <select id="tst_search_select_category" name="category">
                                    <option value="전체">검색 분류</option>
                                    <option value="부서">부서</option>
                                    <option value="이름">이름</option>
                                </select>
                            </div>
                            <div class="tst_search_input">
                                <input type="text" name="keyword" maxlength="50" placeholder="검색어를 입력하세요" id = "search"/>
                            </div>
                            <div class="tst_search_icon">
                                <button type="button" onclick="approval_filter_empl()" class="btn_icon"><i class="bi bi-search"></i></button>
                            </div>
                        </div>
                    <!-- //검색 -->

                    <table class="tst_table table_align_left">
                        <colgroup>
                            <col style="width: 40px;" />
                            <col style="width: auto;" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th colspan="2">직원 선택</th>
                        </tr>
                        </thead>
                        <tbody class="tst_pointer" id = "empl_wrapper">

                        <!-- 직원 정보 -->
                        <tr onclick="{함수}">
                            <td class="td_align_top td_no_padding">
                                <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                            </td>
                            <td>
                                <p>{직원명 (부서/직급)}</p>
                                <p class="min font_subtle">{직책}</p>
                            </td>
                        </tr>
                        <!-- //직원 정보 -->


                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="tst_modal_footer">
            <button onclick="approval_send_line()" class="btn_primary">결재선 등록하기</button>
            <button onclick="approval_line_none()" class="btn_secondary">결재선 비워두기</button>
            <button onclick="tst_modal_close('tst_modal_select')" class="btn_subtle">이전 화면으로 돌아가기</button>
        </div>
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
                    <button onclick="approval_write_delete()" class="btn_primary btn_full">삭제하기</button>
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
<script src="/resources/js/approval_write_line_child.js"></script>
<script src="/resources/js/approval_write_line_parent.js"></script>
<script src="/resources/js/approval_search.js"></script>
