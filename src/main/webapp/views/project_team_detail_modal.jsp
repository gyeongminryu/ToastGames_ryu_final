<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/approval_send_modal.css" />

<!-- 프로젝트 팀 정보 수정하기 -->
<div id="meeting_event_modal" class="tst_modal tst_modal_input tst_modal_update">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">프로젝트 팀 정보 수정하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_update')"></i>
        </div>
        <form action="project_team_update.do" method="post">
            <div class="tst_modal_body">
                <ul class="list_no_desc list_block">
                    <li>
                        <label class="form_label">프로젝트 팀명</label>
                        <input type="hidden" name="team_idx" value="${team_info.team_idx}" >
                        <input type="text" name="team_name" maxlength="100" value="${team_info.team_name}" placeholder="팀명을 입력하세요" />
                    </li>
                    <li>
                        <label class="form_label">팀장</label>
                        <div class="tst_flex">
                            <div class="tst_col8">
                            	<input type="hidden" value="${team_info.team_head_idx}" name="team_head_idx"/>
                                <input type="text" name="team_head_info" maxlength="100" value="${team_info.head_name} (${team_info.head_dept_name}/${team_info.head_position_name})" placeholder="팀장을 선택하세요" readonly />
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
                                <input type="date" id="calup_date" value="" name="calup_date" />
                            </div>
                            <div class="tst_col6">
                                <label class="form_label">운영 종료일</label>
                                <input type="date" id="deletion_date" value="" name="deletion_date" />
                            </div>
                        </div>
                    </li>
                    <li>
                        <label class="form_label">직무</label>
                        <textarea rows="5" name="team_duty" maxlength="1000"  placeholder="담당 직무를 입력하세요">${team_info.team_duty}</textarea>
                    </li>
                </ul>
            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <input type="submit" value="등록하기" class="btn_primary btn_full" />
                    </div>
                    <div class="tst_col6">
                        <button type="button" onclick="tst_modal_close('tst_modal_update')" class="btn_secondary btn_full">취소하기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_update')"></div>
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
                        <tbody class="tst_pointer team_dept"  id="team_dept">
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
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <!-- //팀 목록 출력 -->

                        

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
  

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="tst_modal_footer">
            <button onclick="tst_modal_close('tst_modal_select')" class="btn_primary">팀장 임명하기</button>
            <button onclick="tst_modal_close('tst_modal_select')" class="btn_secondary">이전 화면으로 돌아가기</button>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_select')"></div>
</div>
<!-- //팀장 임명하기 -->

<!-- 팀원 방출하기 -->
<div class="tst_modal tst_modal_alert tst_modal_delete">

    <!-- 내보낼 팀원의 사원번호가 아래 입력창 값으로 저장됩니다. -->
    <input type="hidden" name="tst_modal_param" id="tst_modal_param" value="" />

    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">팀원 내보내기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_delete')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                <input type="hidden" name="member_idx" id="member_idx" value="" />
                <input type="hidden" name="team_idx" id="team_idx_del" value="${team_info.team_idx }" />
                    <h3 id="prod_name" class="prod_name">{직원명 (부서/직급)}</h3>
                </li>
                <li>
                    <p>위 팀원을 내보내시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <button onclick="removeTeamMember()" class="btn_primary btn_full">팀원 내보내기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_delete')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_delete')"></div>
</div>
<!-- //팀원 방출하기 -->

<!-- 회의 참석자 추가하기 -->
<div class="tst_modal tst_modal_wide tst_modal_add">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">프로젝트 팀원 추가하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_add')"></i>
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
                        <tbody class="tst_pointer team_dept" id="">
                        <tr>
                            <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this, '부서번호')"></i></td><!-- 한꺼번에 불러오실 경우 '부서 번호' 지우시면 됩니다.-->
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

                    <!-- 검색 -->
                    <form id="searchForm">
                    
                    <input type="hidden" id="team_idx" name="team_idx" value="${team_info.team_idx}" />
                     <input type="hidden" id="dept_idx" name="dept_idx" value="" />
                        <div class="tst_search_container">
                            <div class="tst_search_select">
                                <select id="tst_search_select_category_pro" name="category">
                                    <option value="">검색 분류</option>
                                    <option value="empl_name">이름</option>
                                </select>
                            </div>
                            <div class="tst_search_input">
                                <input type="text" id="keyword_pro" name="keyword" maxlength="50" placeholder="검색어를 입력하세요" />
                            </div>
                            <div class="tst_search_icon">
                                <button type="button" id="searchButton"class="btn_icon"><i class="bi bi-search"></i></button>
                            </div>
                        </div>
                    </form>
                    <!-- //검색 -->

                    <table class="tst_table table_align_left">
                        <colgroup>
                            <col style="width: 33px;" />
                            <col style="width: 40px;" />
                            <col style="width: auto;" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th colspan="3">직원 선택</th>
                        </tr>
                        </thead>

                        <tbody class="tst_pointer" id="dept_member_add">

                        <!-- 직원 정보 
                
                        <!-- //직원 정보 -->

                        <!-- 예시 -->
                        <!-- 
                        <tr>
                        <tr onclick="{함수}">
                            <td><input type="checkbox" name="" /></td>
                            <td class="td_align_top td_no_padding">
                                <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                            </td>
                            <td>
                                <p>{직원명 (부서/직급)}</p>
                                <p class="min font_subtle">{직책}</p>
                            </td>
                        </tr>
                        <tr>
                        <tr onclick="{함수}">
                            <td><input type="checkbox" name="" /></td>
                            <td class="td_align_top td_no_padding">
                                <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                            </td>
                            <td>
                                <p>{직원명 (부서/직급)}</p>
                                <p class="min font_subtle">{직책}</p>
                            </td>
                        </tr>
                         -->
                        <!-- //예시 -->

                        </tbody>
                    </table>
                    <hr class="separator" />
                </div>
            </div>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <button type="submit" form="hiddenMembersForm" class="btn_primary btn_full">추가하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_add')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_add')"></div>
</div>
<!-- //회의 참석자 추가하기 -->

<form id="hiddenMembersForm" action="project_team_member_add" method="POST">
    <input type="hidden" name="team_idx" value="${team_info.team_idx }">
</form>

<script src="resources/js/module_modal.js"></script>
<script>
//날짜 설정
const colupdate = "${team_info.calup_date}".split(" ")[0];
const deldate = "${team_info.deletion_date}".split(" ")[0];
document.getElementById("calup_date").value = colupdate;
document.getElementById("deletion_date").value = deldate;

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
            '<td onclick="fetchDeptMembers(' + upperDept.dept_idx + '); fetchDeptTeamMembers(' + upperDept.dept_idx+','+${team_info.team_idx} + '); getdept(' + upperDept.dept_idx + ');" class="tst_pointer">' + upperDept.dept_name + '</td>' +
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
                        '<td onclick="fetchDeptMembers(' + lowerDept.dept_idx + '); fetchDeptTeamMembers(' + lowerDept.dept_idx+','+${team_info.team_idx} + '); getdept(' + lowerDept.dept_idx + '); ">' + lowerDept.dept_name + '</td>' +
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
        },
        error: function(xhr, status, error) {
            console.error('부서원 정보 가져오기 실패:', error);
        }
    });
}

//프로젝트 팀원 아닌 부서원 목록 가져오기
function fetchDeptTeamMembers(deptIdx,teamIdx) {
	
	
    $.ajax({
        url: './get_dept_team_members.ajax', // 경로 설정 
        type: 'GET',
        data: { 
        	dept_idx: deptIdx,
        	team_idx: teamIdx}, // 서버로 전달할 데이터
        dataType: 'json',
        success: function(data) {
        	console.log(data);
           
            renderAddDeptMembers(data);
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
        		'<tr onclick="updateTeamLeader(' +
                "'" + member.empl_idx + "', '" + member.empl_name + "', '" + member.dept_name + "', '" + member.position_name + "'" +
                ')">' +
                '<td class="td_align_top td_no_padding">' +
                '<img src="' + profileImage + '" alt="' + member.empl_idx + '의 프로필 사진" class="approval_profile_image" />' +
                '</td>' +
                '<td>' +
                '<p>' + member.empl_name + ' (' + member.dept_name + '/' + member.position_name + ')</p>' +
                '<p class="min font_subtle">' + member.duty_name + '</p>' +
                '</td>' +
                '</tr>'
        );
    });
}

// 프로젝트 추가 부서원 목록
function renderAddDeptMembers(members) {
    var membersTable = $('#dept_member_add'); // 부서원 정보 표시할 테이블
    membersTable.empty(); // 기존 데이터를 초기화

    $.each(members, function(index, member) {
        // 프로필 이미지 처리
        var profileImage = member.empl_profile
            ? '/files/' + member.empl_profile
            : 'http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png';
        
        // 테이블 행 추가
        membersTable.append(
            '<tr onclick="">' +
            '<td><input type="checkbox" name="add_member" value="' + member.empl_idx + '" /></td>' +
                '<td class="td_align_top td_no_padding">' +
                    '<img src="' + profileImage + '" alt="' + member.empl_name + '의 프로필 사진" class="approval_profile_image" />' +
                '</td>' +
                '<td>' +
                    '<p>' + member.empl_name + ' (' + member.dept_name + '/' + member.position_name + ')</p>' +
                    '<p class="min font_subtle">' + member.duty_name + '</p>' +
                '</td>' +
            '</tr>'
        );
    });
}
// 클릭시 팀장 정보 바꾸기
function updateTeamLeader(id, name, dept, position) {
    // 팀장 정보 업데이트
    document.querySelector("input[name='team_head_idx']").value = id; // 팀장 ID
    document.querySelector("input[name='team_head_info']").value = name + " (" + dept + "/" + position + ")"; // 팀장 이름 및 직책
    console.log("팀장 정보 업데이트: ", id, name, dept, position);
}

function getdept(deptidx){
	 $('#dept_idx').val(deptidx);
}

// 프로젝트 팀원 추가 검색 아작스
$(document).ready(function () {
    // 검색 버튼 클릭 이벤트
    $('#searchButton').on('click', function (e) {
    	console.log("검색 함수 실행");
    	
        e.preventDefault(); // 기본 동작 방지

        // 폼 데이터 수집
        var deptIdx = $('#dept_idx').val(); // 숨겨진 부서 ID
        var category = $('#tst_search_select_category_pro').val(); // 선택된 검색 분류
        var keyword = $('#keyword_pro').val(); // 입력된 검색어
        
        
        
        console.log("deptIdx:",deptIdx);
        console.log("category:",category);
        console.log("keyword:",keyword);
			
        // AJAX 요청
        $.ajax({
            url: 'get_dept_search_member.ajax', // 서버 URL
            type: 'POST', // 요청 방식
            data: {
                dept_idx: deptIdx,
                category: category,
                team_idx: team_idx,
                keyword: keyword
            },
            dataType: 'json', // 서버에서 JSON 응답을 받음
            success: function (response) {
                console.log('검색 결과:', response);
             //   renderSearchResults(response); // 결과 렌더링 함수 호출
            },
            error: function (xhr, status, error) {
                console.error('검색 실패:', error);
            }
        });
    });
    
    
    });
// 검색 프로젝트원 목록
function renderSearchResults(members){
	 var membersTable = $('#dept_member_add'); // 부서원 정보 표시할 테이블
	    membersTable.empty(); // 기존 데이터를 초기화

	    $.each(members, function(index, member) {
	        // 프로필 이미지 처리
	        var profileImage = member.empl_profile
	            ? '/files/' + member.empl_profile
	            : 'http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png';
	        
	        // 테이블 행 추가
	        membersTable.append(
	            '<tr onclick="someFunction(' + member.empl_idx + ')">' +
	                '<td><input type="checkbox" name="add_member" /></td>' +
	                '<td class="td_align_top td_no_padding">' +
	                    '<img src="' + profileImage + '" alt="' + member.empl_name + '의 프로필 사진" class="approval_profile_image" />' +
	                '</td>' +
	                '<td>' +
	                    '<p>' + member.empl_name + ' (' + member.dept_name + '/' + member.position_name + ')</p>' +
	                    '<p class="min font_subtle">' + member.duty_name + '</p>' +
	                '</td>' +
	            '</tr>'
	        );
	    });
}

//체크박스 상태 변경 시 hidden 필드를 추가/제거
$(document).on('change', 'input[name="add_member"]', function () {
    var memberId = $(this).val(); // 체크박스의 value 값 (empl_idx)
    var hiddenForm = $('#hiddenMembersForm'); // 폼 태그 선택

    if ($(this).is(':checked')) {
        // 체크된 경우 hidden 필드 추가
        hiddenForm.append('<input type="hidden" name="members" value="' + memberId + '" id="hidden_member_' + memberId + '" />');
    } else {
        // 체크 해제된 경우 해당 hidden 필드 제거
        $('#hidden_member_' + memberId).remove();
    }
});

// 팀원 방출
function removeTeamMember() {
    // 입력값 가져오기
    var memberIdx = document.getElementById("member_idx").value;
    var teamIdx = document.getElementById("team_idx_del").value;

    if (!memberIdx || !teamIdx) {
        alert("팀원 정보가 올바르지 않습니다.");
        return;
    }

    // AJAX 요청
    $.ajax({
        url: './remove_team_member', // 컨트롤러 URL 경로
        type: 'POST',
        data: {
            member_idx: memberIdx,
            team_idx: teamIdx
        },
        success: function(response) {
            if (response.success) {
                alert("팀원이 성공적으로 방출되었습니다.");
                // 모달 닫기 및 목록 새로고침
                tst_modal_close('tst_modal_delete');
                location.reload(); // 페이지 새로고침 (필요 시 다른 방법으로 UI 업데이트 가능)
            } else {
                alert("팀원 방출에 실패하였습니다: " + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error("팀원 방출 중 오류 발생:", error);
            alert("팀원 방출 중 문제가 발생했습니다.");
        }
    });
}

// 초기 데이터 로드
fetchAndRenderDeptList();



</script>


<script src="resources/js/approval_send_modal.js"></script>