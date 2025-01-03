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

                    <div class="tst_flex">
                        <!-- 게시글 상세보기 -->
                        <div class="tst_col9">
                            <table class="tst_table table_align_left table_no_padding">
                                <colgroup>
                                    <col style="width: 120px" />
                                    <col style="width: auto" />
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th colspan="2">게시글</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>제목</th>
                                        <th>${board.board_type_name} ${board.board_title}</th>
                                    </tr>
                                    <tr>
                                        <th>작성자</th>
                                        <td><span onclick="tst_view_profile('${board.empl_idx}')" class="tst_pointer">${board.empl_name} (${deptName})</span></td>
                                    </tr>
                                    <tr>
                                        <th>작성</th>
                                        <td>${board.board_write_date} (마지막 수정일시: ${board.board_update_date})</td>
                                    </tr>
                                    <tr>
                                        <th>내용</th>
                                        <td><div id="content" class="content">${board.board_content}</div></td>
                                    </tr>
                                    <tr>
                                        <th class="td_align_top">댓글</th>
                                        <td>
                                            <!-- 댓글 작성 -->
                                            <form id="replyForm" action="reply_write.do" method="POST">
                                                <input type="hidden" name="board_idx" value="${board.board_idx}" />
                                                <table class="tst_table table_no_padding table_align_left table_no_underline">
                                                    <colgroup>
                                                        <col style="width: auto" />
                                                        <col style="width: 70px" />
                                                    </colgroup>
                                                    <tbody>
                                                        <tr>
                                                            <td><textarea name="reply" rows="3" placeholder="댓글을 작성하실 때 욕설 및 비속어를 삼가시기 바랍니다."></textarea></td>
                                                            <td class="td_align_right td_align_bottom">
                                                                <button type="submit" class="btn_primary btn_min">작성하기</button>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </form>
                                        </td>
                                    </tr>
                                    <tr class="td_no_underline">
                                        <td></td>
                                        <td>
                                            <table class="tst_table table_no_padding table_align_left table_no_padding tst_table_in_table">
                                                <colgroup>
                                                    <col style="width: 140px" />
                                                    <col style="width: auto" />
                                                    <col style="width: 70px" />
                                                </colgroup>
                                                <tbody id="commentList">
                                                    <!-- 댓글 목록 출력 -->
                                                    <c:forEach var="comment" items="${comments}">
                                                        <tr id="td_comment_${comment.reply_idx}" class="td_reply_${comment.reply_idx}">
                                                            <td class="td_align_top">
                                                                <h3><span onclick="tst_view_profile('${comment.empl_idx}')" class="tst_pointer">${comment.empl_name}</span></h3>
                                                                <p class="min">${comment.dept_name}/${comment.position_name}</p>
                                                                <p class="min font_subtle">${comment.reply_write_date}</p>
                                                            </td>
                                                            <td class="td_align_top">${comment.reply_content}</td>
                                                            <td class="td_align_top td_align_right">
                                                                <ul class="tst_list list_no_desc list_block">
                                                                    <li><button onclick="reply_write('${comment.reply_idx}')" class="btn_primary btn_min">댓글쓰기</button></li>
                                                                    <!-- 작성자만 볼 수 있는 버튼입니다 -->
                                                                    <li><button onclick="reply_update('${comment.reply_idx}')" class="btn_secondary btn_min">수정하기</button></li>
                                                                    <!-- 작성자만 볼 수 있는 버튼입니다 -->
                                                                </ul>
                                                            </td>
                                                        </tr>
                                                        
                                            			<form id="reReplyForm" action="re_reply_write.do" method="POST">
			                                            <tr class="disp_hide reply_write_${comment.reply_idx}">
			                                                <td></td>
			                                                <td>
			                                                    <textarea name="re_reply" rows="3" placeholder="댓글을 작성하실 때 욕설 및 비속어를 삼가시기 바랍니다."></textarea>
			                                                </td>
			                                                <td class="td_align_right td_align_top">
			                                                    <ul class="tst_list list_no_desc list_block">
			                                                        <li><button type="submit" class="btn_primary btn_min">작성하기</button></li>
			                                                        <li><button type="button" onclick="reply_write_cancel('${comment.reply_idx}')" class="btn_subtle btn_min">취소하기</button></li>
			                                                    </ul>
			                                                </td>
			                                            </tr>
			                                            <input type="hidden" name="reply_idx" value="${comment.reply_idx}" />                           
			                                            </form>
                                            		    <form id="replyUpdateForm" action="reply_update.do" method="POST">
			                                            <tr class="disp_hide reply_update_${comment.reply_idx}">
			                                                <td></td>
			                                                <td>
			                                                    <textarea name="reply" rows="3" placeholder="댓글을 작성하실 때 욕설 및 비속어를 삼가시기 바랍니다.">${comment.reply_content}</textarea>
			                                                </td>
			                                                <td class="td_align_right td_align_top">
			                                                    <ul class="tst_list list_no_desc list_block">
			                                                        <li><button type="submit" class="btn_primary btn_min">수정하기</button></li>
			                                                        <li><button type="button" onclick="update_reply_cancel('${comment.reply_idx}')" class="btn_subtle btn_min">취소하기</button></li>
			                                                    </ul>
			                                                </td>
			                                            </tr>
			                                            <!-- hidden 필드로 reply_idx 전송 -->
    													<input type="hidden" name="reply_idx" value="${comment.reply_idx}" />
			                                            </form>
                                                        <tr class="td_reply_${comment.reply_idx}">
                                                            <td class="td_no_padding" colspan="3">
                                                            
                                                                <!-- 대댓글 목록 -->
                                                                <table class="tst_table table_no_padding table_no_underline table_align_left">
                                                                    <colgroup>
                                                                        <col style="width: 20px" />
                                                                        <col style="width: 140px" />
                                                                        <col style="width: auto" />
                                                                        <col style="width: 70px" />
                                                                    </colgroup>
                                                                    <tbody>
                                                                    
                                                                        <!-- 대댓글 목록 출력 -->
                                                                        <c:forEach var="reReply" items="${comment.reReplies}">
                                                                            <tr class="reReply" id="re_reply_${reReply.re_reply_idx}">
                                                                                <td class="td_align_top"><i class="bi bi-arrow-return-right"></i></td>
                                                                                <td class="td_align_top">
                                                                                    <h3><span onclick="tst_view_profile('${reReply.empl_idx}')" class="tst_pointer">${reReply.empl_name}</span></h3>
                                                                                    <p class="min">${reReply.dept_name}/${reReply.position_name}</p>
                                                                                    <p class="min font_subtle">${reReply.re_reply_write_date}</p>
                                                                                </td>
                                                                                <td class="td_align_top">${reReply.re_reply_content}</td>
                                                                                <td class="td_align_top td_align_right">
                                                                                    <ul class="tst_list list_no_desc list_block">
                                                                                        <!-- 작성자만 볼 수 있는 버튼입니다 -->
                                                                                        <li><button onclick="re_reply_update('${reReply.re_reply_idx}')" class="btn_secondary btn_min">수정하기</button></li>
                                                                                        <!-- //작성자만 볼 수 있는 버튼입니다 -->
                                                                                    </ul>
                                                                                </td>
                                                                            </tr>
                                            		    					<form id="reReplyUpdateForm" action="re_reply_update.do" method="POST">
					                                                        <tr class="disp_hide re_reply_update_${reReply.re_reply_idx}">
					                                                            <td colspan="2"></td>
					                                                            <td>
					                                                                <textarea name="re_reply" rows="3" placeholder="댓글을 작성하실 때 욕설 및 비속어를 삼가시기 바랍니다.">${reReply.re_reply_content}</textarea>
					                                                            </td>
					                                                            <td class="td_align_right td_align_top">
					                                                                <ul class="tst_list list_no_desc list_block">
					                                                                    <li><button type="submit" class="btn_primary btn_min">수정하기</button></li>
					                                                                    <li><button type="button" onclick="update_re_reply_cancel('${reReply.re_reply_idx}')" class="btn_subtle btn_min">취소하기</button></li>
					                                                                </ul>
					                                                            </td>
					                                                        </tr>
					                                                        <input type="hidden" name="re_reply_idx" value="${reReply.re_reply_idx}" />                          
					                                                    </form>
                                                                        </c:forEach>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- //게시글 상세보기 -->

                        <div class="tst_col3">
                            <!-- 첨부 파일 목록 -->
                            <table class="tst_table table_align_left table_no_padding">
                                <colgroup>
                                    <col style="width: auto" />
                                    <col style="width: 60px" />
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th colspan="2">첨부 파일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- 첨부 파일이 있을 경우 -->
                                    <c:forEach var="file" items="${fileList}">
                                        <tr>
                                            <td>${file.ori_filename} (${file.file_size}KB)</td>
                                            <td>
                                                <!-- 다운로드 버튼 -->
                                                <button type="button" onclick="location.href='boardDownload/${file.new_filename}'" class="btn_min btn_primary">다운로드</button>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <!-- 첨부 파일이 없는 경우 -->
                                    <c:if test="${empty fileList}">
                                        <tr>
                                            <td colspan="2" class="td_align_center"><span class="font_subtle">첨부 파일이 없습니다.</span></td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                            <!-- //첨부 파일 목록 -->

                            <hr class="separator" />

                            <!-- 버튼 -->
                            <ul class="list_no_desc list_block">
                                <li><button type="button" onclick="location.href='board_list.go'" class="btn_primary btn_full">목록으로 돌아가기</button></li>

                                <!-- 게시글 수정하기 버튼, 작성자만 보이게 설정 -->
							    <c:if test="${board.empl_idx == sessionScope.empl_idx}">
								    <li><button type="button" onclick="location.href='board_update.go?board_idx=${board.board_idx}'" class="btn_secondary btn_full">게시글 수정하기</button></li>
								</c:if>
							    <!-- 게시글 수정하기 버튼, 작성자만 보이게 설정 -->
							    
							    <!-- //담당자만 볼 수 있는 버튼입니다 -->
							    <c:if test="${board.empl_idx == sessionScope.user.empl_idx}">
							        <li><button type="button" onclick="tst_modal_call('tst_modal_delete')" class="btn_subtle btn_full">게시글 삭제하기</button></li>
							    </c:if>
                                <!-- //담당자만 볼 수 있는 버튼입니다 -->
                            </ul>
                            <!-- //버튼 -->
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <c:import url="board_detail_modal.jsp" />
</body>

<script src="resources/js/common.js"></script>
<script src="resources/js/board_detail.js"></script>
</html>
