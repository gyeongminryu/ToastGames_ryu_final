<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>구성원 관리</title>
</head>
<body>
    <!-- Header Section -->
    <header>
        <h1>TOAST GAMES</h1>
        <nav>
            <ul>
                <li><a href="#">메뉴1</a></li>
                <li><a href="#">메뉴2</a></li>
                <li><a href="#">메뉴3</a></li>
            </ul>
        </nav>
    </header>

    <!-- Sidebar Section -->
    <aside>
        <div>
            <img src="profile_placeholder.png" alt="프로필 이미지" />
            <p>김이름</p>
            <p>직책 / 부서</p>
        </div>
        <ul>
            <li><a href="#">대시보드</a></li>
            <li><a href="#">구성원 관리</a></li>
            <li><a href="#">결재함</a></li>
            <!-- 추가 메뉴 -->
        </ul>
    </aside>

    <!-- Main Content Section -->
    <main>
        <h2>구성원 관리</h2>
        <div>
            <label for="search">검색:</label>
            <input type="text" id="search" placeholder="검색어를 입력하세요" />
            <button>검색</button>
        </div>

        <!-- Table Section -->
        <table border="1">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>부서</th>
                    <th>성명</th>
                    <th>직급/직책</th>
                    <th>ID</th>
                    <th>유선 연락처</th>
                    <th>이메일</th>
                    <th>입사일시</th>
                    <th>퇴사일시</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // 예제 데이터 출력 (DB 연동 부분은 나중에 추가 가능)
                    for (int i = 1; i <= 20; i++) {
                %>
                <tr>
                    <td><%= i %></td>
                    <td>소속 부서 <%= (i % 3) + 1 %></td>
                    <td>직원<%= i %></td>
                    <td>직급/직책</td>
                    <td>Identification</td>
                    <td>02-1234-5678</td>
                    <td>member<%= i %>@toastgames.com</td>
                    <td>2024-11-29 09:00</td>
                    <td>2024-11-29 18:00</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </main>
</body>
</html>