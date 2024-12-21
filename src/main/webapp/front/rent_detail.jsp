<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_table.css" /
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/'">
                        <h1>공용 물품 대여</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/'">
                        <h1>내가 대여한 물품</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <!-- 상신한 사항 상세보기 -->
                <div class="tst_flex">

                    <!-- 문서 상세보기 -->
                    <div class="tst_col9">
                        <table class="tst_table table_align_left">
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
                    </div>
                    <!-- //문서 상세보기 -->

                    <div class="tst_col3">

                        <!-- 첨부 파일 목록 -->
                        <table class="tst_table table_align_left">
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
                            </tbody>
                        </table>
                        <!-- //첨부 파일 목록 -->

                        <hr class="separator" />

                        <!-- 대여 정보 > 대여 가능한 경우 -->
                        <table class="tst_table table_align_left">
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
                                <th>대여 가능 여부</th>
                                <td>대여 가능</td>
                            </tr>
                            <tr>
                                <th>대여 상태</th>
                                <td>대여 가능</td>
                            </tr>
                            <tr>
                                <th>반납 예정일</th>
                                <td>없음</td>
                            </tr>
                            <tr>
                                <th colspan="2" class="td_align_center td_bg_subtle">대여 장소는 본관 3층 312호 경영 지원실입니다.</th>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //대여 정보 > 대여 가능한 경우 -->

                        <hr class="separator" />

                        <!-- 대여 정보 > 대여 불가한 경우 -->
                        <table class="tst_table table_align_left">
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
                                <th>대여 가능 여부</th>
                                <td>대여 불가</td>
                            </tr>
                            <tr>
                                <th>대여 상태</th>
                                <td>대여중 ({대여 시작일|yyyy-MM-dd}부터)</td>
                            </tr>
                            <tr>
                                <th>반납 예정일</th>
                                <td>{반납 예정일|yyyy-MM-dd}</td>
                            </tr>
                            <tr>
                                <th colspan="2" class="td_align_center td_bg_subtle disp_hide">대여 장소는 본관 3층 312호 경영 지원실입니다.</th>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //대여 정보 > 대여 불가한 경우 -->

                        <hr class="separator" />

                        <!-- 버튼 -->
                        <ul class="list_no_desc list_block">
                            <li>
                                <button class="btn_primary btn_full" onclick="location.href='/'">물품 대여 신청하기</button>
                            </li>
                            <li>
                                <button class="btn_secondary btn_full" onclick="location.href='/'">목록으로 돌아가기</button>
                            </li>
                        </ul>
                        <!-- //버튼 -->

                    </div>
                    <!-- //상신한 문서 정보 확인 -->

                </div>
                <!-- //상신한 사항 상세보기 -->

            </div>
        </div>
    </div>
</div>
<c:import url="approval_send_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/rent_list.js"></script>
</html>