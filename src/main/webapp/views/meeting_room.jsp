<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table, th, td{
	border:1px solid black;
	border-collapse: collapse;
}
</style>
</head>
<body>
<div>
	<table>
		<tr>
			<th>회의실 이름</th>
			<td>${roomDetail.room_name}</td>
		</tr>
		<tr>
			<th>회의실 위치</th>
			<td>${roomDetail.room_addr}</td>
		</tr>
		<tr>
			<th>관리사원</th>
			<td>${roomDetail.empl_name}</td>
		</tr>
		<tr>
			<th>회의실 정보</th>
			<td>${roomDetail.room_info}</td>
		</tr>
		<tr>
			<th>회의실 사진</th>
			<td><img alt="${file.ori_filename}" src="/photo/${file.new_filename}"></td>
		</tr>
		<tr>
			<th>최소 인원</th>
			<td>${roomDetail.room_min}</td>
		</tr>
		<tr>
			<th>최대 인원</th>
			<td>${roomDetail.room_max}</td>
		</tr>
	</table>
	<a href="meeting.go">돌아가기</a>

</div>

</body>
</html>