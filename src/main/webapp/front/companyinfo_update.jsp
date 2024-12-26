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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/companyinfo_update'">
                        <h1>회사 정보 수정하기</h1>
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
                                    <th>회사명</th>
                                    <td>
                                        <input type="text" name="" value="{회사명}" maxlength="100" placeholder="회사명을 입력하세요" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>대표</th>
                                    <td>
                                        <div class="tst_flex">
                                            <div class="tst_col10">
                                                <input type="text" name="" value="{직원명}" maxlength="100" placeholder="문서 제목을 입력하세요" />
                                            </div>
                                            <div class="tst_col2">
                                                <button onclick="" class="btn_secondary btn_full">대표 변경하기</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>설립일</th>
                                    <td>
                                        <input type="date" name="" value="{설립일}" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>사업자 등록 번호</th>
                                    <td>
                                        <input type="text" name="" value="{사업자 등록 번호}" maxlength="100" placeholder="사업자 등록번호를 입력하세요" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>법인 등록 번호</th>
                                    <td>
                                        <input type="text" name="" value="{법인 등록 번호}" maxlength="100" placeholder="법인 등록 번호를 입력하세요" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>대표 전화번호</th>
                                    <td>
                                        <input type="text" name="" value="{대표 전화번호}" maxlength="100" placeholder="회사 대표 전화번호를 입력하세요" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>주소</th>
                                    <td>
                                        <input type="text" name="" value="{주소}" maxlength="1000" placeholder="회사 주소를 입력하세요" />
                                    </td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th class="td_align_top"></th>
                                    <td class="td_align_left">
                                        <hr class="separator" />

                                        <!-- 파일 적용시 아래 코드에서 주석을 제거한 뒤 적용하세요 -->
                                        <!-- <input type="submit" class="btn_primary" value="회사 정보 수정하기" /> -->

                                        <!-- 파일 적용시 아래 코드는 삭제하세요 -->
                                        <button type="button" class="btn_primary" onclick="location.href='/companyinfo_detail'">회사 정보 수정하기</button>

                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                        <!-- //문서 작성하기 -->

                        <div class="tst_col3">

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

                            <hr class="separator" />

                            <!-- 직인 > 파일이 있을 경우 -->
                            <table class="tst_table table_align_left table_no_padding">
                                <thead>
                                <tr>
                                    <th>직인</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="td_no_underline">
                                    <td>{파일 이름 (용량kb)}</td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="tst_flex">
                                            <div class="tst_col12 align_center align_middle">
                                                <img src="https://images3.theispot.com/1024x1024/a4140a1012.jpg?v=210305105300" class="companyinfo_stamp" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="2">
                                        <form>
                                            <input type="file" name="attached_stamp" multiple />
                                        </form>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                            <!-- //직인 > 파일이 있을 경우 -->

                            <!-- 직인 > 파일이 없을 경우 -->
                            <table class="tst_table table_align_left table_no_padding">
                                <thead>
                                <tr>
                                    <th>직인</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><p class="font_subtle align_center">직인이 없습니다.</p></td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="2">
                                        <form>
                                            <input type="file" name="attached_stamp" multiple />
                                        </form>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                            <!-- //직인 > 파일이 없을 경우 -->

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
</html>