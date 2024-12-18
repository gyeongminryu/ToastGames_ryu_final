<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/css/approval_form.css" />


    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- Underscore CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.13.1/underscore-min.js"></script>
    <!-- Backbone CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.4.0/backbone-min.js"></script>
</head>
<body>
<div id = "content_box">
    <div class="form_subject" onclick=""></div>
</div>


<div class = "form_wrapper">
    <form action="approval_write.go" method="POST">
        <input type="hidden" name = "form_idx" id = "form_idx"/>
        <div id = "html_rendering">
        </div>
        <input type="hidden" name = "form_content" id = "form_content"/>
    </form>
    <div id = "button_wrapper">
    </div>
</div>
</body>
<script src="/resources/js/approval_form_row.js"></script>
<script src="/resources/js/approval_form_list.js"></script>

</html>