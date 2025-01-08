// doc_idx 가져오기
const searchParams= new URLSearchParams(window.location.search);
var doc_idx = searchParams.get('doc_idx');
var form_idx = '';

// 에디터 설정하기
var editor = new RichTextEditor("#div_editor", configView);

// 문서 정보 출력하기
var tags = '';
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
            form_idx = data.info.form_idx;
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
    $.ajax({
        type: 'post',
        url: 'document_reference.ajax',
        data: {
            'doc_idx': idx
        },
        dataType: 'json',
        success: function(data) {
            // 목록 출력
            referPrint(data.list);
            //console.log(data.list);
        },
        error: function(e) {
            //console.log(e);
        }
    });

    // 첨부파일 출력하기
    $.ajax({
        type: 'post',
        url: 'document_file.ajax',
        data: {
            'doc_idx': idx
        },
        dataType: 'json',
        success: function(data) {
            // 목록 출력
            filePrint(data.list);
            //console.log(data.list);
        },
        error: function(e) {
            //console.log(e);
        }
    });
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
    //console.log(list);
    tags = '';

    for (let i = 0; i < list.length; i++) {
        tags += '<tr>';
        tags += '<td class="td_align_top td_no_padding">';
        tags += '<img src="' + list[i].empl_profile + '" alt="' + list[i].empl_name + '의 프로필 사진" class="approval_profile_image" /></td>';
        tags += '<td class="approval_line_info">';
        tags += '<h4 class="font_subtle approval_datetime_subtle">' + list[i].appr_date + '</h4>';

        switch (list[i].line_order) {
            case 0:
                tags += '<h4>작성</h4>';
                break;
            case 1:
                tags += '<h4>1차 결재</h4>';
                break
            case 2:
                tags += '<h4>2차 결재</h4>';
                break;
            case 3:
                tags += '<h4>3차 결재</h4>';
                break
        }

        tags += '<p><span onClick="tst_view_profile(\'' + list[i].empl_idx + '\')" class="tst_pointer">';
        tags += list[i].empl_name + ' (' + list[i].dept_name + '/' + list[i].position_name + ')</span></p>';
        tags += '</td>';
        tags += '</tr>';
    }
    //console.log(tags);

    document.getElementsByClassName('appr_list')[0].innerHTML = tags;
    const elem = document.getElementsByClassName('appr_list')[0].querySelector('tr:last-child').getElementsByClassName('approval_line_info');
    elem.item(0).getElementsByTagName('h4')[1].innerHTML = '최종 결재';
}

function referPrint(list) {
    //console.log(list);
    tags = '';

    if (list.length === 0) {
        tags += '<tr>';
        tags += '<td colspan="2" class="td_align_center">';
        tags += '<span class="font_subtle">참조인이 없습니다.</span>';
        tags += '</td>';
        tags += '</tr>';
    } else {
        for (let i = 0; i < list.length; i++) {
            tags += '<tr>';
            tags += '<th>참조 ' + i + '</th>';
            tags += '<td><span onclick="tst_view_profile(\'' + list[i].ref_empl_idx + '\')" class="tst_pointer">' + list[i].empl_name + '</span></td>';
            tags += '</tr>';
        }
    }
    //console.log(tags);

    document.getElementsByClassName('refer_list')[0].innerHTML = tags;
}

function filePrint(list) {
    //console.log(list);
    tags = '';

    if (list.length === 0 || (list.length !== 0 && list[0] == null)) {
        tags += '<tr>';
        tags += '<td colspan="2" class="td_align_center">';
        tags += '<span class="font_subtle">첨부 파일이 없습니다.</span>';
        tags += '</td>';
        tags += '</tr>';
    } else {
        for (let i = 0; i < list.length; i++) {
            tags += '<tr>';
            tags += '<td>' + list[i].ori_filename + '.' + list[i].file_type + ' (' + list[i].file_size + 'kb)</td>';
            tags += '<td><button type="button" onclick="location.href=/\'' + list[i].addr;
            tags += list[i].new_filename + '.' + list[i].file_type + '\'" class="btn_min btn_primary">다운로드</button></td>';
            tags += '</tr>';
        }
    }
    //console.log(tags);

    document.getElementsByClassName('file_list')[0].innerHTML = tags;
}

// 문서를 복사하여 새 문서 작성하기
function copyThisDoc() {
    location.href = '/approval_copy_doc.do?doc_idx=' + doc_idx + '&form_idx=' + form_idx;
}