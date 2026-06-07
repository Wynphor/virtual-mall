<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/header.jsp" %>

<div class="container mt-4 fade-in" style="max-width: 800px;">
    <h4 class="section-title">ORDER DETAIL 订单详情</h4>

    <div class="glass-card mb-3 p-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <span style="color: var(--color-primary-light);">订单号：<code style="color: var(--color-nav);">${order.orderNo}</code></span>
            <c:choose>
                <c:when test="${order.status == 0}"><span class="badge bg-warning">待支付</span></c:when>
                <c:when test="${order.status == 2}"><span class="badge bg-success">已完成</span></c:when>
                <c:when test="${order.status == 3}"><span class="badge bg-secondary">已取消</span></c:when>
            </c:choose>
        </div>
        <div class="row" style="color: var(--color-primary-light); font-size: 0.88rem;">
            <div class="col-6">下单时间：<fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
            <div class="col-6 text-end">联系方式：${fn:escapeXml(order.contact)}</div>
        </div>
        <c:if test="${order.status == 0}">
            <hr style="border-color: rgba(123,161,197,0.2);">
            <a href="${pageContext.request.contextPath}/order/pay/${order.orderNo}" class="btn btn-danger btn-sm" style="border-radius: 8px;">去支付</a>
        </c:if>
    </div>

    <!-- 商品明细 -->
    <c:forEach var="item" items="${items}">
        <div class="glass-card mb-3 p-4">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <div>
                    <div style="font-weight: bolder; color: var(--color-heading-alt);">${fn:escapeXml(item.productName)}</div>
                    <small style="color: var(--color-primary-light);">规格：${fn:escapeXml(item.specName)} × ${item.quantity}</small>
                </div>
                <span class="price-tag">¥<fmt:formatNumber value="${item.price * item.quantity}" pattern="#,##0.00"/></span>
            </div>

            <c:if test="${order.status == 2 && not empty item.cardKeys}">
                <hr style="border-color: rgba(123,161,197,0.2);">
                <h6 style="font-weight: bolder; color: var(--color-accent); margin-bottom: 0.5rem;">卡密信息</h6>
                <c:forEach var="key" items="${item.cardKeys}">
                    <div class="card-key-box mb-2">${fn:escapeXml(key.content)}</div>
                </c:forEach>
            </c:if>
        </div>
    </c:forEach>

    <!-- 订单金额 -->
    <div class="glass-card p-4 text-end">
        <span style="color: var(--color-primary-light); margin-right: 0.5rem;">订单总额：</span>
        <span class="price-tag" style="font-size: 1.5rem;">
            ¥<fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/>
        </span>
    </div>

    <div class="text-center mt-3 mb-4">
        <a href="${pageContext.request.contextPath}/order/query" style="color: var(--color-primary-light);">返回订单查询</a>
    </div>
</div>

<%@ include file="../../common/footer.jsp" %>
