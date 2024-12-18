<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/table.css" />
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
                        <h1>내게 온 업무 요청</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/'">
                        <h1>내가 보낸 업무 요청</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/'">
                        <h1>작성중인 문서</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <!-- 결재할 사항 상세보기 -->
                <div class="tst_flex">

                    <!-- 결재할 문서 상세보기 -->
                    <div class="tst_col9">
                        <table class="tst_table table_align_left">
                            <colgroup>
                                <col style="width: 120px" />
                                <col style="width: auto" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">
                                    결재할 문서
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>제목</th>
                                <th>{제목}</th>
                            </tr>
                            <tr>
                                <th>상신자</th>
                                <td>{사원명 (부서/직급)}</td>
                            </tr>
                            <tr>
                                <th>마감일</th>
                                <td>{yyyy-MM-dd HH:mm}</td>
                            </tr>
                            <tr>
                                <th>내용</th>
                                <td>{내용}</td>
                            </tr>
                            <tr>
                                <th>첨부파일</th>
                                <td><i class="bi bi-paperclip"></i> {첨부파일} <span class="tst_badge_min btn_secondary">다운로드</span></td>
                            </tr>
                            <tr>
                                <th>문서</th>
                                <td>{문서}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- //결재할 문서 상세보기 -->

                    <!-- 결재할 문서 정보 확인 -->
                    <div class="tst_col3">

                        <!-- 결재할 작성 정보 확인 -->
                        <table class="tst_table table_align_left">
                            <colgroup>
                                <col style="width: 100px" />
                                <col style="width: auto" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">
                                    문서 정보
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>문서 제목</th>
                                <th>{문서 제목}</th>
                            </tr>
                            <tr>
                                <th>문서 유형</th>
                                <td>{문서 유형} 예)기안서</td>
                            </tr>
                            <tr>
                                <th>작성자</th>
                                <td>{사원명 (부서/직급)}</td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //결재할 작성 정보 확인 -->

                        <hr class="separator" />

                        <!-- 결재 이력 -->
                        <table class="tst_table table_align_left">
                            <colgroup>
                                <col style="width: 60%" />
                                <col style="width: 40%" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">
                                    결재 이력
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <p.min>
                                        <b>1차 결재자</b>
                                    </p.min>
                                    <p>{사원명 (부서/직급)}</p>
                                </td>
                                <td>
                                    <p.min>%nbsp;</p.min>
                                    <p>{결재/반려일}</p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //결재선 -->

                    </div>
                    <!-- //결재할 문서 정보 확인 -->

                </div>
                <!-- //결재할 사항 상세보기 -->

            </div>
        </div>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
</html>