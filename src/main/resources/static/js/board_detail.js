// 대댓글 작성
function reply_write(no) {
    document.getElementsByClassName('reply_write_'+no)[0].classList.remove('disp_hide');
}

function reply_write_cancel(no) {
    document.getElementsByClassName('reply_write_'+no)[0].classList.add('disp_hide');
}

// 댓글 수정
function reply_update(no) {
    document.getElementsByClassName('reply_update_'+no)[0].classList.remove('disp_hide');
}

function update_reply_cancel(no) {
    document.getElementsByClassName('reply_update_'+no)[0].classList.add('disp_hide');
}

// 대댓글 수정
function re_reply_update(no) {
    document.getElementsByClassName('re_reply_update_'+no)[0].classList.remove('disp_hide');
}

function update_re_reply_cancel(no) {
    document.getElementsByClassName('re_reply_update_'+no)[0].classList.add('disp_hide');
}

// 리치텍스트에디터
	var config = {}	
	config.editorResizeMode = "none";
		
	config.toolbar="simple";
	// html 저장, 출력, pdf 저장, 코드보기 만 노출
	config.toolbar_simple = "{save, print, html2pdf, code}";
	
	
	var editor = new RichTextEditor("#div_editor", config);
	editor.setHTMLCode($('#content').html());
	editor.setReadOnly();
