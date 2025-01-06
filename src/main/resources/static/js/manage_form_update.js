// form_idx 가져오기
const searchParams = new URLSearchParams(window.location.search);
var form_idx = searchParams.get('form_idx');

// 에디터 설정하기
var editor = new RichTextEditor("#div_editor", configDocument);

// 양식 불러오기
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
    document.getElementById('div_editor_copy').innerHTML = editor.getHTMLCode();
    //console.log(editor.getHTMLCode());

    // 결재선
    // 1차 결재선
    tags = '';

    if (info.dept_idx_1 === 0 && info.duty_idx_1 === 0) {
        tags += '없음';
    } else if (info.dept_idx_1 === 0 && info.duty_idx_1 !== 0) {
        tags += '작성자 소속/' + info.duty_name_1;
        document.getElementById('approval_1').style.display = '';
        setHtmlCode();
    } else {
        tags += info.dept_name_1 + '/' + info.duty_name_1;
        document.getElementById('approval_1').style.display = '';
        setHtmlCode();
    }

    document.getElementsByClassName('form_approval_line')[0].innerHTML = tags;

    // 2차 결재선
    tags= '';

    if (info.dept_idx_2 === 0 && info.duty_idx_2 === 0) {
        tags += '없음';
    } else if (info.dept_idx_2 === 0 && info.duty_idx_2 !== 0) {
        tags += '작성자 소속/' + info.duty_name_2;
        document.getElementById('approval_2').style.display = '';
        setHtmlCode();
    } else {
        tags += info.dept_name_2 + '/' + info.duty_name_2;
        document.getElementById('approval_2').style.display = '';
        setHtmlCode();
    }

    document.getElementsByClassName('form_approval_line')[1].innerHTML = tags;

    // 3차 결재선
    tags= '';

    if (info.dept_idx_3 === 0 && info.duty_idx_3 === 0) {
        tags += '없음';
    } else if (info.dept_idx_3 === 0 && info.duty_idx_3 !== 0) {
        tags += '작성자 소속/' + info.duty_name_3;
        document.getElementById('approval_3').style.display = '';
        setHtmlCode();
    } else {
        tags += info.dept_name_3 + '/' + info.duty_name_3;
        document.getElementById('approval_3').style.display = '';
        setHtmlCode();
    }

    document.getElementsByClassName('form_approval_line')[2].innerHTML = tags;
}

// 임시 저장
function saveForm() {
    const subject = document.getElementsByName('subject')[0].value;
    const content = editor.getHTMLCode();
    //console.log('input value: ' + subject + '/' + content);

    if (subject != null || subject != '' || subject != 'null') {
        $.ajax({
            type: 'post',
            url: 'manage_form_update.ajax',
            data: {
                'form_idx': form_idx,
                'form_subject': subject,
                'form_content': content
            },
            dataType: 'json',
            success: function(data) {
                //console.log(data.success);
                saveMsg();
            },
            error: function(e) {
                //console.log(e);
            }
        });
    }
}

//const saveInterval = setInterval(saveForm(),120000);

// 문서 양식을 저장할 시 메시지 출력
function saveMsg() {
    document.getElementsByClassName('msg')[0].innerHTML = '<span class="font_caution">문서 양식을 저장했습니다.</span>';
    setTimeout(function() {
        document.getElementsByClassName('msg')[0].innerHTML = '2분마다 자동으로 저장됩니다.';
    }, 5000);
}

// 에디터를 수정하면 카피 div에 html 코드를 저장
editor.attachEvent("change", function () {
    //console.log(editor.getHTMLCode());
    document.getElementById('div_editor_copy').innerHTML = editor.getHTMLCode();
});

// 카피 div의 코드를 에디터에 덮어 씌우기
function setHtmlCode() {
    document.querySelectorAll('#div_editor_copy td:empty').forEach(function(td) {
        td.innerHTML = '<br />';
    });
    let html = document.getElementById('div_editor_copy').innerHTML;
    editor.setHTMLCode(html);
}

// 제목을 입력하면 문서에 반영
function syncTitleToEditor(elem) {
    document.getElementById('form_title').innerHTML = elem.value;
    setHtmlCode();
}

// 문서를 수정하면 제목에 반영 - 사용 안 함
//console.log(editor.document.getElementById('form_title').innerHTML);
function syncTitleToForm() {
    document.getElementsByName('subject')[0].value = document.getElementById('form_title').innerHTML;
    setHtmlCode();
}

// 이전 화면으로 돌아가기
document.getElementsByClassName('form_return')[0].addEventListener('click', () => {
    location.href = '/manage_form_detail.go?form_idx=' + form_idx;
});