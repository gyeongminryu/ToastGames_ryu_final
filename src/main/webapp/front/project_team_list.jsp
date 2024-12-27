<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_table.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_tree.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/organization.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/approval.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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

                <table class="tst_table table_no_padding table_no_underline">
                    <tr>
                        <td class="td_align_bottom">

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

                        </td>
                        <td class="td_align_right posit_relative">

                            <!-- 프로젝트 팀 추가 -->
                            <button onclick="tst_modal_call('tst_modal_write')" class="btn_primary">프로젝트 팀 추가하기</button>
                            <!-- //프로젝트 팀 추가 -->

                        </td>
                    </tr>
                </table>

                <!-- 표 -->
                <table class="tst_table">
                    <colgroup>
                        <col style="width: 80px" />
                        <col style="width: 180px" />
                        <col style="width: 180px" />
                        <col style="width: 160px" />
                        <col style="width: 200px" />
                        <col style="width: 100px" />
                        <col style="width: auto" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th></th>
                        <th>팀명</th>
                        <th>팀장</th>
                        <th>팀장 연락처</th>
                        <th>팀장 이메일</th>
                        <th>소속 인원</th>
                        <th>담당 직무</th>
                    </tr>
                    </thead>
                    <tbody>

                    <!-- 프로젝트 팀 > 운영중 -->
                    <tr>
                        <td class="td_no_padding td_align_left"><span class="tst_badge_min btn_secondary">운영중</span></td>
                        <th class="td_align_left tst_pointer" onclick="location.href='/project_team_detail?'">{팀명}</th>
                        <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{팀장} ({소속부서|팀}/{직급})</span></td>
                        <td>{팀장 연락처}</td>
                        <td>{팀장 이메일}</td>
                        <td>{소속 인원}명</td>
                        <td class="td_align_left">{팀 담당 직무}</td>
                    </tr>
                    <!-- //프로젝트 팀 > 운영중 -->

                    <!-- 프로젝트 팀 > 운영 종료 -->
                    <tr>
                        <td class="td_no_padding td_align_left"><span class="tst_badge_min btn_subtle">운영 종료</span></td>
                        <th class="td_align_left tst_pointer" onclick="location.href='/project_team_detail?'">{팀명}</th>
                        <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{팀장} ({소속부서|팀}/{직급})</span></td>
                        <td>{팀장 연락처}</td>
                        <td>{팀장 이메일}</td>
                        <td>{소속 인원}명</td>
                        <td class="td_align_left">{팀 담당 직무}</td>
                    </tr>
                    <!-- //프로젝트 팀 > 운영 종료 -->

                    <!-- 예시 -->
                    <tr>
                        <td class="td_no_padding td_align_left"><span class="tst_badge_min btn_secondary">운영중</span></td>
                        <th class="td_align_left tst_pointer" onclick="location.href='/project_team_detail?'">토스트 타이쿤 2</th>
                        <td class="td_align_left"><span onclick="tst_view_profile('10052')" class="tst_pointer">서연진 (프로그래밍 부/차장)</span></td>
                        <td>02-2345-6789</td>
                        <td>member@toastgames.com</td>
                        <td>12명</td>
                        <td class="td_align_left">토스트 가게를 운영하는 게임 토스트 타이쿤의 차기작 개발</td>
                    </tr>
                    <tr>
                        <td class="td_no_padding td_align_left"><span class="tst_badge_min btn_secondary">운영중</span></td>
                        <th class="td_align_left tst_pointer" onclick="location.href='/project_team_detail?'">놀러 와요 토스트 숲</th>
                        <td class="td_align_left"><span onclick="tst_view_profile('10060')" class="tst_pointer">김인하 (게임엔진 팀/과장)</span></td>
                        <td>02-2345-6789</td>
                        <td>member@toastgames.com</td>
                        <td>13명</td>
                        <td class="td_align_left">농사, 목축, 낚시 등 힐링 컨텐츠를 제공하는 게임 놀러 와요 토스트 숲 개발</td>
                    </tr>
                    <tr>
                        <td class="td_no_padding td_align_left"><span class="tst_badge_min btn_secondary">운영중</span></td>
                        <th class="td_align_left tst_pointer" onclick="location.href='/project_team_detail?'">웹사이트 차세대</th>
                        <td class="td_align_left"><span onclick="tst_view_profile('10059')" class="tst_pointer">박사금 (게임플레이 팀/과장)</span></td>
                        <td>02-2345-6789</td>
                        <td>member@toastgames.com</td>
                        <td>5명</td>
                        <td class="td_align_left">토스트게임즈의 웹사이트 차세대 버전 개발</td>
                    </tr>
                    <tr>
                        <td class="td_no_padding td_align_left"><span class="tst_badge_min btn_secondary">운영중</span></td>
                        <th class="td_align_left tst_pointer" onclick="location.href='/project_team_detail?'">그룹웨어 차세대</th>
                        <td class="td_align_left"><span onclick="tst_view_profile('10064')" class="tst_pointer">주차장 (DBA 팀/과장)</span></td>
                        <td>02-2345-6789</td>
                        <td>member@toastgames.com</td>
                        <td>5명</td>
                        <td class="td_align_left">토스트게임즈의 그룹웨어 차세대 버전 개발</td>
                    </tr>
                    <tr class="font_subtle">
                        <td class="td_no_padding td_align_left"><span class="tst_badge_min btn_subtle">운영 종료</span></td>
                        <th class="td_align_left tst_pointer" onclick="location.href='/project_team_detail?'">토스트 타이쿤</th>
                        <td class="td_align_left"><span onclick="tst_view_profile('10052')" class="tst_pointer">서연진 (프로그래밍 부/차장)</span></td>
                        <td>02-2345-6789</td>
                        <td>member@toastgames.com</td>
                        <td>12명</td>
                        <td class="td_align_left">토스트 가게를 운영하는 게임 토스트 타이쿤 개발</td>
                    </tr>
                    <!-- //예시 -->

                    </tbody>
                </table>
                <!-- //표 -->

            </div>
        </div>
    </div>
</div>
<c:import url="project_team_list_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
</html>