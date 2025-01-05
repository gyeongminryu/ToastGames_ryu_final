<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_table.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <link rel="stylesheet" href="resources/richtexteditor/rte_theme_default.css" />
    <script type="text/javascript" src="resources/richtexteditor/rte.js"></script>
    <script type="text/javascript" src="resources/richtexteditor/plugins/all_plugins.js"></script>
    <script type='text/javascript' src="resources/richtexteditor/lang/rte-lang-ko.js"></script>
    <link rel="stylesheet" href="resources/css/module_rte.css" />
    <script type="text/javascript" src="resources/js/module_rte.js"></script>
</head>
<body>
<c:import url="layout_topnav.jsp" />
<div class="tst_container">
    <c:import url="layout_leftnav.jsp" />
    <div class="tst_container_right">
        <div class="tst_contents">
            <div class="tst_contents_inner">

                <!-- 제목 -->
                <ul class="tst_title list_no_desc list_inline">
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_form_list'">
                        <h1>문서 양식 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_form_disuse_list'">
                        <h1>사용하지 않는 문서 양식 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_form_wip_list'">
                        <h1>작성중인 문서 양식</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <form>
                    <div class="tst_flex">

                        <!-- 문서 양식 수정하기 -->
                        <div class="tst_col9">
                            <table class="tst_table table_align_left table_no_underline table_no_padding">
                                <colgroup>
                                    <col style="width: 120px;" />
                                    <col style="width: auto;" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th colspan="2">문서 양식 관리</th>
                                </tr>
                                </thead>


                                <tbody>
                                <tr>
                                    <th class="td_align_top">문서 양식명</th>
                                    <td>
                                        <input type="text" onkeyup="syncTitleToEditor(this)" name="subject" maxlength="100" placeholder="문서 제목을 입력하세요" />
                                    </td>
                                </tr>
                                <tr>
                                    <th class="td_align_top">문서 양식</th>
                                    <td>
                                        <p class="min font_subtle">1분마다 자동으로 임시 저장됩니다.</p>

                                        <!-- rte -->
                                        <div id="div_editor"></div>
                                        <div id="div_editor_copy"></div>
                                        <!-- //rte -->

                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- //문서 양식 수정하기 -->

                        <div class="tst_col3">

                            <!-- 결재선 수정 -->
                            <table class="tst_table table_align_left table_no_padding">
                                <colgroup>
                                    <col style="width: 80px;" />
                                    <col style="width: auto;" />
                                    <col style="width: 60px;" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th colspan="3">결재선</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th>1차 결재선</th>
                                    <td class="form_approval_line td_align_left">{팀}/팀장</td>
                                    <td>
                                        <button type="button" onclick="tst_modal_call('tst_modal_select')" class="btn_primary btn_min">변경하기</button>
                                    </td>
                                </tr>
                                <tr>
                                    <th>2차 결재선</th>
                                    <td class="form_approval_line td_align_left">{부서}/부서장</td>
                                    <td>
                                        <button type="button" onclick="tst_modal_call('tst_modal_select')" class="btn_primary btn_min">변경하기</button>
                                    </td>
                                </tr>
                                <tr>
                                    <th>3차 결재선</th>
                                    <td class="form_approval_line td_align_left">대표/대표이사</td>
                                    <td>
                                        <button type="button" onclick="tst_modal_call('tst_modal_select')" class="btn_primary btn_min">변경하기</button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <!-- //결재선 수정 -->

                            <ul class="tst_list list_no_desc list_block">
                                <li>
                                    <button type="button" onclick="tst_modal_call('tst_modal_send')" class="btn_primary btn_full">양식 등록하기</button>
                                </li>
                                <li>
                                    <button type="button" onclick="temporary_save()" class="btn_secondary btn_full">임시 저장하기</button>
                                </li>
                                <li>
                                    <button type="button" onclick="tst_modal_call('tst_modal_cancel')" class="btn_subtle btn_full">작성 취소하기</button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<c:import url="manage_form_update_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/manage_form_update.js"></script>
</html>