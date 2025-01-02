<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />

    <link rel="stylesheet" href="resources/richtexteditor/rte_theme_default.css" />
    <script type="text/javascript" src="resources/richtexteditor/rte.js"></script>
    <script type="text/javascript" src="resources/richtexteditor/plugins/all_plugins.js"></script>
    <script type='text/javascript' src="resources/richtexteditor/lang/rte-lang-ko.js"></script>

    <style></style>
</head>
<body>
<c:import url="layout_topnav.jsp" />
<div class="tst_container">
    <c:import url="layout_leftnav.jsp" />
    <div class="tst_container_right">
        <div class="tst_contents">
            <div class="tst_contents_inner">


                <!-- rte -->
                <div id="div_editor1" >
                    <p>Initial Document Content</p>
                </div>
                <!-- //rte -->



            </div>
        </div>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>
<script>
    var editor1cfg = {
        skin: "rounded-corner",
        maxTextLength: 1000,
        editorResizeMode: "height",
        showFloatParagraph: false,
        showTagList: false,
        url_base: "resources/richtexteditor"
    };
    editor1cfg.toolbar = "tsttoolbar";
    editor1cfg.toolbar_tsttoolbar = "{bold,italic,underline}|{fontsize}|{forecolor,backcolor}|removeformat|"
        + "{justifyleft,justifycenter,justifyright,justifyfull}|{indent,outdent}|{insertorderedlist,insertunorderedlist}|"
        + "inserttable|insertdate|{insertlink,insertimage,insertcode}|code"
        + "#"
        + "{find,undo,redo,fullscreenenter,fullscreenexit,togglemore}";
    var editor1 = new RichTextEditor("#div_editor1", editor1cfg);
</script>
</html>