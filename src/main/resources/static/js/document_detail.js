// doc_idx 가져오기
const searchParams= new URLSearchParams(window.location.search);
var doc_idx = searchParams.get('doc_idx');

// 에디터 설정하기
var editor = new RichTextEditor("#div_editor", configView);

// 문서 정보 출력하기
pageShow(doc_idx);

function pageShow(idx) {

    // 문서 기본 정보 출력하기
    $.ajax({
        type: 'post',
        url: 'document_detail.ajax',
        data: {
            'doc_idx': idx
        },
        dataType: 'json',
        success: function(data) {
            // 목록 출력
            infoPrint(data.info);
            //console.log(data.info);
        },
        error: function(e) {
            //console.log(e);
        }
    });

    // 결재선 출력하기
    $.ajax({
        type: 'post',
        url: 'document_line.ajax',
        data: {
            'doc_idx': idx
        },
        dataType: 'json',
        success: function(data) {
            // 목록 출력
            apprPrint(data.list);
            //console.log(data.list);
        },
        error: function(e) {
            //console.log(e);
        }
    });

    // 참조인 출력하기

    // 첨부파일 출력하기
    //
}

function infoPrint(info) {
    //console.log(info);
    let writer = '';
    writer += '<span onClick="tst_view_profile(\'' + info.doc_empl_idx + '\')" class="tst_pointer">';
    writer += info.empl_name_0 + ' (' + info.dept_name_0 + '/' + info.position_name_0 + ')</span>';

    document.getElementsByClassName('doc_subject')[0].innerHTML = info.doc_subject;
    document.getElementsByClassName('form_subject')[0].innerHTML = info.form_subject;
    document.getElementsByClassName('doc_empl')[0].innerHTML = writer;

    if (info.appr_date_3 != null) {
        document.getElementsByClassName('appr_date')[0].innerHTML = info.appr_date_3;
        //console.log("appr_date_3 is "+info.appr_date_3);
    } else if (info.appr_date_2 != null) {
        document.getElementsByClassName('appr_date')[0].innerHTML = info.appr_date_2;
        //console.log("appr_date_2 is "+info.appr_date_2);
    } else {
        document.getElementsByClassName('appr_date')[0].innerHTML = info.appr_date_1;
        //console.log("appr_date_1 is "+info.appr_date_1);
    }

    //document.getElementsByClassName('appr_date')[0].innerHTML = info.appr_date_1

    editor.setHTMLCode(info.doc_content);
}

function apprPrint(list) {
    console.log(list);
    let tags = '';

    for (let i = 0; i < list.length; i++) {
        tags += '<tr>';
        tags += '<td class="td_align_top td_no_padding">';
        tags += '<img src="' + list.empl_profile + ' alt="' + list.empl_name + '의 프로필 사진" class="approval_profile_image"/></td>';
        tags += '<td class="approval_line_info">';
        tags += '<h4 class="font_subtle approval_datetime_subtle">' + list.empl_date + '</h4>';
            //<h4>작성자</h4>
            //<p><span onClick="tst_view_profile('{직원 번호}')" className="tst_pointer">{직원명} ({부서}/{직급})</span></p>
        tags += '</td>';
        tags += '</tr>';
    }
}