<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <style>
        #title{
            background-color: lightgray;
            font-weight: bold;
            text-align: center;
        }
        table,td{
            border: 1px solid black;
            border-collapse: collapse;
            height: 75px;
            padding: 0px 10px;
        }

        .content{
            text-align: center;
        }
        a.button { background: rgb(102, 102, 102); color: rgb(255, 255, 255); padding: 2px 5px; border-radius: 3px; }

        #row_adjust{
            margin: 10px 10px 10px 2140px;
        }
    </style>
</head>
<body>

<button onclick="management_set_empldata()">사원 등록하기</button>
<div id = "header_wrapper">
    <div id = "row_adjust">
        <a class="button" id="plus1">추가</a> <a class="button" id="minus1">삭제</a>
    </div>
</div>
<div id = "content_wrapper">
    <table>
        <!-- 키 값의 순서에 맞춰서 열 생성하기? -->
        <c:forEach items="${data_col_names}" var="data_col_name">
            <tr id = "title">
                    <%--<td>${data_col_name}</td>--%>

                    <c:forEach items="${data_col_name.entrySet()}" var="entry">
                        <td>${entry.value}</td>
                    </c:forEach>
            </tr>
        </c:forEach>
        <c:forEach items="${data}" var="datas">
            <tr class = "content">
                <c:forEach items="${datas}" var="entry">
                    <td><input type = "text" name = "${entry.key}"  value =${entry.value}></td>
                </c:forEach>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
<script src="/resources/js/management_member_add_all.js"></script>


</html>