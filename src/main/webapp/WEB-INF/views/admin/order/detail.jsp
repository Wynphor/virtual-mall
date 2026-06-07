<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin_header.jsp" %>

<h4 class="section-title">ORDER DETAIL 订单详情</h4>

<div class="row g-4 mb-4">
    <div class="col-lg-6">
        <div class="glass-card p-4 h-100">
            <h6 style="font-weight: bolder; color: var(--color-heading-alt); margin-bottom: 1rem;">订单信息</h6>
            <div class="mb-2 d-flex justify-content-between">
                <span style="color: var(--color-primary-light);">订单编号</span>
                <code style="color: var(--color-nav);">${order.orderNo}</code>
            </div>
            <div class="mb-2 d-flex justify-content-between">
                <span style="color: var(--color-primary-light);">联系方式</span>
                <span>${fn:escapeXml(order.contact)}</span>
            </div>
            <div class="mb-2 d-flex justify-content-between">
                <span style="color: var(--color-primary-light);">用户ID</span>
                <span>${order.userId != null ? order.userId : '未登录用户'}</span>
            </div>
            <div class="mb-2 d-flex justify-content-between">
                <span style="color: var(--color-primary-light);">下单时间</span>
                <span><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
            </div>
            <c:if test="${not empty order.payTime}">
                <div class="mb-2 d-flex justify-content-between">
                    <span style="color: var(--color-primary-light);">付款时间</span>
                    <span><fmt:formatDate value="${order.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                </div>
            </c:if>
            <div class="d-flex justify-content-between align-items-center">
                <span style="color: var(--color-primary-light);">状态</span>
                <c:choose>
                    <c:when test="${order.status == 0}"><span class="badge bg-warning">待支付</span></c:when>
                    <c:when test="${order.status == 2}"><span class="badge bg-success">已完成</span></c:when>
                    <c:when test="${order.status == 3}"><span class="badge bg-secondary">已取消</span></c:when>
                </c:choose>
            </div>
        </div>
    </div>
    <div class="col-lg-6">
        <div class="glass-card p-4 h-100 text-center d-flex flex-column justify-content-center">
            <span style="color: var(--color-primary-light); margin-bottom: 0.5rem;">订单金额</span>
            <span class="price-tag" style="font-size: 2.5rem;">¥<fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/></span>
        </div>
    </div>
</div>

<div class="glass-card mb-4">
    <div class="table-responsive">
        <table class="table mb-0">
            <thead>
                <tr><th>商品</th><th>规格</th><th>单价</th><th>数量</th><th>小计</th></tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${items}">
                    <tr>
                        <td style="font-weight: bolder;">${fn:escapeXml(item.productName)}</td>
                        <td>${fn:escapeXml(item.specName)}</td>
                        <td>¥${item.price}</td>
                        <td>${item.quantity}</td>
                        <td class="price-tag">¥<fmt:formatNumber value="${item.price * item.quantity}" pattern="#,##0.00"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<c:if test="${order.status == 2}">
    <div class="glass-card mb-4 p-4">
        <h6 style="font-weight: bolder; color: var(--color-accent); margin-bottom: 1rem;">已发货卡密</h6>
        <c:forEach var="item" items="${items}">
            <div class="mb-3">
                <div style="font-weight: bolder; margin-bottom: 0.3rem;">${fn:escapeXml(item.productName)} - ${fn:escapeXml(item.specName)}</div>
                <c:forEach var="key" items="${item.cardKeys}">
                    <div class="card-key-box mb-1">${fn:escapeXml(key.content)}</div>
                </c:forEach>
            </div>
        </c:forEach>
    </div>
</c:if>

<a href="${pageContext.request.contextPath}/admin/order/list" class="btn btn-outline-secondary" style="border-radius: 8px;">返回订单列表</a>

<%@ include file="../admin_footer.jsp" %>
