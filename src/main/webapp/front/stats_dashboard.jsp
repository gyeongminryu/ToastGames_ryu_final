<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Insert Title Here</title>
    <!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/stats_dashboard'">
                        <h1>매출/통계</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <h3>I'd be the number one girl in your eyes.</h3>

            </div>
        </div>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
</html>