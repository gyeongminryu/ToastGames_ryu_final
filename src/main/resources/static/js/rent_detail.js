
//대여 가능

	<tr>
		<th>대여 가능 여부</th>
		<td>대여 가능</td>
	</tr>
	<tr>
		<th>대여 상태</th>
		<td>대여 가능</td>
	</tr>
	<tr>
		<th>반납 예정일</th>
		<td>없음</td>
	</tr>
	<tr>
		<th colspan="2" class="td_align_center td_bg_subtle">대여 장소는 본관 3층 312호 경영 지원실입니다.</th>
	</tr>
	
if (item.prod_rent_str === "대여 가능") { // 문자열 비교 수정 및 괄호 추가
    content += '<tr>';
    content += '<th>대여 가능 여부</th>';
    content += '<td>' + item.prod_rent_str + '</td>';
    content += '</tr>';
    content += '<tr>';
    content += '<th>대여 상태</th>';
    content += '<td>' + (item.prod_rent_str === "대여 가능" ? "대여 가능" : "대여 불가") + '</td>';
    content += '</tr>';
    content += '<tr>';
    content += '<th>반납 예정일</th>';
    content += '<td>' + (item.prod_exp_date == null ? '없음' : item.prod_exp_date) + '</td>';
    content += '</tr>';
    content += '<tr>';
    content += '<th colspan="2" class="td_align_center td_bg_subtle">대여 장소는 ' + item.prod_place + ' 입니다.</th>';
    content += '</tr>';
}
	
	
//대여 불가(신청중/대여중)
	<tr>
		<th>대여 가능 여부</th>
		<td>대여 불가</td>
	</tr>

	<!-- 대여 신청중인 경우 아래와 같이 출력하세요 -->
	<tr>
		<th>대여 상태</th>
		<td>대여 신청중</td>
	</tr>
	<!-- //대여 신청중인 경우 아래와 같이 출력하세요 -->

	<!-- 대여중인 경우 아래와 같이 출력하세요 -->
	<tr>
		<th>대여 상태</th>
		<td>대여중 ({대여 시작일|yyyy-MM-dd}부터)</td>
	</tr>
	<!-- //대여중인 경우 아래와 같이 출력하세요 -->

	<tr>
		<th>반납 예정일</th>
		<td>{반납 예정일|yyyy-MM-dd}</td>
	</tr>
	<tr>
		<th colspan="2" class="td_align_center td_bg_subtle disp_hide">대여 장소는 본관 3층 312호 경영 지원실입니다.</th>
	</tr>	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	