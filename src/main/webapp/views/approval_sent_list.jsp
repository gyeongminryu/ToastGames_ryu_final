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
          <li class="tst_title_item" onclick="location.href='/approval_received_list.go'">
            <h1>수신함</h1>
          </li>
          <li class="tst_title_item tst_title_item_active" onclick="location.href='/approval_send_list.go'">
            <h1>발신함</h1>
          </li>
          <li class="tst_title_item" onclick="location.href='/approval_writing_list.go'">
            <h1>작성중인 문서</h1>
          </li>
        </ul>
        <!-- //제목 -->

        <!-- 게시물 분류 -->
        <ul class="tst_tablist list_no_desc list_inline">
          <li class="tst_tablist_item all tst_tablist_item_active" onclick="approval_list_filter('전체','탭','sent',this)">
            <h3>전체 보기</h3>
          </li>
          <li class="tst_tablist_item unread" onclick="approval_list_filter('결재 대기','탭','sent',this)">
            <h3>읽지 않음</h3>
          </li>
          <li class="tst_tablist_item continue" onclick="approval_list_filter('결재 진행','탭','sent',this)">
            <h3>결재중</h3>
          </li>
          <li class="tst_tablist_item approved" onclick="approval_list_filter('최종 승인','탭','sent',this)">
            <h3>결재 승인</h3>
          </li>
          <li class="tst_tablist_item reject" onclick="approval_list_filter('반려','탭','sent',this)">
            <h3>결재 반려</h3>
          </li>
          <li class="tst_tablist_item">
            <!-- 문서 검색 -->
            <form>
              <div class="tst_search_container">
                <div class="tst_search_input">
                  <input type="text" name="keyword" maxlength="50" placeholder="검색어를 입력하세요" id = "search"/>
                </div>
                <div class="tst_search_icon">
                  <button type="button" onclick="approval_list('sent')" class="btn_icon"><i class="bi bi-search"></i></button>
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
            <col style="width: 180px" />
            <col style="width: 140px" />
            <col style="width: auto" />
            <col style="width: 150px" />
            <col style="width: 150px" />
            <col style="width: 150px" />
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

            <c:if test="${sent_list.size()<=0}">
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
            </c:if>
            <c:if test="${sent_list.size()>0}">
                <c:forEach items="${sent_list}" var="list">
                <tr>
                  <td class="td_align_left td_no_padding">
                    <span onclick="tst_view_profile('${list.empl_idx}')" class="tst_pointer">${list.empl_name} (${list.dept_name}/${list.position_name})</span>
                  </td>
                  <td>${list.form_subject}</td>
                  <td class="td_align_left">
                    <c:choose>
                      <c:when test="${list.approval_state == '결재 대기' || list.approval_state == '결재 진행'}">
                        <span class="tst_badge_min btn_secondary margin_right">${list.approval_state}</span>
                      </c:when>
                      <c:when test="${list.approval_state == '최종 승인'}">
                        <span class="tst_badge_min btn_subtle margin_right">${list.approval_state}</span>
                      </c:when>

                      <c:otherwise>
                        <span class="tst_badge_min btn_primary margin_right">${list.approval_state}</span>
                      </c:otherwise>

                    </c:choose>


                    <c:choose>
                      <c:when test="${list.doc_subject == null}">
                      <span onclick="location.href='/approval_sent_detail.go?doc_idx=${list.doc_idx} &type=\'sent\''" class="tst_pointer">제목 없음</span>
                      </c:when>

                      <c:when test="${list.doc_subject != null}">
                        <c:choose>
                          <c:when test="${list.doc_subject == '결재가 최종 승인되었습니다.' || list.doc_subject =='결재가 반려되었습니다.'}">
                          <span onclick="location.href='/approval_sent_detail.go?doc_idx=${list.doc_idx}&type=sent'" class="tst_pointer font_subtle">${list.doc_subject}</span>
                          </c:when>
                          <c:otherwise>
                            <span onclick="location.href='/approval_sent_detail.go?doc_idx=${list.doc_idx}&type=sent'" class="tst_pointer">${list.doc_subject}</span>
                          </c:otherwise>
                        </c:choose>


                      </c:when>
                    </c:choose>
                  </td>
                  <td>${list.update_date}</td>
                  <td>${list.approval_response_date}</td>
                  <td>${list.end_date}</td>
                </tr>
                </c:forEach>
            </c:if>


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
                </li><%--
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
                </li>--%>
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
<c:import url="notify_all.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="/resources/js/approval_list_filter.js"></script>
<script src="/resources/js/approval_search.js"></script>

<script>
  var sent_list = "${sent_list}";
  var filter = "${filter}";
</script>
</html>