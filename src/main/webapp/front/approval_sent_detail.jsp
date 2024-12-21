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
    <link rel="stylesheet" type="text/css" href="resources/css/approval.css" />
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
                    <li class="tst_title_item" onclick="location.href='/'">
                        <h1>내게 온 업무 요청</h1>
                    </li>
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/'">
                        <h1>내가 보낸 업무 요청</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/'">
                        <h1>작성중인 문서</h1>
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
                                <td>
                                    <ul class="list_no_desc list_inline">
                                        <li>
                                            <i class="bi bi-paperclip"></i>
                                            <span>{첨부파일_1 (용량)}</span>
                                            <a href="/" target="_blank">
                                                <span class="tst_badge_min btn_secondary margin_right">다운로드</span>
                                            </a>
                                        </li>
                                        <li>
                                            <i class="bi bi-paperclip"></i>
                                            <span>{첨부파일_2 (000.0kb)}</span>
                                            <a href="/" target="_blank">
                                                <span class="tst_badge_min btn_secondary margin_right">다운로드</span>
                                            </a>
                                        </li>
                                        <li>
                                            <i class="bi bi-paperclip"></i>
                                            <span>{첨부파일_3 (000.0kb)}</span>
                                            <a href="/" target="_blank">
                                                <span class="tst_badge_min btn_secondary margin_right">다운로드</span>
                                            </a>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <th>문서</th>
                                <td>{문서}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- //문서 상세보기 -->

                    <!-- 문서 정보 확인 -->
                    <div class="tst_col3">

                        <!-- 작성 정보 확인 -->
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
                        <!-- //작성 정보 확인 -->

                        <hr class="separator" />

                        <!-- 결재 이력 -->
                        <table class="tst_table table_align_left">
                            <colgroup>
                                <col style="width: 40px" />
                                <col style="width: auto" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">
                                    결재 이력
                                </th>
                            </tr>
                            </thead>
                            <tbody>

                            <!-- 작성자 -->
                            <tr>
                                <td class="td_align_top">
                                    <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                                </td>
                                <td class="approval_line_info">
                                    <h4 class="font_subtle approval_datetime_subtle">{상신일시}</h4>
                                    <h4>작성자</h4>
                                    <p>{직원명 (부서/직급)}</p>
                                </td>
                            </tr>
                            <!-- //작성자 -->

                            <!-- 1차 결재자 / 결재 승인했을 경우 -->
                            <tr>
                                <td class="td_align_top">
                                    <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                                </td>
                                <td class="approval_line_info">
                                    <h4 class="font_subtle approval_datetime_subtle">{결재/반려일시}</h4>
                                    <h4>1차 결재자</h4>
                                    <p>{직원명 (부서/직급)}</p>
                                    <p><span class="tst_badge_min btn_subtle approval_result_badge">결재 승인</span></p>
                                </td>
                            </tr>
                            <!-- //1차 결재자 / 결재 승인했을 경우 -->

                            <!-- 2차 결재자 / 반려했을 경우 -->
                            <tr>
                                <td class="td_align_top">
                                    <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                                </td>
                                <td class="approval_line_info">
                                    <h4 class="font_subtle approval_datetime_subtle">{결재/반려일시}</h4>
                                    <h4>2차 결재자</h4>
                                    <p>{직원명 (부서/직급)}</p>
                                    <p><span class="tst_badge_min btn_caution approval_result_badge">반려</span></p>
                                    <p class="font_caution approval_reject_reason">{반려 사유}</p>
                                </td>
                            </tr>
                            <!-- //2차 결재자 / 반려했을 경우 -->

                            <!-- 3차 결재자 / 결재 대기중인 경우 -->
                            <tr>
                                <td class="td_align_top">
                                    <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                                </td>
                                <td class="approval_line_info">
                                    <h4 class="font_subtle approval_datetime_subtle">{결재/반려일시}</h4>
                                    <h4>최종 결재자</h4>
                                    <p>{직원명 (부서/직급)}</p>
                                    <p><span class="tst_badge_min btn_secondary approval_result_badge">결재 대기중</span></p>
                                </td>
                            </tr>
                            <!-- //3차 결재자 / 결재 대기중인 경우 -->

                            <!-- 3차 결재자 / 결재 불가한 경우 -->
                            <tr>
                                <td class="td_align_top">
                                    <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                                </td>
                                <td class="approval_line_info">
                                    <h4 class="font_subtle approval_datetime_subtle">{결재/반려일시}</h4>
                                    <h4>최종 결재자</h4>
                                    <p>{직원명 (부서/직급)}</p>
                                    <p><span class="tst_badge_min btn_disable approval_result_badge">결재 불가</span></p>
                                </td>
                            </tr>
                            <!-- //3차 결재자 / 결재 불가한 경우 -->

                            </tbody>
                        </table>
                        <!-- //결재선 -->

                        <hr class="separator" />

                        <!-- 참조인 -->
                        <table class="tst_table table_align_left">
                            <colgroup>
                                <col style="width: 100px" />
                                <col style="width: auto" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">
                                    참조인
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>참조인 1</th>
                                <td>{직원명 (부서/직급)}</td>
                            </tr>
                            <tr>
                                <th>참조인 2</th>
                                <td>{직원명 (부서/직급)}</td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //참조인 -->

                        <!-- 버튼 -->
                        <ul class="list_no_desc list_block">
                            <li>
                                <button class="btn_primary btn_full" onclick="location.href='/'">문서를 복사하여 다시 작성하기</button>
                            </li>
                            <li>
                                <button class="btn_secondary btn_full" onclick="location.href='/'">양식만 복사하여 다시 작성하기</button>
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
</body>
<script src="resources/js/common.js"></script>
</html>