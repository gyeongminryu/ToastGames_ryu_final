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
    <link rel="stylesheet" type="text/css" href="resources/css/approval.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/approval_send_modal.css" />>
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_staff_list'">
                        <h1>구성원 관리</h1>
                    </li>
                </ul>
                <!-- //제목 -->



                <!-- 직원 검색 -->
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
                <!-- //직원 검색 -->

                <table class="tst_table">
                    <colgroup>
                        <col style="width: 60px;" />
                        <col style="width: 200px;" />
                        <col style="width: 250px;" />
                        <col style="width: 120px;" />
                        <col style="width: auto;" />
                        <col style="width: 150px;" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>부서/팀</th>
                        <th>직원명 (ID)</th>
                        <th>직급/직책</th>
                        <th>직무</th>
                        <th>입사일</th>
                    </tr>
                    </thead>
                    <tbody>

                    <!-- 검색되는 직원이 없을 경우 -->
                    <tr class="rent_list_no_data disp_hide"><!-- 데이터가 있을 경우 클래스 disp_hide를 추가하세요. -->
                        <td colspan="6" class="td_no_data">
                            <p><i class="bi bi-person-exclamation"></i></p>
                            <h3>검색 조건에 해당하는 직원이 없습니다.</h3>
                        </td>
                    </tr>
                    <!-- //검색되는 직원이 없을 경우 -->

                    <!-- 직원 목록 -->
                    <tr>
                        <td>{번호}</td>
                        <td class="td_align_left">
                            <span onclick="location.href='/organization_detail?'" class="tst_pointer">{부서}</span>
                        </td>
                        <td class="td_align_left">
                            <h3 onclick="location.href='/manage_staff_detail?'" class="tst_pointer">{직원명} ({ID})</h3>
                        </td>
                        <td class="td_align_left">{직급}/{직책}</td>
                        <td class="td_align_left">{직무}</td>
                        <td>{입사일|yyyy-MM-dd}</td>
                    </tr>
                    <!-- //직원 목록 -->

                    <!-- 예시 -->
                    <tr>
                        <td>126</td>
                        <td class="td_align_left">
                            <span onclick="location.href='/organization_detail?'" class="tst_pointer">아트/UI/UX디자인</span>
                        </td>
                        <td class="td_align_left">
                            <h3 onclick="location.href='/manage_staff_detail?'" class="tst_pointer">김이름 (kimname_art)</h3>
                        </td>
                        <td class="td_align_left">대리/사원</td>
                        <td class="td_align_left">게임 내 UI/UX 요소 디자인</td>
                        <td>2023-03-05</td>
                    </tr>
                    <tr>
                        <td>126</td>
                        <td class="td_align_left">
                            <span onclick="location.href='/organization_detail?'" class="tst_pointer">아트/UI/UX디자인</span>
                        </td>
                        <td class="td_align_left">
                            <h3 onclick="location.href='/manage_staff_detail?'" class="tst_pointer">김이름 (kimname_audio)</h3>
                        </td>
                        <td class="td_align_left">대리/사원</td>
                        <td class="td_align_left">오디오 미들웨어 설계, 오디오 데이터 관리</td>
                        <td>2023-03-05</td>
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
            </div>
        </div>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/approval_send_modal.js"></script>
</html>