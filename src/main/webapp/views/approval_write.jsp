
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">

  <title></title>
  <link rel="stylesheet" href="/resources/css/approval_form.css" />
  <%--퀼 css--%>
  <link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet" />
<%--  <link rel="stylesheet" href="/resources/richtexteditor/res/style.css" />--%>
<%--  <link rel="stylesheet" href="/resources/richtexteditor/rte_theme_default.css" />--%>



  <%--퀼 script--%>
  <script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="/resources/js/approval_form_row.js"></script>
<%--  <script type="text/javascript" src="/resources/richtexteditor/rte.js"></script>--%>
<%--  <script type="text/javascript" src="/resources/richtexteditor/plugins/all_plugins.js"></script>--%>
<%--  <!-- Underscore CDN -->--%>
<%--  <script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.13.1/underscore-min.js"></script>--%>
<%--  <!-- Backbone CDN -->--%>
<%--  <script src="https://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.4.0/backbone-min.js"></script>--%>


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
      <td colspan="2">
        <%--<div id="div_editor"></div>--%>
        <div id="editor"></div>
        <input type="hidden" name="content" class ="content"/>
      </td>
      <td>

      </td>
    </tr>
    <tr>
      <td colspan="2" id ="form_content"></td>
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
</form>
</body>

<script src="/resources/js/approval_form_row.js"></script>
<script src="/resources/js/approval_form_adjust.js"></script>
<script src="/resources/js/approval_write.js"></script>
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
