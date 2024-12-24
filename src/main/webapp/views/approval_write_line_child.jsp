<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>



  <style>

  </style>


</head>

<body>

<div>
  <input type ="text" id ="search" placeholder="부서 이름으로 검색하기"/>
</div>

<div id = "none_selected">
  <input type="button" value = "결재선 선택하지 않기" onclick="approval_line_none()"/>
</div>

<div id = "all_dept_wrapper">

</div>


<div id = "empl_wrapper">

</div>
<input type = "hidden" id="send_val"/>
<input type="button" id = "send" value="결재선 선택" onclick="approval_send_line()"/>
</body>
<%--기능 script--%>
<script src="/resources/js/approval_write_line_child.js"></script>
</html>