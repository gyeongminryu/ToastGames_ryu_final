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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_staff_list'">
                        <h1>구성원 관리</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <!-- 직원 정보 상세보기 -->
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
                        <td>${empl_info.empl_name}</td>
                        <th class="td_bg_subtle">직원 번호</th>
                        <td>${empl_info.empl_idx}</td>
                    </tr>
                    <tr>
                        <th class="td_bg_subtle">성별</th>
                        <td>
                            <c:choose>
						        <c:when test="${empl_info.empl_gender == 'F'}">남성</c:when>
						        <c:otherwise>여성</c:otherwise>
						    </c:choose>
                        </td>
                        <th class="td_bg_subtle">아이디</th>
                        <td>${empl_info.empl_id}</td>
                    </tr>
                    <tr>
                        <th class="td_bg_subtle">생년월일</th>
                        <td>${empl_info.empl_birth}</td>
                        <th class="td_bg_subtle">부서</th>
                        <td>${empl_info.dept_name}</td><!-- 부서장인 경우에는 팀을 기재하지 않습니다 -->
                    </tr>
                    <tr>
                        <th class="td_bg_subtle">주민등록번호</th>
                        <td>****** - *******</td><!-- 비공개 정보입니다 -->
                        <th class="td_bg_subtle">직급/직책</th>
                        <td>${empl_info.position_name}/${empl_info.duty_name}</td>
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
                        <td>${empl_info.empl_cmp_phone}</td>
                        <th class="td_bg_subtle">회사 내 이메일</th>
                        <td>${empl_info.empl_cmp_email}</td>
                    </tr>
                    <tr>
                        <th class="td_bg_subtle">개인 전화번호</th>
                        <td>${empl_info.empl_per_phone}</td>
                        <th class="td_bg_subtle">개인 이메일</th>
                        <td>${empl_info.empl_per_email}</td>
                    </tr>
                    <tr>
                        <th class="td_bg_subtle">주소</th>
                        <td colspan="3">${empl_info.empl_addr}</td>
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
                        <td>{이번 주 근무 시간}/52시간 <button onclick="location.href='/work_record?'" class="btn_min btn_primary">상세보기</button></td>
                        <th class="td_bg_subtle">초과 근무 여부</th>
                        <td>대상 아님|초과 근무중</td>
                    </tr>
                    <!-- <tr>
                        <th class="td_bg_subtle">잔여 연차</th>
                        <td>{잔여 연차}/15개</td>
                        <th class="td_bg_subtle">연차 초기화 일시</th>
                        <td>{내년}-01-01 00:00</td>
                    </tr> -->
                    </tbody>
                    <tfoot>
                   
                    </tfoot>
                </table>
                <hr class="separator" />
                <hr class="separator" />
                <hr class="separator" />
                <!-- // 직원 정보 상세보기 -->
				
				


            </div>
        </div>
    </div>
</body>

<script src="resources/js/common.js"></script>
</html>