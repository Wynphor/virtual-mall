<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/header.jsp" %>

<div class="container mt-4 fade-in" style="max-width: 700px;">
    <h4 class="section-title">ORDER 确认订单</h4>

    <div class="glass-card mb-3 p-4">
        <h6 style="font-weight: bolder; color: var(--color-heading-alt); margin-bottom: 1rem;">商品信息</h6>
        <div class="d-flex justify-content-between align-items-center mb-2">
            <div>
                <div style="font-weight: bolder;">${fn:escapeXml(product.name)}</div>
                <small style="color: var(--color-primary-light);">规格：${fn:escapeXml(sku.specName)}</small>
            </div>
            <span class="price-tag">¥${sku.price}</span>
        </div>
        <hr style="border-color: rgba(123,161,197,0.2);">
        <div class="d-flex justify-content-between align-items-center">
            <span style="color: var(--color-primary-light);">数量 × ${quantity}</span>
            <span class="price-tag" style="font-size: 1.3rem;">
                ¥<fmt:formatNumber value="${sku.price * quantity}" pattern="#,##0.00"/>
            </span>
        </div>
    </div>

    <div class="glass-card mb-3 p-4">
        <h6 style="font-weight: bolder; color: var(--color-heading-alt); margin-bottom: 1rem;">联系方式</h6>
        <form action="${pageContext.request.contextPath}/order/submit" method="post" id="orderForm">
            <input type="hidden" name="_csrf" value="${csrfToken}">
            <input type="hidden" name="skuId" value="${sku.id}">
            <input type="hidden" name="quantity" value="${quantity}">
            <input type="hidden" name="queryPassword" value="${queryPassword}">
            <input type="hidden" name="payMethod" value="${payMethod}">
            <div class="mb-3">
                <label class="form-label" style="font-weight: bolder;">邮箱或手机号 <span class="text-danger">*</span></label>
                <input type="text" class="form-control" name="contact" value="${fn:escapeXml(defaultContact)}"
                       placeholder="用于查询订单和接收卡密" required>
                <div class="form-text">请确保填写正确，支付完成后可凭此查询订单</div>
            </div>
        </form>
    </div>

    <div class="glass-card p-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <span style="font-weight: bolder; color: var(--color-heading-alt);">应付金额</span>
            <span class="price-tag" style="font-size: 1.5rem;">
                ¥<fmt:formatNumber value="${sku.price * quantity}" pattern="#,##0.00"/>
            </span>
        </div>
        <button type="submit" form="orderForm" class="btn btn-primary w-100 btn-lg" style="border-radius: 10px; padding: 0.7rem;" onclick="return validateOrder();">
            提交订单
        </button>
    </div>
</div>

<script>
function validateOrder() {
    var contact = document.querySelector('#orderForm input[name="contact"]').value.trim();
    if (!contact) { alert('请输入联系方式'); return false; }
    var isPhone = /^1[3-9]\d{9}$/.test(contact);
    var isEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(contact);
    if (!isPhone && !isEmail) { alert('联系方式请输入正确的手机号或邮箱'); return false; }
    return true;
}
</script>

<%@ include file="../../common/footer.jsp" %>
