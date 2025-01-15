<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/approval_send_modal.css" />

<!-- 일정 추가하기 -->
<div id="meeting_event_modal" class="tst_modal tst_modal_double tst_modal_write">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">회의 추가하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_write'); reset_parti();"></i>
        </div>
        <form>
            <div class="tst_modal_body">
                <div class="tst_flex">
                    <div class="tst_col7">
                        <table class="tst_table table_no_padding table_no_underline table_align_left">
                            <colgroup>
                                <col style="width: 100px;" />
                                <col style="width: auto;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">예약 정보</th>
                            </tr>
                            </thead>
                        </table>
                        <ul class="list_no_desc list_block">
                            <li>
                                <label class="form_label">회의 주제<span class="font_caution"> *</span></label>
                                <input type="text" name="meet_subject" id="meeting_title" maxlength="1000" placeholder="회의 주제를 입력하세요" />
                            </li>
                            <li>
                                <div class="tst_flex">
                                    <div class="tst_col6">
                                        <label class="form_label">회의 시작 시각<span class="font_caution"> *</span></label>
                                        <input type="datetime-local" name="meet_start_date" id="meeting_start_time"/>
                                    </div>
                                    <div class="tst_col6">
                                        <label class="form_label">회의 종료 시각<span class="font_caution"> *</span></label>
                                        <input type="datetime-local" name="meet_end_date" id="meeting_end_time"/>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <p class="min font_subtle">회의실 선택<span class="font_caution"> *</span></p>
                                <div>
						            <select id="meeting_room_select_modal">
						           		<option value="0">전체 회의 보기</option>
						                <c:forEach items="${roomList}" var="room">
						                    <option value="${room.room_idx}">${room.room_name}</option>
						                </c:forEach>
						            </select>
                                    <p class="min font_subtle">- 수용 인원: 4~10명</p>
                                    <p class="min font_subtle">- 사용 가능한 기자재: 고정형 빔 프로젝터, 데스크탑, 모니터, 키보드, 마우스, 연단, 콘센트 책상, 레이저포인터 리모컨</p>
                                    <p class="min font_subtle">- 담당 부서: 경영지원</p>
                                </div>
                            </li>
                            <li>
                                <label class="form_label">회의 내용<span class="font_caution"> *</span></label>
                                <textarea rows="5" name="meet_content" maxlength="1000" id="meeting_content" placeholder="회의 내용을 입력하세요"></textarea>
                            </li>
                        </ul>
                    </div>
                    <div class="tst_col5">
                        <table class="tst_table table_no_padding table_align_left">
                            <colgroup>
                                <col style="width: 80px" />
                                <col style="width: auto" />
                                <col style="width: 20px" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="3">참석자 목록</th>
                            </tr>
                            </thead>
                            <tbody id="emplTableBody">
                            <tr id="add-participant-row">
                                <td colspan="3">
                                    <button type="button" onclick="tst_modal_call('tst_modal_select')" class="btn_subtle btn_full">참석자 추가하기</button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="tst_modal_footer align_left">
                <ul class="tst_list list_no_desc list_inline">
                    <li><input type="button" value="예약하기" class="btn_primary" id="addMeeting"/></li>
                    <li><button type="button" class="btn_secondary" onclick="tst_modal_close('tst_modal_write'); reset_parti();">취소하기</button></li>
                </ul>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_write'); reset_parti();"></div>
</div>
<!-- //일정 추가하기 -->

<!-- 일정 상세보기 -->
<div id="meeting_event_modal" class="tst_modal tst_modal_input tst_modal_detail">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">회의 상세보기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_detail')"></i>
        </div>

        <div class="tst_modal_body">
            <ul class="list_no_desc list_block">
                <li>
                    <p class="min font_subtle">회의실</p>
                    <p id="meeting_room_detail"></p>
                </li>
                <li>
                    <label class="form_label">회의 주제</label>
                    <p id="meeting_title_detail"></p>
                </li>
                <li>
                    <label class="form_label">회의 일시</label>
                    <p><span id="meeting_start_time_detail"></span>~<span id="meeting_end_time_detail"></span></p>
                </li>
                <li>
                    <label class="form_label">회의 내용</label>
                    <p id="meeting_content_detail"></p>
                </li>
                <li>
                    <label class="form_label">참석자</label>
                    <p id="meeting_participants_detail">
                    </p>
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <button onclick="tst_modal_close('tst_modal_detail')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_detail')"></div>
</div>
<!-- 일정 상세보기 -->

<!-- 일정 수정하기 -->
<div id="meeting_event_modal" class="tst_modal tst_modal_double tst_modal_update">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">회의 수정하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_update')"></i>
        </div>
        <form>
            <div class="tst_modal_body">
                <div class="tst_flex">
                    <div class="tst_col7">
                        <table class="tst_table table_no_padding table_no_underline table_align_left">
                            <colgroup>
                                <col style="width: 100px;" />
                                <col style="width: auto;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">예약 정보</th>
                            </tr>
                            </thead>
                        </table>
                        <ul class="list_no_desc list_block">
                            <li>
                                <label class="form_label">회의 주제<span class="font_caution"> *</span></label>
                                <input type="text" id="meeting_title_update" name="meet_subject" maxlength="1000" value="" placeholder="회의 주제를 입력하세요" />
                            </li>
                            <li>
                                <div class="tst_flex">
                                    <div class="tst_col6">
                                        <label class="form_label">회의 시작 시각<span class="font_caution"> *</span></label>
                                        <input type="datetime-local" id="meeting_start_time_update" name="meet_start_date" value="" />
                                    </div>
                                    <div class="tst_col6">
                                        <label class="form_label">회의 종료 시각<span class="font_caution"> *</span></label>
                                        <input type="datetime-local" id="meeting_end_time_update" name="meet_end_date" value="" />
                                    </div>
                                </div>
                            </li>
                            <li>
                                <p class="min font_subtle">회의실 선택<span class="font_caution"> *</span></p>
                                <div>
                                    <select id="meeting_room_idx_update" name="room_idx" onchange="<!-- 회의실을 선택하면 회의실 정보를 수정하는 함수명을 입력하세요 -->">
										<c:forEach items="${roomList}" var="room">
									    	<option value="${room.room_idx}">${room.room_name}</option>
									    </c:forEach>
                                    </select>
                                    <p class="min font_subtle">- 수용 인원: 4~10명</p>
                                    <p class="min font_subtle">- 사용 가능한 기자재: 고정형 빔 프로젝터, 데스크탑, 모니터, 키보드, 마우스, 연단, 콘센트 책상, 레이저포인터 리모컨</p>
                                    <p class="min font_subtle">- 담당 부서: 경영지원</p>
                                </div>
                            </li>
                            <li>
                                <label class="form_label">회의 내용<span class="font_caution"> *</span></label>
                                <textarea rows="5" id="meeting_content_update" name="meet_content" maxlength="1000" placeholder="회의 내용을 입력하세요"></textarea>
                            </li>
                        </ul>
                    </div>
                    <div class="tst_col5">
                        <table class="tst_table table_no_padding table_align_left">
                            <colgroup>
                                <col style="width: 80px" />
                                <col style="width: auto" />
                                <col style="width: 20px" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="3">참석자 목록</th>
                            </tr>
                            </thead>
                            <tbody id="empl_update">
	                            <tr id="add-participant-row-update">
	                                <td colspan="3">
	                                    <button type="button" onclick="tst_modal_call('tst_modal_select')" class="btn_subtle btn_full">참석자 추가하기</button>
	                                </td>
	                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="tst_modal_footer align_left">
                <ul class="tst_list list_no_desc list_inline">
                    <li><button type="button" onclick="meeting_update_modal()" class="btn_primary">수정하기</button></li>
                    <li><button type="button" class="btn_secondary" onclick="tst_modal_close('tst_modal_update')">취소하기</button></li>
                    <li><button type="button" class="btn_secondary" onclick="meeting_delete()">삭제하기</button></li>
                </ul>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_update')"></div>
</div>
<!-- //일정 수정하기 -->

<!-- 회의 참석자 추가하기 -->
<div class="tst_modal tst_modal_wide tst_modal_select">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">회의 참석자 추가하기</h1>
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
                        <tbody class="tst_pointer">
                        <tr>
                            <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this)"></i></td><!-- 한꺼번에 불러오실 경우 '부서 번호' 지우시면 됩니다.-->
                            <td onclick="show_second_team_list(this)" class="tst_pointer">부서</td>
                        </tr>

                        <!-- 부서 목록 출력 -->
                        <tr class="disp_hide">
                            <td></td>
                            <td>
                                <table class="tst_table tst_table_in_table table_align_left table_no_padding">
					                <tbody>
									<c:forEach var="dept" items="${deptList}">
					                    <tr>
					                        <td onclick="get_dept_empl(${dept.dept_idx})">${dept.dept_name}</td>
					                    </tr>
									</c:forEach>
					                </tbody>
					            </table>
					        </td>
                        </tr>
                        <!-- //부서 목록 출력 -->

                        <!-- 예시 -->
                        <tr>
                            <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this)"></i></td>
                            <td onclick="show_second_team_list(this)" class="tst_pointer">팀</td>
                        </tr>
					    <tr class="disp_hide">
					        <td></td>
					        <td>
					            <table class="tst_table table_align_left table_no_padding">
					                <tbody>
									<c:forEach var="team" items="${teamList}">
					                    <tr>
					                        <td onclick="get_team_empl(${team.team_idx})">${team.team_name}</td>
					                    </tr>
									</c:forEach>
					                </tbody>
					            </table>
					        </td>
					    </tr>
                        <!-- //예시 -->

                        </tbody>
                        <!-- //부서 목록 출력 -->

                    </table>
                </div>
                <div class="tst_col7">

                    <!-- 검색 -->
                    <form onsubmit="return meeting_empl_search(event);">
                        <div class="tst_search_container">
                            <div class="tst_search_select">
                                <select id="tst_search_select_category" name="category">
                                    <option value="dept_name">부서 검색</option>
                                    <option value="position_name">직급 검색</option>
                                    <option value="empl_name">사원명 검색</option>
                                </select>
                            </div>
                            <div class="tst_search_input">
                                <input type="text" name="keyword" maxlength="50" id="search_keyword" placeholder="검색어를 입력하세요" />
                            </div>                      
                            <div class="tst_search_icon">
                                <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
                            </div>
                        </div>
                    </form>
                    <!-- //검색 -->

                    <table class="tst_table table_align_left">
                        <colgroup>
                            <col style="width: 33px;" />
                            <col style="width: 40px;" />
                            <col style="width: auto;" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th colspan="3">직원 선택</th>
                        </tr>
                        </thead>

                        <tbody class="tst_pointer" id="empl_list">

                        <!-- 직원 정보 -->

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="tst_modal_footer">
            <button onclick="tst_modal_close('tst_modal_select')" class="btn_secondary">이전 화면으로 돌아가기</button>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_select')"></div>
</div>
<!-- //회의 참석자 추가하기 -->

<script src="resources/js/meeting_room_calendar_modal.js"></script>