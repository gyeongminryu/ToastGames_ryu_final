<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/table.css" />
</head>
<body>
<c:import url="layout_topnav.jsp" />
<div class="tst_container">
    <c:import url="layout_leftnav.jsp" />
    <div class="tst_container_right">
        <div class="tst_contents">
            <div class="tst_contents_inner">
                <ul class="tst_title list_no_desc list_inline">
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/'">
                        <h1>내게 온 업무 요청</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/'">
                        <h1>내가 보낸 업무 요청</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/'">
                        <h1>작성중인 문서</h1>
                    </li>
                </ul>
                <ul class="tst_tablist list_no_desc list_inline">
                    <li class="tst_tablist_item tst_tablist_item_active" onclick="location.href='/'">
                        <h3>전체 보기</h3>
                    </li>
                    <li class="tst_tablist_item" onclick="location.href='/'">
                        <h3>읽지 않음</h3>
                    </li>
                    <li class="tst_tablist_item" onclick="location.href='/'">
                        <h3>결재중</h3>
                    </li>
                    <li class="tst_tablist_item" onclick="location.href='/'">
                        <h3>결재 승인</h3>
                    </li>
                    <li class="tst_tablist_item" onclick="location.href='/'">
                        <h3>결재 반려</h3>
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
                <table class="tst_table">
                    <colgroup>
                        <col style="width: auto" />
                        <col style="width: auto" />
                        <col style="width: auto" />
                        <col style="width: auto" />
                        <col style="width: auto" />
                        <col style="width: auto" />
                        <col style="width: auto" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th>발신인</th>
                        <th>유형</th>
                        <th>제목</th>
                        <th>결재 현황</th>
                        <th>수신 일시</th>
                        <th>처리 일시</th>
                        <th>마감 일시</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
</html>