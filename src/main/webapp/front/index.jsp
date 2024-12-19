<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/table.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/approval.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/pagenation.css" />
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
                <div class="tst_flex">
                    <div class="tst_col9">
                        <!-- 제목 -->
                        <ul class="tst_title list_no_desc list_inline">
                            <li class="tst_title_item" onclick="location.href='/'">
                                <h1>내게 온 업무 요청</h1>
                            </li>
                            <li class="tst_title_item" onclick="location.href='/'">
                                <h1>내가 보낸 업무 요청</h1>
                            </li>
                            <li class="tst_title_item tst_title_item_active" onclick="location.href='/'">
                                <h1>작성중인 문서</h1>
                            </li>
                        </ul>
                        <!-- //제목 -->

                        <!-- 게시물 분류 -->
                        <ul class="tst_tablist list_no_desc list_inline">
                            <li class="tst_tablist_item tst_tablist_item_active" onclick="location.href='/'">
                                <h3>전체 보기</h3>
                            </li>
                            <li class="tst_tablist_item" onclick="location.href='/'">
                                <h3>작성중인 문서</h3>
                            </li>
                            <li class="tst_tablist_item" onclick="location.href='/'">
                                <h3>삭제한 문서</h3>
                            </li>
                            <li class="tst_tablist_item">
                                <form>
                                    <div class="tst_search_container">
                                        <h3>검색</h3>
                                        <input type="text" name="search" maxlength="50" class="input_min input_underline" />
                                    </div>
                                </form>
                            </li>
                        </ul>
                        <!-- //게시물 분류 -->

                        <!-- 작성중인 문서 목록 -->
                        <table class="tst_table approval_received_list">
                            <colgroup>
                                <col style="width: 180px" />
                                <col style="width: 180px" />
                                <col style="width: auto" />
                                <col style="width: 150px" />
                                <col style="width: 150px" />
                                <col style="width: 100px" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>수신인</th>
                                <th>유형</th>
                                <th>제목</th>
                                <th>최초 작성 일시</th>
                                <th>최종 수정 일시</th>
                                <th>삭제</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- //작성중인 문서 목록 -->

                            <!-- 작성중인 전자 문서가 없을 경우 -->
                            <tr class="approval_received_no_data"><!-- 데이터가 있을 경우 클래스 disp_hide를 추가하세요. -->
                                <td colspan="7" class="td_no_data">
                                    <p>
                                        <i class="bi bi-file-earmark-break"></i>
                                    </p>
                                    <h3>결재 요청한 문서가 없습니다.</h3>
                                </td>
                            </tr>
                            <!-- //작성중인 전자 문서가 없을 경우 -->

                            <!-- 기본 -->
                            <tr>
                                <td class="td_align_left">{직원명 (부서명/직급명)}</td>
                                <td>{문서 유형}</td>
                                <td class="td_align_left">
                                    <a href="/" target="_blank">{제목}</a>
                                </td>
                                <td>{최초 작성 일시}</td>
                                <td>{최종 수정 일시}</td>
                                <td>
                                    <a href="/"><span class="tst_badge_min btn_subtle">삭제</span></a>
                                </td>
                            </tr>
                            <!-- //기본 -->

                            <!-- 예시 -->
                            <tr>
                                <td class="td_align_left">
                                    김이름 (영업/대리)
                                </td>
                                <td>
                                    출장 결과 보고서
                                </td>
                                <td class="td_align_left">
                                    <a href="/" target="_blank">제목이 여기에 출력됩니다.</a>
                                </td>
                                <td>2024-12-18 09:30</td>
                                <td>2024-12-18 10:00</td>
                                <td>
                                    <a href="/"><span class="tst_badge_min btn_subtle">삭제</span></a>
                                </td>
                            </tr>
                            <!-- //예시 -->

                            <!-- pagination -->
                            <tfoot>
                            <tr>
                                <td colspan="7">
                                    <ul id="pagination" class="pagination-sm pagination">
                                        <li class="page-item first disabled">
                                            <a href="#" class="page-link"><i class="bi bi-chevron-double-left"></i></a>
                                        </li>
                                        <li class="page-item prev disabled">
                                            <a href="#" class="page-link"><i class="bi bi-chevron-left"></i></a>
                                        </li>
                                        <li class="page-item active">
                                            <a href="#" class="page-link">1</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">2</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">3</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">4</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">5</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">6</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">7</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">8</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">9</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">10</a>
                                        </li>
                                        <li class="page-item next">
                                            <a href="#" class="page-link"><i class="bi bi-chevron-right"></i></a>
                                        </li>
                                        <li class="page-item last">
                                            <a href="#" class="page-link"><i class="bi bi-chevron-double-right"></i></a>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                            </tfoot>
                            <!-- //pagination -->

                        </table>
                        <!-- //결재할 문서 목록 -->

                    </div>
                    <div class="tst_col3">
                        <h1>문서 작성하기</h1>
                        <hr class="separator" />
                        <ul class="tst_list list_no_desc list_block">

                            <!-- 새 문서 작성하기 -->
                            <li>
                                <h2>새로 작성하기</h2>
                                <button onclick="location.href='/'" class="btn_primary btn_full">문서 양식 검색하기</button>
                            </li>
                            <!-- //문서 작성하기 -->

                            <!-- 기존에 작성한 문서 양식 불러오기 -->
                            <li>
                                <h2>기존에 작성한 문서 양식 불러오기</h2>
                                <button onclick="location.href='/'" class="btn_secondary btn_full">사내 문서함 참조하기</button>
                                <ul class="tst_list list_block">
                                    <li>
                                        <h3>{문서 제목}</h3>
                                        <p class="font_subtle">{문서 종류}</p>
                                        <div class="tst_flex">
                                            <div class="tst_col6">
                                                <button onclick="location.href='/'" class="btn_primary btn_full">내용+양식 복사하기</button>
                                            </div>
                                            <div class="tst_col6">
                                                <button onclick="location.href='/'" class="btn_secondary btn_full">양식만 복사하기</button>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </li>
                            <!-- //기존에 작성한 문서 양식 불러오기 -->

                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
</html>