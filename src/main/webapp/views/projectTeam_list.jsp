<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>프로젝트 팀 목록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<!-- 검색 기준 선택 (팀 이름 또는 팀장 이름) -->
<input type="radio" name="searchOption" value="teamName" checked> 팀 이름
<input type="radio" name="searchOption" value="teamHead"> 팀장 이름

<!-- 팀 이름 검색 필드 (직접 입력) -->
<div id="teamNameContainer">
    <label for="teamName">팀 이름:</label>
    <input type="text" id="teamName" name="teamName" placeholder="팀 이름을 입력하세요">
</div>

<!-- 팀장 이름 검색 필드 (직접 입력) -->
<div id="teamHeadContainer" style="display: none;">
    <label for="teamHead">팀장 이름:</label>
    <input type="text" id="teamHead" name="teamHead" placeholder="팀장 이름을 입력하세요">
</div>

<button id="searchBtn">검색</button>

    <!-- 검색 결과 테이블 -->
    <table id="teamListTable" border="1">
        <thead>
            <tr>
                <th>팀 이름</th>
                <th>팀장</th>
                <th>직위</th>
                <th>팀원 수</th>
            </tr>
        </thead>
        <tbody>
            <!-- 검색 결과가 여기에 동적으로 추가됩니다 -->
        </tbody>
    </table>

    <script>
    $(document).ready(function() {
        // 검색 기준 변경 시, 입력 필드 토글
        $('input[name="searchOption"]').on('change', function() {
            if ($(this).val() === 'teamName') {
                $('#teamNameContainer').show();  // 팀 이름 입력 필드 보이기
                $('#teamHeadContainer').hide();  // 팀장 이름 입력 필드 숨기기
                $('#teamHead').val('');  // 팀장 이름 초기화
            } else {
                $('#teamNameContainer').hide();  // 팀 이름 입력 필드 숨기기
                $('#teamHeadContainer').show();  // 팀장 이름 입력 필드 보이기
                $('#teamName').val('');  // 팀 이름 초기화
            }
        });

        // 검색 버튼 클릭 시
        $('#searchBtn').on('click', function() {
            var searchOption = $('input[name="searchOption"]:checked').val();  // 선택된 검색 기준
            var teamName = $('#teamName').val();  // 팀 이름 입력 값
            var teamHead = $('#teamHead').val();  // 팀장 이름 입력 값

            var requestData = {};

            // 선택된 기준에 따라 requestData에 값 추가
            if (searchOption === 'teamName' && teamName) {
                requestData.teamName = teamName;  // 팀 이름만 전송
            } else if (searchOption === 'teamHead' && teamHead) {
                requestData.teamHead = teamHead;  // 팀장 이름만 전송
            } else {
                alert('팀 이름 또는 팀장 이름을 입력해주세요.');
                return;
            }

            // AJAX 요청
            $.ajax({
                url: './searchTeamlist.ajax',  // 서버의 검색 엔드포인트
                method: 'GET',
                data: requestData,  // 선택된 기준에 맞는 데이터를 서버로 전송
                success: function(response) {
                    console.log(response);  // 서버 응답 확인

                    var tableBody = $('#teamListTable tbody');
                    tableBody.empty();  // 기존 테이블 내용 비우기

                    if (response.team_list && response.team_list.length > 0) {
                        // 검색 결과가 있을 경우 테이블에 추가
                        response.team_list.forEach(function(team) {
                            tableBody.append('<tr>' +
                                '<td>' + team.team_name + '</td>' +
                                '<td>' + team.team_head_name + '</td>' +
                                '<td>' + team.duty_name, + '</td>' +
                                '<td>' + team.position_name + '</td>' +
                                '<td>' + team.team_duty + '</td>' +
                                '<td>' + team.team_member_count + '</td>' +
                                '<td>' + team.calup_date + '</td>' +
                                '<td>' + team.deletion_date + '</td>' +
                                '</tr>');
                        });
                    } else {
                        // 결과가 없으면
                        tableBody.append('<tr><td colspan="4">검색 결과가 없습니다.</td></tr>');
                    }
                },
                error: function(xhr, status, error) {
                    alert('검색 중 오류가 발생했습니다.');
                }
            });
        });
    });
    </script>

</body>
</html>