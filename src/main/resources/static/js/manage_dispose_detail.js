
const prodIdxElement = document.querySelector('#prod_idx');
const prod_idx = prodIdxElement ? prodIdxElement.textContent.trim() : null;

// 초기 호출
pageCall(1,prod_idx);

//카테고리별 목록
function pageCall(page,prod_idx) {
	console.log(prod_idx);

    $.ajax({
        type: 'GET',
        url: '/dispoRentList.ajax', 
        data:{
        	'page' : page,  //몇페이지 보여줘?
        	'cnt': 9,    //페이지당 몇개의 게시물 보여줘?
        	'prod_idx':prod_idx
        },
        dataType: 'json', 
        success: function(data) {
					console.log(data);
					resource_list_print(data.list);			
			
			//페이징 플러그인 처리
			$('#pagination').twbsPagination({
				startPage:1, //현재 보여지는 페이지
				totalPages:data.totalPages, //최대 페이지 수
				visiblePages: 5 , //보여지는 페이지 수
				onPageClick:function(evt,page){
					console.log('evt',evt); //클릭 이벤트의 모든 내용
					console.log('page',page); //클릭한 페이지 번호
					pageCall(page,prod_idx);
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
			content += '<tr>';
			content += '<td>' + item.prod_rent_idx + '</td>';
			content += '<td><h3><span onclick="tst_view_profile(\'' + item.empl_idx + '\')" class="tst_pointer">' + item.empl_name + ' (' + item.position_name + '/' + item.duty_name + ')</span></h3></td>';
			content += '<td class="td_align_left">' + item.prod_rent_reason + '</td>';
			content += '<td>' + formatDateTime(item.prod_rent_date) + '</td>';
			content += '<td>' + formatDateTime(item.prod_exp_date) + '</td>';
			
			// 대여 상태 계산
			if (item.prod_return_date == null) { // 반납일이 없을 경우
			    content += '<td><h3>대여중</h3></td>';
			    
			    // 반납 기한 경과 여부
			    const today = new Date();
			    const returnDeadline = new Date(item.prod_exp_date);
			    if (today > returnDeadline) {
			        content += '<td><h3 class="font_caution">연체</h3></td>';
			    } else {
			        content += '<td><h3>정상 대여</h3></td>';
			    }
			} else { // 반납일이 있을 경우
			    content += '<td>' + formatDateTime(item.prod_return_date) + '</td>';
			    
			    // 반납일과 반납기한 비교
			    const returnDate = new Date(item.prod_return_date);
			    const returnDeadline = new Date(item.prod_exp_date);
			    if (returnDate > returnDeadline) {
			        content += '<td><h3 class="font_caution">연체</h3></td>';
			    } else {
			        content += '<td><h3>정상 반납</h3></td>';
			    }
			}
			content += '</tr>';
		}
	} else {
		content += '<tr class="rent_history_no_data">'; // 데이터가 있을 경우 클래스 disp_hide를 추가하세요.
		content += '<td colspan="7" class="td_no_data">';
		content += '<p><i class="bi bi-box-seam"></i></p>';
		content += '<h3>검색 조건에 해당하는 공용 물품이 없습니다.</h3>';
		content += '</td>';
		content += '</tr>';
	}
	
	$('#dipo_rent_list').html(content);
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