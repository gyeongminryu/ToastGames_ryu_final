<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 파일 삭제하기 -->
<div class="tst_modal tst_modal_wide tst_modal_review">

    <!-- 삭제할 파일의 idx가 아래 입력창 값으로 저장됩니다. -->
    <input type="hidden" name="tst_modal_param" id="tst_modal_param" value="" />

    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">리뷰</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_review')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="list_no_desc list_tab">
                <li class="list_tab_item list_tab_item_active" onclick="printCommentOnGoogle()">
                    구글 플레이
                </li>
                <li class="list_tab_item" onclick="printCommentOnAppstore()">
                    앱스토어
                </li>
            </ul>

            <ul class="tst_list list_no_desc list_block">

                <li class="comment_container">
                    <div class="comment_information">
                        <h3>닉네임</h3>
                        <p class="min">
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <span class="font_subtle"> 2024년 11월 21일</span>
                        </p>
                    </div>
                    <div class="comment_content">
                        <p>
                            복귀 유저의 별점입니다 :) 우선 복귀한 후 부터 하루도 빠짐없이 열심히 원신 즐기고 있고 업데이트도 매번 새롬고 즐겁게 하고있습니다. 폰 버전과 PC버전 콘솔 까지 전부 사용하는 유저로써 우선 용량은 예전보다는 최적화 되었고 발열은 어떤기기든 어쩔수 없는것 같습니다. 그 외 게임적으로 봤을 때 편의선 개성이 필요한 부분은 꽤 존재하지만 캐릭터와 스토리, 설정 등 모두 너무 재미있고 마음에 들어요. 용량이 엄청난 만큼 맵도 가득 차있고 탐사도 늘 새롭습니다.
                        </p>
                    </div>
                </li>


            </ul>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_review')"></div>
</div>
<!-- //파일 삭제하기 -->

<script src="resources/js/module_modal.js"></script>