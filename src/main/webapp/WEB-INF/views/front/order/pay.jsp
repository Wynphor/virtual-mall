<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/header.jsp" %>

<div class="container mt-4 fade-in" style="max-width: 500px;">
    <div class="glass-card p-4 text-center">
        <h4 style="font-weight: bolder; color: var(--color-heading-alt); margin-bottom: 0.8rem;">扫码支付</h4>
        <p style="color: var(--color-primary-light); margin-bottom: 1rem;">订单号：<code style="color: var(--color-nav);">${order.orderNo}</code></p>

        <div class="qr-container mb-3">
            <img src="${pageContext.request.contextPath}/static/images/doro-pay.webp"
                 alt="扫码支付" style="width: 280px; height: auto; border-radius: 16px;">
        </div>

        <div class="mb-3">
            <span class="price-tag" style="font-size: 1.8rem;">
                ¥<fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/>
            </span>
        </div>

        <p style="color: var(--color-primary-light); margin-bottom: 1rem;">
            请在 <span id="countdown" style="font-weight: bolder; color: var(--color-accent); font-size: 1.2rem;">15:00</span> 内完成支付
        </p>

        <button class="btn btn-primary w-100 btn-lg" id="confirmPayBtn" onclick="confirmPay()" style="border-radius: 10px; padding: 0.7rem;">
            我已完成支付
        </button>

        <p style="color: rgba(123,161,197,0.6); font-size: 0.8rem; margin-top: 1rem; margin-bottom: 0;">扫码后请截图保存，付款后点击上方按钮</p>
    </div>
</div>

<script>
    let seconds = 900;
    setInterval(function() {
        if (seconds <= 0) return;
        seconds--;
        const m = Math.floor(seconds / 60);
        const s = seconds % 60;
        document.getElementById('countdown').textContent =
            (m < 10 ? '0' : '') + m + ':' + (s < 10 ? '0' : '') + s;
    }, 1000);

    function confirmPay() {
        const btn = document.getElementById('confirmPayBtn');
        btn.disabled = true;
        btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>提交中...';

        fetch('${pageContext.request.contextPath}/order/confirmPay', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'orderNo=${order.orderNo}'
        })
        .then(r => r.json())
        .then(data => {
            if (data.success) {
                window.location.href = '${pageContext.request.contextPath}/order/success/${order.orderNo}';
            } else {
                alert(data.msg);
                btn.disabled = false;
                btn.textContent = '我已完成支付';
            }
        })
        .catch(() => {
            alert('网络错误，请重试');
            btn.disabled = false;
            btn.textContent = '我已完成支付';
        });
    }
</script>

<%@ include file="../../common/footer.jsp" %>
