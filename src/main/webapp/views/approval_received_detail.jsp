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
    <%--폼 양식 css--%>
    <link rel="stylesheet" href="/resources/css/approval_form.css" />

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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/approval_received_list.go'">
                        <h1>내게 온 업무 요청</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/approval_send_list.go'">
                        <h1>내가 보낸 업무 요청</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/approval_writing_list.go'">
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
                                <th>
                                <c:if test="${doc_info.doc_subject != null}">
                                ${doc_info.doc_subject}
                                </c:if>
                                <c:if test="${doc_info.doc_subject == null}">
                                    제목 없음
                                </c:if>
                                </th>

                            </tr>
                            <tr>
                                <th>상신자</th>
                                <td><span onclick="tst_view_profile('${doc_info.doc_empl_idx}')" class="tst_pointer">${doc_info.empl_name} (${doc_info.dept_name}/${doc_info.position_name})</span></td>
                            </tr>
                            <tr>
                                <th>마감일</th>
                                <td>
                                    <c:if test="${doc_info.doc_end_date != null}">
                                        ${doc_info.doc_end_date}
                                    </c:if>
                                    <c:if test="${doc_info.doc_end_date == null}">
                                        마감 기한 없음
                                    </c:if>
                                    </td>
                            </tr>
                            <tr>
                                <th>내용</th>
                                <td>
                                    <c:if test="${doc_info.doc_content_sub != null}">
                                        ${doc_info.doc_content_sub}
                                    </c:if>
                                    <c:if test="${doc_info.doc_content_sub == null}">
                                        내용 없음
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <th>첨부파일</th>
                                <td>
                                    <ul class="list_no_desc list_inline">
                                        <li>
                                            <i class="bi bi-paperclip"></i>
                                            <span>{첨부파일_1 (용량)}</span>
                                            <!-- 다운로드 경로를 입력하세요 --><button onclick="location.href=''" class="btn_min btn_secondary">다운로드</button>
                                        </li>
                                        <li>
                                            <i class="bi bi-paperclip"></i>
                                            <span>{첨부파일_2 (000.0kb)}</span>
                                            <!-- 다운로드 경로를 입력하세요 --><button onclick="location.href=''" class="btn_min btn_secondary">다운로드</button>
                                        </li>
                                        <li>
                                            <i class="bi bi-paperclip"></i>
                                            <span>{첨부파일_3 (000.0kb)}</span>
                                            <!-- 다운로드 경로를 입력하세요 --><button onclick="location.href=''" class="btn_min btn_secondary">다운로드</button>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <th>문서</th>
                                <td id="doc_content" class="doc_content">${doc_info.doc_content}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- //결재할 문서 상세보기 -->

                    <!-- 결재할 문서 정보 확인 -->
                    <div class="tst_col3">

                        <!-- 결재할 작성 정보 확인 -->
                        <table class="tst_table table_align_left table_no_padding">
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
                                <th>
                                    <c:if test="${doc_info.doc_subject != null}">
                                        ${doc_info.doc_subject}
                                    </c:if>
                                    <c:if test="${doc_info.doc_subject == null}">
                                    제목 없음
                                    </c:if>
                            </tr>
                            <tr>
                                <th>문서 유형</th>
                                <td>${form_info.form_subject}</td>
                            </tr>
                            <tr>
                                <th>작성자</th>
                                <td><span onclick="tst_view_profile('${doc_info.doc_empl_idx}')" class="tst_pointer">${doc_info.empl_name} (${doc_info.dept_name}/${doc_info.position_name})</span></td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //결재할 작성 정보 확인 -->

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
                                <td class="td_align_top td_no_padding">
                                    <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                                </td>
                                <td class="approval_line_info">
                                    <h4 class="font_subtle approval_datetime_subtle">{상신일시}</h4>
                                    <h4>작성자</h4>
                                    <p><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></p>
                                </td>
                            </tr>
                            <!-- //작성자 -->

                            <!-- 1차 결재자 / 결재 승인했을 경우 -->
                            <tr>
                                <td class="td_align_top td_no_padding">
                                    <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                                </td>
                                <td class="approval_line_info">
                                    <h4 class="font_subtle approval_datetime_subtle">{결재/반려일시}</h4>
                                    <h4>1차 결재자</h4>
                                    <p><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></p>
                                    <p><span class="tst_badge_min btn_subtle approval_result_badge">결재 승인</span></p>
                                </td>
                            </tr>
                            <!-- //1차 결재자 / 결재 승인했을 경우 -->

                            <!-- 2차 결재자 / 반려했을 경우 -->
                            <tr>
                                <td class="td_align_top td_no_padding">
                                    <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                                </td>
                                <td class="approval_line_info">
                                    <h4 class="font_subtle approval_datetime_subtle">{결재/반려일시}</h4>
                                    <h4>2차 결재자</h4>
                                    <p><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></p>
                                    <p><span class="tst_badge_min btn_caution approval_result_badge">반려</span></p>
                                    <p class="font_caution approval_reject_reason">{반려 사유}</p>
                                </td>
                            </tr>
                            <!-- //2차 결재자 / 반려했을 경우 -->

                            <!-- 3차 결재자 / 결재 대기중인 경우 -->
                            <tr>
                                <td class="td_align_top td_no_padding">
                                    <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                                </td>
                                <td class="approval_line_info">
                                    <h4 class="font_subtle approval_datetime_subtle">{결재/반려일시}</h4>
                                    <h4>최종 결재자</h4>
                                    <p><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></p>
                                    <p><span class="tst_badge_min btn_secondary approval_result_badge">결재 대기중</span></p>
                                </td>
                            </tr>
                            <!-- //3차 결재자 / 결재 대기중인 경우 -->

                            <!-- 3차 결재자 / 결재 불가한 경우 -->
                            <tr>
                                <td class="td_align_top td_no_padding">
                                    <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                                </td>
                                <td class="approval_line_info">
                                    <h4 class="font_subtle approval_datetime_subtle">{결재/반려일시}</h4>
                                    <h4>최종 결재자</h4>
                                    <p><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></p>
                                    <p><span class="tst_badge_min btn_disable approval_result_badge">결재 불가</span></p>
                                </td>
                            </tr>
                            <!-- //3차 결재자 / 결재 불가한 경우 -->

                            </tbody>
                        </table>
                        <!-- //결재선 -->

                        <hr class="separator" />

                        <!-- 참조인 -->
                        <table class="tst_table table_align_left table_no_padding">
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
                            <c:forEach items="${refer_lines}" var="refer_line">
                                <tr>
                                    <th>참조인</th>
                                    <td><span onclick="tst_view_profile('${refer_line.ref_empl_idx}')" class="tst_pointer">${refer_line.empl_name} (${refer_line.dept_name}/${refer_line.position_name})</span></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <!-- //참조인 -->

                        <!-- 버튼 -->
                        <ul class="list_no_desc list_block">
                            <li>
                                <button class="btn_primary btn_full" onclick="tst_modal_call('tst_modal_send')">결재하기</button>
                            </li>
                            <li>
                                <button class="btn_secondary btn_full" onclick="tst_modal_call('tst_modal_reject')">반려하기</button>
                            </li>
                        </ul>
                        <!-- //버튼 -->

                    </div>
                    <!-- //결재할 문서 정보 확인 -->

                </div>
                <!-- //결재할 사항 상세보기 -->

            </div>
        </div>
    </div>

    <!-- 결재 반려사유 기재하는 모달 -->
    <c:import url="approval_received_reject_modal.jsp" />
    <!-- //결재 반려사유 기재하는 모달 -->

</div>
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/module_modal.js"></script>
<script src="resources/js/approval_detail.js"></script>


<script>








</script>

</html>