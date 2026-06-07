<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/header.jsp" %>

<div class="container mt-4 fade-in" style="max-width: 600px;">
    <div class="glass-card p-5 text-center">
        <div style="font-size: 3rem; margin-bottom: 1rem;">🎉</div>
        <h4 style="font-weight: bolder; color: var(--color-heading-alt); margin-bottom: 0.5rem;">支付成功 · 卡密已发放</h4>
        <p style="color: var(--color-primary-light); margin-bottom: 1rem;">订单号：<code style="color: var(--color-nav);">${order.orderNo}</code></p>

        <div style="background: rgba(219, 235, 241, 0.45); border-radius: 12px; padding: 1rem; margin-bottom: 1rem; text-align: left;">
            <div class="d-flex justify-content-between mb-1">
                <span style="color: var(--color-primary-light);">应付金额</span>
                <span class="price-tag">¥<fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/></span>
            </div>
            <div class="d-flex justify-content-between">
                <span style="color: var(--color-primary-light);">联系方式</span>
                <span>${fn:escapeXml(order.contact)}</span>
            </div>
        </div>

        <!-- 卡密信息 -->
        <c:if test="${not empty order.items}">
            <div class="text-start" style="margin-bottom: 1rem;">
                <h6 style="font-weight: bolder; color: var(--color-accent); margin-bottom: 0.6rem;">卡密信息</h6>
                <c:forEach var="item" items="${order.items}">
                    <c:if test="${not empty item.cardKeys}">
                        <div style="margin-bottom: 0.5rem;">
                            <small style="color: var(--color-primary-light); font-weight: bolder;">${fn:escapeXml(item.productName)} - ${fn:escapeXml(item.specName)}</small>
                            <c:forEach var="key" items="${item.cardKeys}">
                                <div class="card-key-box mb-1">${fn:escapeXml(key.content)}</div>
                            </c:forEach>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </c:if>

        <a href="${pageContext.request.contextPath}/order/detail/${order.orderNo}"
           class="btn btn-primary w-100 mb-2" style="border-radius: 10px; padding: 0.7rem;">查看订单详情</a>
        <a href="${pageContext.request.contextPath}/"
           class="btn btn-outline-secondary w-100" style="border-radius: 10px; padding: 0.7rem;">返回首页</a>
    </div>
</div>

<%@ include file="../../common/footer.jsp" %>
