<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/module_modal.css" />

<div id="meeting_event_modal" class="tst_modal tst_modal_input tst_modal_write">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">일정 추가하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_write')"></i>
        </div>
        <form>
            <div class="tst_modal_body">
                <ul class="list_no_desc list_block">
                    <li>
                        <p class="min font_subtle">회의실</p>
                        <h3>{회의실}</h3>
                    </li>
                    <li>
                        <label class="form_label">회의 주제</label>
                        <input type="text" name="meet_subject" maxlength="1000" placeholder="회의 주제를 입력하세요" />
                    </li>
                    <li>
                        <label class="form_label">회의 일자</label>
                        <input type="date" name="meet_date" />
                    </li>
                    <li>
                        <label class="form_label">회의 시간</label>
                        <div class="tst_flex">
                            <div class="tst_col6"><input type="time" name="meet_start_date" /></div>
                            <div class="tst_col6"><input type="time" name="meet_end_date" /></div>
                        </div>
                    </li>
                    <li>
                        <label class="form_label">회의 내용</label>
                        <textarea rows="5" name="meet_content" maxlength="1000" placeholder="회의 내용을 입력하세요"></textarea>
                    </li>
                </ul>
            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <input type="submit" value="예약하기" class="btn_primary btn_full" />
                    </div>
                    <div class="tst_col6">
                        <button type="button" class="btn_secondary btn_full" onclick="tst_modal_close('tst_modal_write')">취소하기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_write')"></div>
</div>

<script src="resources/js/module_modal.js"></script>