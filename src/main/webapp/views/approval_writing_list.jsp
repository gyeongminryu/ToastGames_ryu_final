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
    <link rel="stylesheet" type="text/css" href="resources/css/approval_writing_list.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
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
                <div class="tst_flex">
                    <div class="tst_col9">
                        <!-- 제목 -->
                        <ul class="tst_title list_no_desc list_inline">
                            <li class="tst_title_item" onclick="location.href='/approval_received_list.go'">
                                <h1>수신함</h1>
                            </li>
                            <li class="tst_title_item" onclick="location.href='/approval_send_list.go'">
                                <h1>발신함</h1>
                            </li>
                            <li class="tst_title_item tst_title_item_active" onclick="location.href='/approval_writing_list.go'">
                                <h1>작성중인 문서</h1>
                            </li>
                        </ul>
                        <!-- //제목 -->

                        <!-- 게시물 분류 -->
                        <ul class="tst_tablist list_no_desc list_inline">
                            <li class="tst_tablist_item tst_tablist_item_active">
                            </li>
                            <li class="tst_tablist_item">
                                <!-- 문서 검색 -->
                                    <div class="tst_search_container">
                                        <div class="tst_search_input">
                                            <input type="text" name="keyword" maxlength="50" placeholder="검색어를 입력하세요" id="search"/>
                                        </div>
                                        <div class="tst_search_icon">
                                            <button type="button" class="btn_icon" onclick="approval_list('write')"><i class="bi bi-search"></i></button>
                                        </div>
                                    </div>
                                <!-- //문서 검색 -->
                            </li>
                        </ul>
                        <!-- //게시물 분류 -->
                        <!-- 작성중인 문서 목록 -->

                            <table class="tst_table approval_received_list">
                                <colgroup>
                                    <col style="width: 150px" />
                                    <col style="width: 150px" />
                                    <col style="width: auto" />
                                    <col style="width: 180px" />
                                    <col style="width: 180px" />
                                    <col style="width: 70px" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th>수신인</th>
                                    <th>유형</th>
                                    <th>제목</th>
                                    <th>최초 작성 일시</th>
                                    <th>최종 수정 일시</th>
                                    <th>삭제</th>
                                </tr>
                                </thead>
                                <tbody>
                                <!-- //작성중인 문서 목록 -->
                                <c:if test="${writing_lists.size()<=0}">
                                    <!-- 작성중인 전자 문서가 없을 경우 -->
                                    <tr class="approval_received_no_data"><!-- 데이터가 있을 경우 클래스 disp_hide를 추가하세요. -->
                                        <td colspan="7" class="td_no_data">
                                            <p>
                                                <i class="bi bi-file-earmark-break"></i>
                                            </p>
                                            <h3>작성 중인 문서가 없습니다.</h3>
                                        </td>
                                    </tr>
                                    <!-- //작성중인 전자 문서가 없을 경우 -->
                                </c:if>



                                <c:if test="${writing_lists.size()>0}">
                                    <c:forEach items="${writing_lists}" var="writing_list">
                                    <!-- 기본 -->
                                    <tr>
                                        <td class="td_align_left td_no_padding">
                                            <span onclick="tst_view_profile('${writing_list.empl_idx}')" class="tst_pointer">${writing_list.empl_name} (${writing_list.dept_name}/${writing_list.position_name})</span>
                                        </td>
                                        <td>${writing_list.form_subject}</td>


                                            <td class="td_align_left">
                                                <c:choose>
                                                    <c:when test="${writing_list.doc_subject == null}">
                                                        <span onclick="location.href='/approval_update.go?doc_idx= ${writing_list.doc_idx}'" class="tst_pointer">제목 없음</span>
                                                    </c:when>

                                                    <c:when test="${writing_list.doc_subject != null}">
                                                        <span onclick="location.href='/approval_update.go?doc_idx= ${writing_list.doc_idx}'" class="tst_pointer">${writing_list.doc_subject}</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>${writing_list.write_date}</td>
                                            <td>${writing_list.update_date}</td>
                                            <td class="td_align_right td_no_padding">
                                                <a href="approval_doc_del.do?doc_idx=${writing_list.doc_idx}"><span class="tst_badge_min btn_subtle">삭제</span></a>
                                            </td>

                                    </tr>
                                    <!-- //기본 -->
                                </c:forEach>
                            </c:if>

                            <!-- 예시 -->



                            <!-- pagination -->
                            <tfoot>
                            <tr>
                                <td colspan="7">
                                    <ul id="pagination" class="pagination-sm pagination">

                                    </ul>
                                </td>
                            </tr>
                            </tfoot>
                            <!-- //pagination -->

                        </table>
                        <!-- //결재할 문서 목록 -->

                    </div>
                    <div class="tst_col3 wrote_documents">
                        <h1>문서 작성하기</h1>
                        <hr class="separator" />
                        <ul class="tst_list list_no_desc list_block">

                            <!-- 새 문서 작성하기 -->
                            <li>
                                <h2>새로 작성하기</h2>
                                <button onclick="location.href='/approval_form_list.go'" class="btn_primary btn_full">문서 양식 검색하기</button>
                            </li>
                            <!-- //문서 작성하기 -->

                            <!-- 기존에 작성한 문서 양식 불러오기 -->
                            <li>
                                <h2>기존에 작성한 문서 양식 불러오기</h2>
                                <ul class="tst_list list_block" id="recent_doc_list">

                                    <!-- 기존에 작성한 문서 -->
                                    <li>
                                        <div class="tst_flex">
                                            <div class="tst_flex tst_col3 align_center">
                                                <i class="bi bi-file-earmark-text"></i>
                                            </div>
                                            <div class="tst_col9">
                                                <h3>{문서 제목}</h3>
                                                <p class="font_subtle">
                                                    <!-- 문서 양식만 복사 --><a href="/">
                                                    <i class="bi bi-file-earmark-text"></i>{문서 종류}
                                                </a>
                                                </p>
                                                <!-- 문서+내용 복사 --><button onclick="location.href='/'" class="btn_secondary btn_min">복사</button>
                                            </div>
                                        </div>
                                    </li>
                                    <!-- //기존에 작성한 문서 -->

                                    <!-- 예시 -->
                                    <li>
                                        <div class="tst_flex">
                                            <div class="tst_flex tst_col3 align_center">
                                                <i class="bi bi-file-earmark-text"></i>
                                            </div>
                                            <div class="tst_col9">
                                                <h3>12월 10일 화요일에 연차 신청합니다.</h3>
                                                <p class="font_subtle">
                                                    <a href="/">
                                                        <i class="bi bi-file-earmark-text"></i>연차 신청서
                                                    </a>
                                                </p>
                                                <button onclick="location.href='/'" class="btn_secondary btn_min">복사</button>
                                            </div>
                                        </div>
                                    </li>
                                    <!-- //예시 -->

                                </ul>
                            </li>
                            <!-- //기존에 작성한 문서 양식 불러오기 -->

                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<c:import url="notify_all.jsp" />
</body>
<script src="/resources/js/approval_list_filter.js"></script>
<script src="/resources/js/approval_search.js"></script>
<script src="/resources/js/approval_writing_list.js"></script>
<script src="/resources/js/list_initialize.js"></script>

<script src="resources/js/common.js"></script>
<script>
    var filter = "${filter}";
</script>

</html>