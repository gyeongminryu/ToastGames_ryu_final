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
  <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
  <link rel="stylesheet" type="text/css" href="resources/css/module_pagenation.css" />
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
          <li class="tst_title_item" onclick="location.href='/approval_received_list'">
            <h1>내게 온 업무 요청</h1>
          </li>
          <li class="tst_title_item tst_title_item_active" onclick="location.href='/approval_send_list'">
            <h1>내가 보낸 업무 요청</h1>
          </li>
          <li class="tst_title_item" onclick="location.href='/approval_writing_list'">
            <h1>작성중인 문서</h1>
          </li>
        </ul>
        <!-- //제목 -->

        <!-- 게시물 분류 -->
        <ul class="tst_tablist list_no_desc list_inline">
          <li class="tst_tablist_item tst_tablist_item_active" onclick="location.href=''">
            <h3>전체 보기</h3>
          </li>
          <li class="tst_tablist_item" onclick="location.href=''">
            <h3>읽지 않음</h3>
          </li>
          <li class="tst_tablist_item" onclick="location.href=''">
            <h3>결재중</h3>
          </li>
          <li class="tst_tablist_item" onclick="location.href=''">
            <h3>결재 승인</h3>
          </li>
          <li class="tst_tablist_item" onclick="location.href=''">
            <h3>결재 반려</h3>
          </li>
          <li class="tst_tablist_item">
            <!-- 문서 검색 -->
            <form>
              <div class="tst_search_container">
                <div class="tst_search_input">
                  <input type="text" name="keyword" maxlength="50" placeholder="검색어를 입력하세요" />
                </div>
                <div class="tst_search_icon">
                  <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
                </div>
              </div>
            </form>
            <!-- //문서 검색 -->
          </li>
        </ul>
        <!-- //게시물 분류 -->

        <!-- 상신한 문서 목록 -->
        <table class="tst_table approval_received_list">
          <colgroup>
            <col style="width: 150px" />
            <col style="width: 140px" />
            <col style="width: auto" />
            <col style="width: 130px" />
            <col style="width: 130px" />
            <col style="width: 130px" />
          </colgroup>
          <thead>
          <tr>
            <th>수신인</th>
            <th>유형</th>
            <th>제목</th>
            <th>상신 일시</th>
            <th>처리 일시</th>
            <th>마감 일시</th>
          </tr>
          </thead>
          <tbody>




          <!-- 상신한 전자 문서가 없을 경우 -->
          <tr class="approval_received_no_data"><!-- 데이터가 있을 경우 클래스 disp_hide를 추가하세요. jq -> .hide처리하기 -->
            <td colspan="7" class="td_no_data">
              <p>
                <i class="bi bi-file-earmark-break"></i>
              </p>
              <h3>결재 요청한 문서가 없습니다.</h3>
            </td>
          </tr>
          <!-- //상신한 전자 문서가 없을 경우 -->


          <!-- pagination -->
          <tfoot>
          <tr>
            <td colspan="7">
              <ul id="pagination" class="pagination-sm pagination">
                <li class="page-item first disabled">
                  <a href="#" class="page-link"><i class="bi bi-chevron-double-left"></i></a>
                </li>
                <li class="page-item prev disabled">
                  <a href="#" class="page-link"><i class="bi bi-chevron-left"></i></a>
                </li>
                <li class="page-item active">
                  <a href="#" class="page-link">1</a>
                </li>
                <li class="page-item">
                  <a href="#" class="page-link">2</a>
                </li>
                <li class="page-item">
                  <a href="#" class="page-link">3</a>
                </li>
                <li class="page-item">
                  <a href="#" class="page-link">4</a>
                </li>
                <li class="page-item">
                  <a href="#" class="page-link">5</a>
                </li>
                <li class="page-item">
                  <a href="#" class="page-link">6</a>
                </li>
                <li class="page-item">
                  <a href="#" class="page-link">7</a>
                </li>
                <li class="page-item">
                  <a href="#" class="page-link">8</a>
                </li>
                <li class="page-item">
                  <a href="#" class="page-link">9</a>
                </li>
                <li class="page-item">
                  <a href="#" class="page-link">10</a>
                </li>
                <li class="page-item next">
                  <a href="#" class="page-link"><i class="bi bi-chevron-right"></i></a>
                </li>
                <li class="page-item last">
                  <a href="#" class="page-link"><i class="bi bi-chevron-double-right"></i></a>
                </li>
              </ul>
            </td>
          </tr>
          </tfoot>
          <!-- //pagination -->

        </table>
        <!-- //결재할 문서 목록 -->

      </div>
    </div>
  </div>
</div>
</body>
<script src="resources/js/common.js"></script>
</html>