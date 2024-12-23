
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">

  <title></title>
  <link rel="stylesheet" href="/resources/css/approval_form.css" />
  <%--퀼 css--%>
  <link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet" />

  <%--퀼 script--%>
  <script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>



</head>
<body>
<form method="POST" enctype="multipart/form-data">
  <input type = "hidden" name = "doc_idx" id="hidden_doc_idx"/>
  <input type = "hidden" name = "doc_write_date" id="hidden_doc_date"/>

  <table>
    <tr>
      <td>결재 마감일</td>
      <td><input type="datetime-local" name="doc_end_date"/></td>
    </tr>

    <tr>
      <td>보고 제목</td>
      <td><input type="text" name="doc_subject" placeholder="제목을 입력 하세요!"/></td>
    </tr>

    <tr>

      <td colspan="2">
        보고 내용
        <div id="editor"></div>
        <input type="hidden" name="doc_content_sub" class ="content"/>
      </td>
      <td>

      </td>
    </tr>
    <tr>
      <td colspan="2" id ="form_content"></td>
      <input type = "hidden" name = "doc_content"/>
      <td>
      </td>
    </tr>
    <tr>
      <th><input type="button" value="보고하기" onclick=""/><input type="button" value="저장하기" onclick="approval_write_save()"/><input type="button" value="취소하기" onclick="approval_write_delete()"/></th>
    </tr>
  </table>

    <table>
      <thead>
        <tr>
          <td>첨부 파일</td>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>
            <input type="file"  name="files"  multiple = "multiple"/>
          </td>
        </tr>
      </tbody>

    </table>

<div id = "approval_line">
  <div id = "approval_first_wrapper">1차 결재 :
    <div class="approval_line" id = "approval_line1"></div>
    <input type="hidden" name = "empl_line1" id="empl_line1"/>
    <input type="hidden" name = "dept_line1" id="dept_line1"/>
    <input type="hidden" name = "duty_line1" id="duty_line1"/>
    <div onclick="approval_line_window(1)">결재선 선택</div>
  </div>

  <div id = "approval_second">
    <div id = "approval_second_wrapper">2차 결재 :
      <div class="approval_line" id = "approval_line2"></div>
      <input type="hidden" name = "empl_line2"  id = "empl_line2"/>
      <input type="hidden" name = "dept_line2" id = "dept_line2"/>
      <input type="hidden" name = "duty_line2" id = "duty_line2"/>
      <div onclick="approval_line_window(2)">결재선 선택</div>
    </div>
  </div>

  <div id = "approval_final">
    <div id = "approval_final_wrapper">최종 결재 :
      <div class="approval_line" id = "approval_line3"></div>
      <input type="hidden" name = "empl_line3" id = "empl_line3"/>
      <input type="hidden" name = "dept_line3" id = "dept_line3"/>
      <input type="hidden" name = "duty_line3" id = "duty_line3"/>

      <div onclick="approval_line_window(3)">결재선 선택</div>
    </div>
  </div>
</div>
</form>
</body>

<%--기능 script--%>
<script src="/resources/js/approval_request_form_row.js"></script>
<script src="/resources/js/approval_request_form_adjust.js"></script>
<script src="/resources/js/approval_request_write.js"></script>
<script src="/resources/js/approval_request_save.js"></script>
<script src="/resources/js/approval_list_line.js"></script>

<script>
  //모델앤뷰로 받은 파라메터
  console.log("${form_idx}");
  console.log("${doc_idx}");


  var doc_idx = "${doc_idx}";
  var form_idx = "${form_idx}";





  //quill editor
  const quill = new Quill('#editor', {
    theme: 'snow'
  });
</script>
</html>
