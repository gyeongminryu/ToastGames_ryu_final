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
        <form action="login.do" method="post">
            <ul class="list_no_desc list_block">
                <li>
                    <!-- 아이디가 틀렸을 때 오류 메시지 표시. -->
                    <label class="form_label">Identification</label>
                    <input type="text" name="id" maxlength="50" placeholder="아이디를 입력하세요" value="${inputId != null ? inputId : ''}" class = "${not empty idError ? 'input_caution' : ''}" />
                    <c:if test="${not empty idError}">
					    <p class="min font_caution" >${idError}</p>
					</c:if>
                </li>
                <li>
                	<!-- 비밀번호가 틀렸을 때 오류 메시지 표시. -->
                    <label class="form_label">Passwords</label>
                    <input type="password" name="pw" maxlength="50" placeholder="비밀번호를 입력하세요" class = "${not empty pwError ? 'input_caution' : ''}" />
                    <c:if test="${not empty pwError}">
					    <p class="min font_caution">${pwError}</p>
					</c:if>
                </li>
                <li>
                    <hr class="separator" />
                </li>
                <li>
                    <input type="submit" value="Login => {work}" class="btn_full btn_primary" />
                </li>
                <li>
                    <input type="button" value="Exception => {ID|비밀번호 찾기}" class="btn_full btn_text" onclick="location.href='findId.go'"/>
                </li>
            </ul>
        </form>
        <!-- 테스트용 로그인!!! 나중에 삭제 예정!!! -->
        <form action="testLogin.do" method="post">
		    <input type="hidden" name="idx" value="10016">
		    <button type="submit">idx = 10,016</button>
		</form>      
		<form action="testLogin.do" method="post">
		    <input type="hidden" name="idx" value="10003">
		    <button type="submit">idx = 10,003</button>
		</form> 
		<!-- 테스트용 로그인!!! 나중에 삭제 예정!!! -->		
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
</html>