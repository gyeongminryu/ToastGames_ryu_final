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
    <link rel="stylesheet" type="text/css" href="resources/css/manage_rent.css" />
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/board_list'">
                        <h1>전자 게시판</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <form>
                    <div class="tst_flex">

                        <!-- 게시글 -->
                        <div class="tst_col9">
                            <table class="tst_table table_align_left table_no_padding table_no_underline">
                                <colgroup>
                                    <col style="width: 120px;" />
                                    <col style="width: auto;" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th colspan="2">게시글</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th class="td_align_top">부서/팀 선택</th>
                                    <td>
                                        <div class="tst_flex">
                                            <div class="tst_col5">
                                                <select type="text" name="" onchange="<!-- 부서 선택시 팀 목록을 셀렉트 박스에 출력하는 함수를 입력하세요 -->">
                                                    <option value="">전체</option>
                                                    <option value="{부서idx}" selected>{부서명}</option>
                                                    <option value="{부서idx}">{부서명}</option>
                                                    <option value="{부서idx}">{부서명}</option>
                                                </select>
                                            </div>
                                            <div class="tst_col7">
                                                <select type="text" name="">
                                                    <option value="">전체</option>
                                                    <option value="{부서idx}" selected>{팀명}</option>
                                                    <option value="{부서idx}">{팀명}</option>
                                                    <option value="{부서idx}">{팀명}</option>
                                                </select>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="td_align_top">제목</th>
                                    <td>
                                        <input type="text" name="subject" value="{제목}" maxlength="1000" placeholder="제목을 입력하세요" />
                                    </td>
                                </tr>
                                <tr>
                                    <th class="td_align_top">내용</th>
                                    <td>
                                        <textarea name="content" rows="27" placeholder="내용을 입력하세요">{내용}</textarea>
                                    </td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th class="td_align_top"></th>
                                    <td class="td_align_left">
                                        <ul class="list_no_desc list_inline">
                                            <li>
                                                <button type="button" onclick="tst_modal_call('tst_modal_update')" class="btn_primary">게시글 수정하기</button>
                                            </li>
                                            <li>
                                                <button type="button" onclick="location.href='/board_list'" class="btn_secondary">목록으로 돌아가기</button>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                        <!-- //게시글 -->

                        <div class="tst_col3">

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

                                <!-- 첨부 파일이 없는 경우 아래와 같이 입력하세요 -->
                                <tr>
                                    <td colspan="2" class="td_align_center">
                                        <span class="font_subtle">첨부 파일이 없습니다.</span>
                                    </td>
                                </tr>
                                <!-- //첨부 파일이 없는 경우 아래와 같이 입력하세요 -->

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
<c:import url="board_update_modal.jsp" />

<script src="resources/js/common.js"></script>
<script src="resources/js/manage_rent_write.js"></script>
</html>