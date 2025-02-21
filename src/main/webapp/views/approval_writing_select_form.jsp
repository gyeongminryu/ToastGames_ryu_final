<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_search_min.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/module_table.css" />

    <%--rich text editor--%>
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/approval_writing_select_form'">
                        <h1>문서 양식 선택</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="tst_flex">

                    <div class="tst_col3">
                        <table class="tst_table table_no_padding">
                            <colgroup>
                                <col style="width: auto;" />
                                <col style="width: 60px;" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th colspan="2">문서 양식 선택</th>
                            </tr>
                            </thead>
                            <tbody>

                            <!-- 양식 이름 검색 -->
                            <tr>
                                <td colspan="2">
                                    <hr class="separator" />
                                    <form>
                                        <div class="tst_search_container">
                                            <div class="tst_search_input">
                                                <input type="text" name="keyword" maxlength="50" placeholder="검색어를 입력하세요" id="search"/>
                                            </div>
                                            <div class="tst_search_icon">
                                                <button type="button" onclick="approval_form_search()" class="btn_icon"><i class="bi bi-search"></i></button>
                                            </div>
                                        </div>
                                    </form>
                                </td>
                            </tr>
                            </tbody>
                            <!-- //양식 이름 검색 -->

                            <!-- 양식 목록 -->
                            <tbody class="tst_form_list_container">
                                <c:forEach items="${form_list}" var="form">
                                <tr>
                                    <td class="td_align_left">
                                        <a onclick="approval_data_form_preview(${form.form_idx})">${form.form_subject}</a>
                                    </td>
                                    <td>
                                        <button onclick="location.href='/approval_write.go?form_idx=${form.form_idx}'" class="btn_subtle btn_min">선택하기</button>
                                    </td>
                                </tr>
                                <!-- //양식 목록 -->
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- 문서 양식 미리보기 -->
                    <p class="tst_col9">
                        <table class="tst_table table_no_padding">
                            <thead>
                            <tr>
                                <th>미리보기</th>
                            </tr>
                            </thead>

                            <!-- 선택한 문서 양식이 없을 경우 -->
                            <tfoot>
                            <tr class="approval_received_no_data"><!-- 양식을 선택했을 경우 클래스 disp_hide를 추가하세요. -->
                                <td class="td_no_data">
                                    <p>
                                        <i class="bi bi-file-earmark-text"></i>
                                    </p>
                                    <h3>문서 양식 이름을 클릭하면</h3>
                                    <h3>기본형을 확인할 수 있습니다.</h3>
                                </td>
                            </tr>
                            </tfoot>
                            <!-- //선택한 문서 양식이 없을 경우 -->

                            <!-- 문서 양식을 선택했을 경우 -->
                            <tbody class="html_rendering">
                                <tr>
                                    <td id="div_editor"></td>
                                </tr>
                            </tbody>

                            <tfoot id="form_select">

                            </tfoot>
                            <!-- //문서 양식을 선택했을 경우 -->

                        </table>
                    </div>
                    <!-- //문서 양식 미리보기 -->

                </div>
            </div>
        </div>
    </div>
</div>
<c:import url="notify_all.jsp" />

</body>
<script src="resources/js/common.js"></script>
<script src="/resources/js/approval_writing_select_form.js"></script>
<script src="/resources/js/approval_search.js"></script>
<script>
</script>
</html>