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
        <form>
            <div class="tst_modal_body">
                <ul class="list_no_desc list_block">
                    <li>
                        <label class="form_label">프로젝트 팀명</label>
                        <input type="text" name="" maxlength="100" value="${team_info.team_name}" placeholder="팀명을 입력하세요" />
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
                        <tbody class="tst_pointer"  id="team_dept">
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

                        <!-- 직원 정보 -->
                        <tr>
                            <!-- 직원을 결재선 혹은 참조에 추가하는 함수를 입력하세요 --><tr onclick="{함수}">
                            <td class="td_align_top td_no_padding">
                                <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                            </td>
                            <td>
                                <p>{직원명 (부서/직급)}</p>
                                <p class="min font_subtle">{직책}</p>
                            </td>
                        </tr>
                        <!-- //직원 정보 -->

                        <!-- 예시 -->
                        <tr>
                        <tr onclick="{함수}">
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
                            <td class="td_align_top td_no_padding">
                                <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                            </td>
                            <td>
                                <p>{직원명 (부서/직급)}</p>
                                <p class="min font_subtle">{직책}</p>
                            </td>
                        </tr>
                        <!-- //예시 -->

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
                    <button onclick="<!-- 팀원을 내보내는 함수를 입력하세요 -->" class="btn_primary btn_full">팀원 내보내기</button>
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
                        <tbody class="tst_pointer">
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
                    <form>
                        <div class="tst_search_container">
                            <div class="tst_search_select">
                                <select id="tst_search_select_category" name="category">
                                    <option value="{검색 분류}">검색 분류</option>
                                </select>
                            </div>
                            <div class="tst_search_input">
                                <input type="text" name="keyword" maxlength="50" placeholder="검색어를 입력하세요" />
                            </div>
                            <div class="tst_search_icon">
                                <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
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

                        <tbody class="tst_pointer" >

                        <!-- 직원 정보 -->
                        <tr>
                            <!-- 직원을 결재선 혹은 참조에 추가하는 함수를 입력하세요 --><tr onclick="{함수}">
                            <td><input type="checkbox" name="" /></td>
                            <td class="td_align_top td_no_padding">
                                <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                            </td>
                            <td>
                                <p>{직원명 (부서/직급)}</p>
                                <p class="min font_subtle">{직책}</p>
                            </td>
                        </tr>
                        <!-- //직원 정보 -->

                        <!-- 예시 -->
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
                    <button onclick="<!-- 팀원을 추가하는 함수를 입력하세요 -->" class="btn_primary btn_full">추가하기</button>
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

<script src="resources/js/module_modal.js"></script>
<script>
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
    var tbody = $('#team_dept'); // jQuery를 사용해 요소 선택
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

//부서원 정보 가져오기
function fetchDeptMembers(deptIdx) {
    $.ajax({
        url: './get_dept_members.ajax', // 경로 설정 
        type: 'GET',
        data: { dept_idx: deptIdx }, // 서버로 전달할 데이터
        dataType: 'json',
        success: function(data) {
        	console.log(data);
            renderDeptMembers(data); // 부서원 정보 렌더링
        },
        error: function(xhr, status, error) {
            console.error('부서원 정보 가져오기 실패:', error);
        }
    });
}

//부서원 정보 렌더링
function renderDeptMembers(members) {
    var membersTable = $('#dept_member'); // 부서원 정보 표시할 테이블
    membersTable.empty(); // 기존 데이터를 초기화

    $.each(members, function(index, member) {
    	 var profileImage = member.empl_profile
         ? '/files/' + member.empl_profile
         : 'http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png';
        membersTable.append(
        		'<tr onclick="' + member.empl_idx + '">' +
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


// 초기 데이터 로드
fetchAndRenderDeptList();

</script>


<script src="resources/js/approval_send_modal.js"></script>