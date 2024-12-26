<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<html>
<head>
<meta charset="UTF-8">
<title>회사 정보 입력 폼</title>
</head>
<body>
    <h2>회사 정보 입력 폼</h2>
    <!-- 상대경로 -->
   
        <table>
            <tr>
                <td><label for="companyName">회사명:</label></td>
                <td><input type="text" id="comp_name" name="comp_name"  value="${comp_info.comp_name }" required readonly/></td>
            </tr>
            <tr>
                <td><label for="ceoName">대표 이름:</label></td>
                <td><input type="text" id="ceo_idx" name="ceo_idx" value="${ceo_info.empl_name}/${ceo_info.position_name}/${ceo_info.duty_name}" required readonly/></td>
            </tr>
             <tr>
                <td><label for="ceoName">회사 번호:</label></td>
                <td><input type="text" id="comp_phone" name="comp_phone" value="${comp_info.comp_phone }" required readonly/></td>
            </tr>
            <tr>
                <td><label for="businessNumber">사업자등록번호:</label></td>
                <td><input type="text" id="comp_biz_no" name="comp_biz_no" value="${comp_info.comp_biz_no }" required readonly/></td>
            </tr>
            <tr>
                <td><label for="corporateNumber">법인등록번호:</label></td>
                <td><input type="text" id="comp_corp_no" name="comp_corp_no" value="${comp_info.comp_corp_no }" required readonly/></td>
            </tr>
            <tr>
                <td><label for="address">주소:</label></td>
                <td><input type="text" id="comp_addr" name="comp_addr" value="${comp_info.comp_addr }" required readonly/></td>
            </tr>
            <tr>
                <td><label for="establishmentDate">설립일:</label></td>
                <td><input type="date" id="comp_est_date" name="comp_est_date" value="${comp_info.comp_est_date }" required readonly/></td>
            </tr>
        </table>
        <br />
           
</body>

<script>

</script>

</html>
