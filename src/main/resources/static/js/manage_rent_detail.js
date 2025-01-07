

// 테이블의 prod_idx 값을 가져옴
const prodIdxElement = document.querySelector('#prod_idx');
const prod_idx = prodIdxElement ? prodIdxElement.textContent.trim() : null;

const prodRentIdx = document.querySelector('#prod_rent_idx');
const prod_rent_idx = prodRentIdx ? prodRentIdx.textContent.trim() : null;

prodDate(prod_idx);


// 초기 호출
pageCall(1,prod_idx);

//카테고리별 목록
function pageCall(page,prod_idx) {
	console.log(prod_idx);

    $.ajax({
        type: 'GET',
        url: '/rentManageList.ajax', 
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
			content += '<td><h3>' + item.empl_name + ' (' + item.position_name + '/' + item.duty_name + ')</span></h3></td>';
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
	
	$('#rent_list').html(content);
}



//카테고리별 목록
function prodDate(prod_idx) {
	console.log(prod_idx);
    $.ajax({
        type: 'GET',
        url: '/prodDate.ajax', 
        data:{
        	'prod_idx':prod_idx
        },
        dataType: 'json', 
        success: function(data) {
					console.log(data);
					prod_date(data);	
					prod_button(data);		
        },
        error: function(e) {
            console.log("오류 발생", e);
        }       
    });
}



// 사용연한 관련
var expiration_content = '';
var prodExpDateStr = '';
let expirationDate ='';

// 오늘 날짜
const today = new Date();

function prod_date(item) {
    // item에서 사용 연한 값 추출
    prodExpDateStr = item.formattedDates.prodDispoDate;

    // prodExpDateStr를 Date 객체로 변환
    expirationDate = new Date(prodExpDateStr);
    console.log("Expiration Date: ", expirationDate);

    expiration_content = ''; // 초기화
    if (expirationDate.getTime() - today.getTime() > 0) {
        // 사용 연한이 지나지 않았을 경우
        expiration_content += '<th>사용연한</th>';
        expiration_content += '<td>' + prodExpDateStr + '</td>';
    } else {
        // 사용 연한이 지났을 경우
        expiration_content += '<th>사용연한</th>';
        expiration_content += '<td><h3 class="font_caution">' + prodExpDateStr + '</h3></td>';
    }

    // 동적으로 테이블에 삽입
    $('#dispo_date').html(expiration_content);

    // 사용 연한에 따라 메시지 표시
    const expireMessageRow = document.querySelector('.expire-message');
    if (today < expirationDate) {
        // 사용 연한이 지나지 않았을 경우 메시지 숨김
        expireMessageRow.classList.add('disp_hide');
    } else {
        // 사용 연한이 지난 경우 메시지 표시
        expireMessageRow.classList.remove('disp_hide');
    }
}

 
 



//버튼
var button_content = '';

function prod_button(item) {
	// 대여 상태에 따른 버튼 출력
	if (item.dto.prod_rent === 2) {
	    button_content += '<li>';
	    button_content += '<button class="btn_primary btn_full" onclick="tst_modal_call(\'tst_modal_rent\')">대여 승인하기</button>';
	    button_content += '</li>';
	} else if (item.dto.prod_rent === 3) {
	    // 사용 연한 비교
	    if (today.getTime() < expirationDate.getTime() || today.getTime() === expirationDate.getTime()) {
	        // 사용 연한이 지나지 않았을 경우
	        button_content += '<li>';
	        button_content += '<button class="btn_primary btn_full" onclick="tst_modal_call(\'tst_modal_return\')">반납 처리하기</button>';
	        button_content += '</li>';
	    } else {
	        // 사용 연한이 지났을 경우
	        button_content += '<li>';
	        button_content += '<button class="btn_primary btn_full" onclick="location.href=\'/manage_rent_transfer.go?prod_idx=' + prod_idx + '\'">직원에게 인계하기</button>';
	        button_content += '</li>';
	    }
	}
	
	// 사용 연한과 상관없이 동일하게 출력하는 버튼들
	button_content += '<li>';
	button_content += '<button class="btn_secondary btn_full" onclick="location.href=\'/manage_rent_dispose.go?prod_idx=' + prod_idx + '\'">폐기하기</button>';
	button_content += '</li>';
	button_content += '<li>';
	button_content += '<button class="btn_subtle btn_full" onclick="location.href=\'/manage_rent_list.go\'">목록으로 돌아가기</button>';
	button_content += '</li>';
	
	// 동적으로 <ul> 내부에 삽입
	$('#button_list').html(button_content);
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


//대여승인 버튼
document.getElementById("permit_product").addEventListener("click", function () {
    if (getConfirmationStatus()) {
	    $.ajax({
	        type: 'GET',
	        url: '/permitProd.do', 
	        data:{
	        	'prod_rent_idx':prod_rent_idx,
	        	'prod_idx':prod_idx
	        },
	        dataType: 'json', 
	        success: function(data) {
						console.log(data);	
						window.location.href = data.redirectUrl;
	        },
	        error: function(e) {
	            console.log("오류 발생", e);
	        }       
	    });
    } else {
        alert("승인이 취소되었습니다. 다시 시도해주세요.");
    }
});


//반납승인 버튼
document.getElementById("permit_return").addEventListener("click", function () {
    if (getReturnStatus()) {
        $.ajax({
	        type: 'GET',
	        url: '/permitReturn.do', 
	        data:{
	        	'prod_rent_idx':prod_rent_idx,
	        	'prod_idx':prod_idx
	        },
	        dataType: 'json', 
	        success: function(data) {
						console.log(data);
						window.location.href = data.redirectUrl;	
	        },
	        error: function(e) {
	            console.log("오류 발생", e);
	        }       
	    });
    } else {
        alert("반납이 취소되었습니다. 다시 시도해주세요.");
    }
});


