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
    <link rel="stylesheet" type="text/css" href="resources/css/login.css" />
</head>
<body>
<c:import url="layout_topnav_empty.jsp" />
<div class="tst_container">
    <div class="login_box">

        <!-- 제목 -->
        <div>
            <h1>비밀번호 찾기 결과</h1>
        </div>

        <!-- 탭 메뉴 -->
        <ul class="list_no_desc list_tab">
            <li class="list_tab_item" onclick="location.href='/'">
                ID찾기
            </li>
            <li class="list_tab_item list_tab_item_active">
                비밀번호찾기
            </li>
        </ul>

        <!-- 결과 출력 -->
        <p><b>${name}</b>님의 임시 비밀번호를 아래 이메일로 발송했습니다.</p>
        <div class="result_box tst_flex">
            <h1 class="tst_flex align_middle">${email}</h1>
        </div>
        <p>비밀번호를 받지 못하셨다면 인사과(본관 306호)에 방문하여 직접 임시 비밀번호를 발급받으시기 바랍니다.</p>
        <hr class="separator" />

        <!-- 버튼 -->
        <ul class="list_no_desc list_block">
            <li>
                <input type="button" value="로그인 화면으로 돌아가기" onclick="location.href='/'" class="btn_full btn_secondary" />
            </li>
        </ul>

    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
</html>