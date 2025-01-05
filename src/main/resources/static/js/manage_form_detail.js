// 검색 옵션 및 검색어 가져오기
const searchParams = new URLSearchParams(window.location.search);
var form_idx = searchParams.get('form_idx');

// 에디터 설정하기
var editor = new RichTextEditor("#div_editor", configView);

// 양식 미리보기
previewPrint(form_idx);

function previewPrint(form_idx) {
    //console.log(form_idx);

    // 양식 태그 불러오기
    $.ajax({
        type: 'post',
        url: 'manage_form_detail.ajax',
        data: {
            'form_idx': form_idx
        },
        dataType: 'json',
        success: function(data) {
            // 목록 출력
            printInfo(data.info);
        },
        error: function(e) {
            //console.log(e);
        }
    });
}

function printInfo(info) {
    //console.log(info);
    let tags= '';

    // 문서 양식명
    document.getElementsByClassName('info_subject')[0].innerHTML = info.form_subject;
    document.getElementsByClassName('info_subject')[1].innerHTML = info.form_subject;

    // 문서 최초 작성자
    tags = '';
    tags += '<span onclick="tst_view_profile(\'' + info.form_handler_idx + '\')" class="tst_pointer">' + info.empl_name + ' (부서/직위)</span>';
    tags += '<span class="font_subtle"> (최초 작성 일시: )</span>';
    document.getElementsByClassName('info_initial_issue')[0].innerHTML = tags;

    // 문서 최종 수정자
    tags = '';
    tags += '<span onclick="tst_view_profile(\'idx\')" class="tst_pointer">최종 수정자 (부서/직위)</span>';
    tags += '<span class="font_subtle"> (최종 수정 일시: )</span>';
    document.getElementsByClassName('info_final_issue')[0].innerHTML = tags;

    // 문서
    editor.setHTMLCode(info.form_content);

    // 결재선
    // 1차 결재선
    tags = '';

    if (info.dept_idx_1 === 0 && info.duty_idx_1 === 0) {
        tags += '없음';
    } else if (info.dept_idx_1 === 0 && info.duty_idx_1 !== 0) {
        tags += '작성자 소속/' + info.duty_name_1;
    } else {
        tags += info.dept_name_1 + '/' + info.duty_name_1;
    }

    document.getElementsByClassName('form_approval_line')[0].innerHTML = tags;

    // 2차 결재선
    tags= '';

    if (info.dept_idx_2 === 0 && info.duty_idx_2 === 0) {
        tags += '없음';
    } else if (info.dept_idx_2 === 0 && info.duty_idx_2 !== 0) {
        tags += '작성자 소속/' + info.duty_name_2;
    } else {
        tags += info.dept_name_2 + '/' + info.duty_name_2;
    }

    document.getElementsByClassName('form_approval_line')[1].innerHTML = tags;

    // 3차 결재선
    tags= '';

    if (info.dept_idx_3 === 0 && info.duty_idx_3 === 0) {
        tags += '없음';
    } else if (info.dept_idx_3 === 0 && info.duty_idx_3 !== 0) {
        tags += '작성자 소속/' + info.duty_name_3;
    } else {
        tags += info.dept_name_3 + '/' + info.duty_name_3;
    }

    document.getElementsByClassName('form_approval_line')[2].innerHTML = tags;
}

// 양식 수정하기
document.getElementsByClassName('form_update')[0].addEventListener('click', () => {
    location.href = '/manage_form_update.do?form_idx=' + form_idx;
});

// 양식 작성하기
document.getElementsByClassName('form_write')[0].addEventListener('click', () => {
    location.href = '/manage_form_write.do?form_idx=' + form_idx;
});

// 양식 삭제하기
document.getElementsByClassName('form_disuse')[0].addEventListener('click', () => {
    location.href = '/manage_form_delete.do?form_idx=' + form_idx;
});