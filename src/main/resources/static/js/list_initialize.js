var showPage=1;
let filter='전체';
let type ='전체';
var page = 0;
var cnt = 10;
var url = '';
var list_cate ='';
let whole_list=[];

var content = '';

let filtered_list =[];

approval_list_view();



//처음에 페이지 콜 할 때
function approval_pageCall(page,filter_val,type_val){
    filter = filter_val;
    type = type_val;
    get_list_cate();
    approval_list_filter();
}



function approval_list_view(){
    console.log('approval_list_view');
    get_list_cate();
    $.ajax({
        type: 'GET',
        url: url,
        data: {},
        dataType: 'JSON',
        success: function (data) {
            console.log('데이터 목록',data.list);
            console.log('데이터 목록',data.list.length);
            if(data.list.length>0){
                for(var list of data.list){
                    console.log('데이터 목록 분리',list);
                    whole_list.push(list);
                    console.log('분리 후 넣고 whole_list',whole_list);
                }
                approval_pagination(1);
            }else{
                content = '<tr class="approval_received_no_data"><!-- 데이터가 있을 경우 클래스 disp_hide를 추가하세요. jq -> .hide처리하기 -->\n' +
                    '                <td colspan="7" class="td_no_data">\n' +
                    '                  <p>\n' +
                    '                    <i class="bi bi-file-earmark-break"></i>\n' +
                    '                  </p>\n';

                switch (list_cate){
                    case 'send':
                        content+= '<h3>결재 요청한 문서가 없습니다.</h3>\n';
                        break;
                    case 'receive':
                        content+= ' <h3>결재할 문서가 없습니다.</h3>\n';
                        break;
                    case 'write':
                        content+= '<h3>작성한 문서가 없습니다.</h3>\n';
                        break;
                }
                content+='</td>\n' +'</tr>';

                $('tbody').html(content);
            }
        }
    });
}

function get_list_cate(){
    switch (location.pathname){

        case '/approval_send_list.go':
            console.log('보낸 페이지');
            url ='/approval_send_list.ajax';
            list_cate='send';
            break;
        case '/approval_received_list.go':
            console.log('받은 페이지');
            url='/approval_received_list.ajax';
            list_cate='receive';
            break;
        case '/approval_writing_list.go':
            console.log('작성페이지');
            url='/approval_writing_list.ajax';
            list_cate='write';
            break;
    }
}

function approval_list_filter(){
    filtered_list = [];
    content='';
    console.log('approval_list_filter 도착');
    console.log('whole_list',whole_list);
    for(var list_entity of whole_list){
        console.log(list_entity);
        console.log(list_entity.empl_name);

        console.log('list_cate',list_cate);
        console.log('type',type);

        var appr_state='';
        if(type ==='탭'){

            approval_change_tab_css();
        //type
            //탭
                //만약 list_cate = send
                    if(list_cate==='send'){
                        //filter
                        switch (filter){
                            case '결재 대기':
                                appr_state = '결재 대기';
                                break;
                            case '결재 진행':
                                appr_state = '결재 진행';
                                break;
                            case '최종 승인' :
                                appr_state = '결재 진행';
                                break;
                            case '반려' :
                                appr_state = '반려';
                                break;
                        }

                        if(list_entity.approval_state === appr_state){
                            filtered_list.push(list_entity);
                        }else if(filter ==='전체'){
                            filtered_list = whole_list;
                        }
                        console.log('filtered_list sent',filtered_list);

                    }else if(list_cate==='receive'){
                        //filter
                        switch (filter){
                            case '읽지 않음':
                                appr_state = '읽지 않음';
                                break;
                            case '결재중':
                                appr_state = '결재중';
                                break;
                            case '승인' :
                                appr_state = '승인';
                                break;
                            case '반려' :
                                appr_state = '반려';
                                break;
                        }

                        if(list_entity.i_approval_state === appr_state){
                            filtered_list.push(list_entity);
                        }
                        console.log('filtered_list received',filtered_list);
                    }

        }else if(type ==='검색'){
            //무조건 doc_subject에서 가지고 있는 것
            //검색
            if(list_entity.doc_subject.includes(filter)){
                filtered_list.push(list_entity);
                console.log('filtered_list',filtered_list);
            }
        }

    }
approval_pagination(1);
}


function approval_pagination(page){
    console.log('filter',filter);
    if(filter ==='전체'){
        console.log('filtered_list.length',filtered_list.length);
        filtered_list = whole_list;
    }

    console.log('filtered_list.length',filtered_list.length);
    if(filtered_list.length ===0){
        content = '<tr class="approval_received_no_data"><!-- 데이터가 있을 경우 클래스 disp_hide를 추가하세요. jq -> .hide처리하기 -->\n' +
            '                <td colspan="7" class="td_no_data">\n' +
            '                  <p>\n' +
            '                    <i class="bi bi-file-earmark-break"></i>\n' +
            '                  </p>\n';

        switch (list_cate){
            case 'send':
                content+= '<h3>결재 요청한 문서가 없습니다.</h3>\n';
                break;
            case 'receive':
                content+= ' <h3>결재할 문서가 없습니다.</h3>\n';
                break;
            case 'write':
                content+= '<h3>작성한 문서가 없습니다.</h3>\n';
                break;
        }
        content+='</td>\n' +'</tr>';
        console.log('content',content);
        $('tbody').html(content);
    }else{
        console.log('페이지네이션할 게시물',filtered_list);
        // list.size: 전체 게시물 수
        console.log('전체 게시물 수:', filtered_list.length);

        // page: 현재 페이지 (사용자가 보고 있는 페이지 번호)
        console.log('현재 페이지:', page);

        // cnt: 한 페이지에 표시할 게시물 수
        console.log('한 페이지에 표시할 게시물 수:', cnt);

        // total_page: 총 페이지 수 (전체 게시물 수를 한 페이지에 표시할 게시물 수로 나누기)
        let total_page = Math.ceil(filtered_list.length/cnt);
        console.log('총 페이지 수:', total_page);

        // 시작 인덱스와 끝 인덱스를 계산하여 현재 페이지에 표시할 데이터를 추출
        let start_idx = (page - 1) * cnt;
        let end_idx = Math.min(start_idx + cnt, filtered_list.length); // 끝 인덱스가 전체 게시물 수를 초과하지 않도록 처리
        let page_items = filtered_list.slice(start_idx, end_idx); // 현재 페이지에 해당하는 데이터만 추출
        console.log('현재 페이지 데이터:', page_items);

        approval_list_draw(page_items);

        // 페이지 번호 버튼을 동적으로 생성
        let pagination_html = '';
        if(page===1){
            pagination_html = '<li class="page-item first disabled">\n' +
                '                                    <a class="page-link"><i class="bi bi-chevron-double-left"></i></a>\n' +
                '                                </li>\n' +
                '                                <li class="page-item prev disabled">\n' +
                '                                    <a class="page-link"><i class="bi bi-chevron-left"></i></a>\n' +
                '                                </li>';

        }else if(page>=2){

            pagination_html = '<li class="page-item first">\n' +
                '                                    <a class="page-link" onclick="goToPage('+1+')"><i class="bi bi-chevron-double-left"></i></a>\n' +
                '                                </li>\n' +
                '                                <li class="page-item prev">\n' +
                '                                    <a class="page-link" onclick="goToPage('+(page-1)+')"><i class="bi bi-chevron-left"></i></a>\n' +
                '                                </li>';
        }
        for (let i = 1; i <= total_page; i++) {
            if(i===page){
                pagination_html += '<li class="page-item active"><a class="page-link" onclick="goToPage('+i+')">'+i+'</a></li>';
            }else{
                pagination_html += '<li class="page-item"><a class="page-link" onclick="goToPage('+i+')">'+i+'</a></li>';
            }
        }

        console.log('page가 작은지 확인 filtered_list.length',filtered_list.length);
        if(page < filtered_list.length) {
            pagination_html+='<li class="page-item next">\n' +
            '            <a class="page-link" onclick="goToPage('+(page+1)+')"><i class="bi bi-chevron-right"></i></a>\n' +
            '        </li>\n' +
            '        <li class="page-item last">\n' +
            '            <a class="page-link" onclick="goToPage('+filtered_list.length+')"><i class="bi bi-chevron-double-right"></i></a>\n' +
            '        </li>'
        }else{
            pagination_html+='<li class="page-item next disabled">\n' +
            '            <a class="page-link"><i class="bi bi-chevron-right"></i></a>\n' +
            '        </li>\n' +
            '        <li class="page-item last disabled">\n' +
            '            <a class="page-link" "><i class="bi bi-chevron-double-right"></i></a>\n' +
            '        </li>'
        }
        // 페이지 버튼을 화면에 추가
        document.getElementById('pagination').innerHTML = pagination_html;
    }
}

// 페이지 이동 함수 (버튼 클릭 시 호출)
function goToPage(page) {
    approval_pagination(page);
}


function approval_list_draw(lists){
    content = '';
    for(var list of lists){
        if(list_cate ==='send'){
            content +='<tr>\n' +
                '                  <td class="td_align_left td_no_padding">\n' +
                '<span onclick="tst_view_profile(' + list.empl_idx + ')" class="tst_pointer">' + list.empl_name + ' (' + list.dept_name + '/' + list.position_name + ')</span>'+                '                  </td>\n' +
                '                  <td>'+list.form_subject+'</td>\n' +
                '                  <td class="td_align_left">';

            if(list.approval_state == '결재 대기'|| list.approval_state == '결재 진행'){
                content+= '<span class="tst_badge_min btn_secondary margin_right">'+list.approval_state+'</span>';
            }else if(list.approval_state == '최종 승인') {
                content += '<span className="tst_badge_min btn_subtle margin_right">'+list.approval_state+'</span>';
            }else {
                content+='<span className="tst_badge_min btn_primary margin_right">'+list.approval_state+'</span>';
            }

            if(list.doc_subject == '') {
                content += '<span onclick="location.href=\'/approval_sent_detail.go?doc_idx=${list.doc_idx}&type=sent\'" class="tst_pointer">제목 없음</span>';
            }else{
                if(list.doc_subject == '결재가 최종 승인되었습니다.' || list.doc_subject =='결재가 반려되었습니다.') {

                    content += '<span onClick="location.href=\'/approval_sent_detail.go?doc_idx=${list.doc_idx}&type=sent\'"\n' +
                        'className="tst_pointer font_subtle">${list.doc_subject}</span>';
                }else{
                    content+='<span onclick="location.href=\'/approval_sent_detail.go?doc_idx=${list.doc_idx}&type=sent\'" class="tst_pointer">'+list.doc_subject+'</span>';
                }
            }

            content+='\n' +
                '                  </td>\n' +
                '                  <td>'+list.update_date+'</td>\n' +
                '                  <td>'+list.approval_response_date+'</td>\n' +
                '                  <td>'+list.end_date+'</td>\n' +
                '                </tr>';
        }else if(list_cate ==='receive'){
            content+='<tr>\n' +
                '                        <td class="td_align_left td_no_padding">\n' +
                '                            <span onclick="tst_view_profile('+list.empl_idx+')" class="tst_pointer">'+list.empl_name+'('+list.dept_name+'/'+list.position_name+')</span>\n' +
                '                        </td>\n' +
                '                        <td>'+list.form_subject+'</td>\n' +
                '                        <td class="td_align_left">\n' +
                '                            <span class="tst_badge_min btn_primary margin_right">'+list.i_approval_state+'</span>\n' +
                '                            <span onclick="location.href=\'/approval_received_detail.go?doc_idx='+list.doc_idx+'&type=received\'" class="tst_pointer">'+list.doc_subject+'</span>\n' +
                '                        </td>\n' +
                '                        <td><span class="tst_badge_min btn_primary">'+list.approval_state+'</span></td>\n' +
                '                        <td>'+list.update_date+'</td>\n' +
                '                        <td>'+list.appr_date+'</td>\n' +
                '                        <td>'+list.end_date+'</td>\n' +
                '                    </tr>';
        }else if(list_cate === 'write'){
            content+='<tr>\n' +
                '                                        <td class="td_align_left td_no_padding">\n' +
                '                                            <span onclick="tst_view_profile('+list.empl_idx+')" class="tst_pointer">'+list.empl_name+'('+list.dept_name+'/'+list.position_name+')</span>\n' +
                '                                        </td>\n' +
                '                                        <td>'+list.form_subject+'</td>\n' +
                '\n' +
                '\n' +
                '                                            <td class="td_align_left">';
            if(list.doc_subject ==''){
                content+='<span onclick="location.href=\'/approval_update.go?doc_idx='+list.doc_idx+'" class="tst_pointer">제목 없음</span>';
            }else{
                content+='<span onclick="location.href=\'/approval_update.go?doc_idx='+ list.doc_idx+'\'" class="tst_pointer">'+list.doc_subject+'</span>';
            }

            content+='</td>\n' +
                '                                            <td>'+list.write_date+'</td>\n' +
                '                                            <td>'+list.update_date+'</td>\n' +
                '                                            <td class="td_align_right td_no_padding">\n' +
                '                                                <a href="approval_doc_del.do?doc_idx='+list.doc_idx+'"><span class="tst_badge_min btn_subtle">삭제</span></a>\n' +
                '                                            </td>\n' +
                '\n' +
                '                                    </tr>';
        }
    }

    $('tbody').html(content);
}

function approval_change_tab_css(){

    console.log("filter",filter);
    var class_name = '';


        $('.tst_tablist_item_active').removeClass('tst_tablist_item_active');

        switch (filter){
            case '전체':
                class_name='.all'
                break;

            case '읽지 않음':
            case '결재 대기':
                class_name = '.unread'
                break;

            case '결재중':
            case '결재 진행':
                class_name = '.continue';
                break;

            case '승인':
            case '최종 승인':
                class_name = '.approved';
                break;

            case '반려':
                class_name = '.reject';
                break;

        }
        $(class_name).addClass('tst_tablist_item_active');

}
