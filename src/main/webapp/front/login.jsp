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
        <div class="logo_box">
            <h1>TOAST Games</h1>
        </div>

        <!-- 입력폼 -->
        <form>
            <ul class="list_no_desc list_block">
                <li>
                    <label class="form_label">Identification</label>
                    <input type="text" name="id" maxlength="50" placeholder="아이디를 입력하세요" />
                    <p class="min font_caution disp_hide">아이디를 확인하세요.</p>
                </li>
                <li>
                    <label class="form_label">Passwords</label>
                    <input type="password" name="pw" maxlength="50" placeholder="비밀번호를 입력하세요" />
                    <p class="min font_caution disp_hide">비밀번호를 확인하세요.</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
                <li>
                    <input type="submit" value="Login => {work}" class="btn_full btn_primary" />
                </li>
                <li>
                    <input type="button" value="Exception => {ID|비밀번호 찾기}" class="btn_full btn_text" onclick="location.href='login_findid.html'"/>
                </li>
            </ul>
        </form>

        <!-- 로그인 오류 발생시 입력창의 클래스을 아래와 같이 변경하세요. -->
        <ul class="list_no_desc list_block">
            <li>
                <label class="form_label">Identification</label>
                <input type="text" name="id" maxlength="50" placeholder="아이디를 입력하세요" class="input_caution" />
                <p class="min font_caution">아이디를 확인하세요.</p>
            </li>
            <li>
                <label class="form_label">Passwords</label>
                <input type="password" name="pw" maxlength="50" placeholder="비밀번호를 입력하세요" class="input_caution" />
                <p class="min font_caution">비밀번호를 확인하세요.</p>
            </li>
        </ul>
        <!-- //로그인 오류 발생시 입력창의 클래스를 위와 같이 변경하세요. -->

    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
</html>