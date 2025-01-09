// 팀 목록 토글
function show_team_list(elem, no){
    // no: 부서 번호
    let number = "'"+no+"'";
    elem.parentElement.parentElement.nextElementSibling.classList.remove('disp_hide');
    elem.parentElement.innerHTML = '<i class="bi bi-caret-down-fill" onclick="hide_team_list(this, '+number+')"></i>';
}

function hide_team_list(elem, no){
    // no: 부서 번호
    let number = "'"+no+"'";
    elem.parentElement.parentElement.nextElementSibling.classList.add('disp_hide');
    elem.parentElement.innerHTML = '<i class="bi bi-caret-right-fill" onclick="show_team_list(this, '+number+')"></i>';
}

// 열람 가능한 문서만 볼 수 있도록 필터링하는 기능 토글
var accessible_filtering = false;

function accessible_filtering_on(elem) {
    $('#pagination').twbsPagination('destroy');
    elem.classList.add("disp_hide");
    elem.nextElementSibling.classList.remove("disp_hide");
    accessible_filtering = true;
    pageShow(showPage);
}

function accessible_filtering_off(elem) {
    $('#pagination').twbsPagination('destroy');
    elem.classList.add("disp_hide");
    elem.previousElementSibling.classList.remove("disp_hide");
    accessible_filtering = false;
    pageShow(showPage);
}

// 검색 옵션 및 검색어, 부서 번호 가져오기
const searchParams= new URLSearchParams(window.location.search);
var opt = searchParams.get('opt');
var keyword = searchParams.get('keyword');
var dept1 = searchParams.get('dept1');
var dept2 = searchParams.get('dept2');

fillSearchForm(opt, keyword);

function fillSearchForm(opt, keyword) {
    const opts = document.getElementsByName('opt')[0].options;

    if (opt != null) {
        for (var i = 0; i < opts.length; i++) {
            opts[i].removeAttribute('selected');
        }

        switch (opt) {
            case 'doc_subject':
                opts[0].setAttribute('selected', 'selected');
                break;
            case 'doc_content':
                opts[1].setAttribute('selected', 'selected');
                break;
            case 'form_subject':
                opts[2].setAttribute('selected', 'selected');
                break;
            case 'empl_name_0':
                opts[3].setAttribute('selected', 'selected');
                break;
            case 'empl_name_1':
                opts[4].setAttribute('selected', 'selected');
                break;
            case 'empl_name_2':
                opts[5].setAttribute('selected', 'selected');
                break;
            case 'empl_name_3':
                opts[6].setAttribute('selected', 'selected');
                break;
        }
    }

    document.getElementsByName('keyword')[0].value = keyword;
}

// 부서 목록 출력하기
printDepartment(2, 0);

function printDepartment(depth, high) {
    $.ajax({
        type: 'post',
        url: 'document_list_call_dept.ajax',
        data: {
            'dept_depth': depth,
            'dept_high': high
        },
        dataType: 'json',
        success: function(data) {
            // 목록 출력
            executeFunctions(data.list);
            //console.log(data.list);
        },
        error: function(e) {
            //console.log(e);
        }
    });
}

// 비동기 문제 해결
async function executeFunctions(list) {
    await printDeptList(list);
    callTeamList(list);
}

// 부서 목록 출력
async function printDeptList(list) {
    //console.log(list);
    let tags = '';

    tags += '<tr><td></td><th class="td_no_padding">';
    tags += '<span onClick="location.href=\'/document_list\'">전체 보기</span>';
    tags += '</th></tr>';

    for (let i = 0; i < list.length; i++) {
        //console.log(dept1);
        //console.log(list[i].dept_idx);
        if (dept1 == list[i].dept_idx) {
            tags += '<tr class="td_bg_medium">';
        } else {
            tags += '<tr>';
        }
        tags += '<td><i class="bi bi-caret-right-fill" onClick="show_team_list(this, ' + list[i].dept_idx + ')"></i></td>';
        tags += '<th class="td_no_padding"><span onClick="location.href=\'/document_list?dept1=' + list[i].dept_idx + '\'">';
        tags += list[i].dept_name + '</span>';
        tags += '</th></tr>';
        tags += '<tr id="dept_list_' + list[i].dept_idx + '" class="disp_hide"></tr>';
        printTeam(3, list[i].dept_idx);
    }
    //console.log(tags);

    //console.log(document.getElementsByClassName('dept_list_high')[0]);
    document.getElementsByClassName('dept_list_high')[0].innerHTML = tags;
}

// 하위 부서(팀) 목록 출력
async function callTeamList(list) {
    for (let i = 0; i < list.length; i++) {
        printTeam(3, list[i].dept_idx);
    }
}

function printTeam(depth, high) {
    $.ajax({
        type: 'post',
        url: 'document_list_call_dept.ajax',
        data: {
            'dept_depth': depth,
            'dept_high': high
        },
        dataType: 'json',
        success: function(data) {
            // 목록 출력
            printTeamList(data.list, high);
            //console.log(data.list);
        },
        error: function(e) {
            //console.log(e);
        }
    });
}

function printTeamList(list, high) {
    //console.log(list);
    let tags = '';

    tags += '<td colspan="2" class="td_no_padding">';
    tags += '<table class="tst_table tst_table_in_table table_align_left">';
    tags += '<colgroup><col style="width: 23px;" /><col style="width: auto;" /></colgroup>';

    for (let i = 0; i < list.length; i++) {
        if (dept2 == list[i].dept_idx) {
            tags += '<tr id="dept_list_' + list[i].dept_idx + '" class="font_subtle td_bg_medium">';
            document.getElementById('dept_list_' + high).classList.remove("disp_hide");
        } else {
            tags += '<tr id="dept_list_' + list[i].dept_idx + '" class="font_subtle">';
        }
        tags += '<td></td>';
        tags += '<td><span onClick="location.href=\'/document_list?dept2=' + list[i].dept_idx + '\'">';
        tags += list[i].dept_name + '</span>';
        tags += '</td></tr>';
    }
    //console.log(tags);

    //console.log(document.getElementById('dept_list_' + high));
    document.getElementById('dept_list_' + high).innerHTML = tags;
}

// 목록 출력하기
var showPage = 1;
var cnt = 15;
var vPages = 10;

pageShow(showPage);

function pageShow(page) {
    $.ajax({
        type: 'post',
        url: 'document_list.ajax',
        data: {
            'page': page,
            'cnt': cnt,
            'opt': opt,
            'keyword': keyword,
            'dept1': dept1,
            'dept2': dept2,
            'accessible_filtering': accessible_filtering
        },
        dataType: 'json',
        success: function(data) {
            // 목록 출력
            printList(data.list, data.totalIdx, data.currentPage);
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

function printList(list, totalIdx, currentPage) {
    //console.log(list);
    let tags = '';

    if (list.length > 0) {
        for (let i = 0; i < list.length; i++) {
            //console.log(list[i]);
            tags += '<tr>';
            tags += '<td>' + (totalIdx - ((currentPage - 1) * cnt) - i) + '</td>';
            tags += '<td class="td_align_left">' + list[i].form_subject + '</td>'
            tags += '<td class="td_align_left">';

            if (list[i].authority) {
                tags += '<span class="tst_badge_min btn_secondary margin_right">열람 가능</span>';
                tags += '<span onclick="location.href=\'/document_detail?doc_idx=' + list[i].doc_idx + '\'" class="tst_pointer">';
            } else {
                tags += '<span class="tst_badge_min btn_disable margin_right">열람 불가</span>';
                tags += '<span class="font_cancellation font_subtle">';
            }

            tags += list[i].doc_subject;

            if (list[i].cnt_file > 0) {
                tags += '<span class="margin_left"><i class="bi bi-paperclip"></i></span>';
            }

            tags += '</span></td>';
            tags += '<td><span onclick="tst_view_profile(\'' + list[i].empl_idx_0 + '\')" class="tst_pointer">';
            tags += list[i].empl_name_0 + ' (' + list[i].dept_name_0 + '/' + list[i].position_name_0 + ')</span></td>';
            tags += '<td>' + list[i].doc_write_date + '</td>';

            if (list[i].dept_idx_3 > 0 || list[i].dept_idx_3 !== null || list[i].dept_idx_3 !== 'null') {
                tags += '<td><span onclick="tst_view_profile(\'' + list[i].empl_idx_3 + '\')" class="tst_pointer">';
                tags += list[i].empl_name_3 + ' (' + list[i].dept_name_3 + '/' + list[i].position_name_3 + ')</span></td>';
            } else if (list[i].dept_idx_2 > 0 || list[i].dept_idx_2 !== null || list[i].dept_idx_2 !== 'null') {
                tags += '<td><span onclick="tst_view_profile(\'' + list[i].empl_idx_2 + '\')" class="tst_pointer">';
                tags += list[i].empl_name_2 + ' (' + list[i].dept_name_2 + '/' + list[i].position_name_2 + ')</span></td>';
            } else {
                tags += '<td><span onclick="tst_view_profile(\'' + list[i].empl_idx_1 + '\')" class="tst_pointer">';
                tags += list[i].empl_name_1 + ' (' + list[i].dept_name_1 + '/' + list[i].position_name_1 + ')</span></td>';
            }

            tags += '<td>' + list[i].doc_write_date + '</td>';
            tags += '</tr>';
        }
    } else {
        tags += '<tr class="document_list_no_data"><td colspan="7" class="td_no_data">';
        tags += '<p><i class="bi bi-file-earmark-break"></i></p><h3>검색 조건에 해당하는 문서가 없습니다.</h3>';
        tags += '</td></tr>';
    }

    document.getElementsByClassName('doc_list')[0].innerHTML = tags;
}