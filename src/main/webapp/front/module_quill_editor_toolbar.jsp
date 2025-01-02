<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/module_quill_editor.css" />
<link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.core.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.core.js"></script>

<div id="module_quill_toolbar">
    <button type="button" onclick="quill.format('bold', true);" class="toolbar_btn_bold"><i class="bi bi-type-bold"></i></button>
    <button type="button" onclick="quill.format('italic', true);" class="toolbar_btn_italic"><i class="bi bi-type-italic"></i></button>
    <button type="button" onclick="quill.format('strikeThrough', true);" class="toolbar_btn_strike"><i class="bi bi-type-strikethrough"></i></button>
    <button type="button" onclick="quill.format('underline', true);" class="toolbar_btn_underline"><i class="bi bi-type-underline"></i></button>
    <button type="button" onclick="quill.format('superSubscript', true);" class="toolbar_btn_superscript"><i class="bi bi-superscript"></i></button>
    <button type="button" onclick="quill.format('subscript', true);" class="toolbar_btn_script"><i class="bi bi-subscript"></i></button>
    <span class="toolbar_seperator">|</span>
    <button type="button" onclick="quill.format('header', 1);" class="toolbar_btn_h1"><i class="bi bi-type-h1"></i></button>
    <button type="button" onclick="quill.format('header', 2);" class="toolbar_btn_h2"><i class="bi bi-type-h2"></i></button>
    <span class="toolbar_seperator">|</span>
    <button type="button" onclick="quill.format('align', 'left');" class="toolbar_btn_left"><i class="bi bi-text-left"></i></button>
    <button type="button" onclick="quill.format('align', 'center');" class="toolbar_btn_center"><i class="bi bi-text-center"></i></button>
    <button type="button" onclick="quill.format('align', 'right');" class="toolbar_btn_right"><i class="bi bi-text-right"></i></button>
    <button type="button" onclick="quill.format('align', 'justify');" class="toolbar_btn_justify"><i class="bi bi-justify"></i></button>
    <span class="toolbar_seperator">|</span>
    <!--<button type="button" onclick="insert_list('ol');" class="toolbar_btn_ol"><i class="bi bi-list-ol"></i></button>
    <button type="button" onclick="insert_list('ul');" class="toolbar_btn_ul"><i class="bi bi-list-ul"></i></button>
    <span class="toolbar_seperator">|</span>
    <button type="button" class="toolbar_btn_indentleft"><i class="bi bi-text-indent-left"></i></button>
    <button type="button" class="toolbar_btn_indentright"><i class="bi bi-text-indent-right"></i></button>
    <span class="toolbar_seperator">|</span>-->
    <button type="button" onclick="insert_divider()" class="toolbar_btn_divider"><i class="bi bi-dash-lg"></i></button>
    <button type="button" onclick="insert_link()" class="toolbar_btn_link"><i class="bi bi-link-45deg"></i></button>
    <!-- <button type="button" class="toolbar_btn_image"><i class="bi bi-image"></i></button> -->
</div>

<div id="module_quill_editor"></div>
<input type="hidden" name="content" id="module_quill_copier" value="" />

<div id="module_quill_counter"></div>

<script src="resources/js/module_quill_editor.js"></script>