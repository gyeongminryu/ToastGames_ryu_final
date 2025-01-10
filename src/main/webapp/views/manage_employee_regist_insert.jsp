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
    <link rel="stylesheet" type="text/css" href="resources/css/manage_employee_regist_insert.css" />
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
                <form>
                    <div class="tst_flex tst_flex_block">
                        <div class="tst_col12 title_container">
                            <div class="tst_flex">
                                <div class="tst_col6">
                                    <h2>
                                        <span onclick="manage_empl_add_row()" class="tst_pointer">+ 열 추가하기 </span>
                                        <span id="count">(총 ${row_length}건)</span>
                                    </h2>
                                </div>
                                <div class="tst_col6">
                                    <button type="button" onclick="tst_modal_call('tst_modal_insert')" class="btn_primary">직원 일괄 등록하기</button>
                                </div>
                            </div>
                        </div>
                        <div class="tst_col12 table_container">
                            <table class="tst_table">
                                <thead>
                                <tr>
                                    <th></th>
                                    <c:forEach items="${data_col_names}" var="data_col_name">
                                        <c:forEach items="${data_col_name.entrySet()}" var="entry">
                                            <th class = "col_names">${entry.value}</th>
                                        </c:forEach>
                                    </c:forEach>
                                   <%-- <th>아이디</th>
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
                                    <th>직무</th>--%>
                                </tr>
                                </thead>
                                <tbody id = "empl_infos">
                                <c:forEach items="${data}" var="datas" varStatus="status">
                                <tr id = "row_${status.index+ 1}">
                                        <td><i class="bi bi-dash-circle-dotted" onclick="tst_modal_call_regist('tst_modal_delete', ${status.index+1})"></i></td>
                                        <c:forEach items="${datas}" var="entry">
                                            <td><input type="text" name="${entry.key}" value = "${entry.value}" class="empl_info_input"></td>
                                        </c:forEach>
                                </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <c:import url="manage_employee_regist_insert_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/manage_member_add_all.js"></script>
<script type="text/javascript">
    //총 갯수 세는 용도
    var row_length = '${row_length}';//제목 열까지 포함된 값 예) 내용이 4줄이면 5줄로 나옴
    console.log("row_length",row_length);//더하기 할 때 row_length부터 시작하면 됨


    var col_length = '${col_length}';//제목 열까지 포함된 값 예) 내용이 4줄이면 5줄로 나옴


    //열 추가 시 열 구분 용도
    var identi_length = '${row_length}';

    var data_col_names ='${data_col_names}';

</script>

</html>