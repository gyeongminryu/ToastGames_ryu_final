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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_rent_list.go'">
                        <h1>공용 물품 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_dispose_list.go'">
                        <h1>폐기 물품 확인</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">
                    <div class="tst_col2">

                        <!-- 분류 검색 -->
                        <form onsubmit="return category_search(event);">
                            <div class="tst_search_container width_full">
                                <div class="tst_search_input">
                                    <input type="text" id="keyword_category" name="keyword_category" maxlength="50" class="input_min input_underline" placeholder="검색어를 입력하세요" />
                                </div>
                                
						        <!-- 초기화 버튼 -->
						        <div class="tst_search_init font_subtle" onclick="location.href='/manage_rent_list.go'">
						            <i class="bi bi-x-circle-fill"></i>
						        </div>
						        <!-- //초기화 버튼 -->
                         
                                
                                <div class="tst_search_icon">
                                    <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
                                </div>
                            </div>
                        </form>
                        <!-- //분류 검색 -->

                        <!-- 제품 등록 버튼 -->
                        <div>
                            <button onclick="location.href='/manage_rent_write.go'" class="btn_full btn_primary">물품 등록하기</button>
                        </div>
                        <!-- //제품 등록 버튼 -->

                        <hr class="separator" />

                        <table class="tst_table table_align_left">
                            <tbody class="tst_pointer">

                            <!-- 전체 제품 조회 (필터링 초기화) -->
                            <tr><th><span onclick="pageCall(1, 'all')">전체 보기</span></th></tr>
                            <!-- //전체 제품 조회 (필터링 초기화) -->

                            <!-- 분류 목록 (필터링) -->
                            <c:forEach items="${categoryList}" var="category">
                            	<tr><td><span onclick="pageCall(1, '${category.prod_cate_idx}')">
	                            	${category.prod_cate_name}</span></td></tr>
                            </c:forEach>
                            <!-- //분류 목록 (필터링) -->

                            </tbody>
                        </table>
                    </div>

                    <div class="tst_col10">
                        
                        <form onsubmit="return resource_search(event);">
                            <div class="tst_search_container">
		                        <!-- 물품 검색 -->
		                       <div class="tst_search_select">
		                       		<select id="tst_search_select_state" name="rent_state" class="btn_secondary">
		                            	<option value="all">대여 상태</option>
		                                <option value="1">대여 가능</option>
		                                <option value="2">대여 신청중</option>
		                                <option value="3">대여중</option>
		                                <option value="4">연체</option>
		                                <option value="0">대여 불가</option>
		                             </select>
		                        </div>
                                <div class="tst_search_select">
                                    <select id="tst_search_select_category" name="category">
                                    	<option value="prod_name">물품명</option>
                                        <option value="prod_info">물품정보</option>
                                    </select>
                                </div>
                                <div class="tst_search_input">
                                    <input type="text" id="search_keyword" name="keyword" maxlength="50" placeholder="검색어를 입력하세요" />
                                </div>
                                
						        <!-- 초기화 버튼 -->
						        <div class="tst_search_init font_subtle" onclick="location.href='/manage_rent_list.go'">
						            <i class="bi bi-x-circle-fill"></i>
						        </div>
						        <!-- //초기화 버튼 -->
 
                                <div class="tst_search_icon">
                                    <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
                                </div>
                            </div>
                        </form>
                        <!-- //물품 검색 -->

                        <table class="tst_table">
                            <colgroup>
                                <col style="width: 60px;" />
                                <col style="width: 150px;" />
                                <col style="width: 200px;" />
                                <col style="width: auto;" />
                                <col style="width: 60px;" />
                                <col style="width: 150px;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>관리번호</th>
                                <th>분류</th>
                                <th>물품명</th>
                                <th>물품 정보</th>
                                <th>상태</th>
                                <th>반납 예정 일시</th>
                            </tr>
                            </thead>
                            <tbody id="resource_manage_list">
							<!-- 물품 목록 표시구역 -->
							</tbody>

                            <!-- pagination -->
                            <tfoot>
                            <tr>
                                <td colspan="7">
                                    <ul id="pagination" class="pagination-sm pagination">
                                    
                                    </ul> 
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
<script src="resources/js/manage_rent_list.js"></script>
</html>