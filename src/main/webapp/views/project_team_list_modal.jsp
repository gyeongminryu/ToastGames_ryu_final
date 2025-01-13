<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/approval_send_modal.css" />

<!-- 프로젝트 팀 추가하기 -->
<div id="meeting_event_modal" class="tst_modal tst_modal_input tst_modal_write">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">프로젝트 팀 추가하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_write')"></i>
        </div>
        <form>
            <div class="tst_modal_body">
                <ul class="list_no_desc list_block">
                    <li>
                        <label class="form_label">프로젝트 팀명</label>
                        <input type="text" name="" maxlength="100" placeholder="프로젝트 팀명을 입력하세요" />
                    </li>
                    <li>
                        <label class="form_label">팀장</label>
                        <div class="tst_flex">
                            <div class="tst_col8">
                                <input type="text" name="" maxlength="100" placeholder="팀장을 선택하세요" readonly />
                            </div>
                            <div class="tst_col4">
                                <button type="button" onclick="tst_modal_call('tst_modal_select')" class="btn_secondary btn_full">팀장 임명하기</button>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="tst_flex">
                            <div class="tst_col6">
                                <label class="form_label">운영 시작일</label>
                                <input type="date" name="" />
                            </div>
                            <div class="tst_col6">
                                <label class="form_label">운영 종료일</label>
                                <input type="date" name="" />
                            </div>
                        </div>
                    </li>
                    <li>
                        <label class="form_label">직무</label>
                        <textarea rows="5" name="" maxlength="1000" placeholder="담당 직무를 입력하세요"></textarea>
                    </li>
                </ul>
            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <input type="submit" value="등록하기" class="btn_primary btn_full" />
                    </div>
                    <div class="tst_col6">
                        <button type="button" onclick="tst_modal_close('tst_modal_write')" class="btn_secondary btn_full">취소하기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_write')"></div>
</div>
<!-- //프로젝트 팀 추가하기 -->

<!-- 팀장 임명하기 -->
<div class="tst_modal tst_modal_wide tst_modal_select">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">팀장 임명하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_select')"></i>
        </div>
        <div class="tst_modal_body">
            <div class="tst_flex">
                <div class="tst_col5">
                    <table class="tst_table table_align_left">
                        <colgroup>
                            <col style="width: 23px;" />
                            <col style="width: auto;" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th colspan="2">부서 선택</th>
                        </tr>
                        </thead>

                        <!-- 부서 목록 출력 -->
                        <tbody class="tst_pointer team_dept" id="team_dept">
                        <tr>
                            <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this)"></i></td><!-- 한꺼번에 불러오실 경우 '부서 번호' 지우시면 됩니다.-->
                            <!-- 부서 내 직원을 출력하는 함수를 입력하세요 --><td onclick="{함수}" class="tst_pointer">{부서명}</td>
                        </tr>

                        <!-- 팀 목록 출력 -->
                        <tr class="disp_hide">
                            <td></td>
                            <td>
                                <table class="tst_table table_align_left table_no_padding">
                                    <tbody>
                                    <tr>
                                        <!-- 팀 내 직원을 출력하는 함수를 입력하세요 --><td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <!-- //팀 목록 출력 -->

                        <!-- 예시 -->
                        <tr>
                            <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this, '부서번호')"></i></td>
                            <td onclick="{함수}">{부서명}</td>
                        </tr>
                        <tr class="disp_hide">
                            <td></td>
                            <td>
                                <table class="tst_table table_align_left table_no_padding">
                                    <tbody>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <!-- //예시 -->

                        </tbody>
                        <!-- //부서 목록 출력 -->

                    </table>
                </div>
                <div class="tst_col7">

                    <!-- 직원 검색 -->
                    <!-- //직원 검색 -->

                    <table class="tst_table table_align_left">
                        <colgroup>
                            <col style="width: 40px;" />
                            <col style="width: auto;" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th colspan="2">직원 선택</th>
                        </tr>
                        </thead>

                        <tbody class="tst_pointer" id="dept_member">

                        <!-- 직원 정보 보여주는곳 -->

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="tst_modal_footer">
            <button onclick="<!-- 직원을 팀장으로 등록하는 함수를 입력하세요 -->" class="btn_primary">팀장 임명하기</button>
            <button onclick="tst_modal_close('tst_modal_select')" class="btn_secondary">이전 화면으로 돌아가기</button>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_select')"></div>
</div>
<!-- //팀장 임명하기 -->
<script>

//모달창 스크립트
//날짜 설정 


function fetchAndRenderDeptList() {
 $.ajax({
     url: './get_dept_list.ajax', // 아작스 경로
     type: 'GET',
     dataType: 'json',
     success: function(data) {
         renderDeptList(data); // 성공적으로 데이터를 가져왔을 경우 렌더링
         
     },
     error: function(xhr, status, error) {
         console.error('AJAX 요청 실패:', error);
     }
 });
}

//부서 목록 렌더링
function renderDeptList(data) {
 var tbody = $('.team_dept'); // jQuery를 사용해 요소 선택
 tbody.empty(); // 기존 내용을 초기화

 $.each(data, function(key, deptList) {
     if (deptList.length === 0) return;

     var upperDept = deptList[0]; // 상위 부서
     var lowerDepts = deptList.slice(1); // 하위 부서들

     // 상위 부서 행 추가
     tbody.append(
         '<tr>' +
         '<td><i class="bi bi-caret-right-fill" onclick="show_team_list(this, \'lower-' + upperDept.dept_idx + '\')"></i></td>' +
         '<td onclick="fetchDeptMembers(' + upperDept.dept_idx + ')" class="tst_pointer">' + upperDept.dept_name + '</td>' +
         '</tr>'
     );

     // 하위 부서 컨테이너 추가
     var lowerRow = '<tr id="lower-' + upperDept.dept_idx + '" class="disp_hide">' +
                    '<td></td>' +
                    '<td>' +
                    '<table class="tst_table table_align_left table_no_padding">' +
                    '<tbody>';
     $.each(lowerDepts, function(index, lowerDept) {
         lowerRow += '<tr>' +
                     '<td onclick="fetchDeptMembers(' + lowerDept.dept_idx + ')">' + lowerDept.dept_name + '</td>' +
                     '</tr>';
     });
     lowerRow += '</tbody>' +
                 '</table>' +
                 '</td>' +
                 '</tr>';
     tbody.append(lowerRow);
 });
}
let isFetching = false; // 중복 요청 방지 플래그
//부서원 정보 가져오기
function fetchDeptMembers(deptIdx) {
	
 $.ajax({
     url: './get_dept_members.ajax', // 경로 설정 
     type: 'GET',
     data: { dept_idx: deptIdx }, // 서버로 전달할 데이터
     dataType: 'json',
     success: function(data) {
     	console.log(data);
         renderDeptMembers(data); // 부서원 정보 렌더링 팀장 선택시
      //   renderAddDeptMembers(data);
         $('#dept_member').closest('.disp_hide').removeClass('disp_hide'); // 숨김 클래스 제거
     },
     error: function(xhr, status, error) {
         console.error('부서원 정보 가져오기 실패:', error);
     }
 });
}


//부서원 정보 렌더링 - 전체 부서워 - 팀장 임명 부서원 목록
function renderDeptMembers(members) {
 var membersTable = $('#dept_member'); // 부서원 정보 표시할 테이블
 membersTable.empty(); // 기존 데이터를 초기화

 $.each(members, function(index, member) {
 	 var profileImage = member.empl_profile
      ? '/files/' + member.empl_profile
      : 'http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png';
     membersTable.append(
     		'<tr onclick="updateTeamLeader(\'' + member.empl_idx + '\', \'' + member.empl_name + '\', \'' + member.dept_name + '\', \'' + member.position_name + '\')">' +
             '<td class="td_align_top td_no_padding">' +
             '<img src="' + profileImage + '" alt="' + member.empl_idx + '의 프로필 사진" class="approval_profile_image" style="width:50px; height:50px; object-fit:cover;"/>' +
             '</td>' +
             '<td>' +
             '<p>' + member.empl_name + ' (' + member.dept_name + '/' + member.position_name + ')</p>' +
             '<p class="min font_subtle">' + member.duty_name + '</p>' +
             '</td>' +
             '</tr>'
     );
 });
 $('#dept_member').css('display', 'block'); // 강제로 표시
}


//클릭시 팀장 정보 바꾸기
function updateTeamLeader(id, name, dept, position) {
 // 팀장 정보 업데이트
 document.querySelector("input[name='ceo_idx']").value = id; // 팀장 ID
 document.querySelector("input[name='ceo']").value = name + " (" + dept + "/" + position + ")"; // 팀장 이름 및 직책
 console.log("팀장 정보 업데이트: ", id, name, dept, position);
}



//초기 데이터 로드
fetchAndRenderDeptList();

</script>

<script src="resources/js/module_modal.js"></script>
<script src="resources/js/approval_send_modal.js"></script>