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
    <link rel="stylesheet" type="text/css" href="resources/css/module_pagenation.css" />
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
                    <li class="tst_title_item" onclick="location.href='/manage_rent_list'">
                        <h1>공용 물품 관리</h1>
                    </li>
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_dispose_list'">
                        <h1>폐기 물품 확인</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">

                    <!-- 물품 정보 상세보기 -->
                    <div class="tst_col9">
                        <table class="tst_table table_align_left table_no_padding">
                            <colgroup>
                                <col style="width: 120px" />
                                <col style="width: auto" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">공용 물품 정보</th>
                            </tr>
                            </thead>
                            <tbody>

                            <tr>
                                <th>제품명</th>
                                <th>{제품명}</th>
                            </tr>
                            <tr>
                                <th>제품 정보</th>
                                <td>{제품 정보}</td>
                            </tr>
                            <tr>
                                <th>제품 설명</th>
                                <td>{제품 설명}</td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- // 물품 정보 상세보기 -->

                        <hr class="separator" />

                        <!-- 대여 이력 -->
                        <table class="tst_table">
                            <colgroup>
                                <col style="width: 60px;" />
                                <col style="width: 160px;" />
                                <col style="width: auto;" />
                                <col style="width: 110px;" />
                                <col style="width: 150px;" />
                                <col style="width: 150px;" />
                                <col style="width: 110px;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>대여자</th>
                                <th>대여 사유</th>
                                <th>대여일</th>
                                <th>반납 기한</th>
                                <th>실제 반납일시</th>
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

                            <!-- 대여 내역 > 기한 내에 반납한 물품 -->
                            <tr>
                                <td>{번호}</td>
                                <td><h3><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></h3></td>
                                <td class="td_align_left">{대여 사유}</td>
                                <td>{대여일}</td>
                                <td>{반납 기한}</td>
                                <td>{실제 반납일시}</td>
                                <td>정상 반납</td>
                            </tr>
                            <!-- //대여 내역 > 기한 내에 반납한 물품 -->

                            <!-- 대여 내역 > 연체 후 반납한 물품 -->
                            <tr>
                                <td>{번호}</td>
                                <td><h3><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></h3></td>
                                <td class="td_align_left">{대여 사유}</td>
                                <td>{대여일}</td>
                                <td>{반납 기한}</td>
                                <td>{실제 반납일시}</td>
                                <td><span class="font_caution">연체 후 반납</span></td>
                            </tr>
                            <!-- //대여 내역 > 연체 후 반납한 물품 -->

                            <!-- 예시 -->
                            <tr>
                                <td>16</td>
                                <td><h3><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">김사원 (영업/대리)</span></h3></td>
                                <td class="td_align_left">12일에 고객사 출장시 사용할 예정입니다.</td>
                                <td>2025-01-11</td>
                                <td>2025-01-13 18:00</td>
                                <td>2025-01-14 09:20</td>
                                <td><span class="font_caution">연체 후 반납</span></td>
                            </tr>
                            <tr>
                                <td>15</td>
                                <td><h3><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">박대리 (개발/대리)</span></h3></td>
                                <td class="td_align_left">1월 3일에 고객사 출장시 사용할 예정입니다.</td>
                                <td>2024-12-31</td>
                                <td>2025-01-04 18:00</td>
                                <td>2025-01-04 09:20</td>
                                <td>정상 반납</td>
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
                    <!-- //대여 이력 -->

                    <div class="tst_col3">

                        <!-- 첨부 파일 목록 -->
                        <table class="tst_table table_align_left table_no_padding">
                            <colgroup>
                                <col style="width: auto" />
                                <col style="width: 60px" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">첨부 파일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>{파일명 (파일 용량kb)}</td>
                                <td>
                                    <!-- 다운로드 경로를 입력하세요 --><button onclick="location.href='/'" class="btn_min btn_primary">다운로드</button>
                                </td>
                            </tr>
                            <tr>
                                <td>{파일명 (파일 용량kb)}</td>
                                <td>
                                    <!-- 다운로드 경로를 입력하세요 --><button onclick="location.href='/'" class="btn_min btn_primary">다운로드</button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //첨부 파일 목록 -->

                        <hr class="separator" />

                        <!-- 사용연한 -->
                        <table class="tst_table table_align_left table_no_padding">
                            <colgroup>
                                <col style="width: 100px" />
                                <col style="width: auto" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">사용연한</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>카테고리</th>
                                <td>{카테고리}</td>
                            </tr>
                            <tr>
                                <th>내용연수</th>
                                <td>{내용연수|n년}</td>
                            </tr>
                            <tr>
                                <th>등록일</th>
                                <td>{등록일|yyyy-MM-dd}</td>
                            </tr>
                            <tr>
                                <th>사용연한</th>
                                <td>{사용연한|yyyy-MM-dd}</td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //사용연한 -->

                        <hr class="separator" />

                        <!-- 폐기/인수 정보 -->
                        <table class="tst_table table_align_left table_no_padding">
                            <colgroup>
                                <col style="width: 100px" />
                                <col style="width: auto" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">대여 정보</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>처리 방식</th>
                                <td>폐기|인수</td>
                            </tr>
                            <tr>
                                <th>대여자</th>
                                <td><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></td>
                            </tr>
                            <tr>
                                <th>폐기 사유</th>
                                <td>{폐기 사유}</td>
                            </tr>
                            <tr>
                                <th>처리자</th>
                                <td><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></td>
                            </tr>
                            <tr>
                                <th>처리 일시</th>
                                <td>{처리 일시|yyyy-MM-dd HH:dd}</td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //폐기/인수 정보 -->

                        <hr class="separator" />

                        <!-- 버튼 -->
                        <ul class="list_no_desc list_block">
                            <li>
                                <button class="btn_subtle btn_full" onclick="location.href='/manage_dispose_list'">목록으로 돌아가기</button>
                            </li>
                        </ul>
                        <!-- //버튼 -->

                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
<c:import url="manage_rent_detail_modal.jsp" />
</body>

<script src="resources/js/common.js"></script>
</html>