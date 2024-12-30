<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>구성원 관리</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
            text-align: left;
        }

        .section-title {
            background-color: #f2f2f2;
            font-weight: bold;
            padding: 10px;
        }

        .center {
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>구성원 관리</h1>

    <!-- 개인 정보 -->
    <table>
        <thead>
            <tr>
                <th colspan="4" class="section-title">개인 정보</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>이름</td>
                <td>${empl_info.empl_name}</td>
                <td>사번</td>
                <td>${empl_info.empl_idx}</td>
            </tr>
            <tr>
                <td>성별</td>
                <td>${empl_info.empl_gender}</td>
                <td>아이디</td>
                <td>${empl_info.empl_id}</td>
            </tr>
            <tr>
                <td>생년월일</td>
                <td>${empl_info.empl_birth}</td>
                <td>부서</td>
                <td>${empl_info.duty_name}</td>
            </tr>
            <tr>
                <td>주민등록번호</td>
                <td>${empl_info.empl_ssn1}-${empl_info.empl_ssn2}</td>
                <td>직책 / 직급</td>
                <td>${empl_info.duty_name} / ${empl_info.position_name}</td>
            </tr>
            <tr>
                <td>급여 입금 계좌</td>
                <td colspan="3">토스은행 ${empl_info.empl_account} (예금주 : ${empl_info.empl_name})</td>
            </tr>
        </tbody>
    </table>

    <!-- 연락처 -->
    <table>
        <thead>
            <tr>
                <th colspan="4" class="section-title">연락처</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>이메일</td>
                <td>${empl_info.empl_per_email}</td>
                <td>사내 이메일</td>
                <td>${empl_info.empl_cmp_email}</td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td>${empl_info.empl_per_phone}</td>
                <td>사내 연락처</td>
                <td>${empl_info.empl_cmp_phone}</td>
            </tr>
            <tr>
                <td>주소</td>
                <td colspan="3">${empl_info.empl_addr}</td>
            </tr>
            
        </tbody>
    </table>

    <!-- 근무 상태 및 연차 -->
    <table>
        <thead>
            <tr>
                <th colspan="4" class="section-title">근무 상태 및 연차</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>근무 상태</td>
                <td>${empl_info.statement_name}</td>
                <td>연차 잔여 / 총 연차</td>
                <td>9.5 / 15개</td>
            </tr>
            <tr>
                <td>근무 기간</td>
                <td>${empl_info.empl_join_date} - ${empl_info.empl_resig_date}</td>
                <td>다음 연차 초기화일</td>
                <td>2025-01-01 09:00</td>
            </tr>
        </tbody>
    </table>
</body>
</html>
