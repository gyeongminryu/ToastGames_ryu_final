





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
