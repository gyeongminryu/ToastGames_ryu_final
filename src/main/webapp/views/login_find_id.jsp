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
            <li class="list_tab_item" onclick="location.href='findPw.go'">
                비밀번호찾기
            </li>
        </ul>

        <!-- 입력 폼 -->
        <form action="findId.do" method="post">
            <ul class="list_no_desc list_block">
                <li>
                    <!-- 이름이 틀렸을 때, 오류 메시지 표시. -->
                    <label class="form_label">이름</label>
                    <input type="text" name="name" maxlength="50" placeholder="이름을 입력하세요" value="${inputName != null ? inputName : ''}" class = "${not empty nameError ? 'input_caution' : ''}" />
                    <c:if test="${not empty nameError}">
					    <p class="min font_caution" >${nameError}</p>
					</c:if>
                </li>
                <li>
                    <!-- 이메일이 틀렸을 때, 오류 메시지 표시. -->
                    <label class="form_label">이메일</label>
                    <input type="text" name="email" maxlength="50" placeholder="이메일을 입력하세요" value="${inputEmail != null ? inputEmail : ''}" class = "${not empty emailError ? 'input_caution' : ''}" />
                    <c:if test="${not empty emailError}">
					    <p class="min font_caution" >${emailError}</p>
					</c:if>
                </li>
                <li>
                    <hr class="separator" />
                </li>
                <li>
                    <input type="submit" value="ID 찾기" class="btn_full btn_primary" />
                </li>
                <li>
                    <input type="button" value="로그인 화면으로 돌아가기" onclick="location.href='login.go'" class="btn_full btn_text" />
                </li>
            </ul>
        </form>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
</html>