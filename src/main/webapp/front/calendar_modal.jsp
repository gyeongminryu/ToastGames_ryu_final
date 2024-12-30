<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/approval_send_modal.css" />

<!-- 일정 추가하기 -->
<div id="meeting_event_modal" class="tst_modal tst_modal_double tst_modal_write">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">일정 추가하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_write')"></i>
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
                                <th colspan="2">일정</th>
                            </tr>
                            </thead>
                        </table>
                        <ul class="list_no_desc list_block">
                            <li>
                                <label class="form_label">제목</label>
                                <input type="text" id="schedule_title" maxlength="1000" placeholder="일정 제목을 입력하세요" />
                            </li>
                            <li>
                                <label class="form_label">내용</label>
                                <textarea rows="5" id="schedule_content" maxlength="1000" placeholder="회의 내용을 입력하세요"></textarea>
                            </li>
                            <li>
                                <div class="tst_flex">
                                    <div class="tst_col6">
                                        <label class="form_label">일정 시작 시각</label>
                                        <input type="datetime-local" id="schedule_start_time" />
                                    </div>
                                    <div class="tst_col6">
                                        <label class="form_label">일정 종료 시각</label>
                                        <input type="datetime-local" id="schedule_end_time" />
                                    </div>
                                </div>
                            </li>
                            <li>
                                <p class="min font_subtle">일정 종류</p>
                                <div>
                                    <select name="schedule_type">
                                        <option value="1" selected>개인</option>
                                        <option value="2">부서</option>
                                        <option value="3">프로젝트</option>
                                        <option value="4">기타</option>
                                    </select>
                                </div>
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
                            <tbody>
                            <tr>
                                <td colspan="3">
                                    <button type="button" onclick="tst_modal_call('tst_modal_select')" class="btn_subtle btn_full">참석자 추가하기</button>
                                </td>
                            </tr>
                            <tr>
                                <td><h3>{부서명}</h3></td>
                                <td><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({직급}/{직책})</span></td>
                                <td class="align_left"><i class="bi bi-dash-circle-dotted" onclick="<!--참석자를 제외하는 함수를 입력하세요-->"></i></td>
                            </tr>
                            <tr>
                                <td><h3>{부서명}</h3></td>
                                <td><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({직급}/{직책})</span></td>
                                <td class="align_left"><i class="bi bi-dash-circle-dotted" onclick="<!--참석자를 제외하는 함수를 입력하세요-->"></i></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="tst_modal_footer align_left">
                <ul class="tst_list list_no_desc list_inline">
                    <li><input type="submit" value="예약하기" class="btn_primary" /></li>
                    <li><button type="button" class="btn_secondary" onclick="tst_modal_close('tst_modal_write')">취소하기</button></li>
                </ul>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_write')"></div>
</div>
<!-- //일정 추가하기 -->

<!-- 일정 상세보기 -->
<div id="meeting_event_modal" class="tst_modal tst_modal_input tst_modal_detail">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">일정 상세보기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_detail')"></i>
        </div>

        <div class="tst_modal_body">
            <ul class="list_no_desc list_block">
                <li>
                    <label class="form_label">제목</label>
                    <p>{제목}</p>
                </li>
                <li>
                    <label class="form_label">내용</label>
                    <p>{내용}</p>
                </li>
                <li>
                    <label class="form_label">일시</label>
                    <p>{일정 시작 일시} ~ {일정 종료 일시}</p><!-- 형식은 yyyy-MM-dd HH:mm 으로 맞춰 주세요 -->
                </li>
                <li>
                    <p class="min font_subtle">일정 종류</p>
                    <h3>{일정 종류}</h3>
                </li>
                <li>
                    <label class="form_label">참석자</label>
                    <p>
                        <span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer tst_badge_min btn_subtle margin_right">{직원명}</span>
                        <span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer tst_badge_min btn_subtle margin_right">{직원명}</span>
                        <span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer tst_badge_min btn_subtle margin_right">{직원명}</span>
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
            <h1 class="tst_modal_title">일정 수정하기</h1>
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
                                <th colspan="2">일정</th>
                            </tr>
                            </thead>
                        </table>
                        <ul class="list_no_desc list_block">
                            <li>
                                <label class="form_label">주제</label>
                                <input type="text" name="" maxlength="1000" value="{주제}" placeholder="일정 주제를 입력하세요" />
                            </li>
                            <li>
                                <label class="form_label">내용</label>
                                <textarea rows="5" name="" maxlength="1000" placeholder="일정 내용을 입력하세요">{내용}</textarea>
                            </li>
                            <li>
                                <div class="tst_flex">
                                    <div class="tst_col6">
                                        <label class="">일정 시작 시각</label>
                                        <input type="datetime-local" name="" value="" />
                                    </div>
                                    <div class="tst_col6">
                                        <label class="form_label">일정 종료 시각</label>
                                        <input type="datetime-local" name="" value="" />
                                    </div>
                                </div>
                            </li>
                            <li>
                                <p class="min font_subtle">일정 종류</p>
                                <div>
                                    <select name="schedule_type">
                                        <option value="1" selected>개인</option>
                                        <option value="2">부서</option>
                                        <option value="3">프로젝트</option>
                                        <option value="4">기타</option>
                                    </select>
                                </div>
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
                            <tbody>
                            <tr>
                                <td colspan="3">
                                    <button type="button" onclick="tst_modal_call('tst_modal_select')" class="btn_subtle btn_full">참석자 추가하기</button>
                                </td>
                            </tr>
                            <tr>
                                <td><h3>{부서명}</h3></td>
                                <td><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({직급}/{직책})</span></td>
                                <td class="align_left"><i class="bi bi-dash-circle-dotted" onclick="<!--참석자를 제외하는 함수를 입력하세요-->"></i></td>
                            </tr>
                            <tr>
                                <td><h3>{부서명}</h3></td>
                                <td><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({직급}/{직책})</span></td>
                                <td class="align_left"><i class="bi bi-dash-circle-dotted" onclick="<!--참석자를 제외하는 함수를 입력하세요-->"></i></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="tst_modal_footer align_left">
                <ul class="tst_list list_no_desc list_inline">
                    <li><input type="submit" value="수정하기" class="btn_primary" /></li>
                    <li><button type="button" class="btn_secondary" onclick="tst_modal_close('tst_modal_update')">취소하기</button></li>
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
                            <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this, '부서번호')"></i></td><!-- 한꺼번에 불러오실 경우 '부서 번호' 지우시면 됩니다.-->
                            <!-- 부서 내 직원을 출력하는 함수를 입력하세요 --><td onclick="{함수}" class="tst_pointer">{부서명}</td>
                        </tr>

                        <!-- 팀 목록 출력 -->
                        <tr class="disp_hide">
                            <td></td>
                            <td>
                                <table class="tst_table tst_table_in_table table_align_left table_no_padding">
                                    <tbody>
                                    <tr>
                                        <!-- 팀 내 직원을 출력하는 함수를 입력하세요 --><td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <!-- //팀 목록 출력 -->

                        <!-- 예시 -->
                        <tr>
                            <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this, '부서번호')"></i></td>
                            <td onclick="{함수}">{부서명}</td>
                        </tr>
                        <tr class="disp_hide">
                            <td></td>
                            <td>
                                <table class="tst_table tst_table_in_table table_align_left table_no_padding">
                                    <tbody>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
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
                    <form>
                        <div class="tst_search_container">
                            <div class="tst_search_select">
                                <select id="tst_search_select_category" name="category">
                                    <option value="{검색 분류}">검색 분류</option>
                                </select>
                            </div>
                            <div class="tst_search_input">
                                <input type="text" name="keyword" maxlength="50" placeholder="검색어를 입력하세요" />
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

                        <tbody class="tst_pointer">

                        <!-- 직원 정보 -->
                        <tr>
                            <!-- 직원을 결재선 혹은 참조에 추가하는 함수를 입력하세요 --><tr onclick="{함수}">
                            <td><input type="checkbox" name="" /></td>
                            <td class="td_align_top td_no_padding">
                                <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                            </td>
                            <td>
                                <p>{직원명 (부서/직급)}</p>
                                <p class="min font_subtle">{직책}</p>
                            </td>
                        </tr>
                        <!-- //직원 정보 -->

                        <!-- 예시 -->
                        <tr>
                        <tr onclick="{함수}">
                            <td><input type="checkbox" name="" /></td>
                            <td class="td_align_top td_no_padding">
                                <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                            </td>
                            <td>
                                <p>{직원명 (부서/직급)}</p>
                                <p class="min font_subtle">{직책}</p>
                            </td>
                        </tr>
                        <tr>
                        <tr onclick="{함수}">
                            <td><input type="checkbox" name="" /></td>
                            <td class="td_align_top td_no_padding">
                                <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                            </td>
                            <td>
                                <p>{직원명 (부서/직급)}</p>
                                <p class="min font_subtle">{직책}</p>
                            </td>
                        </tr>
                        <!-- //예시 -->

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

<script src="resources/js/module_modal.js"></script>