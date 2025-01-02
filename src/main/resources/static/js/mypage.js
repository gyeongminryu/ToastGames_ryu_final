	
	// 페이지네이션 관련 js !!! 하지만 페이지네이션 활용은 안함!!!	
	var show = 1;
	var cnt = 3; // 최대 몇개 정도를 보여줄건지 여기서 정함!!!	
	pageCall(show); // 처음 불러오는 코드인듯..?
	
	// 인사 변경 이력 불러오는 함수
	function pageCall(page) {
	
	    $.ajax({
	        type: 'GET',
	        url: 'employmentHistory.ajax',
	        data: {
	            'page': page,
	            'cnt': cnt
	        },
	        dataType: 'JSON',
	        success: function(data) {
	            if (data.error) {
	                alert(data.error);
	            } else {
	                drawList(data.list);
	
	                //$('#pagination').twbsPagination({
	                    //startPage: 1,
	                    //totalPages: data.totalpages, // 총 페이지 수
	                    //visiblePages: 5, // 한 번에 보이는 페이지 수
	                    //onPageClick: function(evt, page) {
	                    	//pageCall(page); // 페이지 이동시 필요한 코드.
	                    //}
	                //});
	            }
	        },
	        error: function(e) {
	            console.error("AJAX call failed: ", e);
	        }
	    });
	}
		
	function drawList(list) {
	    var content = '';
	    if (list.length === 0) {
	        content = '<tr><td colspan="3" style="text-align: center;">인사이동 변경내역이 없습니다.</td></tr>'; // 데이터가 없을 경우 메시지 추가
	    } else {
	        list.forEach(function(employment) {
	            if (employment) {
	                content += '<tr>';
	                content += '<td>' + employment.appo_idx + '</td>'; // 인덱스
	                content += '<td>' + employment.dept_name + '</td>'; // 부서 이름
	                content += '<td>' + employment.position_name +'/'+ employment.duty_name + '</td>'; // 직급/직책
	                content += '<td class ="td_align_left">' + employment.empl_job + '</td>'; // 직무
	                content += '<td>' + employment.movein_date + '</td>'; // 기간
	                content += '<td>' + employment.transfer_date + '</td>'; // 기간
	                content += '</tr>';
	            }
	        });
	    }
	    $('#list').html(content);
	}