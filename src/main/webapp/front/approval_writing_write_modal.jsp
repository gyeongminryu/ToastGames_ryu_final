<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/module_modal.css" />
<link rel="stylesheet" type="text/css" href="resources/css/approval_send_modal.css" />

<!-- 결재선 선택하기 -->
<div class="tst_modal tst_modal_auto tst_modal_select">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">결재선 선택하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_select')"></i>
        </div>
        <div class="tst_modal_body">
            <div class="tst_flex">
                <div class="tst_col5">
                    <table class="tst_table table_align_left">
                        <colgroup>
                            <col style="width: 23px;" />
                            <col style="width: auto;" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th colspan="2">부서 선택</th>
                        </tr>
                        </thead>

                        <!-- 부서 목록 출력 -->
                        <tbody class="tst_pointer">
                        <tr>
                            <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this, '부서번호')"></i></td><!-- 한꺼번에 불러오실 경우 '부서 번호' 지우시면 됩니다.-->
                            <!-- 부서 내 직원을 출력하는 함수를 입력하세요 --><td onclick="{함수}" class="tst_pointer">{부서명}</td>
                        </tr>

                        <!-- 팀 목록 출력 -->
                        <tr class="disp_hide">
                            <td></td>
                            <td>
                                <table class="tst_table table_align_left table_no_padding">
                                    <tbody>
                                    <tr>
                                        <!-- 팀 내 직원을 출력하는 함수를 입력하세요 --><td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <!-- //팀 목록 출력 -->

                        <!-- 예시 -->
                        <tr>
                            <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this, '부서번호')"></i></td>
                            <td onclick="{함수}">{부서명}</td>
                        </tr>
                        <tr class="disp_hide">
                            <td></td>
                            <td>
                                <table class="tst_table table_align_left table_no_padding">
                                    <tbody>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    <tr>
                                        <td onclick="{함수}">{팀명}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <!-- //예시 -->

                        </tbody>
                        <!-- //부서 목록 출력 -->

                    </table>
                </div>
                <div class="tst_col7">
                    <table class="tst_table table_align_left">
                        <colgroup>
                            <col style="width: 40px;" />
                            <col style="width: auto;" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th colspan="2">직원 선택</th>
                        </tr>
                        </thead>

                        <!-- 선택한 문서 양식이 없을 경우 -->
                        <tfoot>
                        <tr class="approval_select_no_data"><!-- 양식을 선택했을 경우 클래스 disp_hide를 추가하세요. -->
                            <td colspan="2" class="td_no_data">
                                <p><i class="bi bi-person-standing"></i></p>
                                <h3>부서명/팀명을 클릭하면</h3>
                                <h3>직원 목록을 확인할 수 있습니다.</h3>
                            </td>
                        </tr>
                        </tfoot>
                        <!-- //선택한 문서 양식이 없을 경우 -->

                        <tbody class="tst_pointer">

                        <!-- 직원 정보 -->
                        <tr>
                            <!-- 직원을 결재선 혹은 참조에 추가하는 함수를 입력하세요 --><tr onclick="{함수}">
                            <td class="td_align_top td_no_padding">
                                <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                            </td>
                            <td>
                                <p>{직원명 (부서/직급)}</p>
                                <p class="min font_subtle">{직책}</p>
                            </td>
                        </tr>
                        <!-- //직원 정보 -->

                        <!-- 예시 -->
                        <tr>
                            <tr onclick="{함수}">
                            <td class="td_align_top td_no_padding">
                                <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                            </td>
                            <td>
                                <p>{직원명 (부서/직급)}</p>
                                <p class="min font_subtle">{직책}</p>
                            </td>
                        </tr>
                        <tr>
                        <tr onclick="{함수}">
                            <td class="td_align_top td_no_padding">
                                <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="{직원명}의 프로필 사진" class="approval_profile_image" />
                            </td>
                            <td>
                                <p>{직원명 (부서/직급)}</p>
                                <p class="min font_subtle">{직책}</p>
                            </td>
                        </tr>
                        <!-- //예시 -->

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="tst_modal_footer">
            <!-- 결재선 선택 경로를 입력하세요 --><button onclick="location.href='/approval_writing_write'" class="btn_primary">결재선 변경하기</button>
            <button onclick="tst_modal_close('tst_modal_select')" class="btn_secondary">이전 화면으로 돌아가기</button>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_select')"></div>
</div>
<!-- //결재선 선택하기 -->

<!-- 상신하기 > 서명하기/직인찍기 -->
<div class="tst_modal tst_modal_input tst_modal_send">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">서명/직인</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_send')"></i>
        </div>
        <form>
            <div class="tst_modal_body">

                <!-- 서명/직인 선택 -->
                <ul class="tst_tablist list_no_desc list_inline">
                    <li class="tst_tablist_item item_sign tst_tablist_item_active" onclick="select_type('sign')">
                        <h3>서명</h3>
                    </li>
                    <li class="tst_tablist_item item_stamp" onclick="select_type('stamp')">
                        <h3>직인</h3>
                    </li>
                </ul>
                <!-- //서명/직인 선택 -->

                <!-- 서명란 -->
                <div class="sign_area"></div>
                <!-- //서명란 -->

                <!-- 직인란 -->
                <div class="stamp_area tst_flex align_center disp_hide">
                    <p class="min font_subtle">직인 변경은 인사과에 문의하세요.</p>

                    <!-- 직인 이미지 -->
                    <i class="bi bi-c-circle" style="color: var(--tst-color-warning); font-size: 48px;"></i>
                    <!-- //직인 이미지 -->
                </div>
                <!-- //직인란 -->

            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <!-- 상신 경로를 입력하세요 --><button type="submit" onclick="location.href='/approval_sent_detail?appr_idx='" class="btn_primary btn_full">상신하기</button>
                    </div>
                    <div class="tst_col6">
                        <button type="button" class="btn_secondary btn_full" onclick="tst_modal_close('tst_modal_select')">취소하기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_send')"></div>
</div>
<!-- //상신하기 > 서명하기/직인찍기 -->

<!-- 취소하기 -->
<div class="tst_modal tst_modal_alert tst_approval_cancel_modal">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">작성 취소하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_cancel')"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <p>작성중인 문서를 삭제하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <!-- 삭제 경로를 입력하세요 --><button onclick="location.href='/approval_writing_list'" class="btn_primary btn_full">삭제하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="tst_modal_close('tst_modal_cancel')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_cancel')"></div>
</div>
<!-- //취소하기 -->

<script src="resources/js/module_modal.js"></script>
<script src="resources/js/approval_send_modal.js"></script>