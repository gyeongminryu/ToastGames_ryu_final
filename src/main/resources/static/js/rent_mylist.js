
// 기본 카테고리 (전체 보기)
var defaultState = 5;

//카테고리 저장
let current_state = '';

// 초기 호출
my_page_call(1, defaultState);


//카테고리별 목록
function my_page_call(page, rent_state) {
	current_state = rent_state;  
	console.log('pageCall');
	console.log(current_state);
	console.log(rent_state);
    $.ajax({
        type: 'GET',
        url: '/myProductList.ajax', 
        data:{
        	'page' : page,  //몇페이지 보여줘?
        	'cnt': 18,    //페이지당 몇개의 게시물 보여줘?
        	'rent_state':rent_state
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
					my_page_call(page,rent_state);
				}
			});
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
    product_search(1,current_state,option, keyword);
    return false; // 폼 제출 방지
}


//검색함수
function product_search(page,current_state,option, keyword) {
    console.log("검색 실행:", option, keyword, current_state);
    // 예: AJAX 요청을 통한 검색 처리
    $.ajax({
        type: 'POST',
        url: '/myProductSearch.ajax',
        data:{
        	'page' : page,  //몇페이지 보여줘?
        	'cnt': 18,    //페이지당 몇개의 게시물 보여줘?
        	'state':current_state,
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
					product_search(page,current_state,option, keyword);
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
    
    if (Array.isArray(list) && list.length > 0) {
    	for (var item of list) {
    		if(item.prod_state !== 0) {
				content += '<tr>';
				content += '<td>' + item.prod_idx + '</td>';
				content += '<td><span class="tst_pointer">' + item.prod_cate_name + '</span></td>';
				content += '<td class="td_align_left">';
				content += '<h3 onclick="location.href=\'/myProdDetail.go?prod_rent_idx=' + item.prod_rent_idx + '\'" class="tst_pointer">' + item.prod_name + '</h3>';
				content += '</td>';
				content += '<td class="td_align_left">';
				content += '<span onclick="location.href=\'/myProdDetail.go?prod_rent_idx=' + item.prod_rent_idx + '\'" class="tst_pointer">' + item.prod_info + '</span>';
	        	content += '</td>';
				content += '<td><span class="tst_badge_min btn_secondary">' + item.prod_return_state_str + '</span></td>';
				content += '<td>' + (item.prod_exp_date == null ? '없음' : formatDateTime(item.prod_exp_date)) + '</td>';
				content += '</tr>';
    		} else {
    			content += '<tr>';
				content += '<td>' + item.prod_idx + '</td>';
				content += '<td><span class="tst_pointer">' + item.prod_cate_name + '</span></td>';
				content += '<td class="td_align_left">';
				content += '<h3>' + item.prod_name + '</h3>';
				content += '</td>';
				content += '<td class="td_align_left">';
				content += '<span>' +'해당 물품은 사용불가 처리 되었습니다'+ '</span>';
	        	content += '</td>';
				content += '<td><span class="tst_badge_min btn_secondary">' + 사용불가 + '</span></td>';
				content += '<td>' + 없음 + '</td>';
				content += '</tr>';
    		}
        }
	} else {
		content += '<tr class="rent_list_no_data">'; // 데이터가 있을 경우 클래스 disp_hide를 추가하세요.
		content += '<td colspan="6" class="td_no_data">';
		content += '<p><i class="bi bi-box-seam"></i></p>';
		content += '<h3>검색 조건에 해당하는 공용 물품이 없거나 사용 불가 처리 되었습니다.</h3>';
		content += '</td>';
		content += '</tr>';
	}
    $('#my_resource_list').html(content);
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
