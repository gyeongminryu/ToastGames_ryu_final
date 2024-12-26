<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회사 정보 수정</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }
        .modal-content {
            background-color: #fff;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 50%;
            border-radius: 8px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover, .close:focus {
            color: black;
            text-decoration: none;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table th, table td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        table th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>회사 정보 수정</h2>
    
    <!-- 회사 정보 수정 폼 -->
    <form action="./companyinfo_update.do" method="POST">
        <table>
            <tr>
                <td><label for="comp_name">회사명:</label></td>
                <td><input type="text" id="comp_name" name="comp_name" value="${comp_info.comp_name}" required /></td>
            </tr>
            <tr>
                <td><label for="ceo_idx">대표(이름/직급/직책):</label></td>
                <td>
                	<input type="hidden" id="ceo_idx" name="ceo_idx" value="${comp_info.ceo_idx}"/>
                    <input type="text" id="ceo" name="ceo" value="${ceo_info.empl_name}/${ceo_info.position_name}/${ceo_info.duty_name}" readonly required />
                    <button type="button" id="changeCeoButton">대표 변경하기</button>
                </td>
            </tr>
            <tr>
                <td><label for="comp_phone">회사 번호:</label></td>
                <td><input type="text" id="comp_phone" name="comp_phone" value="${comp_info.comp_phone}" required /></td>
            </tr>
            <tr>
                <td><label for="comp_biz_no">사업자등록번호:</label></td>
                <td><input type="text" id="comp_biz_no" name="comp_biz_no" value="${comp_info.comp_biz_no}" required /></td>
            </tr>
            <tr>
                <td><label for="comp_corp_no">법인등록번호:</label></td>
                <td><input type="text" id="comp_corp_no" name="comp_corp_no" value="${comp_info.comp_corp_no}" required /></td>
            </tr>
            <tr>
                <td><label for="address">주소:</label></td>
                <td><input type="text" id="comp_addr" name="comp_addr" value="${comp_info.comp_addr }" required/></td>
            </tr>
            <tr>
                <td><label for="establishmentDate">설립일:</label></td>
                <td><input type="date" id="comp_est_date" name="comp_est_date" value="${comp_info.comp_est_date }" required /></td>
            </tr>
        </table>
        <input type="submit" value="저장" />
    </form>

    <!-- 직인 파일 업로드 폼 -->
    <form id="companyStampForm" action="company_stamp.do" method="POST" enctype="multipart/form-data">
        <div>
            <label for="empl_stamp">새로운 직인 파일 선택:</label>
            <input type="file" id="singleFile" name="singleFile" />
            <div>
                <h4>새로운 직인 파일 미리보기:</h4>
                <img id="newSealPreview" src="#" alt="새로운 직인 미리보기" style="display: none; max-width: 200px; max-height: 200px;" />
            </div>
        </div>
        <button type="submit">직인 제출</button>
    </form>

    <!-- 기존 직인 미리보기 -->
    <div>
        <h4>기존 직인 파일:</h4>
        <img id="existingSealPreview" src="/files/${comp_info.comp_stamp}" alt="기존 직인 미리보기" style="display: ${comp_info.comp_stamp != null ? 'block' : 'none'}; max-width: 200px; max-height: 200px;" />
    </div>

    <!-- 모달 창 -->
    <div id="employeeModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>직원 리스트</h3>
            <table id="employeeTable">
                <thead>
                    <tr>
                        <th>직원 번호</th>
                        <th>직원 이름</th>
                        <th>직책/직급</th>
                        <th>선택</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- AJAX로 데이터 추가 -->
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // 모달 엘리먼트
        var modal = document.getElementById('employeeModal');
        var closeModal = document.querySelector('.close');
        var employeeTableBody = document.querySelector('#employeeTable tbody');

        // 대표 변경 버튼 클릭 시 모달 열기
        document.getElementById('changeCeoButton').addEventListener('click', function () {
            modal.style.display = 'block';

            // AJAX 요청으로 직원 리스트 가져오기
            $.ajax({
                url: './employee_list.ajax',
                type: 'GET',
                dataType: 'json',
                success: function (response) {
                    // 테이블 초기화
                    employeeTableBody.innerHTML = '';

                    // 직원 리스트 렌더링
                    response.forEach(function (employee) {
                        var row = document.createElement('tr');
                        row.innerHTML =
                            '<td>' + employee.empl_idx + '</td>' +
                            '<td>' + employee.empl_name + '</td>' +
                            '<td>' +  ((employee.position_name || '없음') + '/' + (employee.duty_name || '없음')) + '</td>' +
                            '<td><button type="button" class="selectCeoButton" data-id="' +
                            employee.empl_idx +
                            '" data-name="' +
                            employee.empl_name +
                            '" data-position="' +
                            (employee.position_name || '') +
                            '" data-duty="' +
                            (employee.duty_name || '') +
                            '">선택</button></td>';
                        employeeTableBody.appendChild(row);
                    });

                    // "선택" 버튼 클릭 이벤트 추가
                    document.querySelectorAll('.selectCeoButton').forEach(function (button) {
                        button.addEventListener('click', function () {
                            var emplName = this.getAttribute('data-name');
                            var positionName = this.getAttribute('data-position')|| '없음';
                            var emplIdx = this.getAttribute('data-id');
                            var dutyName = this.getAttribute('data-duty')|| '없음';

                            // 대표 필드 업데이트
                            document.getElementById('ceo').value = emplName + '/' + positionName + '/'+ dutyName;
                            document.getElementById('ceo_idx').value = emplIdx;
                            // 모달 닫기
                            modal.style.display = 'none';
                        });
                    });
                },
                error: function (xhr, status, error) {
                    console.error('직원 리스트를 가져오는 중 오류 발생: ', error);
                }
            });
        });

        // 모달 닫기 버튼
        closeModal.addEventListener('click', function () {
            modal.style.display = 'none';
        });

        // 모달 외부 클릭 시 닫기
        window.addEventListener('click', function (event) {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });

        // 직인 파일 미리보기
        document.getElementById('singleFile').addEventListener('change', function (event) {
            var file = event.target.files[0];
            var previewImage = document.getElementById('newSealPreview');

            if (file) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    previewImage.src = e.target.result;
                    previewImage.style.display = 'block';
                };
                reader.readAsDataURL(file);
            } else {
                previewImage.style.display = 'none';
            }
        });
    </script>
</body>
</html>
