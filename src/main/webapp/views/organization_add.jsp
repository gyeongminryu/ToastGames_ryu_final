<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>조직 정보 입력 폼</h2>
	<!-- 상대경로 -->
    <form action="./organization.do" method="POST">
        <table>
            <tr>
                <td><label for="organizationName">조직명:</label></td>
                <td><input type="text" id="dept_name" name="dept_name" required /></td>
            </tr>
            <tr>
                <td><label for="jobRole">직무:</label></td>
                <td><input type="text" id="dept_duty" name="dept_duty" required /></td>
            </tr>
            <tr>
                <td><label for="parentOrganization">상위 조직:</label></td>
                <td><input type="text" id="dept_high" name="dept_high" /></td>
            </tr>
            <tr>
                <td><label for="location">위치:</label></td>
                <td><input type="text" id="dept_addr" name="dept_addr" required /></td>
            </tr>
            <tr>
                <td><label for="startDate">최초 조직 일시:</label></td>
                <td><input type="date" id="startDate" name="startDate" required /></td>
            </tr>
        </table>
        <br />
        <input type="submit" value="제출" />
    </form>
</body>
</html>