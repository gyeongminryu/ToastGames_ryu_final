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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/organization_tree'">
                        <h1>부서 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href=''">
                        <h1>프로젝트 팀 관리</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">

                    <div class="tst_col3">

                        <!-- 조직 정보 -->
                        <table class="tst_table table_align_left table_no_padding">
                            <colgroup>
                                <col style="width: 100px" />
                                <col style="width: auto" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">조직 정보</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>조직명</th>
                                <td>{조직명}</td>
                            </tr>
                            <tr>
                                <th>조직 구분</th>
                                <td>부서|팀</td>
                            </tr>
                            <tr>
                                <th>조직장</th>
                                <td><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({직급})</span></td>
                            </tr>
                            <tr>
                                <th>직무</th>
                                <td>{직무}</td>
                            </tr>
                            <tr>
                                <th>소속 부서</th>
                                <td>{소속 부서}</td>
                            </tr>
                            <tr>
                                <th>조직원 수</th>
                                <td>{조직원 수}명</td>
                            </tr>
                            <tr>
                                <th>위치</th>
                                <td>{위치}</td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //조직 정보 -->

                        <hr class="separator" />

                    </div>
                    <div class="tst_col9">

                        <!-- 대여 이력 -->
                        <table class="tst_table">
                            <colgroup>
                                <col style="width: 60px;" />
                                <col style="width: 160px;" />
                                <col style="width: auto;" />
                                <col style="width: 110px;" />
                                <col style="width: 110px;" />
                                <col style="width: 110px;" />
                                <col style="width: 110px;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>대여자</th>
                                <th>대여 사유</th>
                                <th>대여일</th>
                                <th>반납 기한</th>
                                <th>반납일</th>
                                <th>반납 여부</th>
                            </tr>
                            </thead>
                            <tbody>

                            <!-- 대여 내역이 없을 경우 -->
                            <tr class="rent_history_no_data"><!-- 데이터가 있을 경우 클래스 disp_hide를 추가하세요. -->
                                <td colspan="7" class="td_no_data">
                                    <p><i class="bi bi-box-seam"></i></p>
                                    <h3>검색 조건에 해당하는 공용 물품이 없습니다.</h3>
                                </td>
                            </tr>
                            <!-- //대여 내역이 없을 경우 -->

                            <!-- 대여 내역 > 대여중인 물품 -->
                            <tr>
                                <td>{번호}</td>
                                <td><h3><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></h3></td>
                                <td class="td_align_left">{대여 사유}</td>
                                <td>{대여일|yyyy-MM-dd}</td>
                                <td>{반납 기한|yyyy-MM-dd}</td>
                                <td><h3>대여중</h3></td>
                                <td><h3>대여중</h3></td>
                            </tr>
                            <!-- //대여 내역 > 대여중인 물품 -->

                            <!-- 대여 내역 > 연체중인 물품 -->
                            <tr>
                                <td>{번호}</td>
                                <td><h3><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></h3></td>
                                <td class="td_align_left">{대여 사유}</td>
                                <td>{대여일|yyyy-MM-dd}</td>
                                <td>{반납 기한|yyyy-MM-dd}</td>
                                <td>{반납일|yyyy-MM-dd}</td>
                                <td><h3 class="font_caution">연체</h3></td>
                            </tr>
                            <!-- //대여 내역 > 연체중인 물품 -->

                            <!-- 대여 내역 > 기한 내에 반납한 물품 -->
                            <tr>
                                <td>{번호}</td>
                                <td><h3><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></h3></td>
                                <td class="td_align_left">{대여 사유}</td>
                                <td>{대여일|yyyy-MM-dd}</td>
                                <td>{반납 기한|yyyy-MM-dd}</td>
                                <td>{반납일|yyyy-MM-dd}</td>
                                <td>정상 반납</td>
                            </tr>
                            <!-- //대여 내역 > 기한 내에 반납한 물품 -->

                            <!-- 대여 내역 > 연체 후 반납한 물품 -->
                            <tr>
                                <td>{번호}</td>
                                <td><h3><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></h3></td>
                                <td class="td_align_left">{대여 사유}</td>
                                <td>{대여일|yyyy-MM-dd}</td>
                                <td>{반납 기한|yyyy-MM-dd}</td>
                                <td>{반납일|yyyy-MM-dd}</td>
                                <td><span class="font_caution">연체 후 반납</span></td>
                            </tr>
                            <!-- //대여 내역 > 연체 후 반납한 물품 -->

                            <!-- 예시 -->
                            <tr>
                                <td>16</td>
                                <td><h3><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">김사원 (영업/대리)</span></h3></td>
                                <td class="td_align_left">12일에 고객사 출장시 사용할 예정입니다.</td>
                                <td>2025-01-11</td>
                                <td>2025-01-11</td>
                                <td><h3>대여중</h3></td>
                                <td><h3>대여중</h3></td>
                            </tr>
                            <tr>
                                <td>15</td>
                                <td><h3><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">박대리 (개발/대리)</span></h3></td>
                                <td class="td_align_left">1월 3일에 고객사 출장시 사용할 예정입니다.</td>
                                <td>2024-12-31</td>
                                <td>2025-01-04</td>
                                <td>2025-01-04</td>
                                <td>정상 반납</td>
                            </tr>
                            <!-- //예시 -->
                        </table>
                    </div>
                    <!-- //대여 이력 -->

                </div>

            </div>
        </div>
    </div>
</div>
</body>

<script src="resources/js/common.js"></script>
</html>