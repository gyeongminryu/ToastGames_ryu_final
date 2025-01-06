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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_rent_list.go'">
                        <h1>공용 물품 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_dispose_list.go'">
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
							<!-- 사용연한이 지났을 경우 -->
							<tr class="expire-message">
							    <th colspan="2" class="td_bg_subtle td_align_center">사용 연한이 종료되었습니다. 물품을 폐기하거나 직원에게 인계하세요.</th>
							</tr>
							<!-- //사용연한이 지났을 경우 -->
							<tr>
                                <th>물품번호</th>
                                <th id="prod_idx">${detail.dto.prod_idx}</th>
                            </tr>
                            <tr>
                                <th>물품명</th>
                                <th>${detail.dto.prod_name}</th>
                            </tr>
                            <tr>
                                <th>물품 정보</th>
                                <td>${detail.dto.prod_model}</td>
                            </tr>
                            <tr>
                                <th>물품 설명</th>
                                <td>${detail.dto.prod_info}</td>
                            </tr>
                            </tbody>
                            <tfoot>
                            <tr>
                                <th></th>
                                <td><button onclick="location.href='/manage_rent_update.go?prod_idx=${detail.dto.prod_idx}'" class="btn_primary">물품 정보 수정하기</button></td>
                            </tr>
                            </tfoot>
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
                            <tbody id="rent_list">

                            <!-- 대여 내역이 없을 경우 -->
                            <!-- 대여 내역 > 대여중인 물품 -->
                            <!-- 대여 내역 > 연체중인 물품 -->
                            <!-- 대여 내역 > 기한 내에 반납한 물품 -->
                            <!-- 대여 내역 > 연체 후 반납한 물품 -->
                            
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
						        <c:forEach var="file" items="${files}">
						            <tr>
						                <td>
						                    ${file.ori_filename} (${file.file_size / 1024} KB)
						                </td>
						                <td>
						                    <button onclick="location.href='download.do?new_filename=${file.new_filename}&ori_filename=${file.ori_filename}'" 
						                            class="btn_min btn_primary">다운로드</button>
						                </td>
						            </tr>
						        </c:forEach>
                            </tbody>
                        </table>
                        <!-- //첨부 파일 목록 -->

                        <hr class="separator" />

                        <!-- 대여 정보 -->
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
							<c:choose>
							    <c:when test="${detail.dto.prod_rent == 1}">
							        <!-- 대여 상태만 표시 -->
							        <tr>
							            <th>대여 상태</th>
							            <td>${detail.dto.prod_rent_str}</td>
							        </tr>
							    </c:when>
							    <c:otherwise>
							        <!-- 모든 정보 표시 -->
							        <tr>
							            <th>대여번호</th>
							            <td id="prod_rent_idx">${detail.dto.prod_rent_idx}</td>
							        </tr>
							        <tr>
							            <th>대여자</th>
							            <td>${detail.empl.empl_name}(${detail.empl.dept_name}/${detail.empl.position_name})</td>
							        </tr>
							        <tr>
							            <th>대여일</th>
							            <td>${detail.formattedDates.prodRentDate}</td>
							        </tr>
							        <tr>
							            <th>대여 사유</th>
							            <td id="prod_rent_reason">${detail.dto.prod_rent_reason}</td>
							        </tr>
							        <tr>
							            <th>대여 상태</th>
							            <td>${detail.dto.prod_rent_str}</td>
							        </tr>
							        <tr>
							            <th>반납 기한</th>
							            <td id="prod_exp_date">${detail.formattedDates.prodExpDate}</td>
							        </tr>
							    </c:otherwise>
							</c:choose>

                            </tbody>
                        </table>
                        <!-- //대여 정보 -->

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
                                <td>${detail.dto.prod_cate_name}</td>
                            </tr>
                            <tr>
                                <th>내용연수</th>
                                <td>${detail.dto.prod_life}</td>
                            </tr>
                            <tr>
                                <th>등록일</th>
                                <td id="purch_date">${detail.formattedDates.prodPurchDate}</td>
                            </tr>
                            <tr id="dispo_date">

                            </tr>
                            </tbody>
                        </table>
                        <!-- //대여 정보 -->

                        <hr class="separator" />

                        <!-- 버튼 -->
                        <ul class="list_no_desc list_block" id="button_list">

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
<script src="resources/js/manage_rent_detail.js"></script>
</html>