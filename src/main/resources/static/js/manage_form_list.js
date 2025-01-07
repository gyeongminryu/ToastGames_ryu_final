// 주소 가져오기
const path = window.location.pathname;
var sort = '';
//console.log(path);

setSort(path);

function setSort(path) {
    switch(path) {
        case "/manage_form_list.go":
            sort = "use";
            break;
        case "/manage_form_disuse_list.go":
            sort = "disuse";
            break;
        case "/manage_form_wip_list.go":
            sort = "wip";
            break;
    }
}

// 검색 옵션 및 검색어 가져오기
const searchParams = new URLSearchParams(window.location.search);
var opt = searchParams.get('opt');
var keyword = searchParams.get('keyword');

fillSearchForm(opt, keyword);

function fillSearchForm(opt, keyword) {
    const opts = document.getElementsByName('opt')[0].options;

    if (opt != null) {
        for (var i = 0; i < opts.length; i++) {
            opts[i].removeAttribute('selected');
        }
        opts[opt].setAttribute('selected', 'selected');
    }

    document.getElementsByName('keyword')[0].value = keyword;
}

// 목록 출력하기
var showPage = 1;
var cnt = 15;
var vPages = 10;

pageShow(showPage);

function pageShow(page) {
    $.ajax({
        type: 'post',
        url: 'manage_form_list.ajax',
        data: {
            'page': page,
            'cnt': cnt,
            'opt': opt,
            'keyword': keyword,
            'sort': sort
        },
        dataType: 'json',
        success: function(data) {
            // 목록 출력
            listPrint(data.list, data.totalIdx, data.currentPage);
            //console.log(data.list);

            // 페이지네이션 출력
            $('#pagination').twbsPagination({
                startPage: data.page,
                totalPages: data.totalPages,
                visiblePages: vPages,
                onPageClick: function(evt, page) {
                    pageShow(page);
                }
            });
        },
        error: function(e) {
            //console.log(e);
        }
    });
}

function listPrint(list, totalIdx, currentPage) {
    //console.log(list);
    //console.log(list.length);
    let tags = '';

    if (list.length > 0) {
        for (let i = 0; i < list.length; i++) {
            //console.log(list[i]);
            tags += '<tr>';
            tags += '<td>' + (totalIdx - ((currentPage - 1) * cnt) - i) + '</td>';
            tags += '<td class="td_align_left">';
            tags += '<span onClick="previewPrint(' + list[i].form_idx + ')" class="tst_badge_min btn_primary margin_right tst_pointer">미리보기</span>';

            if (sort === 'wip') {
                tags += '<span onClick="location.href=\'/manage_form_wip_update.go?form_idx=' + list[i].form_idx + '\'" class="tst_pointer">' + list[i].form_subject + '</span>';
            } else {
                tags += '<span onClick="location.href=\'/manage_form_detail.go?form_idx=' + list[i].form_idx + '\'" class="tst_pointer">' + list[i].form_subject + '</span>';
            }

            // 1차 결재선
            if (list[i].dept_idx_1 === 0 && list[i].duty_idx_1 === 0) {
                tags += '<td>없음</td>';
            } else if (list[i].dept_idx_1 === 0 && list[i].duty_idx_1 !== 0) {
                tags += '<td>작성자 소속/' + list[i].duty_name_1 + '</td>';
            } else {
                tags += '<td>' + list[i].dept_name_1 + '/' + list[i].duty_name_1 + '</td>';
            }

            // 2차 결재선
            if (list[i].dept_idx_2 === 0 && list[i].duty_idx_2 === 0) {
                tags += '<td>없음</td>';
            } else if (list[i].dept_idx_2 === 0 && list[i].duty_idx_2 !== 0) {
                tags += '<td>작성자 소속/' + list[i].duty_name_2 + '</td>';
            } else {
                tags += '<td>' + list[i].dept_name_2 + '/' + list[i].duty_name_2 + '</td>';
            }

            // 3차 결재선
            if (list[i].dept_idx_3 === 0 && list[i].duty_idx_3 === 0) {
                tags += '<td>없음</td>';
            } else if (list[i].dept_idx_3 === 0 && list[i].duty_idx_3 !== 0) {
                tags += '<td>작성자 소속/' + list[i].duty_name_3 + '</td>';
            } else {
                tags += '<td>' + list[i].dept_name_3 + '/' + list[i].duty_name_3 + '</td>';
            }
            tags += '</tr>';
        }
    } else {
        tags += '<tr class="rent_list_no_data"><td colspan="5" class="td_no_data">';
        tags += '<p><i class="bi bi-file-earmark-break"></i></p><h3>검색 조건에 해당하는 문서 양식이 없습니다.</h3>';
        tags += '</td></tr>';
    }

    document.getElementsByClassName('form_list')[0].innerHTML = tags;
}

// 양식 미리보기
function previewPrint(idx) {
    //console.log(form_idx);

    // no_data 화면 감추기
    document.getElementsByClassName('select_form_no_data')[0].classList.add('disp_hide');

    // 미리보기 표시하기
    document.getElementsByClassName('select_form_data')[0].classList.remove('disp_hide');

    // 양식 태그 불러오기
    $.ajax({
        type: 'post',
        url: 'manage_form_preview.ajax',
        data: {
            'form_idx': idx
        },
        dataType: 'json',
        success: function(data) {
            // 목록 출력
            printTags(data.idx, data.preview);
        },
        error: function(e) {
            //console.log(e);
        }
    });
}

function printTags(idx, content) {
    //console.log(idx);
    //console.log(content);

    var editor = new RichTextEditor("#div_editor", configViewNone);
    editor.setHTMLCode(content);
    //console.log(editor.document.firstChild.childNodes[1]);
    editor.document.firstChild.childNodes[1].style.width = '200%';
    editor.document.firstChild.childNodes[1].style.height = '50%';
    editor.document.firstChild.childNodes[1].style.margin = '0 0 0 -50%';
    editor.document.firstChild.childNodes[1].style.transform = 'scale(0.5)';

    let tags = '';
    switch(sort) {
        case "use":
            tags += '<button onclick="location.href=\'/manage_form_update.go?form_idx=\''+ idx +'" class="btn_secondary">문서 양식 수정하기</button>';
            break;
        case "disuse":
            tags += '<button onclick="location.href=\'/manage_form_restore.do?form_idx=\''+ idx +'" class="btn_secondary">문서 양식 복구하기</button>';
            break;
        case "wip":
            tags += '<button onclick="location.href=\'/manage_form_wip_update.go?form_idx=\''+ idx +'" class="btn_secondary">이어서 작성하기</button>';
            break;
    }
    //console.log(tags);

    document.getElementsByClassName('select_form_button')[0].innerHTML = tags;
}