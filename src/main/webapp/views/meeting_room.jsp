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
    <table id="meeting_room_detail">
        <tr>
            <th>회의실 이름</th>
            <td class="editable" data-key="room_name">${roomDetail.room_name}</td>
        </tr>
        <tr>
            <th>회의실 위치</th>
            <td class="editable" data-key="room_addr">${roomDetail.room_addr}</td>
        </tr>
        <tr>
            <th>관리사원</th>
            <td class="none_editable" data-key="empl_name">${roomDetail.empl_name}</td>
        </tr>
        <tr>
            <th>회의실 정보</th>
            <td class="editable" data-key="room_info">${roomDetail.room_info}</td>
        </tr>
        <tr>
            <th>회의실 사진</th>
            <td>
                <img alt="${file.ori_filename}" src="/photo/${file.new_filename}">
            </td>
        </tr>
        <tr>
            <th>최소 인원</th>
            <td class="editable" data-key="room_min">${roomDetail.room_min}</td>
        </tr>
        <tr>
            <th>최대 인원</th>
            <td class="editable" data-key="room_max">${roomDetail.room_max}</td>
        </tr>
    </table>
     <input type="hidden" id="room_idx" name="room_idx" value="${roomDetail.room_idx}">
    
    <div>
        <button id="editButton">수정</button>
        <button id="confirmButton" style="display: none;">확인</button>
        <button id="deleteButton">삭제</button>
        <a href="meeting.go">돌아가기</a>
    </div>
    
</div>
</body>

<script src="/resources/js/meeting_room.js"></script>

</html>