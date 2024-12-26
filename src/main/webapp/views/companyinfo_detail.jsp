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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/companyinfo_detail'">
                        <h1>회사 정보</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">

                    <!-- 회사 정보 상세보기 -->
                    <div class="tst_col9">
                        <table class="tst_table table_align_left table_no_padding">
                            <colgroup>
                                <col style="width: 150px" />
                                <col style="width: auto" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">회사 정보</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>회사명</th>
                                <td><input type="text" id="comp_name" name="comp_name" value="${comp_info.comp_name}" readonly /></td>
                            </tr>
                            <tr>
                                <th>대표</th>
                                <td>
                                    <input type="text" id="ceo_idx" name="ceo_idx" value="${ceo_info.empl_name}/${ceo_info.position_name}/${ceo_info.duty_name}" readonly />
                                </td>
                            </tr>
                            <tr>
                                <th>설립일</th>
                                <td><input type="date" id="comp_est_date" name="comp_est_date" value="${comp_info.comp_est_date}" readonly /></td>
                            </tr>
                            <tr>
                                <th>사업자 등록번호</th>
                                <td><input type="text" id="comp_biz_no" name="comp_biz_no" value="${comp_info.comp_biz_no}" readonly /></td>
                            </tr>
                            <tr>
                                <th>법인 등록 번호</th>
                                <td><input type="text" id="comp_corp_no" name="comp_corp_no" value="${comp_info.comp_corp_no}" readonly /></td>
                            </tr>
                            <tr>
                                <th>대표 전화번호</th>
                                <td><input type="text" id="comp_phone" name="comp_phone" value="${comp_info.comp_phone}" readonly /></td>
                            </tr>
                            <tr>
                                <th>주소</th>
                                <td><input type="text" id="comp_addr" name="comp_addr" value="${comp_info.comp_addr}" readonly /></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- // 회사 정보 상세보기 -->

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
                                    <button onclick="location.href='/'" class="btn_min btn_primary">다운로드</button>
                                </td>
                            </tr>
                            <tr>
                                <td>{파일명 (파일 용량kb)}</td>
                                <td>
                                    <button onclick="location.href='/'" class="btn_min btn_primary">다운로드</button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //첨부 파일 목록 -->

                        <hr class="separator" />

                        <!-- 직인 > 파일이 있을 경우 -->
                        <table class="tst_table table_align_left table_no_padding">
                            <thead>
                            <tr>
                                <th>직인</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <div class="tst_flex">
                                        <div class="tst_col12 align_center align_middle">
                                            <img src="/files/${comp_info.comp_stamp}" class="companyinfo_stamp" />
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //직인 > 파일이 있을 경우 -->

                    </div>

                </div>
            </div>
        </div>
    </div>
   
</body>

 <script src="resources/js/common.js"></script> 
</html>
