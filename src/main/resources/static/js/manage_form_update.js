// form_idx 가져오기
const searchParams = new URLSearchParams(window.location.search);
var form_idx = searchParams.get('form_idx');

// 에디터 설정하기
var editor = new RichTextEditor("#div_editor", configDocument);

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
    document.getElementsByName('subject')[0].value = info.form_subject;

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

// 임시 저장
function temporary_save() {
    const subject = document.getElementsByName('subject')[0].value;
    const content = editor.getHTMLCode();
    //console.log('input value: ' + subject + '/' + content);

    if (subject != null || subject != '' || subject != 'null') {
        $.ajax({
            type: 'post',
            url: 'manage_form_save.ajax',
            data: {
                'form_idx': form_idx,
                'form_subject': subject,
                'form_content': content
            },
            dataType: 'json',
            success: function(data) {
                console.log('success');
            },
            error: function(e) {
                //console.log(e);
            }
        });
    }
}