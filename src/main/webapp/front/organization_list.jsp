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
    <link rel="stylesheet" type="text/css" href="resources/css/module_tree.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/organization_tree'">
                        <h1>부서 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href=''">
                        <h1>프로젝트 팀 관리</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <!-- 차트 -->
                <table class="tst_table">
                    <thead>
                    <tr><th>조직도</th></tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <div class="chart_wrapper">
                                <!-- Chart Box -->
                                <div class="chart-box">
                                    <div id="chart_div"></div>
                                </div>
                                <!-- //Chart Box -->
                            </div>

                        </td>
                    </tr>
                    </tbody>
                </table>
                <hr class="separator" />
                <!-- //차트 -->

                <!-- 검색 -->
                <form>
                    <div class="tst_search_container">
                        <div class="tst_search_select">
                            <select id="tst_search_select_category" name="category" onchange="location.href='/manage_rent_list'">
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

                <!-- 표 -->
                <table class="tst_table">
                    <colgroup>
                        <col style="width: 40px" />
                        <col style="width: auto" />
                        <col style="width: auto" />
                        <col style="width: auto" />
                        <col style="width: auto" />
                        <col style="width: auto" />
                        <col style="width: auto" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th colspan="2">조직명</th>
                        <th>조직장</th>
                        <th>연락처</th>
                        <th>이메일</th>
                        <th>소속 인원</th>
                        <th>담당 직무</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td colspan="2">UI/UX부서</td>
                        <td>부서장 (직급)</td>
                        <td>00)0000-0000</td>
                        <td>member@toastgames.com</td>
                        <td>32명</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    </tbody>
                </table>
                <!-- //표 -->

            </div>
        </div>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/organization_tree.js"></script>
</html>