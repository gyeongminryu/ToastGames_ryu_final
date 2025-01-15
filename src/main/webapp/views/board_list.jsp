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
    <link rel="stylesheet" type="text/css" href="resources/css/module_pagenation.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="resources/js/jquery.twbsPagination.js"></script>
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/board_list'">
                        <h1>전자 게시판</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">
                    <div class="tst_col2">

                        <!-- 부서/팀 검색 -->
						<form style="visibility: hidden;">
                            <div class="tst_search_container width_full">
                                <div class="tst_search_input">
                                    <input type="text" name="keyword_category" maxlength="50" class="input_min input_underline" placeholder="검색어를 입력하세요" />
                                </div>
                                <div class="tst_search_icon">
                                    <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
                                </div>
                            </div>
                        </form>
                        <!-- //부서/팀 검색 -->

                        <!-- 게시글 작성 버튼 -->
                        <button onclick="location.href='board_write.go'" class="btn_primary btn_full">게시글 작성하기</button>
                        <!-- //게시글 작성 버튼 -->
                                             
							<!-- 부서 필터 선택 -->
							<select id="deptFilter" name="dept">
							    <option value="">부서</option>
							    <!-- 부서 목록을 동적으로 출력 -->
							    <c:forEach var="dept" items="${department}">
							        <option value="${dept.dept_idx}">${dept.dept_name}</option>
							    </c:forEach>
							</select>
							<!-- 부서 필터 선택 -->
							
							<!-- 유형 필터 선택 -->
							<select id="typeFilter">
							    <option value="">유형</option>
							    <option value="1">문서</option>
							    <option value="2">부서공지</option>
							    <option value="3">전체공지</option>
							</select>
							<!-- 유형 필터 선택 -->
													
							<!-- 전 직원 조회 (필터링 초기화) -->
                        	<button onclick="location.href='board_list.go'" class="btn_empty btn_full" >필터 초기화</button>
                        	<!-- //전 직원 조회 (필터링 초기화) -->																			
                    </div>							
                    <div class="tst_col10">

                        <!-- 게시판 검색 -->
                        
                            <div class="tst_search_container">
                                <div class="tst_search_select">
                                    <select id="searchType" name="category">
                                        <option value="">검색 분류</option>
                                        <option value="board_title">제목</option>
							            <option value="empl_name">작성자</option>
							            <option value="board_content">내용</option>
                                    </select>
                                </div>
                                <div class="tst_search_input">
                                    <input type="text" id="searchKeyword" maxlength="50" placeholder="검색어를 입력하세요" />
                                </div>
                                <!-- 초기화 버튼 -->
								<div class="tst_search_init font_subtle" onclick="location.href='board_list'">
									<i class="bi bi-x-circle-fill"></i>
								</div>
								<!-- //초기화 버튼 -->
                                <div class="tst_search_icon">
                                    <button onclick="searchPosts()" class="btn_icon"><i class="bi bi-search"></i></button>
                                </div>
                            </div>
                        
                        <!-- 게시판 검색 -->

                        <table class="tst_table">
                            <colgroup>
                                <col style="width: 60px;" />
                                <col style="width: 190px;" />
                                <col style="width: auto;" />
                                <col style="width: 160px;" />
                                <col style="width: 60px;" />
                                <col style="width: 150px;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>부서</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>조회수</th>
                                <th>작성 일시</th>
                            </tr>
                            </thead>
                            <tbody id="list">
								<!-- 리스트가 여기에 동적으로 추가됩니다. -->
							</tbody>
							
                            <!-- pagination -->
                            <tfoot>
                            <tr>
                                 <td colspan="5">
			                        <nav aria-label="Page navigation">
									   <ul class="pagination" id="pagination"></ul>
									</nav>
			                     </td>
                            </tr>
                            </tfoot>
                            <!-- //pagination -->
                            
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/board_list.js"></script>
</html>