<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 조직 추가하기 -->
<div id="meeting_event_modal" class="tst_modal tst_modal_input tst_modal_update">
    <div class="tst_modal_container">
        <div class="tst_modal_header">
            <h1 class="tst_modal_title">조직 정보 수정하기</h1>
            <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_update')"></i>
        </div>
        <form action="./organization_update.do" method="POST" id="organization-update-form">
        <input type="hidden" name="dept_idx" value="${deptinfo.dept_idx}" />
            <div class="tst_modal_body">
                <ul class="list_no_desc list_block">
                    <li>
                        <label class="form_label">조직명</label>
                        <input type="text" name="dept_name" value="${deptinfo.dept_name}" maxlength="100" placeholder="조직명을 입력하세요" />
                    </li>
                    <li>
                        <label class="form_label">직무</label>
                        <textarea rows="5" name="dept_duty" maxlength="1000" placeholder="담당 직무를 입력하세요">${deptinfo.dept_duty}</textarea>
                    </li>
                    <li>
                        <p class="min font_subtle">상위 조직</p>
                        <div>
                            <c:choose>
					            <c:when test="${deptinfo.dept_depth == 3}">
					                <select name="dept_high" id="high_dept">
					                    <c:if test="${deptinfo.dept_high != null}">
					                        <option selected value="${deptinfo.dept_high}">${highdeptinfo.dept_name}</option>
					                    </c:if> 
					                    <c:forEach var="dept" items="${deptList}">
								            <!-- 선택된 상위 부서와 중복되지 않는 항목만 추가 -->
								            <c:if test="${dept.dept_idx != deptinfo.dept_high}">
								                <option value="${dept.dept_idx}">${dept.dept_name}</option>
								            </c:if>
								        </c:forEach>
					                </select>
					            </c:when>       
					            <c:when test="${deptinfo.dept_depth == 2}">
					                <select name="dept_high" id="high_dept" disabled>
					                    <c:if test="${deptinfo.dept_high != null}">
					                        <option selected value="${deptinfo.dept_high}">${highdeptinfo.dept_name}</option>
					                    </c:if>
					                </select>
					            </c:when>          
					            <c:otherwise>
					                <p>없음</p>
					            </c:otherwise>
					        </c:choose>
                        </div>
                    </li>
                    <li>
                        <label class="form_label">위치</label>
                        <input type="text" name="dept_addr" value="${deptinfo.dept_addr}" maxlength="1000" placeholder="위치를 입력하세요" />
                    </li>
                </ul>
            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <input type="submit" value="정보 수정하기" class="btn_primary" />
                    </div>
                    <div class="tst_col6">
                        <button type="button" class="btn_secondary" onclick="tst_modal_close('tst_modal_update')">취소하기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_update')"></div>
</div>
<!-- //조직 추가하기 -->

<script src="resources/js/module_modal.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('organization-update-form');

    form.addEventListener('submit', function (e) {
        e.preventDefault(); // 기본 제출 동작 막기

        // 정상적인 경우 폼 제출
        form.submit();
    });
});
</script>

