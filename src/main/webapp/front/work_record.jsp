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
    <link rel="stylesheet" type="text/css" href="resources/css/work_record.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/board_list'">
                        <h1>근태</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">
                    <div class="tst_col9">

                        <!-- 이번 주 근무 시간 -->
                        <table class="tst_table table_align_left">
                            <colgroup>
                                <col style="width: auto;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>이번 주 근무 시간</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <div class=""></div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //이번 주 근무 시간 -->

                    </div>
                    <div class="tst_col3">

                        <!-- 근무 시간 상세보기 -->
                        <table class="tst_table table_align_left table_no_padding">
                            <colgroup>
                                <col style="width: 130px;" />
                                <col style="width: auto;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">근무 시간 상세보기</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>총 근무 시간</th>
                                <th>38/52시간</th>
                            </tr>
                            <tr>
                                <th>필수 근무 시간</th>
                                <td>38/40시간</td>
                            </tr>
                            <tr>
                                <th>초과 근무 시간</th>
                                <td>0/12시간</td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //근무 시간 상세보기 -->

                    </div>
                </div>

                <!-- 일일 근무 시간 -->
                <img src="https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F8e6609db-9ef5-437d-babf-1ccea19463fc%2FUntitled.png&blockId=798b2c27-4492-467c-acc7-371338597826" />
                <!-- //일일 근무 시간 -->

            </div>
        </div>
    </div>
</div>
<c:import url="board_detail_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/board_detail.js"></script>
</html>