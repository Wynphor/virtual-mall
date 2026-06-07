<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin_header.jsp" %>

<h4 class="section-title">ORDERS 订单管理</h4>

<div class="mb-4 d-flex gap-2 flex-wrap">
    <a href="${pageContext.request.contextPath}/admin/order/list" class="btn ${empty status ? 'btn-primary' : 'btn-outline-secondary'} btn-sm" style="border-radius: 20px;">全部</a>
    <a href="${pageContext.request.contextPath}/admin/order/list?status=0" class="btn ${status == 0 ? 'btn-warning' : 'btn-outline-secondary'} btn-sm" style="border-radius: 20px;">待支付</a>
    <a href="${pageContext.request.contextPath}/admin/order/list?status=2" class="btn ${status == 2 ? 'btn-success' : 'btn-outline-secondary'} btn-sm" style="border-radius: 20px;">已完成</a>
    <a href="${pageContext.request.contextPath}/admin/order/list?status=3" class="btn ${status == 3 ? 'btn-secondary' : 'btn-outline-secondary'} btn-sm" style="border-radius: 20px;">已取消</a>
</div>

<div class="glass-card">
    <div class="table-responsive">
        <table class="table mb-0">
            <thead>
                <tr><th>订单编号</th><th>联系方式</th><th>金额</th><th>状态</th><th>下单时间</th><th>操作</th></tr>
            </thead>
            <tbody>
                <c:forEach var="o" items="${orders}">
                    <tr>
                        <td><code style="color: var(--color-nav);">${o.orderNo}</code></td>
                        <td>${fn:escapeXml(o.contact)}</td>
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
                            <div class="d-flex gap-1">
                                <a href="${pageContext.request.contextPath}/admin/order/detail/${o.id}" class="btn btn-outline-primary btn-sm">详情</a>
                                <c:if test="${o.status == 0}">
                                    <form action="${pageContext.request.contextPath}/admin/order/cancel/${o.id}" method="post" class="d-inline">
                                        <input type="hidden" name="_csrf" value="${csrfToken}">
                                        <button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirm('确定取消此订单？')">取消</button>
                                    </form>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<c:if test="${totalPage > 1}">
    <nav class="mt-4"><ul class="pagination justify-content-center">
        <c:forEach begin="1" end="${totalPage}" var="i">
            <li class="page-item ${page == i ? 'active' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/order/list?page=${i}${not empty status ? '&status=' : ''}${status}">${i}</a>
            </li>
        </c:forEach>
    </ul></nav>
</c:if>

<%@ include file="../admin_footer.jsp" %>
