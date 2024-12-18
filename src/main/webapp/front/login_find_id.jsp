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
            <h1>ID/비밀번호 찾기</h1>
        </div>

        <!-- 탭 메뉴 -->
        <ul class="list_no_desc list_tab">
            <li class="list_tab_item list_tab_item_active">
                ID찾기
            </li>
            <li class="list_tab_item" onclick="location.href='/'">
                비밀번호찾기
            </li>
        </ul>

        <!-- 입력 폼 -->
        <form>
            <ul class="list_no_desc list_block">
                <li>
                    <label class="form_label">이름</label>
                    <input type="text" name="name" maxlength="50" placeholder="이름을 입력하세요" />
                    <p class="min font_caution disp_hide">이름이 존재하지 않습니다.</p>
                </li>
                <li>
                    <label class="form_label">이메일</label>
                    <input type="text" name="email" maxlength="50" placeholder="이메일을 입력하세요" />
                    <p class="min font_caution disp_hide">이메일이 존재하지 않습니다.</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
                <li>
                    <input type="submit" value="ID 찾기" onclick="location.href='/'" class="btn_full btn_primary" />
                </li>
                <li>
                    <input type="button" value="로그인 화면으로 돌아가기" onclick="location.href='/'" class="btn_full btn_text" />
                </li>
            </ul>
        </form>

        <!-- 오류 발생시 입력창을 클래스를 아래와 같이 변경하세요. -->
        <ul class="list_no_desc list_block">
            <li>
                <label class="form_label">이름</label>
                <input type="text" name="name" maxlength="50" placeholder="이름을 입력하세요" class="input_caution" />
                <p class="min font_caution">이름이 존재하지 않습니다.</p>
            </li>
            <li>
                <label class="form_label">이메일</label>
                <input type="text" name="email" maxlength="50" placeholder="이메일을 입력하세요" class="input_caution" />
                <p class="min font_caution">이메일이 존재하지 않습니다.</p>
            </li>
        </ul>
        <!-- //오류 발생시 입력창 클래스를 위와 같이 변경하세요. -->

    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
</html>