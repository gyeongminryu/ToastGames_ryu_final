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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_rent_list'">
                        <h1>공용 물품 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_dispose_list'">
                        <h1>폐기 물품 확인</h1>
                    </li>
                </ul>
                <!-- //제목 -->
                <form>
                    <div class="tst_flex">

                        <!-- 물품 정보 -->
                        <div class="tst_col9">
                            <table class="tst_table table_align_left table_no_padding table_no_underline">
                                <colgroup>
                                    <col style="width: 120px;" />
                                    <col style="width: auto;" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th colspan="2">공용 물품 정보</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th class="td_align_top">물품명</th>
                                    <td>
                                        <input type="text" name="subject" maxlength="100" value="{물품명}" />
                                    </td>
                                </tr>
                                <tr>
                                    <th class="td_align_top">물품 정보</th>
                                    <td>
                                        <input type="text" name="information" maxlength="1000" value="{물품 정보}" />
                                    </td>
                                </tr>
                                <tr>
                                    <th class="td_align_top">물품 설명</th>
                                    <td>
                                        <textarea name="content" rows="27">{물품 설명}</textarea>
                                    </td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th class="td_align_top"></th>
                                    <td class="td_align_left">
                                        <ul class="list_no_desc list_inline">
                                            <li>
                                                <button type="button" onclick="tst_modal_call('tst_modal_update')" class="btn_primary">물품 수정하기</button>
                                            </li>
                                            <li>
                                                <button type="button" onclick="location.href='/manage_rent_list'" class="btn_secondary">목록으로 돌아가기</button>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                        <!-- //물품 정보 -->

                        <div class="tst_col3">

                            <!-- 대여 정보 -->
                            <table class="tst_table table_align_left table_no_padding">
                                <colgroup>
                                    <col style="width: 90px;" />
                                    <col style="width: auto;" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th colspan="2">대여 정보</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th>카테고리</th>
                                    <td>
                                        <select name="category" onchange="change_category(this)"><!-- 함수는 파일 'resources/js/manage_rent_write.js'에 작성해 주세요 -->
                                            <option value="{카테고리}">{카테고리}</option>
                                            <option value="{카테고리}">{카테고리}</option>
                                            <option value="{카테고리}">{카테고리}</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>내용연수</th>
                                    <td id="useful_life" class="useful_life">{내용연수|0년}</td>
                                </tr>
                                <tr>
                                    <th>사용연한</th>
                                    <td id="due_date" class="due_date">{사용연한|yyyy-MM-dd}</td>
                                </tr>
                                </tbody>
                            </table>
                            <!-- //대여 정보 -->

                            <hr class="separator" />

                            <!-- 첨부 파일 -->
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
                                        <button type="button" onclick="delete_attach(this, '{첨부파일_번호}')" class="btn_primary btn_min">삭제하기</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td_align_left">{첨부 파일명 (용량kb)}</td>
                                    <td>
                                        <button type="button" onclick="delete_attach(this, '{첨부파일_번호}')" class="btn_primary btn_min">삭제하기</button>
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
                            <!-- //첨부 파일 -->

                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<c:import url="manage_rent_update_modal.jsp" />

<script src="resources/js/common.js"></script>
<script src="resources/js/manage_rent_update.js"></script>
</html>