<%@ page contentType="text/html;charset=UTF-8" language="java" %>
</div>
<footer class="footer">
    <div class="footer-brand">© 2026 VIRTUAL MALL</div>
    <div class="footer-sub">Admin Panel · SSM Course Design</div>
    <div class="footer-signature">By Wynphor</div>
    <div class="footer-quote">Cease to struggle and you cease to live</div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/common.js"></script>
<script>
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
        var initActive = container.querySelector('.nav-mall-link.active') || links[0];
        moveTo(initActive);
    })();
    (function() {
        var toggle = document.getElementById('navToggle');
        var body = document.getElementById('navBody');
        if (!toggle || !body) return;
        toggle.addEventListener('click', function() {
            body.classList.toggle('open');
            toggle.classList.toggle('active');
        });
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
