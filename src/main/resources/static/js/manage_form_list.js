var showPage = 1;
var cnt = 20;
var vPages = 10;

pageShow(showPage);

function pageShow(page) {
    $.ajax({
        type: 'post',
        url: 'manage_form_list.ajax',
        data: {
            'page': page,
            'cnt': cnt
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
    console.log(list.length);
    let tags = '';

    if (list.length > 0) {
        for (let i = 0; i < list.length; i++) {
            console.log(list[i]);
            tags += '<tr>';
            tags += '<td>' + (totalIdx - ((currentPage - 1) * cnt) - i) + '</td>';
            tags += '<td class="td_align_left">';
            tags += '<span onClick="previewPrint(\'' + list[i].form_idx + '\')" class="tst_badge_min btn_primary margin_right tst_pointer">미리보기</span>';
            tags += '<span onClick="location.href=\'/manage_form_detail?form_idx=' + list[i].form_idx + '\'" class="tst_pointer">' + list[i].form_subject + '</span>';

            // 1차 결재선
            if (list[i].dept_idx_1 === 0 && list[i].duty_idx_1 === 0) {
                tags += '<td>없음</td>';
            } else if (list[i].dept_idx_1 === 0 && list[i].duty_idx_1 !== 0) {
                tags += '<td>작성자 소속/' + list[i].duty_name_1 + '</td>';
            } else {
                tags += '<td>' + list[i].dept_name_1 + list[i].duty_name_1 + '</td>';
            }

            // 2차 결재선
            if (list[i].dept_idx_2 === 0 && list[i].duty_idx_2 === 0) {
                tags += '<td>없음</td>';
            } else if (list[i].dept_idx_2 === 0 && list[i].duty_idx_2 !== 0) {
                tags += '<td>작성자 소속/' + list[i].duty_name_2 + '</td>';
            } else {
                tags += '<td>' + list[i].dept_name_2 + list[i].duty_name_2 + '</td>';
            }

            // 3차 결재선
            if (list[i].dept_idx_3 === 0 && list[i].duty_idx_3 === 0) {
                tags += '<td>없음</td>';
            } else if (list[i].dept_idx_3 === 0 && list[i].duty_idx_3 !== 0) {
                tags += '<td>작성자 소속/' + list[i].duty_name_3 + '</td>';
            } else {
                tags += '<td>' + list[i].dept_name_3 + list[i].duty_name_3 + '</td>';
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

function previewPrint(idx) {
    console.log(idx);
    let tags = '';
}