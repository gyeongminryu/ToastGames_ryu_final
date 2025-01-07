
		var show = 1;
		var itemsPerPage = 15;
		var lastTotalPages = 0; // 마지막으로 받은 totalPages 값!!!

		pageCall(show); // 처음 불러오는 코드인듯..?
		
		// 부서 필터 값 변경 시
		$('#deptFilter').change(function() {
		    pageCall(1); // 페이지 번호를 1로 설정하여 첫 페이지부터 갱신
		});

		// 유형 필터 값 변경 시
		$('#typeFilter').change(function() {
		    pageCall(1); 
		});		
		
		// 검색 버튼 클릭 시
		function searchPosts() {
		    console.log("검색어: " + $('#searchKeyword').val());  // 검색어 값 확인
			pageCall(1); 
		}
						
		function pageCall(page) {
		    var dept = $("#deptFilter").val();
		    var type = $("#typeFilter").val();
		    var searchType = $("#searchType").val();
		    var keyword = $("#searchKeyword").val();
		    
		    $.ajax({
		        type: 'GET',
		        url: 'board_list.ajax',
		        data: {
		            'page': page,
		            'cnt': itemsPerPage,
		            'dept': dept,
		            'type': type,
		            'searchType': searchType,
		            'keyword': keyword 
		        },
		        dataType: 'JSON',
		        success: function(data) { 
		            if (data.error) {
		                alert(data.error);
		            } else {
		                drawList(data.list);
                		if (data.totalpages !== lastTotalPages) { // 페이지네이션 초기화가 한 번만 수행되도록 수정!!! 이렇게 해야 무한루프가 안돈다!!!
		                    $('#pagination').twbsPagination('destroy');  // 기존 페이지네이션을 제거 !!!
		                    $('#pagination').twbsPagination({
		                        startPage: 1,
		                        totalPages: data.totalpages, // 총 페이지 수
		                        visiblePages: 5, // 한 번에 보이는 페이지 수
		                        onPageClick: function(evt, page) {
		                            pageCall(page); // 페이지 이동 시 호출되는 함수
		                        }
		                    });
		                    lastTotalPages = data.totalpages; // 마지막 totalPages 값을 갱신!!!
		                }
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
        content = '<tr><td colspan="6" style="text-align: center;">작성된 게시글이 없습니다.</td></tr>'; // 데이터가 없을 경우 메시지 추가
    } else {
        list.forEach(function(b) {
            if (b) {
                content += '<tr>';
                content += '<td>' + b.board_idx + '</td>'; // 인덱스
                content += '<td class="td_align_center">' + b.dept_name + '</td>'; // 부서
                
               content += '<td class="td_align_left">';
			   content += '<span class="tst_pointer" onclick="location.href=\'board_detail.go?board_idx=' + b.board_idx + '\'">' 
         	   + '[' + b.board_type_name + ']' + b.board_title 
          	   + ' (' + b.commentCount + ')</span>';
                
                // 첨부파일 아이콘 추가 (파일이 있을 경우)
                if (b.file_key) {
                    content += ' <i class="bi bi-paperclip"></i>';
                }
                
                content += '</td>';
                
				content += `<td><span onclick="tst_view_profile('${b.board_empl_idx}')" class="tst_pointer">`
                          + b.empl_name + ' (' + b.empl_id + ')</span></td>'; // 이름
                content += '<td>' + b.board_view_cnt + '</td>'; // 조회수
                content += '<td>' + b.board_write_date + '</td>'; // 작성일자
                content += '</tr>';
            }
        });
    }
    $('#list').html(content);
}