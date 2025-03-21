<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TOAST Games Groupware</title>
<link rel="stylesheet" type="text/css" href="resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/module_table.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/work_record.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<c:import url="layout_topnav.jsp" />
	<div class="tst_container">
		<c:import url="layout_leftnav.jsp" />
		<div class="tst_container_right">
			<div class="tst_contents">
				<div class="tst_contents_inner">

					<!-- 제목 -->
					<ul class="tst_title list_no_desc list_inline">
						<li class="tst_title_item tst_title_item_active"
							onclick="location.href='/work_record.go'">
							<h1>근태 관리</h1>
						</li>
					</ul>
					<!-- //제목 -->
					<form id="weekRangeForm" action="work_record.go" method="GET">
						<div class="btn_select_week align_left">
							<ul class="tst_list list_no_desc list_inline">
								<!-- 이전 주 버튼 -->
								<li onclick="moveWeek('prev')" class="tst_pointer"><i
									class="bi bi-caret-left-fill"></i></li>
								<!-- 날짜 범위 표시 -->
								<li id="weekRange"><input type="hidden" name="startDate"
									id="startDate" value="${startDate}" /> <span
									id="weekRangeText"></span> <!-- startDate ~ endDate를 보여줄 위치 -->
								</li>
								<!-- 다음 주 버튼 -->
								<li onclick="moveWeek('next')" class="tst_pointer"><i
									class="bi bi-caret-right-fill"></i></li>
							</ul>
						</div>
					</form>

					<div class="tst_flex">
						<div class="tst_col9">

							<!-- 금일 근무 시간 -->
							<table class="tst_table table_align_left">
								<colgroup>
									<col style="width: auto;" />
								</colgroup>
								<thead>
									<tr>
										<th>금일 근무 시간</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<div class="work_record_week">
												<h1 id="workTimeDisplay">
													0시간 0분<span> / 12시간</span>
												</h1>
												<div class="work_record_progress_bar">
													<div class="progress_required">
														<div class="progress_bar_frame">
															<div id="progressRequiredFill"
																class="progress_bar_fill progress_required_fill"></div>
														</div>
														<p>8시간</P>
													</div>
													<div class="progress_over">
														<div class="progress_bar_frame">
															<div id="overtimeProgressBar"
																class="progress_bar_fill progress_over_fill"></div>
														</div>
														<p>12시간</P>
													</div>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<!-- //금일 근무 시간 -->

						</div>
						<div class="tst_col3">

							<!-- 주간 근무 시간 상세보기 -->
							<table class="tst_table table_align_left table_no_padding">
								<colgroup>
									<col style="width: 130px;" />
									<col style="width: auto;" />
								</colgroup>
								<thead>
									<tr>
										<th colspan="2">주간 근무 시간 상세보기</th>
									</tr>
								</thead>
								<tbody>
									<tr>
									    <th>총 근무 시간</th>
									    <th>
									        <c:choose>
									            <c:when test="${empty weeklyTotalWorkHours}">
									                0시간 0분 / 52시간
									            </c:when>
									            <c:otherwise>
									                ${weeklyTotalWorkHours} / 52시간
									            </c:otherwise>
									        </c:choose>
									    </th>
									</tr>
									<tr>
									    <th>필수 근무 시간</th>
									    <td>
									        <c:choose>
									            <c:when test="${empty requiredWorkHours}">
									                0시간 0분 / 40시간
									            </c:when>
									            <c:otherwise>
									                <b>${requiredWorkHours}</b> / 40시간
									            </c:otherwise>
									        </c:choose>
									    </td>
									</tr>
									<tr>
									    <th>초과 근무 시간</th>
									    <td>
									        <c:choose>
									            <c:when test="${empty totalOvertimeHours}">
									                0시간 0분 / 12시간
									            </c:when>
									            <c:otherwise>
									                <b>${totalOvertimeHours}</b> / 12시간
									            </c:otherwise>
									        </c:choose>
									    </td>
									</tr>
								</tbody>
							</table>
							<!-- //주간 근무 시간 상세보기 -->

						</div>
					</div>

					<hr class="separator" />
					<hr class="separator" />

					<!-- 일일 근무 시간 -->
					<table
						class="tst_table work_record_month table_align_left table_no_padding">
						<colgroup>
							<col style="width: 12%;" />
							<!-- 날짜 -->
							<col style="width: 10%;" />
							<!-- 출퇴근 시각 -->
							<col style="width: 6%;" />
							<!-- 업무 시간 -->
							<col style="width: 2%;" />
							<!-- 06:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 07:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 08:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 09:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 10:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 11:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 12:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 13:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 14:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 15:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 16:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 17:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 18:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 19:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 20:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 21:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 22:00 -->
							<col style="width: 2%;" />
							<col style="width: 2%;" />
							<!-- 23:00 -->
							<col style="width: 2%;" />
							<!-- 23:30 -->
						</colgroup>
						<thead>
							<tr>
								<th colspan="39">일일 근무 시간</th>
							</tr>
							<tr class="tr_border_bottom">
								<td><h3>근무일</h3></td>
								<td><h3>출퇴근 시각</h3></td>
								<td class="td_border_right"><h3>근무 시간</h3></td>
								<td colspan="2">6</td>
								<td colspan="2">7</td>
								<td colspan="2">8</td>
								<td colspan="2">9</td>
								<td colspan="2">10</td>
								<td colspan="2">11</td>
								<td colspan="2">12</td>
								<td colspan="2">1</td>
								<td colspan="2">2</td>
								<td colspan="2">3</td>
								<td colspan="2">4</td>
								<td colspan="2">5</td>
								<td colspan="2">6</td>
								<td colspan="2">7</td>
								<td colspan="2">8</td>
								<td colspan="2">9</td>
								<td colspan="2">10</td>
								<td colspan="2">11</td>
							</tr>
						</thead>
						<tbody id="work-schedule-body">
							<!-- workDays 데이터가 없으면 해당 주차에 근태 기록이 없다고 표시 -->
							<c:if test="${empty processedWorkDays}">
								<tr>
									<td colspan="39" style="text-align: center; color: black;">해당
										주차에는 근태 기록이 없습니다.</td>
								</tr>
							</c:if>
							<!-- workDays 데이터가 있으면 반복문으로 테이블에 출력 -->
							<c:forEach var="data" items="${processedWorkDays}">
								<tr>
									<td>${data.formatted_date}</td>
									<!-- 출근 기록이 없을 경우 -->
							        <c:if test="${data.attend_date == '00:00' && data.leave_date == '00:00'}">
							            <!-- 출근 시간과 퇴근 시간을 00:00으로 출력 -->
							            <td>00:00~00:00</td>  
							            <td class="td_border_right">0시간 0분</td> <!-- 근무 시간은 0시간 0분으로 출력 -->
							            <!-- 출근 기록이 없다는 메시지 표시 -->
							            <td class="font_caution" colspan="27" style="text-align: center;">
							                출근 기록이 없습니다.
							            </td>
							        </c:if>

									<!-- 출근 시간과 퇴근 시간이 '00:00'이 아닐 경우 -->
									<c:if
										test="${data.attend_date != '00:00' || data.leave_date != '00:00'}">
										<td>${data.attend_date}~${data.leave_date}</td>
										<td class="td_border_right">${data.total_hours}</td>

										<c:forEach begin="6" end="23" var="hour">
											<c:forEach begin="0" end="30" step="30" var="minute">
												<c:set var="workedHourKey"
													value="worked_hours_${hour}_${minute}" />
												<c:set var="workedHourClass"
													value="${data[workedHourKey] != null ? data[workedHourKey] : 'bg_work_over'}" />
												<c:choose>
													<c:when
														test="${hour == 12 && (minute == 0 || minute == 30)}">
														<td class="td_bg_work">
															<div class="bg_work_lunch"></div>
														</td>
													</c:when>
													<c:when test="${workedHourClass == 'bg_work_ordinary'}">
														<td class="td_bg_work">
															<div class="bg_work_ordinary"></div>
														</td>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${workedHourClass == 'bg_work_over'}">
																<td class="td_bg_work">
																	<div class="bg_work_no_over"></div>
																</td>
															</c:when>
															<c:otherwise>
																<td>
																	<div class="bg_work_over"></div>
																</td>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</c:forEach>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>


					</table>
					<!-- //일일 근무 시간 -->
				</div>
			</div>
		</div>
	</div>
	<c:import url="board_detail_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
<script src="resources/js/work_record.js"></script>
</html>