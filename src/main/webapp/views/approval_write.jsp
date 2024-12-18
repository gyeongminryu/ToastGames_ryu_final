
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">

  <title></title>
  <link rel="stylesheet" href="/resources/css/approval_form.css" />
  <link rel="stylesheet" href="/resources/richtexteditor/res/style.css" />
  <link rel="stylesheet" href="/resources/richtexteditor/rte_theme_default.css" />

  <script src="/resources/js/approval_form_row.js"></script>
  <script type="text/javascript" src="/resources/richtexteditor/rte.js"></script>
  <script type="text/javascript" src="/resources/richtexteditor/plugins/all_plugins.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <!-- Underscore CDN -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.13.1/underscore-min.js"></script>
  <!-- Backbone CDN -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.4.0/backbone-min.js"></script>
</head>
<body>
<form action="doc_write.do" method="POST">
  <table>
    <tr><td></td></tr>
    <tr>
      <td>보고 제목</td>
      <td><input type="text" name="subject" placeholder="제목을 입력 하세요!"/></td>
    </tr>
    <tr>
      <td>보고 내용</td>
      <td><input type="text" name="work_content" placeholder="내용"/></td>
    </tr>
    <tr>
      <td>보고 제목</td>
      <td><input type="file"  name="files"  multiple = "multiple"/></td>
    </tr>
    <tr>
      <td>
        <div id="div_editor"></div>
        <input type="hidden" name="content" class ="content"/>
      </td>

    </tr>
    <tr>
      <td id ="form_content"></td>
    </tr>
    <tr>
      <th><input type="button" value="저장" onclick="save()"/><input type="button" value="결재선 선택" onclick="choose_approval()"/></th>
    </tr>
  </table>
</form>
</body>
<script src="/resources/js/approval_form_row.js"></script>
<script src="/resources/js/approval_form_editable.js"></script>
<script src="/resources/js/approval_write.js"></script>
<script>
  console.log("${form_idx}");
  console.log("${doc_idx}");


  var doc_idx = "${doc_idx}";
  var form_idx = "${form_idx}";

</script>
</html>
