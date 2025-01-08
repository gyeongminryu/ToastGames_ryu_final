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

                                <!-- 문서 검색 -->
                                <form>
                                    <div class="tst_search_container">
                                        <div class="tst_search_select">
                                            <select id="tst_search_select_category" name="opt">
                                                <option value="doc_subject">문서명</option>
                                                <option value="doc_content">문서 내용</option>
                                                <option value="form_subject">문서 형식</option>
                                                <option value="empl_name_0">작성자</option>
                                                <option value="empl_name_1">1차 결재자</option>
                                                <option value="empl_name_2">2차 결재자</option>
                                                <option value="empl_name_3">3차 결재자</option>
                                            </select>
                                        </div>
                                        <div class="tst_search_input">
                                            <input type="text" name="keyword" maxlength="50" placeholder="검색어를 입력하세요" />
                                        </div>
                                        <div class="tst_search_icon">
                                            <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
                                        </div>
                                        <div class="tst_search_icon">
                                            <button type="button" onclick="location.href='/document_list.go'" class="btn_min btn_subtle" style="margin-left: 10px;">초기화</button>
                                        </div>
                                    </div>
                                </form>
                                <!-- //문서 검색 -->

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
                                <col style="width: 150px;" />
                                <col style="width: 120px;" />
                                <col style="width: 150px;" />
                                <col style="width: 120px;" />
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
                            <tbody class="doc_list"></tbody>

                            <!-- pagination -->
                            <tfoot>
                            <tr>
                                <td colspan="7">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination" id="pagination"></ul>
                                    </nav>
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