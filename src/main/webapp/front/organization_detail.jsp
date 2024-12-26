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
                        <hr class="separator" />
                        <!-- //조직 정보 -->

                        <!-- 조직장 변경 이력 -->
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
                                <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({직급})</span></td>
                                <td>{발령일|yyyy-MM-dd}</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('10052')" class="tst_pointer">서연진 (차장)</span></td>
                                <td>2020-01-02</td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //조직장 변경 이력 -->

                    </div>
                    <div class="tst_col9">

                        <!-- 조직원 검색 -->
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
                        <!-- //조직원 검색 -->

                        <!-- 조직원 목록 -->
                        <table class="tst_table">
                            <colgroup>
                                <col style="width: 60px;" />
                                <col style="width: 120px;" />
                                <col style="width: 180px;" />
                                <col style="width: auto;" />
                                <col style="width: 130px;" />
                                <col style="width: 100px;" />
                                <col style="width: 100px;" />
                                <col style="width: 100px;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>직원</th>
                                <th>팀</th>
                                <th>직무</th>
                                <th>발령일</th>
                                <th>금주 근무시간</th>
                                <th>잔여 연차</th>
                                <th>근무 상태</th>
                            </tr>
                            </thead>
                            <tbody>

                            <!-- 조직원이 없을 경우 -->
                            <tr class="rent_history_no_data disp_hide"><!-- 데이터가 있을 경우 클래스 disp_hide를 추가하세요. -->
                                <td colspan="8" class="td_no_data">
                                    <p><i class="bi bi-box-seam"></i></p>
                                    <h3>검색 조건에 해당하는 공용 물품이 없습니다.</h3>
                                </td>
                            </tr>
                            <!-- //조직원이 없을 경우 -->

                            <!-- 부서원/팀원 목록 -->

                            <!-- 부서원/팀원 목록 > 조직장 -->
                            <tr class="td_bg_subtle"><!-- 조직장은 tr에 클래스 'td_bg_subtle'를 추가하세요 -->
                                <td>{번호}</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({직급})</span></td>
                                <td class="td_align_left">{팀} (부서장|팀장)<!-- 부서장은 소속 팀을 표시하지 않습니다 --></td>
                                <td class="td_align_left">{직무}</td>
                                <td>{발령일|yyyy-MM-dd}</td>
                                <td>주 {근무시간}시간</td>
                                <td>{잔여 연차}/15</td>
                                <td>재직중</td>
                            </tr>
                            <!-- //부서원/팀원 목록 > 조직장 -->

                            <!-- 부서원/팀원 목록 > 조직원 -->
                            <tr>
                                <td>{번호}</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({직급})</span></td>
                                <td class="td_align_left">{팀}<!-- 부서장은 소속 팀을 표시하지 않습니다 --></td>
                                <td class="td_align_left">{직무}</td>
                                <td>{발령일|yyyy-MM-dd}</td>
                                <td>주 {근무시간}시간</td>
                                <td>{잔여 연차}/15</td>
                                <td>재직중</td>
                            </tr>
                            <!-- //부서원/팀원 목록 > 조직원 -->

                            <!-- //부서원/팀원 목록 -->

                            <!-- 예시 -->
                            <tr class="td_bg_subtle">
                                <td>24</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('10052')" class="tst_pointer">서연진 (차장)</span></td>
                                <td class="td_align_left">(부서장)</td>
                                <td class="td_align_left">프로그래밍 부서 및 관련 업무 전반 관리</td>
                                <td>2020-01-02</td>
                                <td>주 40시간</td>
                                <td>13/15</td>
                                <td>재직중</td>
                            </tr>
                            <tr>
                                <td>23</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('10060')" class="tst_pointer">김인하 (과장)</span></td>
                                <td class="td_align_left">게임엔진 개발 (팀장)</td>
                                <td class="td_align_left">게임 엔진 개발 및 관련 업무 전반 관리</td>
                                <td>2020-01-02</td>
                                <td>주 32시간</td>
                                <td>10/15</td>
                                <td>재직중</td>
                            </tr>
                            <tr>
                                <td>22</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('')" class="tst_pointer">김이름 (대리)</span></td>
                                <td class="td_align_left">게임엔진 개발</td>
                                <td class="td_align_left">게임 엔진 개발</td>
                                <td>2020-01-02</td>
                                <td>주 32시간</td>
                                <td>10/15</td>
                                <td>재직중</td>
                            </tr>
                            <tr>
                                <td>21</td>
                                <td class="td_align_left"><span onclick="tst_view_profile('')" class="tst_pointer">김이름 (대리)</span></td>
                                <td class="td_align_left">게임엔진 개발</td>
                                <td class="td_align_left">게임 엔진 개발</td>
                                <td>2020-01-02</td>
                                <td>주 32시간</td>
                                <td>10/15</td>
                                <td>재직중</td>
                            </tr>
                            <!-- //예시 -->

                        </table>
                        <!-- //대여 이력 -->

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

<script src="resources/js/common.js"></script>
</html>