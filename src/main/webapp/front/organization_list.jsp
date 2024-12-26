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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/organization_tree'">
                        <h1>부서 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href=''">
                        <h1>프로젝트 팀 관리</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <!-- 차트 -->
                <table class="tst_table">
                    <thead>
                    <tr><th>조직도</th></tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <div class="chart_wrapper">
                                <!-- Chart Box -->
                                <div class="chart-box">
                                    <div id="chart_div"></div>
                                </div>
                                <!-- //Chart Box -->
                            </div>

                        </td>
                    </tr>
                    </tbody>
                </table>
                <hr class="separator" />
                <!-- //차트 -->

                <table class="tst_table table_no_padding table_no_underline">
                    <tr>
                        <td class="td_align_bottom">

                            <!-- 검색 -->
                            <form>
                                <div class="tst_search_container">
                                    <div class="tst_search_select">
                                        <select id="tst_search_select_category" name="category" onchange="location.href='/manage_rent_list'">
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
                            <!-- 조직 추가 -->
                            <button onclick="tst_modal_call('tst_modal_write')" class="btn_primary">조직 추가하기</button>
                            <!-- //조직 추가 -->

                        </td>
                    </tr>
                </table>

                <!-- 표 -->
                <table class="tst_table">
                    <colgroup>
                        <col style="width: 16px" />
                        <col style="width: 120px" />
                        <col style="width: 150px" />
                        <col style="width: 180px" />
                        <col style="width: 220px" />
                        <col style="width: 120px" />
                        <col style="width: auto" />
                        <col style="width: 180px" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th colspan="2">조직명</th>
                        <th>조직장</th>
                        <th>조직장 연락처</th>
                        <th>조직장 이메일</th>
                        <th>소속 인원</th>
                        <th>담당 직무</th>
                        <th>위치</th>
                    </tr>
                    </thead>
                    <tbody>

                    <!-- 부서 출력 -->
                    <tr class="td_bg_subtle">
                        <th><i class="bi bi-folder"></i></th>
                        <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">{부서명}</th>
                        <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{부서장} ({직급})</span></td>
                        <td>{부서장 연락처}</td>
                        <td>{부서장 이메일}</td>
                        <td>{소속 인원}명</td>
                        <td class="td_align_left">{부서 담당 직무}</td>
                        <td>{부서 위치}</td>
                    </tr>
                    <tr>
                        <td colspan="8" class="td_no_padding">

                            <!-- 소속 팀 출력 -->
                            <table class="tst_table tst_table_in_table">
                                <colgroup>
                                    <col style="width: 16px" />
                                    <col style="width: 120px" />
                                    <col style="width: 150px" />
                                    <col style="width: 180px" />
                                    <col style="width: 220px" />
                                    <col style="width: 120px" />
                                    <col style="width: auto" />
                                    <col style="width: 180px" />
                                </colgroup>
                                <tr>
                                    <th>├</th>
                                    <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">{팀명}</th>
                                    <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{팀장} ({직급})</span></td>
                                    <td>{팀장 연락처}</td>
                                    <td>{팀장 이메일}</td>
                                    <td>{소속 인원}명</td>
                                    <td class="td_align_left">{팀 담당 직무}</td>
                                    <td>{팀 위치}</td>
                                </tr>
                                <tr>
                                    <th>└</th><!-- '.tst_table_in_table tr:last-child'의 innerHTML을 '└'으로 바꾸시면 됩니다 -->
                                    <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">{팀명}</th>
                                    <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{팀장} ({직급})</span></td>
                                    <td>{팀장 연락처}</td>
                                    <td>{팀장 이메일}</td>
                                    <td>{소속 인원}명</td>
                                    <td class="td_align_left">{팀 담당 직무}</td>
                                    <td>{팀 위치}</td>
                                </tr>
                            </table>
                            <!-- //소속 팀 출력 -->
                        </td>
                    </tr>
                    <!-- //부서 출력 -->

                    <!-- 예시 -->
                    <tr class="td_bg_subtle">
                        <th><i class="bi bi-folder"></i></th>
                        <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">프로그래밍</th>
                        <td class="td_align_left"><span onclick="tst_view_profile('10052')" class="tst_pointer">서연진 (차장)</span></td>
                        <td>02-2345-6789</td>
                        <td>member@toastgames.com</td>
                        <td>8명</td>
                        <td class="td_align_left">엔진 개발, 게임 콘텐츠 개발, 유지 보수시 이슈 처리, 프로그래밍</td>
                        <td>5층 503-5호</td>
                    </tr>
                    <tr>
                        <td colspan="8" class="td_no_padding">
                            <table class="tst_table tst_table_in_table">
                                <colgroup>
                                    <col style="width: 16px" />
                                    <col style="width: 120px" />
                                    <col style="width: 150px" />
                                    <col style="width: 180px" />
                                    <col style="width: 220px" />
                                    <col style="width: 120px" />
                                    <col style="width: auto" />
                                    <col style="width: 180px" />
                                </colgroup>
                                <tr>
                                    <th>├</th>
                                    <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">게임엔진</th>
                                    <td class="td_align_left"><span onclick="tst_view_profile('10060')" class="tst_pointer">김인하 (과장)</span></td>
                                    <td>02-2345-6789</td>
                                    <td>member@toastgames.com</td>
                                    <td>3명</td>
                                    <td class="td_align_left">게임엔진 개발</td>
                                    <td>5층 503호</td>
                                </tr>
                                <tr>
                                    <th>├</th>
                                    <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">게임플레이</th>
                                    <td class="td_align_left"><span onclick="tst_view_profile('10059')" class="tst_pointer">박사금 (과장)</span></td>
                                    <td>02-2345-6789</td>
                                    <td>member@toastgames.com</td>
                                    <td>3명</td>
                                    <td class="td_align_left">QA 및 테스트</td>
                                    <td>5층 503호</td>
                                </tr>
                                <tr>
                                    <th>└</th>
                                    <th class="td_align_left tst_pointer" onclick="location.href='/organization_detail?'">DBA</th>
                                    <td class="td_align_left"><span onclick="tst_view_profile('10064')" class="tst_pointer">주차장 (과장)</span></td>
                                    <td>02-2345-6789</td>
                                    <td>member@toastgames.com</td>
                                    <td>2명</td>
                                    <td class="td_align_left">데이터베이스 관리</td>
                                    <td>5층 504호</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <!-- //예시 -->

                    </tbody>
                </table>
                <!-- //표 -->

            </div>
        </div>
    </div>
</div>
<c:import url="organization_list_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/organization_list.js"></script>
</html>