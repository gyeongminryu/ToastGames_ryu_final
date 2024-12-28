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
    <link rel="stylesheet" type="text/css" href="resources/css/module_pagenation.css" />
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_employee_list'">
                        <h1>인사 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/'">
                        <h1>사원 등록</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/'">
                        <h1>사원 일괄 등록</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">
                    <div class="tst_col2">

                        <!-- 부서/팀 검색 -->
                        <form>
                            <div class="tst_search_container width_full">
                                <div class="tst_search_input">
                                    <input type="text" name="keyword_category" maxlength="50" class="input_min input_underline" placeholder="검색어를 입력하세요" />
                                </div>
                                <div class="tst_search_icon">
                                    <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
                                </div>
                            </div>
                        </form>
                        <!-- //부서/팀 검색 -->

                        <table class="tst_table table_align_left">
                            <colgroup>
                                <col style="width: 20px;" />
                                <col style="width: auto;" />
                            </colgroup>
                            <tbody class="tst_pointer">

                            <!-- 전 직원 조회 (필터링 초기화) -->
                            <tr>
                                <th colspan="2" class="td_bg_subtle"><span onclick="location.href='/manage_employee_list'">전체 보기</span></th>
                            </tr>
                            <!-- //전 직원 조회 (필터링 초기화) -->

                            <!-- 부서 (필터링) -->
                            <tr>
                                <td onclick="menu_show(this)"><i class="bi bi-caret-right-fill" show_team_list(this, '부서번호')"></i></td><!-- 한꺼번에 불러오실 경우 '부서 번호' 지우시면 됩니다.-->
                                <th>
                                    <span onclick="location.href='/manage_employee_list?'">{부서명}</span>
                                </th>
                            </tr>
                            <tr>
                                <td colspan="2" class="td_no_padding">
                                    <table class="tst_table tst_table_in_table table_align_left">
                                        <colgroup>
                                            <col style="width: 20px;" />
                                            <col style="width: auto;" />
                                        </colgroup>

                                        <!-- 팀 목록 (필터링) -->
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">{팀명}</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">{팀명}</span></td>
                                        </tr>
                                        <!-- //팀 목록 (필터링) -->

                                    </table>
                                </td>
                            </tr>
                            <!-- //부서 (필터링) -->

                            <!-- 부서 > 선택한 항목 (필터링) -->
                            <tr>
                                <td onclick="menu_show(this)"><i class="bi bi-caret-right-fill" show_team_list(this, '부서번호')"></i></td><!-- 한꺼번에 불러오실 경우 '부서 번호' 지우시면 됩니다.-->
                                <th class="td_bg_medium">
                                    <span onclick="location.href='/manage_employee_list?'">{분류명}</span>
                                </th>
                            </tr>

                            <tr>
                                <td colspan="2" class="td_no_padding">
                                    <table class="tst_table tst_table_in_table table_align_left">
                                        <colgroup>
                                            <col style="width: 20px;" />
                                            <col style="width: auto;" />
                                        </colgroup>

                                        <!-- 팀 목록 (필터링) -->
                                        <!-- 팀 > 선택한 항목 (필터링) -->
                                        <tr class="td_bg_medium">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">{팀명}</span></td>
                                        </tr>
                                        <!-- //팀 > 선택한 항목 (필터링) -->

                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">{팀명}</span></td>
                                        </tr>
                                        <!-- //팀 목록 (필터링) -->

                                    </table>
                                </td>
                            </tr>
                            <!-- //부서 > 선택한 항목 (필터링) -->

                            <!-- 예시 -->
                            <tr>
                                <td onclick="menu_show(this)"><i class="bi bi-caret-right-fill"></i></td>
                                <th>
                                    <span onclick="location.href='/manage_employee_list?'">프로그래밍</span>
                                </th>
                            </tr>
                            <tr class="disp_hide">
                                <td class="td_no_padding">
                                    <table class="tst_table tst_table_in_table table_align_left">
                                        <colgroup>
                                            <col style="width: 20px;" />
                                            <col style="width: auto;" />
                                        </colgroup>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">게임엔진</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">게임플레이</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">플랫폼</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">DBA</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">웹개발</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td onclick="menu_hide(this)"><i class="bi bi-caret-right-fill"></i></td>
                                <th>
                                    <span onclick="location.href='/manage_employee_list?'">아트</span>
                                </th>
                            </tr>
                            <tr>
                                <td class="td_no_padding">
                                    <table class="tst_table tst_table_in_table table_align_left">
                                        <colgroup>
                                            <col style="width: 20px;" />
                                            <col style="width: auto;" />
                                        </colgroup>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">이펙트</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">캐릭터모델링</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">애니메이션</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">BX</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">배경모델링</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">웹디자인</span></td>
                                        </tr>
                                        <tr class="font_subtle">
                                            <th></th>
                                            <td><span onclick="location.href='/manage_employee_list?'">UI/UX그래픽</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- //예시 -->

                            </tbody>
                        </table>
                    </div>

                    <div class="tst_col10">

                        <!-- 물품 검색 -->
                        <form>
                            <div class="tst_search_container">
                                <div class="tst_search_select">
                                    <select id="tst_search_select_category" onchange="<!-- 분류 선택시 실행할 함수를 입력하세요 -->">
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
                        <!-- //물품 검색 -->

                        <table class="tst_table">
                            <colgroup>
                                <col style="width: 60px;" />
                                <col style="width: 150px;" />
                                <col style="width: 200px;" />
                                <col style="width: auto;" />
                                <col style="width: 60px;" />
                                <col style="width: 150px;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>분류</th>
                                <th>제품명</th>
                                <th>제품 정보</th>
                                <th>상태</th>
                                <th>반납 예정 일시</th>
                            </tr>
                            </thead>
                            <tbody>

                            <!-- 검색되는 공유 물품이 없을 경우 -->
                            <tr class="rent_list_no_data"><!-- 데이터가 있을 경우 클래스 disp_hide를 추가하세요. -->
                                <td colspan="6" class="td_no_data">
                                    <p><i class="bi bi-person-exclamation"></i></p>
                                    <h3>검색 조건에 해당하는 직원이 없습니다.</h3>
                                </td>
                            </tr>
                            <!-- //검색되는 공유 물품이 없을 경우 -->

                            <!-- 공유 물품 목록 > 대여 신청중인 물품 -->
                            <tr>
                                <td>{번호}</td>
                                <td><span class="tst_pointer">{분류}</span></td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><h3 onclick="location.href='/rent_detail?'" class="tst_pointer">{제품명}</h3>
                                </td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><span onclick="location.href='/rent_detail?'" class="tst_pointer">{제품_정보}</span>
                                </td>
                                <td><span class="tst_badge_min btn_primary">대여 신청</span></td>
                                <td>{반납 예정 일시}</td>
                            </tr>
                            <!-- //공유 물품 목록 > 대여 신청중인 물품 -->

                            <!-- 공유 물품 목록 > 대여중인 물품 -->
                            <tr>
                                <td>{번호}</td>
                                <td><span class="tst_pointer">{분류}</span></td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><h3 onclick="location.href='/rent_detail?'" class="tst_pointer">{제품명}</h3>
                                </td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><span onclick="location.href='/rent_detail?'" class="tst_pointer">{제품_정보}</span>
                                </td>
                                <td><span class="tst_badge_min btn_secondary">대여중</span></td>
                                <td>{반납 예정 일시}</td>
                            </tr>
                            <!-- //공유 물품 목록 > 대여중인 물품 -->

                            <!-- 공유 물품 목록 > 대여 가능한 물품 -->
                            <tr>
                                <td>{번호}</td>
                                <td><span class="tst_pointer">{분류}</span></td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><h3 onclick="location.href='/rent_detail?'" class="tst_pointer">{제품명}</h3>
                                </td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><span onclick="location.href='/rent_detail?'" class="tst_pointer">{제품_정보}</span>
                                </td>
                                <td><span class="tst_badge_min btn_subtle">대여 가능</span></td>
                                <td>없음</td>
                            </tr>
                            <!-- //공유 물품 목록 > 대여 가능한 물품 -->

                            <!-- 예시 -->
                            <tr>
                                <td>1278</td>
                                <td><span class="tst_pointer">윈도 노트북</span></td>
                                <td class="td_align_left"><h3 onclick="location.href='/rent_detail?'" class="tst_pointer">갤럭시북 Pro 16" (1)</h3></td>
                                <td class="td_align_left"><span onclick="location.href='/rent_detail?'" class="tst_pointer">갤럭시 북 5 Pro 360 (40.6cm) Core Ultra 7 / iTB NVMe SSD</span></td>
                                <td><span class="tst_badge_min btn_subtle">대여 가능</span></td>
                                <td>없음</td>
                            </tr>
                            <tr>
                                <td>1277</td>
                                <td><span class="tst_pointer">맥북</span></td>
                                <td class="td_align_left"><h3 onclick="location.href='/rent_detail?'" class="tst_pointer">맥북 Pro 16" (1)</h3></td>
                                <td class="td_align_left"><span onclick="location.href='/rent_detail?'" class="tst_pointer">MacBook Pro 16 M4 Max(16코어 CPU)</span></td>
                                <td><span class="tst_badge_min btn_secondary">대여중</span></td>
                                <td>2025-01-23 18:00</td>
                            </tr>
                            <!-- //예시 -->

                            <!-- pagination -->
                            <tfoot>
                            <tr>
                                <td colspan="7">
                                    <ul id="pagination" class="pagination-sm pagination">
                                        <li class="page-item first disabled">
                                            <a href="#" class="page-link"><i class="bi bi-chevron-double-left"></i></a>
                                        </li>
                                        <li class="page-item prev disabled">
                                            <a href="#" class="page-link"><i class="bi bi-chevron-left"></i></a>
                                        </li>
                                        <li class="page-item active">
                                            <a href="#" class="page-link">1</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">2</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">3</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">4</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">5</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">6</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">7</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">8</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">9</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">10</a>
                                        </li>
                                        <li class="page-item next">
                                            <a href="#" class="page-link"><i class="bi bi-chevron-right"></i></a>
                                        </li>
                                        <li class="page-item last">
                                            <a href="#" class="page-link"><i class="bi bi-chevron-double-right"></i></a>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                            </tfoot>
                            <!-- //pagination -->
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/manage_list.js"></script>
<script src="resources/js/meeting_room_calendar.js"></script>
</html>