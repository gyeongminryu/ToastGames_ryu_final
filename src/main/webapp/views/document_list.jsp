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
    <link rel="stylesheet" type="text/css" href="resources/css/module_pagenation.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="resources/js/jquery.twbsPagination.js"></script>
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/document_list.go'">
                        <h1>문서함</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">
                    <div class="tst_col2">

                        <!-- 분류 검색 -->
                        <form>
                            <div class="tst_search_container width_full disp_hide">
                                <div class="tst_search_input">
                                    <input type="text" name="department" maxlength="50" class="input_min input_underline" placeholder="검색어를 입력하세요" />
                                </div>
                                <div class="tst_search_icon">
                                    <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
                                </div>
                            </div>
                        </form>
                        <!-- //분류 검색 -->

                        <table class="tst_table table_align_left">
                            <colgroup>
                                <col style="width: 20px;" />
                                <col style="width: auto;" />
                            </colgroup>
                            <tbody class="tst_pointer">

                            <!-- 모든 문서 조회 (필터링 초기화) -->
                            <tr>
                                <td></td>
                                <th class="td_no_padding">
                                    <span onclick="location.href='/document_list'">전체 보기</span>
                                </th>
                            </tr>
                            <!-- //모든 문서 조회 (필터링 초기화) -->

                            <!-- 부서 목록 (필터링) -->
                            <tr>
                                <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this, '부서번호')"></i></td>
                                <th class="td_no_padding">
                                    <span onclick="location.href='/document_list?'">{부서명}</span>
                                </th>
                            </tr>
                            <tr class="disp_hide">
                                <td colspan="2" class="td_no_padding">
                                    <table class="tst_table tst_table_in_table table_align_left">
                                        <colgroup>
                                            <col style="width: 23px;" />
                                            <col style="width: auto;" />
                                        </colgroup>

                                        <!-- 팀 목록 (필터링) -->
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/document_list?dept_idx='">{팀명}</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/document_list?dept_idx='">{팀명}</span></td>
                                        </tr>
                                        <!-- //팀 목록 (필터링) -->

                                    </table>
                                </td>
                            </tr>
                            <!-- //부서 목록 (필터링) -->

                            <!-- 부서 목록 > 선택한 항목 (필터링) -->
                            <tr class="td_bg_medium">
                                <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this, '부서번호')"></i></td>
                                <th class="td_no_padding">
                                    <span onclick="location.href='/board_list?'">{분류명}</span>
                                </th>
                            </tr>

                            <tr class="disp_hide">
                                <td colspan="2" class="td_no_padding">
                                    <table class="tst_table tst_table_in_table table_align_left">
                                        <colgroup>
                                            <col style="width: 23px;" />
                                            <col style="width: auto;" />
                                        </colgroup>

                                        <!-- 팀 목록 (필터링) -->
                                        <!-- 팀 > 선택한 항목 (필터링) -->
                                        <tr class="td_bg_medium">
                                            <th></th>
                                            <td><span onclick="location.href='/board_list?'">{팀명}</span></td>
                                        </tr>
                                        <!-- //팀 > 선택한 항목 (필터링) -->

                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/board_list?'">{팀명}</span></td>
                                        </tr>
                                        <!-- //팀 목록 (필터링) -->

                                    </table>
                                </td>
                            </tr>
                            <!-- //부서 > 선택한 항목 (필터링) -->

                            </tbody>
                        </table>
                    </div>

                    <div class="tst_col10">

                        <div class="tst_flex">
                            <div class="tst_col8">

                                <!-- 물품 검색 -->
                                <form>
                                    <div class="tst_search_container">
                                        <div class="tst_search_select">
                                            <select id="tst_search_select_category" onchange="<!-- 분류 선택시 실행할 함수를 입력하세요 -->">
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
                                <!-- //물품 검색 -->

                            </div>
                            <div class="tst_col4">

                                <!-- 열람 가능한 문서 필터링 -->
                                <div class="tst_filtering_container tst_pointer">
                                    <div class="tst_filtering_off" onclick="accessible_filtering_on(this)">
                                        <i class="bi bi-toggle-off"></i>
                                        <span>열람 가능한 문서만 보기</span>
                                    </div>
                                    <div class="tst_filtering_on disp_hide" onclick="accessible_filtering_off(this)">
                                        <i class="bi bi-toggle-on"></i>
                                        <span>열람 가능한 문서만 보기</span>
                                    </div>
                                </div>
                                <!-- //열람 가능한 문서 필터링 -->

                            </div>
                        </div>
                        <table class="tst_table tr_hover_subtle table_no_padding">
                            <colgroup>
                                <col style="width: 80px;" />
                                <col style="width: 120px;" />
                                <col style="width: auto;" />
                                <col style="width: 120px;" />
                                <col style="width: 100px;" />
                                <col style="width: 120px;" />
                                <col style="width: 100px;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>문서 형식</th>
                                <th>문서명</th>
                                <th>작성자</th>
                                <th>작성일</th>
                                <th>최종 승인자</th>
                                <th>최종 승인일</th>
                            </tr>
                            </thead>
                            <tbody>

                            <!-- 검색되는 문서가 없을 경우 -->
                            <tr class="document_list_no_data disp_hide"><!-- 데이터가 있을 경우 클래스 disp_hide를 추가하세요. -->
                                <td colspan="7" class="td_no_data">
                                    <p><i class="bi bi-file-earmark-break"></i></p>
                                    <h3>검색 조건에 해당하는 문서가 없습니다.</h3>
                                </td>
                            </tr>
                            <!-- //검색되는 문서가 없을 경우 -->

                            <!-- 문서 목록 > 열람 가능한 문서 -->
                            <tr>
                                <td>{번호}</td>
                                <td class="td_align_left">출장 결과 보고서</td>
                                <td class="td_align_left">
                                    <span class="tst_badge_min btn_secondary">열람 가능</span>
                                    <span onclick="location.href='/document_detail?'" class="tst_pointer">출장 결과 보고서입니다 {첨부파일여부}</span>
                                </td>
                                <td><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">직원명 (부서/직급)</span></td>
                                <td>yyyy-MM-dd</td>
                                <td><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">직원명 (부서/직급)</span></td>
                                <td>yyyy-MM-dd</td>
                            </tr>
                            <!-- //문서 목록 > 열람 가능한 문서 -->

                            <!-- 문서 목록 > 열람 불가한 문서 -->
                            <tr>
                                <td>{번호}</td>
                                <td class="td_align_left">지출 품의서</td>
                                <td class="td_align_left">
                                    <span class="tst_badge_min btn_disable">열람 불가</span>
                                    <span class="font_cancellation font_subtle">구매 요청드립니다</span>
                                </td>
                                <td><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">직원명 (부서/직급)</span></td>
                                <td>yyyy-MM-dd</td>
                                <td><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">직원명 (부서/직급)</span></td>
                                <td>yyyy-MM-dd</td>
                            </tr>
                            <!-- //문서 목록 > 열람 불가한 문서 -->

                            <!-- pagination -->
                            <tfoot>
                            <tr>
                                <td colspan="7">
                                    <ul id="pagination" class="pagination-sm pagination"></ul>
                                </td>
                            </tr>
                            </tfoot>
                            <!-- //pagination -->
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/document_list.js"></script>
</html>