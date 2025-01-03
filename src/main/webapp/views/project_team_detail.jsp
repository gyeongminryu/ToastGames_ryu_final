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
                            <tbody>
                            <tr>
                                <td>{번호}</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></td>
                                <td>{발령일|yyyy-MM-dd}</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('10052')" class="tst_pointer">서연진 (프로그래밍 부/차장)</span></td>
                                <td>2020-01-02</td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //프로젝트 팀장 변경 이력 -->

                    </div>
                    <div class="tst_col9">

                        <table class="tst_table table_no_padding table_no_underline">
                            <tr>
                                <td class="td_align_bottom">

                                    <!-- 프로젝트 팀원 검색 -->
                                    <form>
                                        <div class="tst_search_container">
                                            <div class="tst_search_select">
                                                <select id="tst_search_select_category" name="category">
                                                    <option value="{검색 분류}">검색 분류</option>
                                                </select>
                                            </div>
                                            <div class="tst_search_input">
                                                <input type="text" name="keyword_class" maxlength="50" class="input_min input_underline" placeholder="검색어를 입력하세요" />
                                            </div>
                                            <div class="tst_search_icon">
                                                <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
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
                            <tbody>

                            <!-- 프로젝트 팀원이 없을 경우 -->
                            <tr class="rent_history_no_data"><!-- 데이터가 있을 경우 클래스 disp_hide를 추가하세요. -->
                                <td colspan="8" class="td_no_data">
                                    <p><i class="bi bi-person-exclamation"></i></p>
                                    <h3>검색 조건에 해당하는 팀원이 없습니다.</h3>
                                </td>
                            </tr>
                            <!-- //프로젝트 팀원이 없을 경우 -->

                            <!-- 프로젝트 팀원 목록 -->

                            <!-- 프로젝트 팀원 목록 > 팀장 > 팀 소속 -->
                            <tr class="td_bg_subtle"><!-- 팀장은 tr에 클래스 'td_bg_subtle'를 추가하세요 -->
                                <td>{번호}</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({직급})</span></td>
                                <td class="td_align_left">{소속 조직} (부서장|팀장)</td>
                                <td class="td_align_left">{직무}</td>
                                <td>{발령일|yyyy-MM-dd}</td>
                                <td>없음</td>
                                <td><span class="tst_badge_min btn_secondary">팀 소속</span></td>
                                <td><!-- 팀장은 삭제할 수 없습니다. --></td>
                            </tr>
                            <!-- //프로젝트 팀원 목록 > 팀장 > 팀 소속 -->

                            <!-- 프로젝트 팀원 목록 > 팀장 > 팀 소속 아님 -->
                            <tr class="td_bg_subtle"><!-- 팀장은 tr에 클래스 'td_bg_subtle'를 추가하세요 -->
                                <td>{번호}</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({직급})</span></td>
                                <td class="td_align_left">{소속 조직} (부서장|팀장)</td>
                                <td class="td_align_left">{직무}</td>
                                <td>{발령일|yyyy-MM-dd}</td>
                                <td>{전출일|yyyy-MM-dd}</td>
                                <td><span class="tst_badge_min btn_disable">소속 아님</span></td>
                                <td><!-- 팀 소속이 아닌 직원은 삭제할 수 없습니다. --></td>
                            </tr>
                            <!-- //프로젝트 팀원 목록 > 팀장 > 팀 소속 아님 -->

                            <!-- 프로젝트 팀원 목록 > 팀원 > 팀 소속 -->
                            <tr>
                                <td>{번호}</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({직급})</span></td>
                                <td class="td_align_left">{소속 조직}</td>
                                <td class="td_align_left">{직무}</td>
                                <td>{발령일|yyyy-MM-dd}</td>
                                <td>없음</td>
                                <td><span class="tst_badge_min btn_secondary">팀 소속</span></td>
                                <td><i class="bi bi-dash-circle-dotted" onclick="tst_modal_call_param('tst_modal_delete', '{직원 번호}')"></i></td>
                            </tr>
                            <!-- //프로젝트 팀원 목록 > 팀원 > 팀 소속 -->

                            <!-- 프로젝트 팀원 목록 > 팀원 > 팀 소속 아님 -->
                            <tr class="font_subtle">
                                <td>{번호}</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({직급})</span></td>
                                <td class="td_align_left">{소속 조직}</td>
                                <td class="td_align_left">{직무}</td>
                                <td>{발령일|yyyy-MM-dd}</td>
                                <td>{전출일|yyyy-MM-dd}</td>
                                <td><span class="tst_badge_min btn_disable">소속 아님</span></td>
                                <td><!-- 팀 소속이 아닌 직원은 삭제할 수 없습니다. --></td>
                            </tr>
                            <!-- //프로젝트 팀원 목록 > 팀원 > 팀 소속 아님 -->

                            <!-- 예시 -->
                            <tr class="td_bg_subtle">
                                <td>24</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('10052')" class="tst_pointer">서연진 (차장)</span></td>
                                <td class="td_align_left">프로그래밍 부 (부서장)</td>
                                <td class="td_align_left">토스트 타이쿤 2 제작 관련 업무 전반 관리</td>
                                <td>2020-01-02</td>
                                <td>없음</td>
                                <td><span class="tst_badge_min btn_secondary">팀 소속</span></td>
                                <td><!-- 팀장은 삭제할 수 없습니다. --></td>
                            </tr>
                            <tr>
                                <td>23</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('10060')" class="tst_pointer">김인하 (과장)</span></td>
                                <td class="td_align_left">게임엔진 개발 (팀장)</td>
                                <td class="td_align_left">게임 엔진 개발 및 관련 업무 전반 관리</td>
                                <td>2020-01-02</td>
                                <td>없음</td>
                                <td><span class="tst_badge_min btn_secondary">팀 소속</span></td>
                                <td><i class="bi bi-dash-circle-dotted" onclick="tst_modal_call_param('tst_modal_delete', '124')"></i></td>
                            </tr>
                            <tr>
                                <td>22</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('')" class="tst_pointer">김이름 (대리)</span></td>
                                <td class="td_align_left">게임엔진 개발</td>
                                <td class="td_align_left">게임 엔진 개발</td>
                                <td>2020-01-02</td>
                                <td>없음</td>
                                <td><span class="tst_badge_min btn_secondary">팀 소속</span></td>
                                <td><i class="bi bi-dash-circle-dotted" onclick="tst_modal_call_param('tst_modal_delete', '123')"></i></td>
                            </tr>
                            <tr class="font_subtle">
                                <td>21</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('')" class="tst_pointer">김이름 (대리)</span></td>
                                <td class="td_align_left">게임엔진 개발</td>
                                <td class="td_align_left">게임 엔진 개발</td>
                                <td>2020-01-02</td>
                                <td>2020-03-02</td>
                                <td><span class="tst_badge_min btn_disable">소속 아님</span></td>
                                <td><!-- 팀 소속이 아닌 직원은 삭제할 수 없습니다. --></td>
                            </tr>
                            <!-- //예시 -->

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
</html>