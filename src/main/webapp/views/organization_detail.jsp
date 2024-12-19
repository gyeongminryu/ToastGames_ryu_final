<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>부서 정보 및 사원 목록</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
    <div class="container mt-4">
        <h2>부서 history 정보</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>부서 ID</th>
                    <th>부서장 이름</th>
                    <th>부서장 직책</th>
                    <th>부서장 직급</th>
                  
                    <th>일시</th>
                </tr>
            </thead>
            <tbody>
                <!-- 서버에서 전달된 depthis 데이터로 부서 정보 동적으로 렌더링 -->
                <c:forEach var="dept" items="${depthis}">
                    <tr>
                        <td>${dept.dept_idx}</td>
                        <td>${dept.empl_name}</td>
                        <td>${dept.duty_name}</td>
                        <td>${dept.position_name}</td>
                        <td>${dept.dept_change_date}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        


        <h2>사원 목록</h2>
      

      
    </div>

    <script>
        // 자바스크립트 코드가 들어갈 곳
    </script>
</body>
</html>