<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 댓글 조회하기 -->
<div class="tst_modal tst_modal_wide tst_modal_review">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">리뷰</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_review')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="list_no_desc list_tab">
                <li class="list_tab_item item_google list_tab_item_active">
                    구글 플레이
                </li>
                <li class="list_tab_item item_appmarket">
                    앱스토어
                </li>
            </ul>

            <table class="print_percentage">
                <colgroup>
                    <col style="width: 60px" />
                    <col style="width: 70px" />
                    <col style="width: auto" />
                </colgroup>
                <tbody>
                <tr class="print_percentage_graph print_grade_5">
                    <td rowspan="5">
                        <p><i class="bi bi-star-fill"></i></p>
                        <h1 class="totalScore"></h1>
                    </td>
                    <td>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                    </td>
                    <td>
                        <div class="progress_bar_frame"></div>
                        <div class="progress_bar_fill"></div>
                    </td>
                </tr>
                <tr class="print_percentage_graph print_grade_4">
                    <td>
                        <i class="bi bi-star"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                    </td>
                    <td>
                        <div class="progress_bar_frame"></div>
                        <div class="progress_bar_fill"></div>
                    </td>
                </tr>
                <tr class="print_percentage_graph print_grade_3">
                    <td>
                        <i class="bi bi-star"></i>
                        <i class="bi bi-star"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                    </td>
                    <td>
                        <div class="progress_bar_frame"></div>
                        <div class="progress_bar_fill"></div>
                    </td>
                </tr>
                <tr class="print_percentage_graph print_grade_2">
                    <td>
                        <i class="bi bi-star"></i>
                        <i class="bi bi-star"></i>
                        <i class="bi bi-star"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                    </td>
                    <td>
                        <div class="progress_bar_frame"></div>
                        <div class="progress_bar_fill"></div>
                    </td>
                </tr>
                <tr class="print_percentage_graph print_grade_1">
                    <td>
                        <i class="bi bi-star"></i>
                        <i class="bi bi-star"></i>
                        <i class="bi bi-star"></i>
                        <i class="bi bi-star"></i>
                        <i class="bi bi-star-fill"></i>
                    </td>
                    <td>
                        <div class="progress_bar_frame"></div>
                        <div class="progress_bar_fill"></div>
                    </td>
                </tr>
                </tbody>
            </table>

            <div class="waiting"><i class="bi bi-reception-4"></i></div>

            <ul class="tst_list list_no_desc list_block comment_area"></ul>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_review')"></div>
</div>
<!-- //댓글 조회하기 -->

<!-- <script src="resources/js/module_modal.js"></script> -->