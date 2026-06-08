<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="footer">
    <div class="footer-brand">© 2026 VIRTUAL MALL</div>
    <div class="footer-sub">虚拟数字商城 · SSM Course Design</div>
    <div class="footer-signature">By Wynphor</div>
    <div class="footer-social">
        <span class="social-icon" title="QQ">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2a7 7 0 0 0-7 7v2.5S3.5 13 3.5 15c0 2 1.5 3 3 3.5L5 22l4-2c.8.2 1.6.3 2.5.3s1.7-.1 2.5-.3l4 2-1.5-3.5c1.5-.5 3-1.5 3-3.5 0-2-1.5-3.5-1.5-3.5V9a7 7 0 0 0-7-7z"/></svg>
        </span>
        <span class="social-icon" title="微信">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>
        </span>
        <span class="social-icon" title="Bilibili">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="6" width="20" height="14" rx="3"/><path d="M8 2l3 4M16 2l-3 4"/><circle cx="9" cy="13" r="1.5"/><circle cx="15" cy="13" r="1.5"/></svg>
        </span>
        <span class="social-icon" title="GitHub">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"/></svg>
        </span>
    </div>
    <div class="footer-quote">Cease to struggle and you cease to live</div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/common.js"></script>
<script>
    /* ---- 导航滑动高亮条 ---- */
    (function() {
        var container = document.getElementById('navLinks');
        var anim = document.getElementById('navAnim');
        if (!container || !anim) return;

        var links = container.querySelectorAll('.nav-mall-link');
        if (!links.length) return;

        function moveTo(el) {
            var cr = el.getBoundingClientRect();
            var pr = container.getBoundingClientRect();
            anim.style.width = cr.width + 'px';
            anim.style.left = (cr.left - pr.left) + 'px';
        }

        links.forEach(function(link) {
            link.addEventListener('mouseenter', function() { moveTo(this); });
        });

        container.addEventListener('mouseleave', function() {
            var active = container.querySelector('.nav-mall-link.active') || links[0];
            moveTo(active);
        });

        // 初始化：定位到当前active链接
        var initActive = container.querySelector('.nav-mall-link.active') || links[0];
        moveTo(initActive);
    })();

    /* ---- 移动端汉堡菜单 ---- */
    (function() {
        var toggle = document.getElementById('navToggle');
        var body = document.getElementById('navBody');
        if (!toggle || !body) return;

        toggle.addEventListener('click', function() {
            body.classList.toggle('open');
            // 汉堡动画
            toggle.classList.toggle('active');
        });

        // 点击链接后自动收起
        body.querySelectorAll('.nav-mall-link').forEach(function(link) {
            link.addEventListener('click', function() {
                if (window.innerWidth <= 767) {
                    body.classList.remove('open');
                    toggle.classList.remove('active');
                }
            });
        });
    })();
</script>
</body>
</html>
