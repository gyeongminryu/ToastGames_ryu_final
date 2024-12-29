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
                                <th>{제목}</th>
                            </tr>
                            <tr>
                                <th>작성자</th>
                                <td><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명} ({부서}/{직급})</span></td>
                            </tr>
                            <tr>
                                <th>작성 </th>
                                <td>{작성일시|yyyy-MM-dd HH:mm} (마지막 수정일시: {마지막 수정일시|yyyy-MM-dd HH:mm})</td>
                            </tr>
                            <tr>
                                <th>내용</th>
                                <td><div id="content" class="content">{내용}</div></td>
                            </tr>
                            <tr>
                                <th class="td_align_top">댓글</th>
                                <td>

                                    <!-- 댓글 작성 -->
                                    <form>
                                        <table class="tst_table table_no_padding table_align_left table_no_underline">
                                            <colgroup>
                                                <col style="width: auto" />
                                                <col style="width: 70px" />
                                            </colgroup>
                                            <tbody>
                                            <tr>
                                                <td>
                                                    <textarea name="" rows="3" placeholder="댓글을 작성하실 때 욕설 및 비속어를 삼가시기 바랍니다."></textarea>
                                                </td>
                                                <td class="td_align_right td_align_bottom">
                                                    <button type="submit" class="btn_primary btn_min">작성하기</button>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </form>
                                    <!-- //댓글 작성 -->

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
                                        <tbody>

                                        <!-- 댓글 -->
                                        <tr id="td_comment_{댓글idx}" class="td_reply_{댓글idx}">
                                            <td class="td_align_top">
                                                <h3><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명}</span></h3>
                                                <p class="min">{부서}/{직급}</p>
                                                <p class="min font_subtle">{댓글 작성 일시|yyyy-MM-dd HH:mm}</p>
                                            </td>
                                            <td class="td_align_top">{댓글}</td>
                                            <td class="td_align_top td_align_right">
                                                <ul class="tst_list list_no_desc list_block">
                                                    <li><button onclick="reply_write('{댓글idx}')" class="btn_primary btn_min">댓글쓰기</button></li>

                                                    <!-- 작성자만 볼 수 있는 버튼입니다 -->
                                                    <li><button onclick="reply_update('{댓글idx}')" class="btn_secondary btn_min">수정하기</button></li>
                                                    <!-- //작성자만 볼 수 있는 버튼입니다 -->

                                                </ul>
                                            </td>
                                        </tr>
                                        <form>
                                            <tr class="disp_hide reply_write_{댓글idx}">
                                                <td></td>
                                                <td>
                                                    <textarea name="" rows="3" placeholder="댓글을 작성하실 때 욕설 및 비속어를 삼가시기 바랍니다."></textarea>
                                                </td>
                                                <td class="td_align_right td_align_top">
                                                    <ul class="tst_list list_no_desc list_block">
                                                        <li><button type="submit" class="btn_primary btn_min">작성하기</button></li>
                                                        <li><button type="button" onclick="reply_write_cancel('{댓글idx}')" class="btn_subtle btn_min">취소하기</button></li>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </form>
                                        <form>
                                            <tr class="disp_hide reply_update_{댓글idx}">
                                                <td></td>
                                                <td>
                                                    <textarea name="" rows="3" placeholder="댓글을 작성하실 때 욕설 및 비속어를 삼가시기 바랍니다.">{댓글}</textarea>
                                                </td>
                                                <td class="td_align_right td_align_top">
                                                    <ul class="tst_list list_no_desc list_block">
                                                        <li><button type="submit" class="btn_primary btn_min">수정하기</button></li>
                                                        <li><button type="button" onclick="update_reply_cancel('{댓글idx}')" class="btn_subtle btn_min">취소하기</button></li>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </form>
                                        <tr class="td_reply_{댓글idx}">
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

                                                    <!-- 대댓글 -->
                                                    <tr>
                                                        <td class="td_align_top"><i class="bi bi-arrow-return-right"></i></td>
                                                        <td class="td_align_top">
                                                            <h3><span onclick="tst_view_profile('{직원 번호}')" class="tst_pointer">{직원명}</span></h3>
                                                            <p class="min">{부서}/{직급}</p>
                                                            <p class="min font_subtle">{대댓글 작성 일시|yyyy-MM-dd HH:mm}</p>
                                                        </td>
                                                        <td class="td_align_top">{대댓글}</td>
                                                        <td class="td_align_top td_align_right">
                                                            <ul class="tst_list list_no_desc list_block">

                                                                <!-- 작성자만 볼 수 있는 버튼입니다 -->
                                                                <li><button onclick="re_reply_update('{대댓글idx}')" class="btn_secondary btn_min">수정하기</button></li>
                                                                <!-- //작성자만 볼 수 있는 버튼입니다 -->

                                                            </ul>
                                                        </td>
                                                    </tr>
                                                    <form>
                                                        <tr class="disp_hide re_reply_update_{대댓글idx}">
                                                            <td colspan="2"></td>
                                                            <td>
                                                                <textarea name="" rows="3" placeholder="댓글을 작성하실 때 욕설 및 비속어를 삼가시기 바랍니다.">{댓글}</textarea>
                                                            </td>
                                                            <td class="td_align_right td_align_top">
                                                                <ul class="tst_list list_no_desc list_block">
                                                                    <li><button type="submit" class="btn_primary btn_min">수정하기</button></li>
                                                                    <li><button type="button" onclick="update_re_reply_cancel('{대댓글idx}')" class="btn_subtle btn_min">취소하기</button></li>
                                                                </ul>
                                                            </td>
                                                        </tr>
                                                    </form>
                                                    <!-- //대댓글 -->

                                                    </tbody>
                                                </table>
                                                <!-- //대댓글 목록 -->

                                            </td>
                                        </tr>
                                        <!-- //댓글 -->

                                        <!-- 예시 -->
                                        <tr id="td_comment_132" class="td_reply_132">
                                            <td class="td_align_top">
                                                <h3><span onclick="tst_view_profile('')" class="tst_pointer">김이름</span></h3>
                                                <p class="min">오디오/대리</p>
                                                <p class="min font_subtle">2024-12-29 20:24</p>
                                            </td>
                                            <td class="td_align_top">댓글은 여기에 출력됩니다.</td>
                                            <td class="td_align_top td_align_right">
                                                <ul class="tst_list list_no_desc list_block">
                                                    <li><button onclick="reply_write('132')" class="btn_primary btn_min">댓글쓰기</button></li>
                                                    <li><button onclick="reply_update('132')" class="btn_secondary btn_min">수정하기</button></li>
                                                </ul>
                                            </td>
                                        </tr>
                                        <form>
                                            <tr class="disp_hide reply_write_132">
                                                <td></td>
                                                <td>
                                                    <textarea name="" rows="3" placeholder="댓글을 작성하실 때 욕설 및 비속어를 삼가시기 바랍니다."></textarea>
                                                </td>
                                                <td class="td_align_right td_align_top">
                                                    <ul class="tst_list list_no_desc list_block">
                                                        <li><button type="submit" class="btn_primary btn_min">작성하기</button></li>
                                                        <li><button type="button" onclick="reply_write_cancel('132')" class="btn_subtle btn_min">취소하기</button></li>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </form>
                                        <form>
                                            <tr class="disp_hide reply_update_132">
                                                <td></td>
                                                <td>
                                                    <textarea name="" rows="3" placeholder="댓글을 작성하실 때 욕설 및 비속어를 삼가시기 바랍니다.">{댓글}</textarea>
                                                </td>
                                                <td class="td_align_right td_align_top">
                                                    <ul class="tst_list list_no_desc list_block">
                                                        <li><button type="submit" class="btn_primary btn_min">수정하기</button></li>
                                                        <li><button type="button" onclick="update_reply_cancel('132')" class="btn_subtle btn_min">취소하기</button></li>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </form>
                                        <tr class="td_reply_132">
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
                                                    <tr>
                                                        <td class="td_align_top"><i class="bi bi-arrow-return-right"></i></td>
                                                        <td class="td_align_top">
                                                            <h3><span onclick="tst_view_profile('')" class="tst_pointer">김이름</span></h3>
                                                            <p class="min">프로그래밍/사원</p>
                                                            <p class="min font_subtle">2024-12-29 20:27</p>
                                                        </td>
                                                        <td class="td_align_top">대댓글은 여기에 출력됩니다.</td>
                                                        <td class="td_align_top td_align_right">
                                                            <ul class="tst_list list_no_desc list_block">
                                                                <li><button onclick="re_reply_update('235')" class="btn_secondary btn_min">수정하기</button></li>
                                                            </ul>
                                                        </td>
                                                    </tr>
                                                    <form>
                                                        <tr class="disp_hide re_reply_update_235">
                                                            <td colspan="2"></td>
                                                            <td>
                                                                <textarea name="" rows="3" placeholder="댓글을 작성하실 때 욕설 및 비속어를 삼가시기 바랍니다.">{댓글}</textarea>
                                                            </td>
                                                            <td class="td_align_right td_align_top">
                                                                <ul class="tst_list list_no_desc list_block">
                                                                    <li><button type="submit" class="btn_primary btn_min">수정하기</button></li>
                                                                    <li><button type="button" onclick="update_re_reply_cancel('235')" class="btn_subtle btn_min">취소하기</button></li>
                                                                </ul>
                                                            </td>
                                                        </tr>
                                                    </form>
                                                    </tbody>
                                                </table>
                                                <!-- //대댓글 목록 -->

                                            </td>
                                        </tr>
                                        <!-- //예시 -->

                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- //물품 정보 상세보기 -->

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
                            <tr>
                                <td>{파일명 (파일 용량kb)}</td>
                                <td>
                                    <!-- 다운로드 경로를 입력하세요 --><button type="button" onclick="location.href=''" class="btn_min btn_primary">다운로드</button>
                                </td>
                            </tr>
                            <tr>
                                <td>{파일명 (파일 용량kb)}</td>
                                <td>
                                    <!-- 다운로드 경로를 입력하세요 --><button type="button" onclick="location.href=''" class="btn_min btn_primary">다운로드</button>
                                </td>
                            </tr>

                            <!-- 첨부 파일이 없는 경우 아래와 같이 입력하세요 -->
                            <tr>
                                <td colspan="2" class="td_align_center">
                                    <span class="font_subtle">첨부 파일이 없습니다.</span>
                                </td>
                            </tr>
                            <!-- //첨부 파일이 없는 경우 아래와 같이 입력하세요 -->

                            </tbody>
                        </table>
                        <!-- //첨부 파일 목록 -->

                        <hr class="separator" />

                        <!-- 버튼 -->
                        <ul class="list_no_desc list_block">
                            <li>
                                <button type="button" onclick="location.href='/board_list'" class="btn_primary btn_full">목록으로 돌아가기</button>
                            </li>

                            <!-- 작성자만 볼 수 있는 버튼입니다 -->
                            <li>
                                <button type="button" onclick="location.href='/board_update?'" class="btn_secondary btn_full">게시글 수정하기</button>
                            </li>
                            <!-- //작성자만 볼 수 있는 버튼입니다 -->

                            <!-- 담당자만 볼 수 있는 버튼입니다 -->
                            <li>
                                <button type="button" onclick="tst_modal_call('tst_modal_delete')" class="btn_subtle btn_full">게시글 삭제하기</button>
                            </li>
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