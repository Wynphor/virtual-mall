<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/header.jsp" %>

<div class="container mt-4 fade-in" style="max-width: 900px;">
    <h4 class="section-title">MY ORDERS 我的订单</h4>

    <c:if test="${not empty orders}">
        <div class="glass-card">
            <div class="table-responsive">
                <table class="table mb-0">
                    <thead>
                        <tr>
                            <th>订单号</th>
                            <th>金额</th>
                            <th>状态</th>
                            <th>时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td><code style="color: var(--color-nav);">${o.orderNo}</code></td>
                                <td class="price-tag">¥<fmt:formatNumber value="${o.totalPrice}" pattern="#,##0.00"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${o.status == 0}"><span class="badge bg-warning">待支付</span></c:when>
                                        <c:when test="${o.status == 2}"><span class="badge bg-success">已完成</span></c:when>
                                        <c:when test="${o.status == 3}"><span class="badge bg-secondary">已取消</span></c:when>
                                    </c:choose>
                                </td>
                                <td style="color: var(--color-primary-light); font-size: 0.85rem;"><fmt:formatDate value="${o.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/order/detail/${o.orderNo}" class="btn btn-outline-primary btn-sm">详情</a>
                                    <c:if test="${o.status == 0}">
                                        <a href="${pageContext.request.contextPath}/order/pay/${o.orderNo}" class="btn btn-danger btn-sm">去支付</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>

    <c:if test="${empty orders}">
        <div class="empty-state">
            <h5>暂无订单</h5>
            <p>你还没有下过单，去逛逛吧~</p>
            <a href="${pageContext.request.contextPath}/product/list" class="btn btn-primary">浏览商品</a>
        </div>
    </c:if>

    <c:if test="${totalPage > 1}">
        <nav class="mt-4">
            <ul class="pagination justify-content-center">
                <c:forEach begin="1" end="${totalPage}" var="i">
                    <li class="page-item ${page == i ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/user/orders?page=${i}">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</div>

<%@ include file="../../common/footer.jsp" %>
