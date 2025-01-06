<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <p class="msg min font_subtle">2분마다 자동으로 저장됩니다.</p>

                        <!-- rte -->
                        <div id="div_editor"></div>
                        <div id="div_editor_copy" class="disp_hide"></div>
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
                        <button type="button" onclick="tst_modal_call_param('tst_modal_select', '1')" class="btn_primary btn_min">변경하기</button>
                    </td>
                </tr>
                <tr>
                    <th>2차 결재선</th>
                    <td class="form_approval_line td_align_left">{부서}/부서장</td>
                    <td>
                        <button type="button" onclick="tst_modal_call_param('tst_modal_select', '2')" class="btn_primary btn_min">변경하기</button>
                    </td>
                </tr>
                <tr>
                    <th>3차 결재선</th>
                    <td class="form_approval_line td_align_left">대표/대표이사</td>
                    <td>
                        <button type="button" onclick="tst_modal_call_param('tst_modal_select', '3')" class="btn_primary btn_min">변경하기</button>
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
                    <button type="button" onclick="saveForm()" class="btn_secondary btn_full">저장하기</button>
                </li>
                <li>
                    <button type="button" onclick="location.href='/manage_form_wip_list.go'" class="btn_subtle btn_full">목록으로 돌아가기</button>
                </li>
                <li>
                    <button type="button" onclick="tst_modal_call('tst_modal_cancel')" class="btn_text btn_full">작성 취소하기</button>
                </li>
            </ul>
        </div>
    </div>
</form>