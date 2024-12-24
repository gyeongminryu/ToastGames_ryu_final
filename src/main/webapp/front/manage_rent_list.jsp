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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_rent_list'">
                        <h1>공용 물품 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_rent_dispose_list'">
                        <h1>폐기 물품 확인</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">
                    <div class="tst_col2">

                        <!-- 분류 검색 -->
                        <form>
                            <div class="tst_search_container width_full">
                                <div class="tst_search_input">
                                    <input type="text" name="keyword_classf" maxlength="50" class="input_min input_underline" placeholder="검색어를 입력하세요" />
                                </div>
                                <div class="tst_search_icon">
                                    <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
                                </div>
                            </div>
                        </form>
                        <!-- //분류 검색 -->

                        <!-- 제품 등록 버튼 -->
                        <div>
                            <button onclick="location.href='/manage_rent_write'" class="btn_full btn_primary">제품 등록하기</button>
                        </div>
                        <!-- //제품 등록 버튼 -->

                        <hr class="separator" />

                        <table class="tst_table table_align_left">
                            <tbody class="tst_pointer">

                            <!-- 전체 제품 조회 (필터링 초기화) -->
                            <tr><th><span onclick="location.href='/manage_rent_list'">전체 보기</span></th></tr>
                            <!-- //전체 제품 조회 (필터링 초기화) -->

                            <!-- 분류 목록 (필터링) -->
                            <tr><td><span onclick="location.href='/manage_rent_list'">{분류명}</span></td></tr>
                            <!-- //분류 목록 (필터링) -->

                            <!-- 분류 목록 > 선택한 항목 (필터링) -->
                            <tr><td class="td_bg_medium"><span onclick="location.href='/manage_rent_list'">{분류명}</span></td></tr>
                            <!-- //분류 목록 > 선택한 항목 (필터링) -->

                            <!-- 예시 -->
                            <tr><td><span onclick="location.href='/manage_rent_list'">{분류명}</span></td></tr>
                            <tr><td><span onclick="location.href='/manage_rent_list'">{분류명}</span></td></tr>
                            <tr><td><span onclick="location.href='/manage_rent_list'">{분류명}</span></td></tr>
                            <tr><td><span onclick="location.href='/manage_rent_list'">{분류명}</span></td></tr>
                            <!-- //예시 -->

                            </tbody>
                        </table>
                    </div>

                    <div class="tst_col10">

                        <!-- 물품 검색 -->
                        <form>
                            <div class="tst_search_container">
                                <div class="tst_search_select">
                                    <select id="tst_search_select_state" name="state" onchange="<!-- 물품 상태가 바뀌었을 경우 작동할 함수를 입력하세요 -->" class="btn_secondary">
                                        <option value="{물품 상태}">물품 상태</option>
                                        <option value="{물품 상태}">대여 가능</option>
                                        <option value="{물품 상태}">대여 신청중</option>
                                        <option value="{물품 상태}">대여중</option>
                                        <option value="{물품 상태}">연체</option>
                                        <option value="{물품 상태}">사용 연한 초과</option>
                                    </select>
                                </div>
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
                                    <p><i class="bi bi-box-seam"></i></p>
                                    <h3>검색 조건에 해당하는 공용 물품이 없습니다.</h3>
                                </td>
                            </tr>
                            <!-- //검색되는 공유 물품이 없을 경우 -->

                            <!-- 공유 물품 목록 > 대여 가능한 물품 -->
                            <tr>
                                <td>{번호}</td>
                                <td>{분류}</td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><h3 onclick="location.href='/manage_rent_detail?'" class="tst_pointer">{제품명}</h3>
                                </td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><span onclick="location.href='/manage_rent_detail?'" class="tst_pointer">{제품_정보}</span>
                                </td>
                                <td><span class="tst_badge_min btn_subtle">대여 가능</span></td>
                                <td>없음</td>
                            </tr>
                            <!-- //공유 물품 목록 > 대여 가능한 물품 -->

                            <!-- 공유 물품 목록 > 대여 신청중인 물품 -->
                            <tr>
                                <td>{번호}</td>
                                <td>{분류}</td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><h3 onclick="location.href='/manage_rent_detail?'" class="tst_pointer">{제품명}</h3>
                                </td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><span onclick="location.href='/manage_rent_detail?'" class="tst_pointer">{제품_정보}</span>
                                </td>
                                <td><span class="tst_badge_min btn_primary">대여 신청</span></td>
                                <td>{반납 예정 일시}</td>
                            </tr>
                            <!-- //공유 물품 목록 > 대여 신청중인 물품 -->

                            <!-- 공유 물품 목록 > 대여중인 물품 -->
                            <tr>
                                <td>{번호}</td>
                                <td>{분류}</td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><h3 onclick="location.href='/manage_rent_detail?'" class="tst_pointer">{제품명}</h3>
                                </td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><span onclick="location.href='/manage_rent_detail?'" class="tst_pointer">{제품_정보}</span>
                                </td>
                                <td><span class="tst_badge_min btn_secondary">대여중</span></td>
                                <td>{반납 예정 일시}</td>
                            </tr>
                            <!-- //공유 물품 목록 > 대여중인 물품 -->

                            <!-- 공유 물품 목록 > 연체중인 물품 -->
                            <tr>
                                <td>{번호}</td>
                                <td>{분류}</td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><h3 onclick="location.href='/manage_rent_detail?'" class="tst_pointer">{제품명}</h3>
                                </td>
                                <td class="td_align_left">
                                    <!-- 해당 제품으로 이동하는 주소를 입력하세요 --><span onclick="location.href='/manage_rent_detail?'" class="tst_pointer">{제품_정보}</span>
                                </td>
                                <td><span class="tst_badge_min btn_caution">연체</span></td>
                                <td>{반납 예정 일시}</td>
                            </tr>
                            <!-- //공유 물품 목록 > 연체중인 물품 -->

                            <!-- 예시 -->
                            <tr>
                                <td>1278</td>
                                <td>윈도 노트북</td>
                                <td class="td_align_left"><h3 onclick="location.href='/manage_rent_detail?'" class="tst_pointer">갤럭시북 Pro 16" (1)</h3></td>
                                <td class="td_align_left"><span onclick="location.href='/manage_rent_detail?'" class="tst_pointer">갤럭시 북 5 Pro 360 (40.6cm) Core Ultra 7 / iTB NVMe SSD</span></td>
                                <td><span class="tst_badge_min btn_subtle">대여 가능</span></td>
                                <td>없음</td>
                            </tr>
                            <tr>
                                <td>1277</td>
                                <td>맥북</td>
                                <td class="td_align_left"><h3 onclick="location.href='/manage_rent_detail?'" class="tst_pointer">맥북 Pro 16" (1)</h3></td>
                                <td class="td_align_left"><span onclick="location.href='/manage_rent_detail?'" class="tst_pointer">MacBook Pro 16 M4 Max(16코어 CPU)</span></td>
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
</html>