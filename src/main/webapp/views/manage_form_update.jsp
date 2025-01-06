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
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <link rel="stylesheet" href="resources/richtexteditor/rte_theme_default.css" />
    <script type="text/javascript" src="resources/richtexteditor/rte.js"></script>
    <script type="text/javascript" src="resources/richtexteditor/plugins/all_plugins.js"></script>
    <script type='text/javascript' src="resources/richtexteditor/lang/rte-lang-ko.js"></script>
    <link rel="stylesheet" href="resources/css/module_rte.css" />
    <script type="text/javascript" src="resources/js/module_rte.js"></script>
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/manage_form_list.go'">
                        <h1>문서 양식 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_form_disuse_list.go'">
                        <h1>사용하지 않는 문서 양식 관리</h1>
                    </li>
                    <li class="tst_title_item" onclick="location.href='/manage_form_wip_list.go'">
                        <h1>작성중인 문서 양식</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <c:import url="manage_form_update_module.jsp" />
            </div>
        </div>
    </div>
</div>
<c:import url="manage_form_update_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/manage_form_update.js"></script>
</html>