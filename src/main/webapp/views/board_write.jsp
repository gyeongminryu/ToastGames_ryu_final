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
    <link rel="stylesheet" type="text/css" href="resources/css/module_modal.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/manage_rent.css" />
    <link rel="stylesheet" href="resources/richtexteditor/rte_theme_default.css" />
    <script type="text/javascript" src="resources/richtexteditor/rte.js"></script>
    <script type="text/javascript" src="resources/richtexteditor/plugins/all_plugins.js"></script>
    <script type='text/javascript' src="resources/richtexteditor/lang/rte-lang-ko.js"></script>
    <link rel="stylesheet" href="resources/css/module_rte.css" />
    <script type="text/javascript" src="resources/js/module_rte.js"></script>
    
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/board_list'">
                        <h1>전자 게시판</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <form action="board_write.do" method="POST" enctype="multipart/form-data">
                    <div class="tst_flex">

                        <!-- 게시글 -->
                        <div class="tst_col9">
                            <table class="tst_table table_align_left table_no_padding table_no_underline">
                                <colgroup>
                                    <col style="width: 120px;" />
                                    <col style="width: auto;" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th colspan="2">게시글</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th class="td_align_top">부서/팀 선택</th>
                                    <td>
                                        <div class="tst_flex">
                                            <div class="tst_col5">
                                                <select id="deptFilter" name="dept_idx">
												    <option value="">부서</option>
												    <!-- 부서 목록을 동적으로 출력 -->
												    <c:forEach var="dept" items="${department}">
												        <option value="${dept.dept_idx}">${dept.dept_name}</option>
												    </c:forEach>
												</select>	
                                            </div>
                                            <div class="tst_col7">
                                                <select id="typeFilter" name="board_type_idx">
                                                    <option value="">유형</option>
                                                    <option value="1">문서</option>
                                                    <option value="2">부서공지</option>
                                                    <option value="3">전체공지</option>
                                                </select>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="td_align_top">제목</th>
                                    <td>
                                        <input type="text" name="board_title" maxlength="1000" placeholder="제목을 입력하세요" required/>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="td_align_top">내용</th>
                                    <td>
	                                    <!-- rte -->
										<div id="div_editor"></div>
										<input type="hidden" name="board_content" id="board_content" rows="27" placeholder="내용을 입력하세요" required/>
										<!-- //rte -->                                
                                    </td>                                  
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th class="td_align_top"></th>
                                    <td class="td_align_left">
                                        <ul class="list_no_desc list_inline">
                                            <li>
                                                <button type="button" onclick="tst_modal_call('tst_modal_write')" class="btn_primary">게시글 등록하기</button>
                                            </li>
                                            <li>
                                                <button type="button" onclick="location.href='board_list.go'" class="btn_secondary">목록으로 돌아가기</button>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                        <!-- //게시글 -->

                        <div class="tst_col3">

                            <!-- 첨부 파일 -->
							<table class="tst_table table_align_left table_no_padding">
						    <colgroup>
						        <col style="width: auto;" />
						        <col style="width: 60px;" />
						    </colgroup>
						    <thead>
						        <tr>
						            <th colspan="2">첨부 파일</th>
						        </tr>
						    </thead>
						    <tbody id="fileListBody">
						        <tr id="noFileMessage">
						            <td colspan="2" class="td_align_center">
						                <span class="font_subtle">첨부 파일이 없습니다.</span>
						            </td>
						        </tr>
						    </tbody>
						    <!-- 첨부파일 input 부분 -->
						    <tfoot>
						        <tr>
						            <td colspan="2">
						                <input type="file" id="fileInput" name="file" onchange="handleFileSelect(event)" multiple/>
						            </td>
						        </tr>
						    </tfoot>
						</table>
							<!-- //첨부 파일 -->
                            
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<c:import url="board_write_modal.jsp" />

<script src="resources/js/common.js"></script>
<script src="resources/js/board_write.js"></script>
</html>