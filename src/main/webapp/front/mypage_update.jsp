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
    <link rel="stylesheet" type="text/css" href="resources/css/mypage.css" />
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/mypage'">
                        <h1>내 정보</h1>
                    </li>
                </ul>
                <!-- //제목 -->
                <form>
                    <div class="tst_flex">
                        <div class="tst_col9">
                            <div class="tst_flex tst_flex_block">
                                <div class="tst_col12">
                                    <div class="tst_flex">
                                        <div class="tst_col4">
                                            <ul class="list_no_desc list_block">
                                                <li>
                                                    <label class="form_label">이름</label>
                                                    <div class="tst_flex">
                                                        <div class="tst_col8">
                                                            <input type="text" name="" maxlength="100" value="{이름}" class="input_disable" readonly />
                                                        </div>
                                                        <div class="tst_col4">
                                                            <button onclick="tst_modal_call('tst_modal_name')" type="button" class="btn_subtle btn_full">정정 신청</button>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li>
                                                    <label class="form_label">ID</label>
                                                    <input type="text" name="" maxlength="100" value="{ID}" class="input_disable" readonly />
                                                </li>
                                                <li>
                                                    <label class="form_label">비밀번호</label>
                                                    <button onclick="tst_modal_call('tst_modal_password')" type="button" class="btn_subtle btn_full">비밀번호 변경하기</button>
                                                </li>
                                                <li>
                                                    <label class="form_label">성별</label>
                                                    <input type="text" name="" maxlength="100" value="{성별}" class="input_disable" readonly />
                                                </li>
                                                <li>
                                                    <label class="form_label">생년월일</label>
                                                    <input type="date" name="" value="{생년월일}" class="input_disable" readonly />
                                                </li>
                                                <li>
                                                    <label class="form_label">주민등록번호</label>
                                                    <input type="text" name="" maxlength="100" value="{주민등록번호}" class="input_disable" readonly />
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="tst_col8 padding_left">
                                            <ul class="list_no_desc list_block">
                                                <li>
                                                    <label class="form_label">사내 유선번호</label>
                                                    <input type="text" name="" maxlength="100" value="{사내 유선번호}" placeholder="사내 유선번호를 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">사내 이메일</label>
                                                    <input type="text" name="" maxlength="100" value="{사내 이메일}" class="input_disable" readonly />
                                                </li>
                                                <li>
                                                    <label class="form_label">
                                                        비상 연락처
                                                        <span class="font_caution">* 비상시 연락할 수 있는 전화번호를 입력하세요.</span>
                                                    </label>
                                                    <input type="text" name="" maxlength="100" value="{비상 연락처}" placeholder="비상 연락처를 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">
                                                        개인 이메일
                                                        <span class="font_caution">* 비밀번호 분실시 새 비밀번호를 수령할 수 있는 메일 주소를 입력하세요.</span>
                                                    </label>
                                                    <input type="text" name="" maxlength="100" value="{개인 이메일}" placeholder="개인 이메일을 입력하세요" />
                                                </li>
                                                <li>
                                                    <label class="form_label">입사일</label>
                                                    <input type="date" name="" maxlength="100" value="{입사일}" class="input_disable" readonly />
                                                </li>
                                                <li>
                                                    <label class="form_label">급여 지급 계좌번호</label>
                                                    <div class="tst_flex">
                                                        <div class="tst_col4">
                                                            <input type="text" name="" maxlength="100" value="{은행명}" class="input_disable" readonly />
                                                        </div>
                                                        <div class="tst_col8">
                                                            <input type="text" name="" maxlength="100" value="{계좌번호}" class="input_disable" readonly />
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="tst_col12">
                                    <label class="form_label">주소</label>
                                    <input type="text" name="" maxlength="100" value="{주소}" placeholder="주소를 입력하세요" />
                                    <hr class="separator" />
                                </div>
                                <div class="tst_col12">
                                    <ul class="tst_list list_no_desc list_inline">
                                        <li>
                                            <input type="submit" class="btn_primary" value="정보 수정하기" />
                                        </li>
                                        <li>
                                            <input type="button" onclick="location.href='/mypage'" class="btn_secondary" value="이전으로 돌아가기" />
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="tst_col3">

                            <!-- 프로필 > 파일이 있을 경우 -->
                            <table class="tst_table table_align_left table_no_padding">
                                <thead>
                                <tr>
                                    <th>프로필</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="td_no_underline">
                                    <td>{파일 이름}</td>
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
                                        <input type="file" name="" multiple />
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                            <!-- //프로필 > 파일이 있을 경우 -->

                            <!-- 프로필 > 파일이 없을 경우 -->
                            <table class="tst_table table_align_left table_no_padding">
                                <thead>
                                <tr>
                                    <th>프로필</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><p class="font_subtle align_center">프로필 이미지가 없습니다.</p></td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="2">
                                        <input type="file" name="" multiple />
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                            <!-- //프로필 > 파일이 없을 경우 -->

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
                                <tr>
                                    <td>{파일명 (파일 용량kb)}</td>
                                    <td>
                                        <!-- 다운로드 경로를 입력하세요 --><button onclick="location.href='/'" type="button" class="btn_min btn_primary">다운로드</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>{파일명 (파일 용량kb)}</td>
                                    <td>
                                        <!-- 다운로드 경로를 입력하세요 --><button onclick="location.href='/'" type="button" class="btn_min btn_primary">다운로드</button>
                                    </td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="2">
                                        <button type="button" onclick="tst_modal_call('tst_modal_file')" class="btn_subtle btn_full">증명 서류 제출하기</button>
                                    </td>
                                </tr>
                                </tfoot>
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
                                        <button type="button" onclick="tst_modal_call('tst_modal_stamp')" class="btn_subtle btn_full">직인 제출</button>
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
                                        <button type="button" onclick="tst_modal_call('tst_modal_stamp')" class="btn_subtle btn_full">직인 제출</button>
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
    <c:import url="mypage_update_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/mypage_update.js"></script>
</html>