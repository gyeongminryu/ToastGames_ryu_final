function tst_modal_call(cls) {
    document.getElementsByClassName(cls)[0].style.display = 'flex';
}

function tst_modal_call_param(cls, param) {
    document.getElementsByClassName(cls)[0].style.display = 'flex';
    document.getElementById('tst_modal_param').value = param;
    console.log(document.getElementById('tst_modal_param').value);
}

function tst_modal_close(cls) {
    document.getElementsByClassName(cls)[0].style.display = 'none';
}

// 부서 정보 불러오기
function callDeptToModal(idx) {
    $.ajax({
        type: 'post',
        url: 'manage_form_call_dept.ajax',
        data: {
            'dept_high': idx
        },
        dataType: 'json',
        success: function(data) {
            console.log(data.info);
        },
        error: function(e) {
            //console.log(e);
        }
    });
}