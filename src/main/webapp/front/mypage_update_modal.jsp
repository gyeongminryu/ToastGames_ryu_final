<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 이름 정정하기 -->
<div class="tst_modal tst_modal_input tst_modal_name">
    <div class="tst_modal_container">
        <form>
            <div class="tst_modal_header">
                <h1 class="tst_modal_title">이름 정정 신청하기</h1>
                <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_name')"></i>
            </div>
            <div class="tst_modal_body">
                <ul class="tst_list list_no_desc list_block">
                    <li>
                        <label class="form_label">새 이름</label>
                        <input type="text" name="" maxlength="100" placeholder="정정한 이름을 입력하세요" />
                    </li>
                    <li>
                        <label class="form_label">주민등록 등본</label>
                        <input type="file" name="" onchange="tst_file_name(this)" />
                    </li>
                </ul>
            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <button onclick="mypage_change_name('{사원번호}')" class="btn_primary btn_full">이름 정정 신청하기</button>
                    </div>
                    <div class="tst_col6">
                        <button onclick="tst_modal_close('tst_modal_name')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_name')"></div>
</div>
<!-- //이름 정정하기 -->

<!-- 비밀번호 변경하기 -->
<div class="tst_modal tst_modal_input tst_modal_password">
    <div class="tst_modal_container">
        <form>
            <div class="tst_modal_header">
                <h1 class="tst_modal_title">비밀번호 변경하기</h1>
                <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_password')"></i>
            </div>
            <div class="tst_modal_body">
                <ul class="tst_list list_no_desc list_block">
                    <li>
                        <label class="form_label">기존 비밀번호</label>
                        <input type="password" name="" maxlength="100" placeholder="기존 비밀번호를 입력하세요" />
                        <!-- 비밀번호가 틀렸을 때 클래스 'disp_hide'를 제거하세요 --><p class="min font_caution disp_hide">비밀번호를 확인하세요.</p>
                        <!-- 비밀번호가 맞았을 때 클래스 'disp_hide'를 제거하세요 --><p class="min disp_hide">기존 비밀번호를 확인했습니다. 새 비밀번호를 입력하세요.</p>
                    </li>
                    <li>
                        <hr class="separator" />
                    </li>
                    <li>
                        <label class="form_label">새 비밀번호</label>
                        <input type="password" name="" maxlength="100" placeholder="새 비밀번호를 입력하세요" />
                        <hr class="separator separator_min" />
                        <input type="password" name="" maxlength="100" placeholder="새 비밀번호를 입력하세요" />
                        <!-- 비밀번호와 확인값이 틀릴 때 클래스 'disp_hide'를 제거하세요 --><p class="min font_caution disp_hide">비밀번호와 비밀번호 확인값은 동일해야 합니다.</p>
                    </li>
                    <li>
                        <hr class="separator" />
                    </li>
                </ul>
            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <button type="button" onclick="location.href='<!-- 비밀번호를 변경하는 경로를 입력하세요 -->'" class="btn_primary btn_full">비밀번호 변경하기</button>
                    </div>
                    <div class="tst_col6">
                        <button type="button" onclick="tst_modal_close('tst_modal_password')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_password')"></div>
</div>
<!-- //비밀번호 변경하기 -->

<!-- 증명 서류 제출하기 -->
<div class="tst_modal tst_modal_input tst_modal_file">
    <div class="tst_modal_container">
        <form>
            <div class="tst_modal_header">
                <h1 class="tst_modal_title">증명 서류 제출하기</h1>
                <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_file')"></i>
            </div>
            <div class="tst_modal_body">
                <ul class="tst_list list_no_desc list_block">
                    <li>
                        <label class="form_label">서류</label>
                        <input type="file" name="" onchange="tst_file_summit(this)" multiple />
                        <p class="min font_caution">개당 2mb 미만, 최대 5개의 파일만 첨부할 수 있습니다. pdf, jpg, png 파일만 첨부할 수 있습니다.</p>
                    </li>
                </ul>
            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <button type="button" onclick="mypage_summit_file('{파일 키}')" class="btn_primary btn_full">증명 서류 제출하기</button>
                    </div>
                    <div class="tst_col6">
                        <button type="button" onclick="tst_modal_close('tst_modal_file')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_file')"></div>
</div>
<!-- //증명 서류 제출하기 -->

<!-- 직인 파일 제출하기 -->
<div class="tst_modal tst_modal_input tst_modal_stamp">
    <div class="tst_modal_container">
        <form>
            <div class="tst_modal_header">
                <h1 class="tst_modal_title">직인 파일 제출하기</h1>
                <i class="bi bi-dash-circle-dotted" onclick="tst_modal_close('tst_modal_stamp')"></i>
            </div>
            <div class="tst_modal_body">
                <ul class="tst_list list_no_desc list_block">
                    <li>
                        <label class="form_label">직인</label>
                        <input type="file" name="" onchange="tst_file_stamp(this)" />
                        <p class="min font_caution">2mb 미만의 gif, png 파일만 첨부할 수 있습니다.</p>
                    </li>
                    <li>
                        <div class="tst_flex">
                            <div id="img_preview" class="tst_col12 align_center align_middle"></div>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="tst_modal_footer">
                <div class="tst_flex">
                    <div class="tst_col6">
                        <button type="button" onclick="mypage_summit_stamp('{사원 번호}')" class="btn_primary btn_full">직인 파일 제출하기</button>
                    </div>
                    <div class="tst_col6">
                        <button type="button" onclick="tst_modal_close('tst_modal_stamp')" class="btn_secondary btn_full">이전 화면으로 돌아가기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="tst_modal_backdrop" onclick="tst_modal_close('tst_modal_stamp')"></div>
</div>
<!-- //직인 파일 제출하기 -->

<script src="resources/js/module_modal.js"></script>