<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TOAST Games Groupware</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/stats_dashboard.css" />
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
                    <li class="tst_title_item tst_title_item_active" onclick="location.href='/stats_dashboard'">
                        <h1>게임 통계</h1>
                    </li>
                </ul>
                <!-- //제목 -->

                <div class="dashboard_container">

                    <div class="list_module">
                        <div class="content_container">
                            <div class="title_container">
                                <div class="content_block">
                                    <div class="content_thumbnail" style="background-image:
                                url('https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/a4/c5/0d/a4c50d21-58a6-3ee2-41a1-69769c91db16/AppIcon-1x_U007epad-0-0-85-220-0.png/230x0w.webp')"></div>
                                </div>
                                <div class="content_block">
                                    <h1>원신</h1>
                                    <p class="font_subtle">모바일, 롤플레잉</p>
                                </div>
                            </div>
                            <div class="summary_container">
                                <div class="content_block">
                                    <h4 class="font_subtle">GOOGLE PLAY</h4>
                                    <table>
                                        <colgroup>
                                            <col style="width: 100px" />
                                            <col style="width: auto" />
                                            <col style="width: 165px" />
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th>별점</th>
                                            <td><i class="bi bi-star-fill"></i> 3.7</td>
                                            <td rowspan="4">

                                                <table class="print_grade">
                                                    <colgroup>
                                                        <col style="width: 70px" />
                                                        <col style="width: auto" />
                                                    </colgroup>
                                                    <tbody>
                                                    <tr class="print_grade_5">
                                                        <td>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_4">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_3">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_2">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_1">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>

                                            </td>
                                        </tr>
                                        <tr>
                                            <th>리뷰</th>
                                            <td>484만개</td>
                                        </tr>
                                        <tr>
                                            <th>다운로드 수</th>
                                            <td>1억 이상</td>
                                        </tr>
                                        <tr>
                                            <th>마켓 내 순위</th>
                                            <td>최고 매출 5위</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="content_block">
                                    <h4 class="font_subtle">APPSTORE</h4>
                                    <table>
                                        <colgroup>
                                            <col style="width: 100px" />
                                            <col style="width: auto" />
                                            <col style="width: 165px" />
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th>별점</th>
                                            <td><i class="bi bi-star-fill"></i> 4.1</td>
                                            <td rowspan="4">

                                                <table class="print_grade">
                                                    <colgroup>
                                                        <col style="width: 70px" />
                                                        <col style="width: auto" />
                                                    </colgroup>
                                                    <tbody>
                                                    <tr class="print_grade_5">
                                                        <td>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_4">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_3">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_2">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_1">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>

                                            </td>
                                        </tr>
                                        <tr>
                                            <th>리뷰</th>
                                            <td>4.2만개</td>
                                        </tr>
                                        <tr>
                                            <th>다운로드 수</th>
                                            <td>1억 이상</td>
                                        </tr>
                                        <tr>
                                            <th>마켓 내 순위</th>
                                            <td>어드벤처 앱 14위</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="review_container">
                                <div class="content_block">
                                    <h4 class="font_subtle">REVIEW</h4>
                                    <div class="review_grade">
                                        <span>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </span>
                                        <span class="font_subtle"> 2024년 11월 21일</span>
                                    </div>
                                    <div class="review_content">
                                        복귀 유저의 별점입니다 :) 우선 복귀한 후 부터 하루도 빠짐없이 열심히 원신 즐기고 있고 업데이트도 매번 새롬고 즐겁게 하고있습니다. 폰 버전과 PC버전 콘솔 까지 전부 사용하는 유저로써 우선 용량은 예전보다는 최적화 되었고 발열은 어떤기기든 어쩔수 없는것 같습니다. 그 외 게임적으로 봤을 때 편의선 개성이 필요한 부분은 꽤 존재하지만 캐릭터와 스토리, 설정 등 모두 너무 재미있고 마음에 들어요. 용량이 엄청난 만큼 맵도 가득 차있고 탐사도 늘 새롭습니다.
                                    </div>
                                </div>
                                <div class="content_block">
                                    <h4 class="font_subtle">REVIEW</h4>
                                    <div class="review_grade">
                                        <span>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </span>
                                        <span class="font_subtle"> 2024년 11월 21일</span>
                                    </div>
                                    <div class="review_content">
                                        일딴 결론만 말슴드리자면은 한번씩해보는걸 추천합니다😙 일딴 장점은 캐릭터 하나하나 발걸음소리가 다르거나 캐릭터만의 스토리도 다른데, 이런 디테일이 게임의 몰입담을 높혀줍니다. 또 전투같은것도 시원스럽고 모션도
                                    </div>
                                </div>
                            </div>
                            <div class="button_container">
                                <i onclick="tst_modal_call_param('tst_modal_review', '{param}')" class="bi bi-arrow-right-circle tst_pointer"></i>
                            </div>
                        </div>
                    </div>

                    <div class="list_module">
                        <div class="content_container">
                            <div class="title_container">
                                <div class="content_block">
                                    <div class="content_thumbnail" style="background-image:
                                url('https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/a4/c5/0d/a4c50d21-58a6-3ee2-41a1-69769c91db16/AppIcon-1x_U007epad-0-0-85-220-0.png/230x0w.webp')"></div>
                                </div>
                                <div class="content_block">
                                    <h1>원신</h1>
                                    <p class="font_subtle">모바일, 롤플레잉</p>
                                </div>
                            </div>
                            <div class="summary_container">
                                <div class="content_block">
                                    <h4 class="font_subtle">GOOGLE PLAY</h4>
                                    <table>
                                        <colgroup>
                                            <col style="width: 100px" />
                                            <col style="width: auto" />
                                            <col style="width: 165px" />
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th>별점</th>
                                            <td><i class="bi bi-star-fill"></i> 3.7</td>
                                            <td rowspan="4">

                                                <table class="print_grade">
                                                    <colgroup>
                                                        <col style="width: 70px" />
                                                        <col style="width: auto" />
                                                    </colgroup>
                                                    <tbody>
                                                    <tr class="print_grade_5">
                                                        <td>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_4">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_3">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_2">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_1">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>

                                            </td>
                                        </tr>
                                        <tr>
                                            <th>리뷰</th>
                                            <td>484만개</td>
                                        </tr>
                                        <tr>
                                            <th>다운로드 수</th>
                                            <td>1억 이상</td>
                                        </tr>
                                        <tr>
                                            <th>마켓 내 순위</th>
                                            <td>최고 매출 5위</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="content_block">
                                    <h4 class="font_subtle">APPSTORE</h4>
                                    <table>
                                        <colgroup>
                                            <col style="width: 100px" />
                                            <col style="width: auto" />
                                            <col style="width: 165px" />
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th>별점</th>
                                            <td><i class="bi bi-star-fill"></i> 4.1</td>
                                            <td rowspan="4">

                                                <table class="print_grade">
                                                    <colgroup>
                                                        <col style="width: 70px" />
                                                        <col style="width: auto" />
                                                    </colgroup>
                                                    <tbody>
                                                    <tr class="print_grade_5">
                                                        <td>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_4">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_3">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_2">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    <tr class="print_grade_1">
                                                        <td>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star"></i>
                                                            <i class="bi bi-star-fill"></i>
                                                        </td>
                                                        <td>
                                                            <div class="progress_bar_frame"></div>
                                                            <div class="progress_bar_fill"></div>
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>

                                            </td>
                                        </tr>
                                        <tr>
                                            <th>리뷰</th>
                                            <td>4.2만개</td>
                                        </tr>
                                        <tr>
                                            <th>다운로드 수</th>
                                            <td>1억 이상</td>
                                        </tr>
                                        <tr>
                                            <th>마켓 내 순위</th>
                                            <td>어드벤처 앱 14위</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="review_container">
                                <div class="content_block">
                                    <h4 class="font_subtle">REVIEW</h4>
                                    <div class="review_grade">
                                        <span>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </span>
                                        <span class="font_subtle"> 2024년 11월 21일</span>
                                    </div>
                                    <div class="review_content">
                                        복귀 유저의 별점입니다 :) 우선 복귀한 후 부터 하루도 빠짐없이 열심히 원신 즐기고 있고 업데이트도 매번 새롬고 즐겁게 하고있습니다. 폰 버전과 PC버전 콘솔 까지 전부 사용하는 유저로써 우선 용량은 예전보다는 최적화 되었고 발열은 어떤기기든 어쩔수 없는것 같습니다. 그 외 게임적으로 봤을 때 편의선 개성이 필요한 부분은 꽤 존재하지만 캐릭터와 스토리, 설정 등 모두 너무 재미있고 마음에 들어요. 용량이 엄청난 만큼 맵도 가득 차있고 탐사도 늘 새롭습니다.
                                    </div>
                                </div>
                                <div class="content_block">
                                    <h4 class="font_subtle">REVIEW</h4>
                                    <div class="review_grade">
                                        <span>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </span>
                                        <span class="font_subtle"> 2024년 11월 21일</span>
                                    </div>
                                    <div class="review_content">
                                        일딴 결론만 말슴드리자면은 한번씩해보는걸 추천합니다😙 일딴 장점은 캐릭터 하나하나 발걸음소리가 다르거나 캐릭터만의 스토리도 다른데, 이런 디테일이 게임의 몰입담을 높혀줍니다. 또 전투같은것도 시원스럽고 모션도
                                    </div>
                                </div>
                            </div>
                            <div class="button_container">
                                <i onclick="tst_modal_call_param('tst_modal_review', '{param}')" class="bi bi-arrow-right-circle tst_pointer"></i>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
<c:import url="stats_dashboard_modal.jsp" />
</body>
<script src="resources/js/common.js"></script>
</html>