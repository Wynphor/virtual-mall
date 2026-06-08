// 公共 JS
(function () {
    function printConsoleBanner() {
        var siteCreatedAt = new Date('2026-06-08T00:00:00+08:00');
        var aliveDays = Math.max(1, Math.floor((Date.now() - siteCreatedAt.getTime()) / 86400000) + 1);
        var banner = String.raw`
  ██╗    ██╗██╗   ██╗███╗   ██╗██████╗ ██╗  ██╗ ██████╗ ██████╗
  ██║    ██║╚██╗ ██╔╝████╗  ██║██╔══██╗██║  ██║██╔═══██╗██╔══██╗
  ██║ █╗ ██║ ╚████╔╝ ██╔██╗ ██║██████╔╝███████║██║   ██║██████╔╝
  ██║███╗██║  ╚██╔╝  ██║╚██╗██║██╔═══╝ ██╔══██║██║   ██║██╔══██╗
  ╚███╔███╔╝   ██║   ██║ ╚████║██║     ██║  ██║╚██████╔╝██║  ██║
   ╚══╝╚══╝    ╚═╝   ╚═╝  ╚═══╝╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝

  这里是 Wynphor 的虚拟数字商城 🛒
  SSM 搭的货架，MySQL 管的仓库，JSP 负责摆摊。
  当前版本 v1.0.0，小店刚开张，欢迎随便看看 ☕
  小站已经苟活 ${aliveDays} 天了！🌱

  欢迎来到控制台。
  你发现了隐藏入口，但这里没有管理员密码 🔐
  只有一份还算努力的 SSM 作业。
  提示：不要粘贴陌生代码，除非它请你喝奶茶。
`;
        console.log('%c' + banner, 'color:#5484a1;font-family:Consolas,Menlo,monospace;line-height:1.35;font-weight:600;');
    }

    function autoCloseAlerts() {
        if (!window.bootstrap) return;
        setTimeout(function () {
            document.querySelectorAll('.alert-dismissible').forEach(function (alertEl) {
                var bsAlert = new bootstrap.Alert(alertEl);
                bsAlert.close();
            });
        }, 5000);
    }

    document.addEventListener('DOMContentLoaded', function () {
        printConsoleBanner();
        autoCloseAlerts();
    });
})();
