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
    <link rel="stylesheet" type="text/css" href="resources/css/companyinfo.css" />
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/mypage.go'">
                        <h1>내 정보</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">
                    <div class="tst_col9">

                        <!-- 내 정보 상세보기 -->
                        <table class="tst_table table_align_left">
                            <colgroup>
                                <col style="width: 15%" />
                                <col style="width: 35%" />
                                <col style="width: 15%" />
                                <col style="width: 35%" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="4">개인 정보</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th class="td_bg_subtle">이름</th>
                                <td>${memberInfo.empl_name}</td>
                                <th class="td_bg_subtle">직원 번호</th>
                                <td>${memberInfo.empl_idx}</td>
                            </tr>
                            <tr>
                                <th class="td_bg_subtle">성별</th>
                                <td>${memberInfo.empl_gender}</td>
                                <th class="td_bg_subtle">아이디</th>
                                <td>${memberInfo.empl_id}</td>
                            </tr>
                            <tr>
                                <th class="td_bg_subtle">생년월일</th>
                                <td>${memberInfo.empl_birth}</td>
                                <th class="td_bg_subtle">부서</th>
                                <td>${memberInfo.dept_name}<!-- / {팀명} (조직장) --></td>
                                <!-- 부서장인 경우에는 팀을 기재하지 않습니다 -->
                            </tr>
                            <tr>
                                <th class="td_bg_subtle">주민등록번호</th>
                                <td>${memberInfo.empl_ssn1}- *******</td>
                                <th class="td_bg_subtle">직급/직책</th>
                                <td>${memberInfo.duty_name}/${memberInfo.position_name}</td>
                            </tr>
                            <tr>
                                <th class="td_bg_subtle">급여 입금 계좌</th>
                                <td colspan="3">${memberInfo.bank_name} ${memberInfo.empl_account} (예금주: ${memberInfo.empl_name})</td>
                            </tr>
                            </tbody>
                        </table>
                        <hr class="separator" />

                        <table class="tst_table table_align_left">
                            <colgroup>
                                <col style="width: 15%" />
                                <col style="width: 35%" />
                                <col style="width: 15%" />
                                <col style="width: 35%" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="4">연락처</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th class="td_bg_subtle">회사 내 유선번호</th>
                                <td>${memberInfo.empl_cmp_phone}</td>
                                <th class="td_bg_subtle">회사 내 이메일</th>
                                <td>${memberInfo.empl_cmp_email}</td>
                            </tr>
                            <tr>
                                <th class="td_bg_subtle">개인 전화번호</th>
                                <td>${memberInfo.empl_per_phone}</td>
                                <th class="td_bg_subtle">개인 이메일</th>
                                <td>${memberInfo.empl_per_email}</td>
                            </tr>
                            <tr>
                                <th class="td_bg_subtle">주소</th>
                                <td colspan="3">${memberInfo.empl_addr}</td>
                            </tr>
                            </tbody>
                        </table>
                        <hr class="separator" />

                        <table class="tst_table table_align_left">
                            <colgroup>
                                <col style="width: 15%" />
                                <col style="width: 35%" />
                                <col style="width: 15%" />
                                <col style="width: 35%" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="4">근태<!-- 및 연차 --></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th class="td_bg_subtle">이번 주 근무 시간</th>
                                <td>${totalHours}시간/52시간</td>
                                <th class="td_bg_subtle">초과 근무 여부</th>
                                <td>대상 아님</td>
                            </tr>
                            <!-- <tr>
                                <th class="td_bg_subtle">잔여 연차</th>
                                <td>{잔여 연차}/15개</td>
                                <th class="td_bg_subtle">연차 초기화 일시</th>
                                <td>{내년}-01-01 00:00</td>
                            </tr> -->
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="4" class="td_align_left td_no_padding">
                                    <hr class="separator" />
                                    <button onclick="location.href='mypage_update.go'" class="btn_primary">정보 수정하기</button>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                        <hr class="separator" />
                        <hr class="separator" />
                        <hr class="separator" />
                        <!-- // 내 정보 상세보기 -->

                        <!-- 제목 -->
                        <h1>인사 변경 이력</h1>
                        <hr class="separator" />
                        <!-- //제목 -->

                        <!-- 인사 이력 -->
                        <table class="tst_table">
                            <colgroup>
                                <col style="width: 60px;" />
                                <col style="width: auto;" />
                                <col style="width: 110px;" />
                                <col style="width: auto;" />
                                <col style="width: 120px;" />
                                <col style="width: 120px;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>부서/팀</th>
                                <th>직급/직책</th>
                                <th>직무</th>
                                <th>발령일</th>
                                <th>전출일</th>
                            </tr>
                            </thead>
                            <tbody id="list">
                            	<!-- 여기에 리스트가 동적으로 추가!!! -->                                                   
                            </tbody>
                            <tfoot>
								<tr>
									<td colspan="3" class="pagination-container">
										<!-- <nav aria-label="Page navigation"> -->
											<!-- <ul class="pagination" id="pagination"></ul> -->
										<!-- </nav> -->
									</td>
								</tr>
							</tfoot>
                        </table>

                    </div>

                    <div class="tst_col3">

                        <!-- 프로필 -->
                        <table class="tst_table table_align_left table_no_padding">
                            <thead>
                            <tr>
                                <th>프로필</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 프로필 파일이 있을 경우 -->
                            <c:if test="${not empty memberInfo.empl_profile}">
                            <tr class="td_no_underline">
                                <td><!-- {파일 이름 (용량kb)} --></td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="tst_flex">
                                        <div class="tst_col12 align_center align_middle">
                                            <img src="memberFiles/${memberInfo.empl_profile}" class="companyinfo_stamp" />
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            </c:if>
                            <!-- 프로필 파일이 없을 경우 -->
                            <c:if test="${empty memberInfo.empl_profile}">
                            <tr>
                            	<td><p class="font_subtle align_center">프로필 이미지가 없습니다.</p></td>
                            </tr>
                            </c:if>
                            </tbody>
                        </table>
						<!-- 프로필 -->

                        <hr class="separator" />

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
                            <!-- 파일이 있을 경우 -->
                            <c:if test="${not empty fileList}">
								<c:forEach var="file" items="${fileList}">
									<tr>
										<td>${file.ori_filename}</td>
										<td><button onclick="location.href='memberDownload/${file.new_filename}'" class="btn_min btn_primary">다운로드</button></td>
									</tr>
								</c:forEach>
							</c:if>
							<!--  파일이 없을 경우 -->
							<c:if test="${empty fileList}">
								<tr>
									<td><p class="font_subtle align_center">첨부 파일이 없습니다.</p></td>
								</tr>
							</c:if>
                            </tbody>
                        </table>
                        <!-- //첨부 파일 목록 -->

                        <hr class="separator" />

                        <!-- 직인 -->
                        <table class="tst_table table_align_left table_no_padding">
                            <thead>
                            <tr>
                                <th>직인</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 직인이 있을 경우 -->
                            <c:if test="${not empty memberInfo.empl_stamp}">        
                            <tr class="td_no_underline">
                                <td><!-- {파일 이름 (용량kb)} --></td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="tst_flex">
                                        <div class="tst_col12 align_center align_middle">
                                            <img src="memberFiles/${memberInfo.empl_stamp}" class="companyinfo_stamp" />
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            </c:if>
                            <!-- 직인이 없을 경우 -->
							<c:if test="${empty memberInfo.empl_stamp}">
								<tr>
									<td><p class="font_subtle align_center">직인이 없습니다.</p></td>
								</tr>
							</c:if>
                            </tbody>
                        </table>
                        <!-- 직인 -->

                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>

<script src="resources/js/common.js"></script>
<script src="resources/js/mypage.js"></script>
</html>