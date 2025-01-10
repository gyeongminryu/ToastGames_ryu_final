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
    <link rel="stylesheet" type="text/css" href="resources/css/manage_employee_regist_multiple.css" />
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
                    <li class="tst_title_item" onclick="location.href='/manage_employee_list'">
                        <h1>인사 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_employee_resign_list'">
                        <h1>퇴사자 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_employee_regist'">
                        <h1>직원 등록</h1>
                    </li>
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_employee_regist_multiple'">
                        <h1>직원 일괄 등록</h1>
                    </li>
                </ul>
                <!-- //제목 -->
                <form action="/manage_employee_regist_insert.do" method = "POST" enctype="multipart/form-data">
                    <div class="tst_flex tst_flex_block">
                        <div class="tst_col12 form_container">
                            <div>
                                <label class="form_label">일괄 등록할 파일</label>
                                <input type="file" name="file" id="file" />
                                <p class="align_left">.xlsx 또는 .csv 파일 한 개만 등록할 수 있습니다.</p>

                                <!-- 백엔드 작업시 아래 버튼을 삭제하세요 -->
                                <button type="submit">파일 등록하기</button>
                            </div>
                        </div>
                        <div class="tst_col12 title_container">
                            <div class="tst_flex">
                                <div class="tst_col6">
                                    <h2>파일 예시</h2>
                                </div>
                                <div class="tst_col6">
                                    <button type="button" class="btn_primary">예시 파일 다운로드</button>
                                </div>
                            </div>
                        </div>
                        <div class="tst_col12 table_container">
                            <table class="tst_table">
                                <thead>
                                <tr>
                                    <th>이름</th>
                                    <th>아이디</th>
                                    <th>초기 비밀번호</th>
                                    <th>성별</th>
                                    <th>생년월일</th>
                                    <th>주민등록번호 앞자리</th>
                                    <th>주민등록번호 뒷자리</th>
                                    <th>급여 입금 은행</th>
                                    <th>급여 입금 계좌</th>
                                    <th>사내 이메일</th>
                                    <th>사내 유선번호</th>
                                    <th>개인 이메일</th>
                                    <th>개인 전화번호</th>
                                    <th>주소</th>
                                    <th>근무 상태</th>
                                    <th>입사일</th>
                                    <th>직무</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>김직원</td>
                                    <td>identification</td>
                                    <td>PASSWORDS</td>
                                    <td>여</td>
                                    <td>1990-01-01</td>
                                    <td>900101</td>
                                    <td>2123456</td>
                                    <td>토스트은행</td>
                                    <td>1234-12-123456</td>
                                    <td>identification@toastgames.com</td>
                                    <td>02-2345-6789</td>
                                    <td>member@email.com</td>
                                    <td>010-1234-5678</td>
                                    <td>서울시 금천구 가산디지털2로 95 KM타워 201호</td>
                                    <td>재직</td>
                                    <td>2025-01-08</td>
                                    <td>UI/UX디자인</td>
                                </tr>
                                <tr>
                                    <td>이직원</td>
                                    <td>identification</td>
                                    <td>PASSWORDS</td>
                                    <td>남</td>
                                    <td>1990-01-01</td>
                                    <td>900101</td>
                                    <td>2123456</td>
                                    <td>토스트은행</td>
                                    <td>1234-12-123456</td>
                                    <td>identification@toastgames.com</td>
                                    <td>02-2345-6789</td>
                                    <td>member@email.com</td>
                                    <td>010-1234-5678</td>
                                    <td>서울시 금천구 가산디지털2로 95 KM타워 201호</td>
                                    <td>재직</td>
                                    <td>2025-01-08</td>
                                    <td>웹개발</td>
                                </tr>
                                <tr>
                                    <td>최직원</td>
                                    <td>identification</td>
                                    <td>PASSWORDS</td>
                                    <td>여</td>
                                    <td>1990-01-01</td>
                                    <td>900101</td>
                                    <td>2123456</td>
                                    <td>토스트은행</td>
                                    <td>1234-12-123456</td>
                                    <td>identification@toastgames.com</td>
                                    <td>02-2345-6789</td>
                                    <td>member@email.com</td>
                                    <td>010-1234-5678</td>
                                    <td>서울시 금천구 가산디지털2로 95 KM타워 201호</td>
                                    <td>재직</td>
                                    <td>2025-01-08</td>
                                    <td>오디오 작곡</td>
                                </tr>
                                <tr>
                                    <td>한직원</td>
                                    <td>identification</td>
                                    <td>PASSWORDS</td>
                                    <td>남</td>
                                    <td>1990-01-01</td>
                                    <td>900101</td>
                                    <td>2123456</td>
                                    <td>토스트은행</td>
                                    <td>1234-12-123456</td>
                                    <td>identification@toastgames.com</td>
                                    <td>02-2345-6789</td>
                                    <td>member@email.com</td>
                                    <td>010-1234-5678</td>
                                    <td>서울시 금천구 가산디지털2로 95 KM타워 201호</td>
                                    <td>재직</td>
                                    <td>2025-01-08</td>
                                    <td>총무</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
<script src="resources/js/common.js"></script>

</html>