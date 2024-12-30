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
                        <td>{직원명}</td>
                        <th class="td_bg_subtle">직원 번호</th>
                        <td>{직원 번호}</td>
                    </tr>
                    <tr>
                        <th class="td_bg_subtle">성별</th>
                        <td>{성별}</td>
                        <th class="td_bg_subtle">아이디</th>
                        <td>{아이디}</td>
                    </tr>
                    <tr>
                        <th class="td_bg_subtle">생년월일</th>
                        <td>{생년월일|yyyy-MM-dd}</td>
                        <th class="td_bg_subtle">부서</th>
                        <td>{부서명}/{팀명} (조직장)</td><!-- 부서장인 경우에는 팀을 기재하지 않습니다 -->
                    </tr>
                    <tr>
                        <th class="td_bg_subtle">주민등록번호</th>
                        <td>****** - *******</td><!-- 비공개 정보입니다 -->
                        <th class="td_bg_subtle">직급/직책</th>
                        <td>{직급}/{직책}</td>
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
                        <td>{회사 내 유선번호}</td>
                        <th class="td_bg_subtle">회사 내 이메일</th>
                        <td>{회사 내 이메일}</td>
                    </tr>
                    <tr>
                        <th class="td_bg_subtle">개인 전화번호</th>
                        <td>{개인 전화번호}</td>
                        <th class="td_bg_subtle">개인 이메일</th>
                        <td>{개인 이메일}</td>
                    </tr>
                    <tr>
                        <th class="td_bg_subtle">주소</th>
                        <td colspan="3">{주소}</td>
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
                        <td>{이번 주 근무 시간}/52시간</td>
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
                    <tr>
                        <td colspan="4" class="td_align_left td_no_padding">
                            <hr class="separator" />
                            <button onclick="location.href='/manage_employee_update'" class="btn_primary">정보 수정하기</button>
                        </td>
                    </tr>
                    </tfoot>
                </table>
                <hr class="separator" />
                <hr class="separator" />
                <hr class="separator" />
                <!-- // 직원 정보 상세보기 -->

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
                    <tbody>
                    <tr>
                        <td>{번호}</td>
                        <td>{부서}/{팀}</td><!-- 부서장일 경우 부서만 기재합니다 -->
                        <td>{직급}/{직책}</td>
                        <td class="td_align_left">{직무}</td>
                        <td>{발령일|yyyy-MM-dd}</td>
                        <td>{전출일|yyyy-MM-dd}</td>
                    </tr>

                    <!-- 예시 -->
                    <tr>
                        <td>3</td>
                        <td>오디오/오디오임플리먼테이션</td>
                        <td>대리/사원</td>
                        <td class="td_align_left">오디오 미들웨어 설계, 오디오 데이터 관리</td>
                        <td>2025-01-02</td>
                        <td>없음</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>오디오/오디오임플리먼테이션</td>
                        <td>사원/사원</td>
                        <td class="td_align_left">오디오 미들웨어 설계, 오디오 데이터 관리</td>
                        <td>2022-01-02</td>
                        <td>2025-01-01</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>가발령</td>
                        <td>사원/사원</td>
                        <td class="td_align_left">없음</td>
                        <td>2022-01-02</td>
                        <td>2022-01-02</td>
                    </tr>
                    <!-- //예시 -->

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>

<script src="resources/js/common.js"></script>
</html>