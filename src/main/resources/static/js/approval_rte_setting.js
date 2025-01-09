function setHtmlCode() {
    document.querySelectorAll('#div_editor_copy td:empty').forEach(function(td) {
        td.innerHTML = '<br />';
    });
    let html = document.getElementById('div_editor_copy').innerHTML;
    console.log("copy:",html)
    editor1.setHTMLCode(html);
}

function getHtmlCode(){
    document.getElementById('div_editor_copy').innerHTML = editor1.getHTMLCode();
}