<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/module_modal.css" />

<!-- 조직 추가하기 -->
<div id="meeting_event_modal" class="tst_modal tst_modal_input tst_modal_write">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">조직 추가하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_write')"></i>
        </div>
        <form>
            <div class="tst_modal_body">
                <ul class="list_no_desc list_block">
                    <li>
                        <label class="form_label">조직명</label>
                        <input type="text" name="" maxlength="100" placeholder="조직명을 입력하세요" />
                    </li>
                    <li>
                        <label class="form_label">직무</label>
                        <textarea rows="5" name="" maxlength="1000" placeholder="담당 직무를 입력하세요"></textarea>
                    </li>
                    <li>
                        <p class="min font_subtle">상위 조직</p>
                        <div>
                            <select name="">
                                <option value="{조직 idx}">{조직명}</option>
                                <option value="{조직 idx}">{조직명}</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <label class="form_label">위치</label>
                        <input type="text" name="" maxlength="1000" placeholder="위치를 입력하세요" />
                    </li>
                </ul>
            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <input type="submit" value="등록하기" class="btn_primary btn_full" />
                    </div>
                    <div class="tst_col6">
                        <button type="button" onclick="tst_modal_close('tst_modal_write')" class="btn_secondary btn_full">취소하기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_write')"></div>
</div>
<!-- //조직 추가하기 -->

<script src="resources/js/module_modal.js"></script>