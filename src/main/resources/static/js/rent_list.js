let list = '';

let rent_state = 'off';

//ON
function rent_available_filtering_on(elem) {
    elem.classList.add("disp_hide");
    elem.nextElementSibling.classList.remove("disp_hide");
    // 상태 기록
    rent_state = 'on'; // ON 상태로 변경
    resource_list_print(list);
    console.log("ON 상태로 변경됨. rent_state:", rent_state);
}

//OFF
function rent_available_filtering_off(elem) {
    elem.classList.add("disp_hide");
    elem.previousElementSibling.classList.remove("disp_hide");
    // 상태 기록
    rent_state = 'off'; // OFF 상태로 변경
    resource_list_print(list);
    console.log("OFF 상태로 변경됨. rent_state:", rent_state);
}

// 기본 카테고리 (전체 보기)
var defaultCategory = 'all';

//카테고리 저장
let currentCategory = '';

// 초기 호출
pageCall(1, defaultCategory);

//카테고리별 목록
function pageCall(page,category) {
	currentCategory = category;  
	console.log('pageCall');
	console.log(currentCategory);
	console.log(category);
    $.ajax({
        type: 'GET',
        url: '/resourceList.ajax', 
        data:{
        	'page' : page,  //몇페이지 보여줘?
        	'cnt': 18,    //페이지당 몇개의 게시물 보여줘?
        	'category':category
        },
        dataType: 'json', 
        success: function(data) {
					console.log(data);
					list=data.list;
					resource_list_print(data.list);			
			
			//페이징 플러그인 처리
			$('#pagination').twbsPagination({
				startPage:1, //현재 보여지는 페이지
				totalPages:data.totalPages, //최대 페이지 수
				visiblePages: 5 , //보여지는 페이지 수
				onPageClick:function(evt,page){
					console.log('evt',evt); //클릭 이벤트의 모든 내용
					console.log('page',page); //클릭한 페이지 번호
					pageCall(page,category);
				}
			});
        },
        error: function(e) {
            console.log("오류 발생", e);
        }       
    });
}


//카테고리 검색
function category_search(event){
    // 폼 기본 제출 동작 방지
    event.preventDefault();
    
    // 입력된 검색어 가져오기
    const category_keyword = document.getElementById('keyword_category').value.trim();

    if (!category_keyword) {
        alert("검색어를 입력하세요.");
        return false;
    }
    // 검색 함수 호출
    category_product_search(category_keyword);
    return false; // 폼 제출 방지
    
}

//카테고리검색함수
function category_product_search(category_keyword) {
    console.log("검색 실행:",category_keyword);
    // 예: AJAX 요청을 통한 검색 처리
    $.ajax({
        type: 'GET',
        url: '/categroySearch.ajax',
        data:{
        	'keyword':category_keyword
        },
        dataType: 'json',
        success: function(data) {
            console.log("검색 결과:", data);  // 반환된 데이터 확인

            // 반환된 데이터가 단일 객체일 경우
            if (data && typeof data === 'object') {
                var tableBody = $('#category_table_tbody'); // 테이블 tbody의 ID

                // 기존 항목 제거
                tableBody.empty();

                // 단일 객체일 경우 직접 테이블에 추가
                var row = '<tr>' +
                          '<td>' +
                          '<span onclick="pageCall(1, \'' + data.prod_cate_idx + '\')">' +
                          data.prod_cate_name +
                          '</span>' +
                          '</td>' +
                          '</tr>';
                tableBody.append(row);
            } else {
                console.log("검색 결과가 없습니다.");
            }
        },
        error: function(e) {
            console.log("오류 발생", e);
        } 
    });
}


//물품 검색
function resource_search(event) {
    // 폼 기본 제출 동작 방지
    event.preventDefault();

    // 선택된 옵션 값 가져오기
    const option = document.getElementById('tst_search_select_category').value;

    // 입력된 검색어 가져오기
    const keyword = document.getElementById('search_keyword').value.trim();

    if (!keyword) {
        alert("검색어를 입력하세요.");
        return false;
    }

    // 검색 함수 호출
    product_search(1,currentCategory,option, keyword);
    return false; // 폼 제출 방지
}


//검색함수
function product_search(page,currentCategory,option, keyword) {
    console.log("검색 실행:", option, keyword, currentCategory);
    // 예: AJAX 요청을 통한 검색 처리
    $.ajax({
        type: 'POST',
        url: '/resourceSearch.ajax',
        data:{
        	'page' : page,  //몇페이지 보여줘?
        	'cnt': 18,    //페이지당 몇개의 게시물 보여줘?
        	'category':currentCategory,
        	'option' : option,
        	'keyword': keyword
        },
        dataType: 'json',
        success: function(data) {
					console.log(data);
					list=data.list;
					resource_list_print(data.list);
			
			
			//페이징 플러그인 처리
			$('#pagination').twbsPagination({
				startPage:1, //현재 보여지는 페이지
				totalPages:data.totalPages, //최대 페이지 수
				visiblePages: 5, //보여지는 페이지 수
				onPageClick:function(evt,page){
					console.log('evt',evt); //클릭 이벤트의 모든 내용
					console.log('page',page); //클릭한 페이지 번호
					product_search(page,currentCategory,option, keyword);
				}
			});
        },
        error: function(e) {
            console.log("오류 발생", e);
        } 
    });
}

//목록
function resource_list_print(list) {
    console.log("Received list:", list);
    var content = '';
    
    if (rent_state === "off") { // 문자열 비교 수정
        if (Array.isArray(list) && list.length > 0) {
            for (var item of list) {
                content += '<tr>';
                content += '<td>' + item.prod_idx + '</td>';
                content += '<td><span class="tst_pointer">' + item.prod_cate_name + '</span></td>';
                content += '<td class="td_align_left">';
                content += '<h3 onclick="location.href=\'/prodDetail.go?prod_idx=' + item.prod_idx + '\'" class="tst_pointer">' + item.prod_name + '</h3>';
                content += '</td>';
                content += '<td class="td_align_left">';
                content += '<span onclick="location.href=\'/prodDetail.go?prod_idx=' + item.prod_idx + '\'" class="tst_pointer">' + item.prod_info + '</span>';
                content += '</td>';
                content += '<td><span class="tst_badge_min btn_secondary">' + item.prod_rent_str + '</span></td>';
                content += '<td>' + (item.prod_exp_date == null ? '없음' : item.prod_exp_date) + '</td>';
                content += '</tr>';
            }
        } else {
            content += '<tr class="rent_list_no_data">'; // 데이터가 있을 경우 클래스 disp_hide를 추가하세요.
            content += '<td colspan="6" class="td_no_data">';
            content += '<p><i class="bi bi-box-seam"></i></p>';
            content += '<h3>검색 조건에 해당하는 공용 물품이 없습니다.</h3>';
            content += '</td>';
            content += '</tr>';
        }
    } else {
        if (Array.isArray(list) && list.length > 0) {
            for (var item of list) {
                if (item.prod_rent_str === "대여 가능") { // 문자열 비교 수정 및 괄호 추가
                    content += '<tr>';
                    content += '<td>' + item.prod_idx + '</td>';
                    content += '<td><span class="tst_pointer">' + item.prod_cate_name + '</span></td>';
                    content += '<td class="td_align_left">';
                    content += '<h3 onclick="location.href=\'/prodDetail.go?prod_idx=' + item.prod_idx + '\'" class="tst_pointer">' + item.prod_name + '</h3>';
                    content += '</td>';
                    content += '<td class="td_align_left">';
                    content += '<span onclick="location.href=\'/prodDetail.go?prod_idx=' + item.prod_idx + '\'" class="tst_pointer">' + item.prod_info + '</span>';
                    content += '</td>';
                    content += '<td><span class="tst_badge_min btn_secondary">' + item.prod_rent_str + '</span></td>';
                    content += '<td>' + (item.prod_exp_date == null || item.prod_rent == 1? '없음' : formatDateTime(item.prod_exp_date)) + '</td>';
                    content += '</tr>';
                }
            }
        } else {
            content += '<tr class="rent_list_no_data">'; // 데이터가 있을 경우 클래스 disp_hide를 추가하세요.
            content += '<td colspan="6" class="td_no_data">';
            content += '<p><i class="bi bi-box-seam"></i></p>';
            content += '<h3>검색 조건에 해당하는 공용 물품이 없습니다.</h3>';
            content += '</td>';
            content += '</tr>';
        }
    }
    $('#resource_list').html(content);
}


//날짜 형식 바꾸기
function formatDateTime(dateTimeStr) {
    var date = new Date(dateTimeStr);

    // 년, 월, 일 추출
    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString().padStart(2, '0');
    var day = date.getDate().toString().padStart(2, '0');

    // 시간, 분 추출
    var hours = date.getHours().toString().padStart(2, '0');
    var minutes = date.getMinutes().toString().padStart(2, '0');

    // 원하는 형식으로 반환
    return `${year}-${month}-${day} ${hours}:${minutes}`;
}
