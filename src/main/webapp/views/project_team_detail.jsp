<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/manage_rent.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_table.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/approval.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/organization.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="resources/js/jquery.twbsPagination.js"></script>
</head>
<body>
<c:import url="layout_topnav.jsp" />
<div class="tst_container">
    <c:import url="layout_leftnav.jsp" />
    <div class="tst_container_right">
        <div class="tst_contents">
            <div class="tst_contents_inner">

                <!-- 제목 -->
                <ul class="tst_title list_no_desc list_inline">
                    <li class="tst_title_item" onclick="location.href='/organization_list'">
                        <h1>부서 관리</h1>
                    </li>
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/project_team_list'">
                        <h1>프로젝트 팀 관리</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">

                    <div class="tst_col3">

                        <!-- 프로젝트 팀 정보 -->
                        <table class="tst_table table_align_left table_no_padding">
                            <colgroup>
                                <col style="width: 100px" />
                                <col style="width: auto" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">프로젝트 팀 정보</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>팀명</th>
                                <td>${team_info.team_name}</td>
                            </tr>
                            <tr>
                                <th>팀장</th>
                                <td><span onclick="tst_view_profile('${team_info.team_head_idx}')" class="tst_pointer">${team_info.head_name} (${team_info.head_dept_name}/${team_info.head_position_name})</span></td>
                            </tr>
                            <tr>
                                <th>직무</th>
                                <td>${team_info.team_duty}</td>
                            </tr>
                            <tr>
                                <th>팀원 수</th>
                                <td>${team_info.team_member_count}명</td>
                            </tr>
                            <tr>
                                <th>운영 기간</th>
                                <td>${team_info.calup_date} ~ ${team_info.deletion_date}</td>
                            </tr>
                            </tbody>

                            <!-- 아래 버튼은 프로젝트 운영 기간 중에만 출력해야 합니다 -->
                            <tfoot>
                            <tr>
                                <td colspan="2">
                                    <button onclick="tst_modal_call('tst_modal_update')" class="btn_primary btn_full">프로젝트 팀 정보 수정하기</button>
                                </td>
                            </tr>
                            </tfoot>
                            <!-- //위 버튼은 프로젝트 운영 기간 중에만 출력해야 합니다 -->

                        </table>
                        <hr class="separator" />
                        <!-- //프로젝트 팀 정보 -->

                        <!-- 프로젝트 팀장 변경 이력 -->
                        <table class="tst_table">
                            <colgroup>
                                <col style="width: 60px;" />
                                <col style="width: auto;" />
                                <col style="width: 110px;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>조직장</th>
                                <th>발령일</th>
                            </tr>
                            </thead>
                            <tbody id="project_leader_history">
                              <c:forEach var="his" items="${team_his}" varStatus="status">
                              <tr> 
                                <td>${status.index + 1}</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('${his.team_head_idx}')" class="tst_pointer">${his.head_name } (${his.head_dept_name }/${his.head_position_name })</span></td>
                                <td>${his.change_log_time}</td>
                              </tr>
                              </c:forEach>
                            
                           
                            </tbody>
                        </table>
                        <!-- //프로젝트 팀장 변경 이력 -->

                    </div>
                    <div class="tst_col9">

                        <table class="tst_table table_no_padding table_no_underline">
                            <tr>
                                <td class="td_align_bottom">

                                    <!-- 프로젝트 팀원 검색 -->
                                    <form id="searchMemberForm">
                                    	<input type="hidden" id="team_idx_mem" name="team_idx" value="${team_info.team_idx}" />
                                        <div class="tst_search_container">
                                            <div class="tst_search_select">
                                                <select id="tst_search_select_category_mem" name="category">
                                                    <option value="{검색 분류}">검색 분류</option>
                                                    <option value="empl_name">이름</option>
                                                </select>
                                            </div>
                                            <div class="tst_search_input">
                                                <input type="text" name="keyword_class" id="keyword_mem" maxlength="50" class="input_min input_underline" placeholder="검색어를 입력하세요" />
                                            </div>
                                            <div class="tst_search_icon">
                                                <button type="button" class="btn_icon" id="searchMemberButton"><i class="bi bi-search"></i></button>
                                            </div>
                                        </div>
                                    </form>
                                    <!-- //프로젝트 팀원 검색 -->

                                </td>
                                <td class="td_align_right posit_relative">

                                    <!-- 팀원 추가 -->
                                    <button onclick="tst_modal_call('tst_modal_add')" class="btn_primary">팀원 추가하기</button>
                                    <!-- //팀원 추가 -->

                                </td>
                            </tr>
                        </table>

                        <!-- 프로젝트 팀원 목록 -->
                        <table class="tst_table">
                            <colgroup>
                                <col style="width: 60px;" />
                                <col style="width: 120px;" />
                                <col style="width: 180px;" />
                                <col style="width: auto;" />
                                <col style="width: 130px;" />
                                <col style="width: 130px;" />
                                <col style="width: 60px;" />
                                <col style="width: 40px;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>직원</th>
                                <th>소속 조직</th>
                                <th>직무</th>
                                <th>발령일</th>
                                <th>전출일</th>
                                <th>현재 상태</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody id="project_member">

                            <!-- 프로젝트 팀원이 없을 경우 -->
                            <!-- 데이터가 없는 경우 -->
						    <c:if test="${empty team_members}">
						        <tr class="rent_history_no_data">
						            <td colspan="8" class="td_no_data">
						                <p><i class="bi bi-person-exclamation"></i></p>
						                <h3>검색 조건에 해당하는 팀원이 없습니다.</h3>
						            </td>
						        </tr>
						    </c:if>
                            <!-- //프로젝트 팀원이 없을 경우 -->

                            <!-- 프로젝트 팀원 목록 -->

                            <!-- 프로젝트 팀원 목록 > 팀장 > 팀 소속 -->
                           <c:forEach var="member" items="${team_members}" varStatus="status">
						        <tr>
						            <td>${status.index + 1}</td>
						            <td class="td_align_left">
						                <span onclick="tst_view_profile('${member.empl_idx}')" class="tst_pointer">
						                    ${member.empl_name} (${member.position_name})
						                </span>
						            </td>
						            <td class="td_align_left">${member.dept_name}</td>
						            <td class="td_align_left">${member.empl_job}</td>
						            <td>${member.movein_date}</td>
						            <td>${member.transfer_date == null ? '없음' : member.transfer_date}</td>
						            <td>
						                <span class="tst_badge_min ${member.transfer_date ==null ?'btn_secondary' : 'btn_disable'  }">
						                    ${member.transfer_date ==null ? '팀 소속':'소속 아님'}
						                </span>
						            </td>
						            <td>
						              <c:if test="${member.transfer_date == null}">
						            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_call_param_custom('tst_modal_delete', '${member.empl_idx}','${member.empl_name}','${member.position_name}')"></i>
						            </c:if>
						            </td>
						            
						        </tr>
						    </c:forEach>
                            </tbody>

                        </table>
                        <!-- //프로젝트 팀원 목록 -->

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<c:import url="project_team_detail_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script>
function tst_modal_call_param_custom(modalId, memberId, memberName, memberPosition) {
    // 기존 모달 호출 유지
    tst_modal_call_param(modalId, memberId);

    // 추가 데이터 설정
      document.getElementById("member_idx").value = memberId;
    var memberElement = document.getElementById("prod_name");
    memberElement.textContent = memberName + " (" + memberPosition + ")"; // 이름과 직책 설정
}

$(document).ready(function () {
    $('#searchMemberButton').on('click', function (e) {
        e.preventDefault();

        // 입력 값 가져오기
        const category = $('#tst_search_select_category_mem').val();
        const keyword = $('#keyword_mem').val();
		const teamIdx = $('#team_idx_mem').val();
        
		console.log(teamIdx);
        
        if (!category || !keyword) {
            alert('검색 분류와 검색어를 입력하세요.');
            return;
        }

        // AJAX 요청
        $.ajax({
            url: './search_project_team_members.ajax', // 서버의 검색 API 엔드포인트
            type: 'POST',
            data:{
                category: category,
                keyword: keyword,
                team_idx: teamIdx
            },
            dataType: 'json',
            success: function (response) {
                // 검색 결과 렌더링
                renderProjectMembers(response);
            },
            error: function (xhr, status, error) {
                console.error('검색 실패:', error);
                alert('검색 중 문제가 발생했습니다. 다시 시도해주세요.');
            }
        });
    });
});

//검색 결과 렌더링 함수
function renderProjectMembers(data) {
    const projectMemberContainer = $('#project_member');
    projectMemberContainer.empty(); // 기존 결과 초기화

    if (data.length === 0) {
        projectMemberContainer.append(
            '<tr class="rent_history_no_data">' +
            '<td colspan="8" class="td_no_data">' +
            '<p><i class="bi bi-person-exclamation"></i></p>' +
            '<h3>검색 조건에 해당하는 팀원이 없습니다.</h3>' +
            '</td>' +
            '</tr>'
        );
        return;
    }

    data.forEach(function (member, index) {
        projectMemberContainer.append(
            '<tr>' +
            '<td>' + (index + 1) + '</td>' +
            '<td class="td_align_left">' +
            '<span onclick="tst_view_profile(\'' + member.empl_idx + '\')" class="tst_pointer">' +
            member.empl_name + ' (' + member.position_name + ')' +
            '</span>' +
            '</td>' +
            '<td class="td_align_left">' + member.dept_name + '</td>' +
            '<td class="td_align_left">' + member.empl_job + '</td>' +
            '<td>' + member.movein_date + '</td>' +
            '<td>' + (member.transfer_date ? member.transfer_date : '없음') + '</td>' +
            '<td>' +
            '<span class="tst_badge_min ' + (member.transfer_date == null ? 'btn_secondary' : 'btn_disable') + '">' +
            (member.transfer_date == null ? '팀 소속' : '소속 아님') +
            '</span>' +
            '</td>' +
            '<td>' +
            (member.transfer_date == null
                ? '<i class="bi bi-dash-circle-dotted" onclick="tst_modal_call_param_custom(\'tst_modal_delete\', \'' + member.empl_idx + '\', \'' + member.empl_name + '\', \'' + member.position_name + '\')"></i>'
                : '') +
            '</td>' +
            '</tr>'
        );
    });
}
</script>


</html>