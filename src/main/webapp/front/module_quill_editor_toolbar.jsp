<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/module_quill_editor.css" />
<link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.core.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.core.js"></script>

<div id="module_quill_toolbar">
    <button type="button" id="toolbar_btn_bold"><i class="bi bi-type-bold"></i></button>
    <button type="button" id="toolbar_btn_italic"><i class="bi bi-type-italic"></i></button>
    <button type="button" id="toolbar_btn_strike"><i class="bi bi-type-strikethrough"></i></button>
    <button type="button" id="toolbar_btn_underline"><i class="bi bi-type-underline"></i></button>
    <button type="button" id="toolbar_btn_superscript"><i class="bi bi-superscript"></i></button>
    <button type="button" id="toolbar_btn_script"><i class="bi bi-subscript"></i></button>
    <span class="toolbar_seperator">|</span>
    <button type="button" id="toolbar_btn_h1"><i class="bi bi-type-h1"></i></button>
    <button type="button" id="toolbar_btn_h2"><i class="bi bi-type-h2"></i></button>
    <span class="toolbar_seperator">|</span>
    <button type="button" id="toolbar_btn_left"><i class="bi bi-text-left"></i></button>
    <button type="button" id="toolbar_btn_center"><i class="bi bi-text-center"></i></button>
    <button type="button" id="toolbar_btn_right"><i class="bi bi-text-right"></i></button>
    <button type="button" id="toolbar_btn_justify"><i class="bi bi-justify"></i></button>
    <span class="toolbar_seperator">|</span>
    <button type="button" id="toolbar_btn_ol"><i class="bi bi-list-ol"></i></button>
    <button type="button" id="toolbar_btn_ul"><i class="bi bi-list-ul"></i></button>
    <span class="toolbar_seperator">|</span>
    <button type="button" id="toolbar_btn_indentleft"><i class="bi bi-text-indent-left"></i></button>
    <button type="button" id="toolbar_btn_indentright"><i class="bi bi-text-indent-right"></i></button>
    <span class="toolbar_seperator">|</span>
    <button type="button" id="toolbar_btn_seperator"><i class="bi bi-dash-lg"></i></button>
    <button type="button" id="toolbar_btn_link"><i class="bi bi-link-45deg"></i></button>
    <button type="button" id="toolbar_btn_image"><i class="bi bi-image"></i></button>
</div>

<div id="module_quill_editor">
    <p>살다가, 살아보다가 더는 못 살 것 같으면</p><p>아무도 없는 산비탈에 구덩이를 파고 들어가</p><p>누워 곡기를 끊겠다고 너는 말했지</p><p><br></p><p>나라도 곁에 없으면</p><p>당장 일어나 산으로 떠날 것처럼</p><p>두 손에 심장을 꺼내 쥔 사람처럼</p><p>취해 말했지</p><p><br></p><p>나는 너무 놀라 번개같이,</p><p>번개같이 사랑을 발명해야만 했네</p><p><br></p><p>- 사랑의 발명, 이영광</p>
</div>
<input type="hidden" name="content" id="module_quill_copier" value="" />

<div id="module_quill_counter"></div>

<script src="resources/js/module_quill_editor.js"></script>


