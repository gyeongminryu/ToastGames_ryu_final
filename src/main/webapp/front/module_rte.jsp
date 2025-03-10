<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_table.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_rte.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/approval.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/approval_send_modal.css" />

    <link rel="stylesheet" href="resources/richtexteditor/rte_theme_default.css" />
    <script type="text/javascript" src="resources/richtexteditor/rte.js"></script>
    <script type="text/javascript" src="resources/richtexteditor/plugins/all_plugins.js"></script>
    <script type='text/javascript' src="resources/richtexteditor/lang/rte-lang-ko.js"></script>
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/approval_writing_select_form'">
                        <h1>문서 작성하기</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <form>
                    <div class="tst_flex">

                        <!-- 문서 작성하기 -->
                        <div class="tst_col9">
                            <table class="tst_table table_align_left table_no_underline table_no_padding">
                                <colgroup>
                                    <col style="width: 120px;" />
                                    <col style="width: auto;" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th colspan="2">문서 작성</th>
                                </tr>
                                </thead>


                                <tbody>
                                <tr>
                                    <th class="td_align_top">문서 제목</th>
                                    <td>
                                        <input type="text" name="subject" maxlength="100" placeholder="문서 제목을 입력하세요" />
                                    </td>
                                </tr>
                                <tr>
                                    <th class="td_align_top">보고 내용</th>
                                    <td>

                                        <!-- rte -->
                                        <div id="div_editor1" class="size-min"></div>
                                        <!-- //rte -->

                                    </td>
                                </tr>
                                <tr>
                                    <th class="td_align_top">문서</th>
                                    <td>

                                        <!-- rte -->
                                        <div id="div_editor2" >



                                            <p style="text-align: center;"><span style="font-weight: bold; font-size: 24px;">구매 품의서</span></p>
                                            <p style="text-align: center;"><span style="font-weight: bold; font-size: 24px;"></span></p>
                                            <div style="text-align: right;">
                                                <table style="width: 120px; height: 140px; float: right; text-align: center; border-collapse: collapse;">
                                                    <colgroup>
                                                        <col style="width: 20px" />
                                                        <col style="width: auto" />
                                                    </colgroup>
                                                    <tbody>
                                                    <tr>
                                                        <td rowspan="3" colspan="1" style="background-color: rgb(220, 220, 220);">기<br />
                                                            <p>안</p>
                                                        </td>
                                                        <td style="height: 20px;">사원</td>
                                                    </tr>
                                                    <tr>
                                                        <td style="border: 1px solid #000 !important;">김이름</td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 20px;"><br />
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <p><br />
                                            </p>
                                            <p><br />
                                            </p>
                                            <p><br />
                                            </p>
                                            <p><br />
                                            </p>
                                            <p><br />
                                            </p>
                                            <p>
                                            <table style="border: 1px solid #000;">
                                                <colgroup>
                                                    <col width="40px" />
                                                    <col width="50px" />
                                                    <col width="170px" />
                                                    <col width="100px" />
                                                    <col width="60px" />
                                                    <col width="60px" />
                                                    <col width="80px" />
                                                    <col width="100px" />
                                                    <col width="80px" />
                                                    <col width="70px" />
                                                </colgroup>
                                                <tbody>
                                                <tr>
                                                    <td rowspan="1" colspan="2" style="text-align: center; background-color: rgb(220, 220, 220);">담당 부서</td>
                                                    <td><br />
                                                    </td>
                                                    <td rowspan="3" colspan="1" style="text-align: center; background-color: rgb(220, 220, 220);">납품자</td>
                                                    <td rowspan="1" colspan="3"><br />
                                                    </td>
                                                    <td style="text-align: center; background-color: rgb(220, 220, 220);">작성 일자</td>
                                                    <td rowspan="1" colspan="2"><br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="1" colspan="2" style="text-align: center; background-color: rgb(220, 220, 220);">프로젝트 번호</td>
                                                    <td><br />
                                                    </td>
                                                    <td style="text-align: center;">TEL:</td>
                                                    <td rowspan="1" colspan="2"><br />
                                                    </td>
                                                    <td style="text-align: center; background-color: rgb(220, 220, 220);">인도장소</td>
                                                    <td rowspan="1" colspan="2"><br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="1" colspan="2" style="text-align: center; background-color: rgb(220, 220, 220);">사용 목적</td>
                                                    <td><br />
                                                    </td>
                                                    <td style="text-align: center;">FAX:</td>
                                                    <td rowspan="1" colspan="2"><br />
                                                    </td>
                                                    <td style="text-align: center; background-color: rgb(220, 220, 220);">희망 납기 일자</td>
                                                    <td rowspan="1" colspan="2"><br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center; background-color: rgb(220, 220, 220);">품번</td>
                                                    <td rowspan="1" colspan="2" style="text-align: center; background-color: rgb(220, 220, 220);">품명</td>
                                                    <td style="text-align: center; background-color: rgb(220, 220, 220);">규격</td>
                                                    <td style="text-align: center; background-color: rgb(220, 220, 220);">단위</td>
                                                    <td style="text-align: center; background-color: rgb(220, 220, 220);">수량</td>
                                                    <td style="text-align: center; background-color: rgb(220, 220, 220);">단가</td>
                                                    <td style="text-align: center; background-color: rgb(220, 220, 220);">금액</td>
                                                    <td style="text-align: center; background-color: rgb(220, 220, 220);">수주금액</td>
                                                    <td style="text-align: center; background-color: rgb(220, 220, 220);">비고</td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center;">1</td>
                                                    <td rowspan="1" colspan="2"><br />
                                                    </td>
                                                    <td><br />
                                                    </td>
                                                    <td style="text-align: center;"><br />
                                                    </td>
                                                    <td style="text-align: center;"><br />
                                                    </td>
                                                    <td style="text-align: right;"><br />
                                                    </td>
                                                    <td style="text-align: right;"><br />
                                                    </td>
                                                    <td><br />
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center;">2</td>
                                                    <td rowspan="1" colspan="2"><br />
                                                    </td>
                                                    <td><br />
                                                    </td>
                                                    <td style="text-align: center;"><br />
                                                    </td>
                                                    <td style="text-align: center;"><br />
                                                    </td>
                                                    <td style="text-align: right;"><br />
                                                    </td>
                                                    <td style="text-align: right;"><br />
                                                    </td>
                                                    <td><br />
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center;">3</td>
                                                    <td rowspan="1" colspan="2"><br />
                                                    </td>
                                                    <td><br />
                                                    </td>
                                                    <td style="text-align: center;"><br />
                                                    </td>
                                                    <td style="text-align: center;"><br />
                                                    </td>
                                                    <td style="text-align: right;"><br />
                                                    </td>
                                                    <td style="text-align: right;"><br />
                                                    </td>
                                                    <td><br />
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center;">4</td>
                                                    <td rowspan="1" colspan="2"><br />
                                                    </td>
                                                    <td><br />
                                                    </td>
                                                    <td style="text-align: center;"><br />
                                                    </td>
                                                    <td style="text-align: center;"><br />
                                                    </td>
                                                    <td style="text-align: right;"><br />
                                                    </td>
                                                    <td style="text-align: right;"><br />
                                                    </td>
                                                    <td><br />
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center;">5</td>
                                                    <td rowspan="1" colspan="2"><br />
                                                    </td>
                                                    <td><br />
                                                    </td>
                                                    <td style="text-align: center;"><br />
                                                    </td>
                                                    <td style="text-align: center;"><br />
                                                    </td>
                                                    <td style="text-align: right;"><br />
                                                    </td>
                                                    <td style="text-align: right;"><br />
                                                    </td>
                                                    <td><br />
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center;">6</td>
                                                    <td rowspan="1" colspan="2"><br />
                                                    </td>
                                                    <td><br />
                                                    </td>
                                                    <td style="text-align: center;"><br />
                                                    </td>
                                                    <td style="text-align: center;"><br />
                                                    </td>
                                                    <td style="text-align: right;"><br />
                                                    </td>
                                                    <td style="text-align: right;"><br />
                                                    </td>
                                                    <td><br />
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="1" colspan="7" style="text-align: center; background-color: rgb(220, 220, 220);">합계</td>
                                                    <td><br />
                                                    </td>
                                                    <td rowspan="1" colspan="2" style="text-align: center;">VAT 별도</td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="1" colspan="10" style="text-align: center; background-color: rgb(220, 220, 220);">구매사유 (구체적 작성)</td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="1" colspan="10" style="height: 130px;"><br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="1" colspan="10" style="text-align: center; background-color: rgb(220, 220, 220);">특기사항</td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="1" colspan="10" style="height: 130px;"><br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="1" colspan="2" style="text-align: center; background-color: rgb(220, 220, 220);">근거서류</td>
                                                    <td rowspan="1" colspan="8"><br />
                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>
                                            <br />
                                            </p>



                                        </div>
                                        <!-- //rte -->

                                    </td>
                                </tr>
                                </tbody>

                                <tfoot>
                                <tr>
                                    <th class="td_align_top"></th>
                                    <td class="td_align_left">
                                        <ul class="list_no_desc list_inline">
                                            <li>
                                                <button type="button" onclick="tst_modal_call('tst_modal_send')" class="btn_primary">상신하기</button>
                                            </li>
                                            <li>
                                                <button type="button" onclick="location.href=''" class="btn_secondary">임시 저장하기</button>
                                            </li>
                                            <li>
                                                <button type="button" onclick="tst_modal_call('tst_modal_cancel')" class="btn_subtle">작성 취소하기</button>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                        <!-- //문서 작성하기 -->

                        <div class="tst_col3">

                            <!-- 결재선 편집 -->
                            <table class="tst_table table_align_left table_no_padding">
                                <colgroup>
                                    <col style="width: 90px;" />
                                    <col style="width: auto;" />
                                    <col style="width: 60px;" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th colspan="3">결재선</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th>1차 결재</th>
                                    <td class="td_align_left">{직원명 (부서/직급)}</td>
                                    <td>
                                        <button type="button" onclick="tst_modal_call('tst_modal_select')" class="btn_primary btn_min">변경하기</button>
                                    </td>
                                </tr>
                                <tr>
                                    <th>2차 결재</th>
                                    <td class="td_align_left">{직원명 (부서/직급)}</td>
                                    <td>
                                        <button type="button" onclick="tst_modal_call('tst_modal_select')" class="btn_primary btn_min">변경하기</button>
                                    </td>
                                </tr>
                                <tr>
                                    <th>최종 결재</th>
                                    <td class="td_align_left">{직원명 (부서/직급)}</td>
                                    <td>
                                        <button type="button" onclick="tst_modal_call('tst_modal_select')" class="btn_primary btn_min">변경하기</button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <hr class="separator" />
                            <!-- //결재선 편집 -->

                            <!-- 참조 편집 -->
                            <table class="tst_table table_align_left table_no_padding">
                                <colgroup>
                                    <col style="width: 90px;" />
                                    <col style="width: auto;" />
                                    <col style="width: 60px;" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th colspan="3">참조</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th>참조 1</th>
                                    <td class="td_align_left">{직원명 (부서/직급)}</td>
                                    <td>
                                        <!-- 참조인에서 제외하는 경로/함수를 입력하세요 --><button type="button" onclick="location.href='/'" class="btn_primary btn_min">제외하기</button>
                                    </td>
                                </tr>
                                <tr>
                                    <th>참조 2</th>
                                    <td class="td_align_left">{직원명 (부서/직급)}</td>
                                    <td>
                                        <!-- 참조인에서 제외하는 경로/함수를 입력하세요 --><button type="button" onclick="location.href='/'" class="btn_primary btn_min">제외하기</button>
                                    </td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="3">
                                        <button type="button" onclick="tst_modal_call('tst_modal_select')" class="btn_subtle btn_full">참조 추가하기</button>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                            <hr class="separator" />
                            <!-- //참조 편집 -->

                            <!-- 첨부 파일 편집 -->
                            <table class="tst_table table_align_left table_no_padding">
                                <colgroup>
                                    <col style="width: auto;" />
                                    <col style="width: 60px;" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th colspan="2">첨부 파일</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td class="td_align_left">{첨부 파일명 (용량kb)}</td>
                                    <td>
                                        <!-- 삭제 경로/함수를 입력하세요 --><button type="button" onclick="location.href='/'" class="btn_primary btn_min">삭제하기</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td_align_left">{첨부 파일명 (용량kb)}</td>
                                    <td>
                                        <!-- 삭제 경로/함수를 입력하세요 --><button type="button" onclick="location.href='/'" class="btn_primary btn_min">삭제하기</button>
                                    </td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="2">
                                        <form>
                                            <input type="file" name="attached_file" multiple />
                                        </form>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                            <!-- //첨부 파일 편집 -->

                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<c:import url="approval_writing_write_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/module_rte.js"></script>
<script src="resources/js/approval_send_modal.js"></script>
</html>