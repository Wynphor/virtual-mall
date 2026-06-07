// 公共JS
$(function () {
    // 自动隐藏提示信息
    setTimeout(function () {
        $('.alert-dismissible').each(function() {
            var bsAlert = new bootstrap.Alert(this);
            bsAlert.close();
        });
    }, 5000);
});
