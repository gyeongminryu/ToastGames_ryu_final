<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
table, th, td{
	border:1px solid black;
	border-collapse: collapse;
}
</style>
</head>
<body>
<div>
	<form action="/meeting/meetingRoom.add" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<th>회의실 이름</th>
				<td><input type="text" name="room_name"/></td>
			</tr>
			<tr>
				<th>회의실 위치</th>
				<td><input type="text" name="room_addr"/></td>
			</tr>
			<tr>
				<th>관리사원</th>
				<td><input type="text" name="room_empl_idx"/></td>
			</tr>
			<tr>
				<th>회의실 정보</th>
				<td><input type="text" name="room_info"/></td>
			</tr>
			<tr>
				<th>회의실 사진</th>
				<td><input type="file" name="file" multiple="multiple"/></td>
			</tr>
			<tr>
				<th>최소 인원</th>
				<td><input type="text" name="room_min"/></td>
			</tr>
			<tr>
				<th>최대 인원</th>
				<td><input type="text" name="room_max"/></td>
			</tr>
		</table>
		<button type="submit">회의실 정보등록</button>
	</form>

</div>

</body>
</html>