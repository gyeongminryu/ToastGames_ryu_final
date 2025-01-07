<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/module_modal.css" />

<!-- 프로필 조회 -->
<div class="tst_modal tst_modal_profile_min">
    <!-- 조회할 직원의 사원번호가 아래 입력창 값으로 저장됩니다. -->
    <input type="hidden" name="tst_modal_employee_idx" id="tst_modal_employee_idx" value="" />

    <div class="tst_modal_container">
        <div class="tst_modal_body align_center">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <img src="memberFiles/${memberInfo.empl_profile}" class="topnav_modal_profile_image" />
                </li>
                <li>
                    <h3 id="empl_name">${memberInfo.empl_name}</h3>
                </li>
                <li>
                    <table class="tst_table table_align_left">
                        <colgroup>
                            <col style="width: 90px;" />
                            <col style="width: auto;" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th colspan="2">프로필</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th class="td_bg_subtle">부서</th>
                                <td id="dept_name">${memberInfo.dept_name}</td>
                            </tr>
                            <tr>
                                <th class="td_bg_subtle">직책</th>
                                <td id="duty_name">${memberInfo.duty_name}</td>
                            </tr>
                            <tr>
                                <th class="td_bg_subtle">유선전화</th>
                                <td id="empl_cmp_phone">${memberInfo.empl_cmp_phone}</td>
                            </tr>
                            <tr>
                                <th class="td_bg_subtle">이메일</th>
                                <td id="empl_cmp_email">${memberInfo.empl_cmp_email}</td>
                            </tr>
                        </tbody>
                    </table>
                </li>
            </ul>
        </div>
        <div class="tst_modal_footer">
            <ul class="tst_list list_no_desc list_block">
                <li>
                    <button onclick="tst_close_profile()" class="btn_text btn_full">프로필 닫기</button>
                </li>
            </ul>
        </div>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_close_profile()"></div>
</div>
<!-- //프로필 조회 -->
