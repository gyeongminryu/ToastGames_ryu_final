<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/approval_send_modal.css" />

<!-- 직원 선택하기 -->
<div class="tst_modal tst_modal_wide tst_modal_select">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">직원 선택하기</h1>
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
                            <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this)"></i></td><!-- 한꺼번에 불러오실 경우 '부서 번호' 지우시면 됩니다.-->
                            <td onclick="show_second_team_list(this)" class="tst_pointer">부서</td>
                        </tr>

                        <!-- 부서원 목록 출력 -->
					        <tr class="disp_hide">
					            <td></td>
					            <td>
					                <table class="tst_table table_align_left table_no_padding">
					                    <tbody>
									    <c:forEach var="dept" items="${deptList}">
					                        <tr>
					                            <td onclick="get_dept_empl(${dept.dept_idx})">${dept.dept_name}</td>
					                        </tr>
									    </c:forEach>
					                    </tbody>
					                </table>
					            </td>
					        </tr>
                        <!-- //부서원 목록 출력 -->

                        <!-- 예시 -->
                        <tr>
                            <td><i class="bi bi-caret-right-fill" onclick="show_team_list(this)"></i></td>
                            <td onclick="show_second_team_list(this)" class="tst_pointer">팀</td>
                        </tr>
					        <tr class="disp_hide">
					            <td></td>
					            <td>
					                <table class="tst_table table_align_left table_no_padding">
					                    <tbody>
									    <c:forEach var="team" items="${teamList}">
					                        <tr>
					                            <td onclick="get_team_empl(${team.team_idx})">${team.team_name}</td>
					                        </tr>
									    </c:forEach>
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

                    <!-- 검색 -->
                    <form onsubmit="return take_empl_search(event);">
                        <div class="tst_search_container">
                            <div class="tst_search_select">
                                <select id="tst_search_select_category" name="category">
                                    <option value="dept_name">부서 검색</option>
                                    <option value="position_name">직급 검색</option>
                                    <option value="empl_name">사원명 검색</option>
                                </select>
                            </div>
                            <div class="tst_search_input">
                                <input type="text" name="keyword" id="search_keyword" maxlength="50" placeholder="검색어를 입력하세요" />
                            </div>                                                    
                            <div class="tst_search_icon">
                                <button type="submit" class="btn_icon"><i class="bi bi-search"></i></button>
                            </div>
                        </div>
                    </form>
                    <!-- //검색 -->

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

                        <tbody class="tst_pointer" id="empl_list">

                        <!-- 직원 정보 -->
                        <!-- <tr>
                        <tr onclick="select_transfer_empl(item.empl_idx)">
                            <td class="td_align_top td_no_padding">
                                <img src="http://t1.daumcdn.net/brunch/service/user/hgs3/image/9JOYw3gnSsO-4srSbvW4LaGayQg.png" alt="item.empl_name의 프로필 사진" class="approval_profile_image" />
                            </td>
                            <td>
                                <p>item.empl_name (item.dept_name/item.position_name)</p>
                                <p class="min font_subtle">item.duty_name</p>
                            </td>
                        </tr> -->
                        <!-- //직원 정보 -->

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="tst_modal_footer">
            <button onclick="tst_modal_close('tst_modal_select')" class="btn_secondary">이전 화면으로 돌아가기</button>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_select')"></div>
</div>
<!-- //직원 선택하기 -->

<!-- 인계하기 -->
<div class="tst_modal tst_modal_alert tst_modal_transfer">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">공용 물품 인계하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="cancelTransfer()"></i>
        </div>
        <div class="tst_modal_body">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <h3><span id="prod_name" class="prod_name">${detail.prod_name}</span><!--  ▶ <span id="empl_name" class="empl_name"></span> --></h3>
                </li>
                <li>
                    <p>해당 물품을 인계하시겠습니까?</p>
                </li>
                <li>
                    <hr class="separator" />
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <div class="tst_flex">
                <div class="tst_col6">
                    <button onclick="confirmTransfer()" class="btn_primary btn_full" id="product_transfer_button">물품 인계하기</button>
                </div>
                <div class="tst_col6">
                    <button onclick="cancelTransfer()" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="cancelTransfer()"></div>
</div>
<!-- //인계하기 -->

<script src="resources/js/manage_rent_transfer_modal.js"></script>
