window.onload = function initialize(){

    /*list 보여주기
    function_list_show('write');
    function_list_show('sent');
    function_list_show('received');
*/


    //기존에 작성한 문서 limit 2
    $.ajax({
        type : 'POST',
        url : 'get_recent_written.ajax',
        data : {},
        dataType : 'JSON',
        success : function(data){
            console.log(data);
            console.log(data.recent_doc);
            approval_draw_recent_written(data.recent_doc);

        },error : function(e){
            console.log(e);
        }
    })

}
function approval_draw_recent_written(recent_docs){
    var content ='';
    for(var recent_doc of recent_docs) {
        console.log("recent_doc", recent_doc);
        if(recent_doc.doc_subject !==undefined){ //아예 불러온 목록에 없으면 undefined
            content += '<li><div class="tst_flex"><div class="tst_flex tst_col3 align_center"><i class="bi bi-file-earmark-text"></i></div><div class="tst_col9"><h3>' + recent_doc.doc_subject + '</h3><p class="font_subtle"><a href="/approval_write.go?form_idx=' + recent_doc.form_idx + '"><i class="bi bi-file-earmark-text"></i>' + recent_doc.form_subject + '</a></p><button onclick="location.href=\'/approval_copy_doc.do?doc_idx=' + recent_doc.doc_idx + '&form_idx=' + recent_doc.form_idx + '\'" class="btn_secondary btn_min">복사</button></div></div></li>';
        }else{
            content += '<li><div class="tst_flex"><div class="tst_flex tst_col3 align_center"><i class="bi bi-file-earmark-text"></i></div><div class="tst_col9"><h3>제목 없음</h3><p class="font_subtle"><a href="/approval_write.go?form_idx=' + recent_doc.form_idx + '"><i class="bi bi-file-earmark-text"></i>' + recent_doc.form_subject + '</a></p><button onclick="location.href=\'/approval_copy_doc.do?doc_idx=' + recent_doc.doc_idx + '&form_idx=' + recent_doc.form_idx + '\'" class="btn_secondary btn_min">복사</button></div></div></li>';
        }
        console.log(content);
    }

    $('#recent_doc_list').html(content);

}